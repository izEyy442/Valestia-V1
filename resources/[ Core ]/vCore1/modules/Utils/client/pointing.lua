local pointing = false

Pointing = function()
    local Player = PlayerPedId()

	if pointing then
        RequestTaskMoveNetworkStateTransition(Player, 'Stop')

        if not IsPedInjured(Player) then
            ClearPedSecondaryTask(Player)
        end
    
        SetPedConfigFlag(Player, 36, false)
        ClearPedSecondaryTask(Player)
		pointing = false
	else
		ESX.Streaming.RequestAnimDict('anim@mp_point', function()
            SetPedConfigFlag(Player, 36, 1)
            TaskMoveNetworkByName(Player, 'task_mp_pointing', 0.5, 0, 'anim@mp_point', 24)
            RemoveAnimDict('anim@mp_point')
        end)

		pointing = true
		
		Citizen.CreateThread(function()
			while pointing do
				local camPitch = GetGameplayCamRelativePitch()
				if camPitch < -70.0 then
					camPitch = -70.0
				elseif camPitch > 42.0 then
					camPitch = 42.0
				end
		
				camPitch = (camPitch + 70.0) / 112.0
		
				local camHeading = GetGameplayCamRelativeHeading()
				local cosCamHeading = Cos(camHeading)
				local sinCamHeading = Sin(camHeading)
		
				if camHeading < -180.0 then
					camHeading = -180.0
				elseif camHeading > 180.0 then
					camHeading = 180.0
				end
		
				camHeading = (camHeading + 180.0) / 360.0
				local coords = GetOffsetFromEntityInWorldCoords(Player, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
				local rayHandle, blocked = GetShapeTestResult(StartShapeTestCapsule(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, Player, 7))
		
				SetTaskMoveNetworkSignalFloat(Player, 'Pitch', camPitch)
				SetTaskMoveNetworkSignalFloat(Player, 'Heading', (camHeading * -1.0) + 1.0)
				SetTaskMoveNetworkSignalBool(Player, 'isBlocked', blocked)
				SetTaskMoveNetworkSignalBool(Player, 'isFirstPerson', N_0xee778f8c7e1142e2(N_0x19cafa3c87f7c2ff()) == 4)
				Citizen.Wait(0)
			end
		end)
	end
end

Shared:RegisterKeyMapping("vCore1:pointing:use", { label = "player_pointing" }, "B", function()
    Pointing()
end)

exports("PlayerIsPointing", function()
    return pointing
end)