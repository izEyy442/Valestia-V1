local lib = exports.loaf_lib:GetLib()

---Adds a transaction to a phone number, doesn't return anything
---@param phoneNumber string
---@param amount number
---@param company string
---@param logo? string
---@return nil
function AddTransaction(phoneNumber, amount, company, logo)
    if not phoneNumber or not amount or not company then
        return
    end

    MySQL.Async.execute("INSERT INTO phone_wallet_transactions (phone_number, amount, company, logo) VALUES (@phoneNumber, @amount, @company, @logo)", {
        ["@phoneNumber"] = phoneNumber,
        ["@amount"] = amount,
        ["@company"] = company,
        ["@logo"] = logo
    }, function()
        local source = GetSourceFromNumber(phoneNumber)
        if not source then
            return
        end

        local content = (amount < 0 and "-" or "") .. Config.CurrencyFormat:format(SeperateNumber(math.abs(amount)))
        SendNotification(phoneNumber, {
            app = "Wallet",
            title = company,
            content = content,
            thumbnail = logo,
            source = source
        })

        TriggerClientEvent("phone:wallet:addTransaction", source, {
            amount = amount,
            company = company,
            logo = logo,
            timestamp = os.time()
        })

        -- amount > 0 and "Received $" .. amount or "Paid $" .. math.abs(amount)
        Log("Wallet", source, amount > 0 and "success" or "error", L("BACKEND.LOGS." .. (amount > 0 and "RECEIVED" or "PAID") .. "_TITLE", { amount = math.abs(amount) }), L("BACKEND.LOGS.TRANSACTION", {
            number = FormatNumber(phoneNumber),
            amount = amount,
            company = company
        }), logo)
    end)

    TriggerEvent("lb-phone:onAddTransaction", amount > 0 and "received" or "paid", phoneNumber, amount, company, logo)
end

---Get recent transactions from a phone number given page & transactions per page
---@param phoneNumber string
---@param page number
---@param perPage number
---@param cb function
local function GetRecentTransactions(phoneNumber, page, perPage, cb)
    MySQL.Async.fetchAll([[
        SELECT 
            amount, company, logo, `timestamp`
        FROM phone_wallet_transactions
        WHERE phone_number=@phoneNumber

        ORDER BY `timestamp` DESC

        LIMIT @page, @perPage
    ]], {
        ["@phoneNumber"] = phoneNumber,
        ["@page"] = page or 0,
        ["@perPage"] = perPage or 3
    }, cb)
end

--- Callback to get recent transactions
lib.RegisterCallback("phone:wallet:getData", function(source, cb)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return cb({
            balance = GetBalance(source),
            transactions = {}
        })
    end

    GetRecentTransactions(phoneNumber, 0, 5, function(transactions)
        cb({
            balance = GetBalance(source),
            transactions = transactions
        })
    end)
end)

lib.RegisterCallback("phone:wallet:doesNumberExist", function(_, cb, number)
    cb(GetSourceFromNumber(number) ~= false)
end)

lib.RegisterCallback("phone:wallet:sendPayment", function(source, cb, sendTo)
    local phoneNumber = GetEquippedPhoneNumber(source)
    if not phoneNumber then
        return cb({
            success = false,
            reason = "No phone number equipped found"
        })
    end

    local amount = tonumber(sendTo.amount)
    if not amount or amount <= 0 then
        return cb({
            success = false,
            reason = "invalid_amount"
        })
    end

    if GetBalance(source) < amount then
        return cb({
            success = false,
            reason = "no_money"
        })
    end

    local sendToSource = GetSourceFromNumber(sendTo.phoneNumber)
    local added = AddMoney(sendToSource, amount)
    if not added then
        return cb({
            success = false,
            reason = "Cannot add money to the other person's account"
        })
    end

    RemoveMoney(source, amount)

    cb({
        success = true
    })

    SendMessage(phoneNumber, sendTo.phoneNumber, "<!SENT-PAYMENT-" .. amount .. "!>")

    GetContact(sendTo.phoneNumber, phoneNumber, function(contact)
        contact = contact?[1]
        if contact then
            AddTransaction(phoneNumber, -amount, contact.name, contact.profile_image)
        else
            AddTransaction(phoneNumber, -amount, sendTo.phoneNumber)
        end
    end)

    GetContact(phoneNumber, sendTo.phoneNumber, function(contact)
        contact = contact?[1]
        if contact then
            AddTransaction(sendTo.phoneNumber, amount, contact.name, contact.profile_image)
        else
            AddTransaction(sendTo.phoneNumber, amount, phoneNumber)
        end
    end)
end)
