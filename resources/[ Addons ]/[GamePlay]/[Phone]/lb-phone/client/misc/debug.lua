CreateThread(function()
    RegisterCommand("phonedebug", function()
        Config.Debug = not Config.Debug
        SendReactMessage("phone:toggleDebug", Config.Debug)
        print("DEBUG:", Config.Debug)
    end, false)

    local function registerDebugCommand(command, fn)
        RegisterCommand(command, function(src, args)
            if Config.Debug then
                fn(src, args)
            end
        end, false)
    end

    registerDebugCommand("center", function()
        SetCursorLocation(0.5, 0.5)
    end)

    registerDebugCommand("getcache", function()
        SendReactMessage("phone:printCache")
    end)

    registerDebugCommand("getstacks", function()
        SendReactMessage("phone:printStacks")
    end)

    registerDebugCommand("testnotification", function(src, args)
        TriggerEvent("phone:sendNotification", {
            app = args[1] or "Wallet",
            title = "Test Notification",
            content = "This is a test notification.",
        })
    end)

    registerDebugCommand("testamberalert", function()
        TriggerEvent("phone:sendNotification", {
            title = "Emergency Alert",
            content = "This is a test emergency alert.",
            icon = "./assets/img/icons/warning.png"
        })
    end)

    registerDebugCommand("testamberalert2", function()
        TriggerEvent("phone:sendNotification", {
            title = "Emergency Alert",
            content = "This is a test emergency alert. 123",
            icon = "./assets/img/icons/danger.png"
        })
    end)

    registerDebugCommand("setbattery", function(source, args)
        battery = tonumber(args[1]) or 50
        exports["lb-phone"]:SetBattery(battery)
    end)

    registerDebugCommand("togglecharging", function(source, args)
        exports["lb-phone"]:ToggleCharging(args[1] == "true" and true or false)
    end)

    registerDebugCommand("addcontact", function(source, args)
        exports["lb-phone"]:AddContact({
            firstname = "John",
            lastname =  "Doe",
            number = args[1] or "1234567890",
            avatar = "https://i.imgur.com/2X1uYkU.png"
        })
    end)

    if Config.QBMailEvent then
        registerDebugCommand("qbmail", function()
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = "Very Cool",
                subject = "Delivery Location",
                message = "whatever",
                button = {
                    enabled = true,
                    buttonEvent = "phone:debug:mail",
                    buttonData = "waitingDelivery"
                }
            })
        end)
    end

    RegisterNetEvent("phone:debug:mail", function(id, data)
        print(id, json.encode(data))
    end)

    RegisterCommand("crashnotify", function()
        exports["lb-phone"]:SendNotification({
            app = "Phone",
            title = L("BACKEND.CALLS.NEW_VOICEMAIL")
        })
    end, false)
end)

-- local control = 24
-- local function DrawText(text)
--     AddTextEntry(GetCurrentResourceName(), text)
--     BeginTextCommandDisplayText(GetCurrentResourceName())
--     SetTextScale(0.35, 0.35)
--     SetTextCentre(true)
--     SetTextFont(4)
--     SetTextDropShadow()
--     EndTextCommandDisplayText(0.5, 0.5)
-- end

-- CreateThread(function()
--     while true do
--         Wait(0)
--         DrawText(("Pressed (disabled): %s\nPressed: %s"):format(tostring(IsDisabledControlPressed(0, control)), tostring(IsControlPressed(0, control))))
--     end
-- end)

-- CreateThread(function()
--     while true do
--         DisableControlAction(0, control, true)
--         Wait(0)
--     end
-- end)

-- CreateThread(function()
--     Wait(500)

--     SetNuiFocus(true, true)
--     SetNuiFocusKeepInput(true)

--     while true do
--         Wait(0)

--         DisableControlAction(0, control, true)
--         if IsDisabledControlJustPressed(0, control) then
--             while not IsDisabledControlJustReleased(0, control) do
--                 Wait(0)
--             end
--             print("disabling keep input")
--             SetNuiFocusKeepInput(false)
--             Wait(500)
--             print("enabling keep input")
--             SetNuiFocusKeepInput(true)
--         end
--     end
-- end)