local lib = exports.loaf_lib:GetLib()

-- Get open companies
local lastRefresh = 0
lib.RegisterCallback("phone:services:getOnline", function(_, cb)
    if (lastRefresh + 60) < os.time() and RefreshCompanies then
        RefreshCompanies()
        lastRefresh = os.time()
    end

    cb(Config.Companies.Services)
end)

-- Messages
local function GetChannel(company, phoneNumber)
    local channel = MySQL.Sync.fetchScalar("SELECT id FROM phone_services_channels WHERE company = @company AND phone_number = @phoneNumber", {
        ["@company"] = company,
        ["@phoneNumber"] = phoneNumber
    })

    if channel then
        return channel
    end

    local id = GenerateId("phone_services_channels", "id")
    MySQL.Sync.execute("INSERT INTO phone_services_channels (id, company, phone_number) VALUES (@id, @company, @phoneNumber)", {
        ["@id"] = id,
        ["@company"] = company,
        ["@phoneNumber"] = phoneNumber
    })
    return id
end

lib.RegisterCallback("phone:services:getChannelId", function(source, cb, job)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return
    end

    local channelId = GetChannel(job, phoneNumber)
    cb(channelId)
end)

lib.RegisterCallback("phone:services:sendMessage", function(source, cb, channelId, company, message, anonymous)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return
    end

    if anonymous then
        phoneNumber = L("BACKEND.SERVICES.ANONYMOUS")
        channelId = GetChannel(company, phoneNumber)
    end

    debugprint("phone:services:sendMessage, company:", company, " message:", message)

    if not channelId then
        channelId = GetChannel(company, phoneNumber)
    end

    local contacter = MySQL.Sync.fetchScalar("SELECT phone_number FROM phone_services_channels WHERE id = @channelId", {
        ["@company"] = company,
        ["@channelId"] = channelId
    })
    local isContacter = contacter == phoneNumber

    local x, y
    if isContacter then
        local coords = GetEntityCoords(GetPlayerPed(source))
        x = coords.x
        y = coords.y
    end

    local messageId = GenerateId("phone_services_messages", "id")
    MySQL.Async.execute([[
        INSERT INTO phone_services_messages (id, channel_id, sender, message, x_pos, y_pos)
        VALUES (@id, @channelId, @sender, @message, @xPos, @yPos)
    ]], {
        ["@id"] = messageId,
        ["@channelId"] = channelId,
        ["@sender"] = phoneNumber,
        ["@message"] = message,
        ["@xPos"] = x,
        ["@yPos"] = y
    }, function()
        TriggerClientEvent("phone:services:newMessage", -1, {
            channelId = channelId,
            id = messageId,
            sender = phoneNumber,
            content = message,
            x = x,
            y = y
        })

        if isContacter then -- if it was sent by the original contacter
            -- alert all online employees
            local employees = GetEmployees(company)
            for i = 1, #employees do
                local employeeNumber = GetEquippedPhoneNumber(employees[i])
                if not employeeNumber then
                    goto continue
                end

                SendNotification(employeeNumber, {
                    source = employees[i],

                    app = "Services",
                    title = L("BACKEND.SERVICES.NEW_MESSAGE"),
                    content = message
                })

                ::continue::
            end
        else
            -- alert the contacter
            SendNotification(contacter, {
                app = "Services",
                title = L("BACKEND.SERVICES.NEW_MESSAGE"),
                content = message
            })
        end

        Log("Services", source, "info", L("BACKEND.LOGS.NEW_SERVICE_TITLE"), L("BACKEND.LOGS.NEW_SERVICE_CONTENT", {
            sender = FormatNumber(phoneNumber),
            channel = company,
            message = message
        }))

        cb(messageId)
    end)

    MySQL.Async.execute("UPDATE phone_services_channels SET last_message = SUBSTRING(@message, 1, 50) WHERE id = @id", {
        ["@id"] = channelId,
        ["@message"] = message
    })
end)

lib.RegisterCallback("phone:services:getRecentMessages", function(source, cb, page)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return
    end

    MySQL.Async.fetchAll([[
        SELECT id, phone_number, company, company, last_message, `timestamp`
        FROM phone_services_channels
        WHERE 
            phone_number = @phoneNumber 
            OR company = @company
        ORDER BY `timestamp` DESC
        LIMIT @page, @perPage
    ]], {
        ["@phoneNumber"] = phoneNumber,
        ["@company"] = GetJob(source),
        ["@page"] = (page or 0) * 25,
        ["@perPage"] = 25
    }, cb)
end)

lib.RegisterCallback("phone:services:getMessages", function(source, cb, channelId, page)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return
    end

    MySQL.Async.fetchAll([[
        SELECT id, sender, message, x_pos, y_pos, `timestamp`
        FROM phone_services_messages
        WHERE channel_id = @channelId
        ORDER BY `timestamp` DESC
        LIMIT @page, @perPage
    ]], {
        ["@channelId"] = channelId,
        ["@page"] = (page or 0) * 25,
        ["@perPage"] = 25
    }, cb)
end)