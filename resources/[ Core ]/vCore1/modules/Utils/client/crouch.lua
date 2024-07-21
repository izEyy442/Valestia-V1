local crouched = false

local function Crouch()
	RequestAnimSet("move_ped_crouched")

    while not HasAnimSetLoaded("move_ped_crouched") do 
        Citizen.Wait(100)
    end 

    if crouched == true then 
        ResetPedMovementClipset(PlayerPedId(), 0)
        crouched = false 
    elseif crouched == false then
        SetPedMovementClipset(PlayerPedId(), "move_ped_crouched", 0.25)
        crouched = true 
    end
end

Shared:RegisterKeyMapping("vCore1:crouch:use", { label = "player_crouch" }, "X", function()
    Crouch()
end)

exports("PlayerIsCrouch", function()
    return crouched
end)