local unarmedHash = GetHashKey("WEAPON_UNARMED")
local currWeapon = unarmedHash
local holstered = true
local canFire = true
local weapon_bypass = false
local IsInPVP = false

local function bagIsAllowed(bagIndex)
	for i = 1, #Config["WeaponAnimation"]["allowed_bags"] do
		if (Config["WeaponAnimation"]["allowed_bags"][i] == bagIndex) then
			return true
		end
	end
	return false
end

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP
end)

RegisterNetEvent("vCore3:Valestia:weapon_bypass")
AddEventHandler("vCore3:Valestia:weapon_bypass", function()
	local resource = GetInvokingResource()

	if (not resource or resource == "vCore3") then
		weapon_bypass = not weapon_bypass

		if weapon_bypass then
			ESX.ShowNotification("WeaponBypass activé")
		else
			ESX.ShowNotification("WeaponBypass désactivé")
		end

	else
		ForceSocialClubUpdate()
	end

end)

local function DisableFire()
	CreateThread(function()
		while not canFire do
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true)
			Wait(0)
		end
	end)
end

CreateThread(function()
	while true do
		Wait(500)
		local Player = PlayerPedId()

		if ( not weapon_bypass and not IsInPVP ) then
			if DoesEntityExist(Player) and not IsPedDeadOrDying(Player) and IsPedOnFoot(Player) then
				local newWeap = GetSelectedPedWeapon(Player)
				if newWeap ~= currWeapon then

					SetCurrentPedWeapon(Player, currWeapon, true)
					local continue = true

					if (Config["WeaponAnimation"]["WeaponList"][newWeap] ~= nil) and (Config["WeaponAnimation"]["WeaponList"][newWeap].settings.bag) then
						local bagIndex = GetPedDrawableVariation(Player, 5)
						if (not bagIsAllowed(bagIndex)) then
							local vehicle = ESX.Game.GetVehicleInDirection()
							if DoesEntityExist(vehicle) then
								SetVehicleDoorOpen(vehicle, 5, false, false)
								Wait(2000)
								SetVehicleDoorShut(vehicle, 5, false)
							else
								ESX.ShowAdvancedNotification('Notification', "Sac", "Vous devez disposer d'un sac ou être proche d'une voiture", 'CHAR_CALL911', 8)
								continue = false
							end
						end
					end

					if continue and not (GetPedParachuteState(PlayerPedId()) ~= -1) then
						ESX.Streaming.RequestAnimDict('reaction@intimidation@1h')
						if (Config["WeaponAnimation"]["WeaponList"][newWeap] ~= nil) and (Config["WeaponAnimation"]["WeaponList"][newWeap].settings.animation) then
							if holstered then
								canFire = false
								DisableFire()
								TaskPlayAnim(Player, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
								Wait(1000)
								SetCurrentPedWeapon(Player, newWeap, true)
								currWeapon = newWeap
								Wait(2000)
								ClearPedTasks(Player)
								holstered = false
								canFire = true
							else
								canFire = false
								DisableFire()
								TaskPlayAnim(Player, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
								SetCurrentPedWeapon(Player, unarmedHash, true)
								SetCurrentPedWeapon(Player, newWeap, true)
								currWeapon = newWeap
								Wait(2000)
								ClearPedTasks(Player)
								holstered = true
								canFire = true
							end
						else
							if not holstered and (Config["WeaponAnimation"]["WeaponList"][currWeapon] ~= nil) and (Config["WeaponAnimation"]["WeaponList"][currWeapon].settings.animation) then
								canFire = false
								DisableFire()
								TaskPlayAnim(Player, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
								SetCurrentPedWeapon(Player, unarmedHash, true)
								ClearPedTasks(Player)
								SetCurrentPedWeapon(Player, newWeap, true)
								holstered = true
								canFire = true
								currWeapon = newWeap
							else
								SetCurrentPedWeapon(Player, newWeap, true)
								holstered = false
								canFire = true
								currWeapon = newWeap
							end

						end

						RemoveAnimDict('reaction@intimidation@1h')
					end
				end
			end
		end
	end
end)