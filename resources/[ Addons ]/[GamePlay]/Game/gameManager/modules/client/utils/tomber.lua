--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local isFalling = false

Keys.Register("J", "Tomber", "Tomber au sol", function()
    CreateThread(function()
        FallAnimation()
    end)
end)

function FallAnimation()
    local ped = PlayerPedId()
    if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then 
        Citizen.CreateThread(function()
            if isFalling then
                isFalling = false
            else
                isFalling = true
                SetPedToRagdoll(ped, 100, 100, 0, 0, 0, 0)
                while isFalling do
                    Citizen.Wait(10)
                    ResetPedRagdollTimer(ped)
                end
            end
        end)
    end 
end