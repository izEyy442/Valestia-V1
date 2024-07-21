
local sCore = {}

ZonesListe = {
    ["planeShop_menu"] = {
        Position = vector3(-963.991, -2966.675, 13.42519),
        Public = false,
        Job = "planeseller",
        Job2 = nil,
        Action = function()
            TriggerEvent("planerShop:openmenu")
        end
    },
    ["boatShop_menu"] = {
        Position = vector3(-734.22015380859, -1343.8698730469, 1.5719245672226),
        Public = false,
        Job = "boatseller",
        Job2 = nil,
        Action = function()
            TriggerEvent("BoatShop:openMenu")
        end
    },

    ["avocatRendezVous_menu"] = {
        Position = vector3(-768.7946, -612.1107, 30.26001),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("avocat:openMenu")
        end
    },
    ["bahamasFrigo_menu"] = {
        Position = vector3(-562.10369873047, 286.95755004883, 82.176536560059),
        Public = false,
        Job = "bahamas",
        Job2 = nil,
        Action = function()
            TriggerEvent("bahamas:OpenMenuFrigo")
        end
    },
    ["bahamasGarage_menu"] = {
        Position = vector3(-556.77416992188, 297.51992797852, 83.056442260742),
        Public = false,
        Job = "bahamas",
        Job2 = nil,
        Action = function()
            TriggerEvent("bahamas:OpenGarage")
        end
    },
    ["bahamasRangerVehicle_menu"] = {
        Position = vector3(-563.90740966797, 302.20217895508, 83.158958435059),
        Public = false,
        Job = "bahamas",
        Job2 = nil,
        Action = function()
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            ESX.Game.DeleteVehicle(vehicle)
        end
    },
    ["burgerShot_menuPreparation"] = {
        Position = vector3(-1194.35, -898.5281, 13.88616),
        Public = false,
        Job = "burgershot",
        Job2 = nil,
        Action = function()
            TriggerEvent("burgershot:OpenMenuPreparation")
        end
    },
    ["burgerShot_menuPreparation2"] = {
        Position = vector3(-1197.032, -897.78, 13.88616),
        Public = false,
        Job = "burgershot",
        Job2 = nil,
        Action = function()
            TriggerEvent("burgershot:OpenMenuPreparation2")
        end
    },
    ["burgerShot_menuShop"] = {
        Position = vector3(-1202.9077148438, -895.72979736328, 13.886160850525),
        Public = false,
        Job = "burgershot",
        Job2 = nil,
        Action = function()
            TriggerEvent("burgershot:OpenMenuShop")
        end
    },
    ["burgerShot_menuPatron"] = {
        Position = vector3(-1199.86, -901.0613, 13.88617),
        Public = false,
        Job = "burgershot",
        Job2 = nil,
        Action = function()
            ESX.OpenSocietyChest("burgershot")
        end
    },
    ["unicorn_menuFrigo"] = {
        Position = vector3(136.2171, -1325.023, 19.39658),
        Public = false,
        Job = "unicorn",
        Job2 = nil,
        Action = function()
            TriggerEvent("unicorn:openMenuFrigo")
        end
    },
    ["unicorn_menuGarage"] = {
        Position = vector3(144.0317, -1290.227, 29.3593),
        Public = false,
        Job = "unicorn",
        Job2 = nil,
        Action = function()
            TriggerEvent("unicorn:openMenuGarage")
        end
    },
    ["barber1"] = {
        Position = vector3(137.09083557129, -1708.1477050781, 29.291622161865-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["barber2"] = {
        Position = vector3(-810.96441650391, -184.06790161133, 37.568992614746-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["barber3"] = {
        Position = vector3(-1280.9237060547, -1116.8645019531, 6.9901103973389-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["barber4"] = {
        Position = vector3(1929.77, 3732.88, 32.83-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["barber5"] = {
        Position = vector3(1214.7652587891, -473.13641357422, 66.207984924316-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["barber6"] = {
        Position = vector3(-33.455024719238, -154.7061920166, 57.076484680176-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["barber7"] = {
        Position = vector3(-275.92349243164, 6226.2612304688, 31.695512771606-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["barber8"] = {
        Position = vector3(5150.6865, -5132.5142, 2.4341-0.98),
        Public = true,
        Job = nil,
        Job2 = nil,
        Action = function()
            TriggerEvent("barbershop:openMenu")
        end
    },
    ["fib_garage_helipad"] = {
        Position = vector3(2505.964, -347.1071, 118.0243),
        Text = "~r~FIB - Hélipad",
        Public = false,
        Job = "fib",
        Job2 = nil,
        Action = function()
            OpenMenuHelipadFIB() 
        end
    },
    -- ["autoSchool_start"] = {
    --     Position = vector3(-2187.779, -409.0029, 13.14),
    --     Text = "~r~Auto Ecole - Payer",
    --     Public = true,
    --     Job = nil,
    --     Job2 = nil,
    --     Blip = {
    --         Name = "[Public] Auto Ecole",
    --         Sprite = 457,
    --         Display = 4,
    --         Scale = 0.70,
    --         Color = 2
    --     },
    --     Action = function()
    --         TriggerEvent("autoSchool:menu")
    --     end
    -- },
    ["agentimmobilier_clothes"] = {
        Position = vector3(237.8912, -3155.901, 40.53),
        Text = "~g~Agent Immobilier - Clothes",
        Public = false,
        Job = "realestateagent",
        Job2 = nil,
        Action = function()
            TriggerEvent("AgentImmobilier:MenuClothes")
        end
    },
    ["agentimmobilier_vehicle"] = {
        Position = vector3(233.7952, -3150.919, 40.53),
        Text = "~r~Agent Immobilier - Vehicules",
        Public = false,
        Job = "realestateagent",
        Job2 = nil,
        Action = function()
            TriggerEvent("AgentImmobilier:MenuVehicules")
        end
    },
}

function AddMarker(id, data)
    if not ZonesListe[id] then 
        ZonesListe[id] = data
    end
end

function RemoveMarker(id)
    ZonesListe[id] = nil
end


Citizen.CreateThread(function()
    for _,marker in pairs(ZonesListe) do
        if marker.Blip then
            local blip = AddBlipForCoord(marker.Position)

            SetBlipSprite(blip, marker.Blip.Sprite)
            SetBlipScale(blip, marker.Blip.Scale)
            SetBlipColour(blip, marker.Blip.Color)
            SetBlipDisplay(blip, marker.Blip.Display)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(marker.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
	end

    while true do
        while not ESX do Wait(1) end
        local isProche = false
        for k,v in pairs(ZonesListe) do
            if v.Public or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == v.Job or ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.Job2 then
                local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), v.Position)

                if dist < 10 then
                    isProche = true
                    -- DrawMarker(2, v.Position.x, v.Position.y, v.Position.z-0.4, 0, 0, 0, 180, nil, nil, 0.2, 0.2, 0.2, 45,110,185, 270, 0, 1, 0, 0, nil, nil, 0)
                    DrawMarker(1, v.Position.x, v.Position.y, v.Position.z-1.2, 0, 0, 0, 270, nil, nil, 1.5, 1.5, 0.9, 45,110,185, 150, 1, 0, 0, 1, nil, nil, 0)
                end
                if dist < 3 then
                    -- DrawInstructionBarNotification(v.Position.x, v.Position.y, v.Position.z + 0.25, "Appuyez sur ~g~E~w~ pour intéragir")
                    Draw3DTextSertyyCore(v.Position.x, v.Position.y, v.Position.z + 0.25, "Appuyez sur [~b~E~w~] pour ~b~intéragir")
                    if IsControlJustPressed(1,51) then
                        v.Action(v.Position)
                    end
                end
            end
        end
        
		if isProche then
			Wait(0)
		else
			Wait(750)
		end
	end
end)


function AddZones(zoneName, data)
    if not ZonesListe[zoneName] then
        ZonesListe[zoneName] = data
        print("Creation d'une zone (ZoneName:"..zoneName..")")
        return true
    else 
        print("Tentative de cree une zone qui exise deja (ZoneName:"..zoneName..")")
        return false
    end
end

function RemoveZone(zoneName)
    if ZonesListe[zoneName] then
        ZonesListe[zoneName] = nil
        print("Suppression d'une zone (ZoneName:"..zoneName..")")
    else 
        print("Tentative de supprimer une zone qui exise pas (ZoneName:"..zoneName..")")
    end
end

function DrawInstructionBarNotification(x, y, z, text)
	local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local distance = GetDistanceBetweenCoords(x, y, z, px, py, pz, false)

	if distance <= 6 then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(true)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		local factor = (string.len(text)) / 370
		DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
		ClearDrawOrigin()
	end
end

function Draw3DTextSertyyCore(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (0.50/distance)*2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end