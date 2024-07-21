local handsup = false

local function handsUp()
    local Player = PlayerPedId()
	if DoesEntityExist(Player) and not IsEntityDead(Player) then

		if exports["vCore1"]:isPlayerEscort() then
			ESX.ShowNotification("Vous pouvez pas faire ça en étant ~escorté")
			return
		end

		if exports["vCore1"]:isPlayerHandcuff() then
			ESX.ShowNotification("Vous pouvez pas faire ça en étant menotté")
			return
		end

		if not IsPedInAnyVehicle(Player, false) and not IsPedSwimming(Player) and not IsPedShooting(Player) and not IsPedClimbing(Player) and not IsPedCuffed(plyPed) and not IsPedDiving(Player) and not IsPedFalling(Player) and not IsPedJumpingOutOfVehicle(Player) and not IsPedUsingAnyScenario(Player) and not IsPedInParachuteFreeFall(Player) then
			RequestAnimDict("random@mugging3")

			while not HasAnimDictLoaded("random@mugging3") do
				Citizen.Wait(100)
			end

			if not handsup then
				handsup = true
				TaskPlayAnim(Player, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
			elseif handsup then
				handsup = false
				ClearPedSecondaryTask(Player)
			end
		end

	end
end

Shared:RegisterKeyMapping("vCore1:handsup:use", { label = "player_handsup" }, "²", function()
    handsUp()
end)

exports("PlayerHasHandsUp", function()
    return handsup
end)