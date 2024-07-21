ESXLoaded = false
ESX = nil
Player = {
    WeaponData = {}
}

RegisterCommand('refresh', function()
	LoadESX()
	TriggerServerEvent("Core:RequestAdmin")
end)
societymoney = 0
gangmoney = 0
function LoadESX()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end    
    
	ESX.PlayerData = ESX.GetPlayerData()
	Player.WeaponData = ESX.GetWeaponList()

	while ESX.PlayerData == nil do 
		print("player data nil")
		Wait(1)
	end

	for i = 1, #Player.WeaponData, 1 do
		if Player.WeaponData[i].name == 'WEAPON_UNARMED' then
			Player.WeaponData[i] = nil
		else
			Player.WeaponData[i].hash = GetHashKey(Player.WeaponData[i].name)
		end
    end
	Wait(500)
    ESXLoaded = true
	ReplaceHudColourWithRgba(116, 45,110,185, 255)
	SetWeaponsNoAutoswap(true)
	exports["pma-voice"]:setRadioVolume(100)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Wait(1000)
	LoadESX()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	ESX.PlayerData.job.name = ESX.PlayerData.job.name
	ESX.PlayerData.job.label = ESX.PlayerData.job.label
	ESX.PlayerData.job.grade_name = ESX.PlayerData.job.grade_name
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	ESX.PlayerData.job2.name = ESX.PlayerData.job2.name
	ESX.PlayerData.job2.label = ESX.PlayerData.job2.label
	ESX.PlayerData.job2.grade_name = ESX.PlayerData.job2.grade_name
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight)
	ESX.PlayerData.maxWeight = newMaxWeight
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		societymoney = ESX.Math.GroupDigits(money)
	end

	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		gangmoney = ESX.Math.GroupDigits(money)
	end
end)

RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group, lastGroup)
	ESX.PlayerData.group = group
end)

RegisterNetEvent('esx:activateMoney')
AddEventHandler('esx:activateMoney', function(money)
    ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)    
    LoadESX()
end)

function DrawMissionText(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end



PermanentWeapon = {
	['WEAPON_ASSAULTRIFLE'] = true,
	['WEAPON_PAN'] = true,
	['WEAPON_KATANA'] = true,
	['WEAPON_TRIDAGGER'] = true,
	['WEAPON_LUCILE'] = true,
	['WEAPON_BAYONET'] = true,
	['WEAPON_KARAMBIT'] = true,
    ['WEAPON_HEAVYSNIPER'] = true,
    ['WEAPON_CARBINERIFLE_MK2'] = true,
    ['WEAPON_ASSAULTSHOTGUN'] = true,
    ['WEAPON_SPECIALCARBINE'] = true,
    ['WEAPON_COMBATPDW'] = true,
    ['WEAPON_REVOLVER_MK2'] = true,
    ['WEAPON_BAT'] = true,
    ['WEAPON_MARSKSMANRIFLE'] = true,
    ['weapon_combatmg_mk2'] = true,
    ['WEAPON_M4A1FM'] = true,
    ['WEAPON_SCAR17FM'] = true,
    ['weapon_heavyshotgun'] = true,
    ['weapon_heavysniper_mk2'] = true,
	['WEAPON_MP5SDFM'] = true,
	['WEAPON_SR25'] = true,
}