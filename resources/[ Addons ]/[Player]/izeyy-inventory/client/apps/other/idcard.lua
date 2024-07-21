local sex = nil
local typeCard = nil
local image = nil


RegisterNUICallback('lookCard', function(data)
    if Config.ActiveMugShot == false then
        image = Config.PictureIdCard 
    else
        image = exports["MugShotBase64"]:GetMugShotBase64(PlayerPedId(), false)
    end
    SendNUIMessage({
        action = "open:idCard", 
        type = data.type, 
        title = Config.IdCardName[data.type].name, 
        information = data.info,
        sex = Config.GenreIdCard[data.info.sex],
        image = image,
        icon = Config.IdCardName[data.type].icon,
        color = Config.IdCardName[data.type].color,
    })

end)

RegisterNUICallback('giveCard', function(data)
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance < 2.5 then
        TriggerServerEvent('izeyko:lookCard', GetPlayerServerId(closestPlayer), GetPlayerServerId(PlayerId()), data)

    else 
        NotificationInInventory(Locales[Config.Language]['no_player'], 'error')
    end
end)

RegisterNetEvent('izey:lookCard')
AddEventHandler('izey:lookCard', function(networkId, data)
    open = true
    
    if Config.ActiveMugShot == false then
        image = Config.PictureIdCard 
    else

        local entity = NetworkGetEntityFromNetworkId(networkId)
        if DoesEntityExist(entity) then
            image = exports["MugShotBase64"]:GetMugShotBase64(entity, false)
        else
            print("Entity with this ID in netword " .. networkId .. " does not exist.")
        end
    end
    SendNUIMessage({
        action = "open:idCard", 
        type = data.type, 
        title = Config.IdCardName[data.type].name, 
        information = data.info,
        sex = Config.GenreIdCard[data.info.sex],
        image = image,
        icon = Config.IdCardName[data.type].icon,
        color = Config.IdCardName[data.type].color,
    })
    while open do 
		Wait(0)

		if (IsControlJustReleased(0, 322) and open) or (IsControlJustReleased(0, 177) and open) then
			SendNUIMessage({
				action = 'close:idCard'
			})
			open = false
		end
	end
end)