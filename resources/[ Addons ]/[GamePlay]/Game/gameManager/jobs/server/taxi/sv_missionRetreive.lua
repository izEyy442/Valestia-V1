local local_date = os.date('%H:%M:%S', os.time())

---
--- @author Azagal
--- Create at [28/10/2022] 15:55:02
--- Current project [Silky-V1]
--- File name [mission]
---

Taxi = Taxi or {}

Taxi.Mission = {
    List = {},
    Checked = {}
}

function Taxi.Mission:generate()
    local newMission = {}

    setmetatable(newMission, self)
    self.__index = self

    newMission.takePos = Taxi.Config.randomPos.take[math.random(1, #Taxi.Config.randomPos.take)]
    newMission.deliverPos = Taxi.Config.randomPos.deliver[math.random(1, #Taxi.Config.randomPos.deliver)]
    newMission.pedModel = Taxi.Config.randomModels[math.random(#Taxi.Config.randomModels)]

    return newMission
end

function Taxi.Mission:startForPlayer(playerIdentifier)
    local playerSelected = ESX.GetPlayerFromIdentifier(playerIdentifier)
    local playerSource = playerSelected.source
    if (playerSelected == nil) then
        return
    end

    if (Taxi.Mission.Checked[playerIdentifier] == nil) then
        Taxi.Mission.Checked[playerIdentifier] = true
        playerSelected.triggerEvent("Taxi:mission:sendData", {
            actived = true
        })
    end

    if (Taxi.Mission.List[playerIdentifier] ~= nil) then
        return playerSelected.showNotification("Vous avez déjà une mission en cours... Veuillez la terminer.")
    end

    self.author = playerIdentifier
    self.entity = CreatePed(3, GetHashKey(self.pedModel), self.takePos["x"], self.takePos["y"], self.takePos["z"], self.takePos["w"], true, true)
    Taxi.Mission.List[playerIdentifier] = self;
    while (not self.entity or not DoesEntityExist(self.entity)) do
        Wait(500)
    end
    FreezeEntityPosition(self.entity, true)

    playerSelected.triggerEvent("Taxi:mission:sendData", {
        blip = {
            coords = vector3(self.takePos["x"], self.takePos["y"], self.takePos["z"])
        }
    })

    while (DoesEntityExist(self.entity) and (#(GetEntityCoords(GetPlayerPed(playerSource))-GetEntityCoords(self.entity)) > 10.0)) do
        Wait(1000)
    end

    local playerVehicle = GetVehiclePedIsIn(GetPlayerPed(playerSource))
    while (DoesEntityExist(self.entity) and playerVehicle == 0 or GetEntityModel(playerVehicle) ~= Taxi.Config.vehicle.model[GetEntityModel(playerVehicle)].model) do
        Wait(1500)
    end

    FreezeEntityPosition(self.entity, false)
    if (DoesEntityExist(self.entity) and GetEntityHealth(self.entity) < 1) then
        return self:stop()
    end

    local passengerSeat = Taxi.Config.vehicle.passengerSeat
    while (DoesEntityExist(self.entity) and GetPedInVehicleSeat(playerVehicle, passengerSeat) ~= 0) do
        TaskLeaveVehicle(GetPedInVehicleSeat(playerVehicle, passengerSeat), playerVehicle, 0)
        Wait(500)
    end

    TaskEnterVehicle(self.entity, playerVehicle, -1, passengerSeat, 1.0, 0)

    while (DoesEntityExist(self.entity) and GetPedInVehicleSeat(playerVehicle, passengerSeat) ~= self.entity) do
        Wait(500)
    end

    if (DoesEntityExist(self.entity)) then
        playerSelected.triggerEvent("Taxi:mission:sendData", {
            blip = {
                coords = vector3(self.deliverPos["x"], self.deliverPos["y"], self.deliverPos["z"])
            }
        })

        while (DoesEntityExist(self.entity) and (#(GetEntityCoords(GetPlayerPed(playerSource))-vector3(self.deliverPos["x"], self.deliverPos["y"], self.deliverPos["z"])) > 10.0)) do
            Wait(1000)
        end

        if (DoesEntityExist(self.entity)) then
            if (#(GetEntityCoords(GetPlayerPed(playerSource))-vector3(self.deliverPos["x"], self.deliverPos["y"], self.deliverPos["z"])) < 10.0) then
                while (DoesEntityExist(self.entity) and GetPedInVehicleSeat(playerVehicle, passengerSeat) ~= 0) do
                    TaskLeaveVehicle(self.entity, playerVehicle, 0)
                    Wait(2500)
                end


                local rewardMoney = math.random(Taxi.Config.reward.min, Taxi.Config.reward.max)
                if (rewardMoney) then

                    local society = ESX.DoesSocietyExist("taxi");
                    local moneyTaxi = math.random(200, 650)
                    local taxiGenereux = math.random(1, 10)
                    local GenereuxTaxi = math.random(850, 1500)
                    local xPlayer = ESX.GetPlayerFromId(playerSource)
                    
                    if taxiGenereux == 6 then
                        if (society) then
                            xPlayer.addAccountMoney("cash", moneyTaxi)
                            xPlayer.addAccountMoney("cash", GenereuxTaxi)
                            xPlayer.showNotification("Vous avez eu un pourboir de "..GenereuxTaxi.."~g~$~s~.")
                            xPlayer.showNotification("Vous avez gagné "..moneyTaxi.."~g~$~s~.")
                            logsTaxi("[Course Taxi] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Montant gagner : **"..rewardMoney.."$", 'https://discord.com/api/webhooks/1226957367422222336/8DkkY04RiB4vNO18CZG0PABewTDuiwb6X0_hbC9gw0dvqYRh6NQO8O2IfYuweUHxAVnO')
                            ESX.AddSocietyMoney("taxi", rewardMoney);
                        end
                    else
                        if (society) then
                           xPlayer.addAccountMoney("cash", moneyTaxi)
                            ESX.AddSocietyMoney("taxi", rewardMoney)
                            xPlayer.showNotification("Vous avez gagné "..moneyTaxi.."~g~$~s~.")
                            logsTaxi("[Course Taxi] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Montant gagner : **"..rewardMoney.."$", 'https://discord.com/api/webhooks/1226957367422222336/8DkkY04RiB4vNO18CZG0PABewTDuiwb6X0_hbC9gw0dvqYRh6NQO8O2IfYuweUHxAVnO')
                        end
                    end

                end

                self:stop()
            end
        end
    end
end

function Taxi.Mission:stop(disconnected)
    local playerSelected = ESX.GetPlayerFromIdentifier(self.author)

    if (self.entity ~= nil and DoesEntityExist(self.entity)) then
        DeleteEntity(self.entity)
        self.entity = nil;
    end

    Taxi.Mission.List[self.author] = nil;

    if (disconnected == true) then
        if (Taxi.Mission.Checked[self.author] == true) then
            Taxi.Mission.Checked[self.author] = nil
        end
    elseif (disconnected ~= true and playerSelected ~= nil) then
        playerSelected.triggerEvent("Taxi:mission:sendData", {
            blip = {
                coords = nil
            }
        })

        local playerJob = playerSelected.getJob()
        if (playerJob ~= nil and playerJob.name ~= "taxi") then
            return
        end

        Taxi.Mission.List[self.author] = nil;

        if (Taxi.Mission.Checked[self.author] == true) then
            local generateMission = Taxi.Mission:generate()
            generateMission:startForPlayer(self.author)
        end
    end
end

RegisterNetEvent("Taxi:mission:retreive", function()
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    local playerJob = xPlayer.getJob()
    if (playerJob ~= nil and playerJob.name ~= "taxi") then
        return
    end

    local playerIdentifier = xPlayer.getIdentifier()
    if (not playerIdentifier) then
        return
    end

    local generateMission = Taxi.Mission:generate()
    generateMission:startForPlayer(playerIdentifier)
end)

AddEventHandler("playerDropped", function()
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (xPlayer ~= nil) then
        local playerJob = xPlayer.getJob()
        if (playerJob ~= nil and playerJob.name ~= "taxi") then
            return
        end

        local playerHasCurrentMission = Taxi.Mission.List[xPlayer.identifier]
        if (playerHasCurrentMission ~= nil) then
            playerHasCurrentMission:stop(true)
        end
    end
end)

function logsTaxi(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 14672749,
            ["footer"]=  {
                ["text"]= "Powered for Silky © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end