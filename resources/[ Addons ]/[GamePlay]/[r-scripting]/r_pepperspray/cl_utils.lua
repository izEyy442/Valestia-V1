/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/firefighter-scba-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Functions ]]

function Hint(message)
    AddTextEntry('r_pepperspray', message)
    BeginTextCommandDisplayHelp('r_pepperspray')
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

-- Function to deactivate controls when the player has been gassed
function DisableControlGassed(ped)
    if Config.DisableControl.sprint then
        DisableControlAction(0, 21, true)
    end

    if Config.DisableControl.enterVehicle then
        DisableControlAction(0, 23, true)
    end

    if Config.DisableControl.fight then
        DisableControlAction(0, 24, true)
        DisablePlayerFiring(ped, true)
        DisableControlAction(0, 142, true)
        DisableControlAction(0, 25, true)
    end
end

-- [[ Command ]]

if not Config.UseFramework then
    -- Command to take a pepper spray
    for command,_ in pairs(Config.PepperSpray) do
        RegisterCommand(command, function(_, Args)
            if GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.PepperSpray[command].weapon then
                RemoveWeaponFromPed(GetPlayerPed(-1), Config.PepperSpray[command].weapon)
            else
                GiveWeaponToPed(GetPlayerPed(-1), Config.PepperSpray[command].weapon, 0, false, false)
                SetCurrentPedWeapon(GetPlayerPed(-1), Config.PepperSpray[command].weapon, true)
            end
        end, false)
    end

    -- Command to take a decontamination spray
    RegisterCommand(Config.Decontamination.command, function(_, Args)
        if GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.Decontamination.weapon then
            RemoveWeaponFromPed(GetPlayerPed(-1), Config.Decontamination.weapon)
        else
            GiveWeaponToPed(GetPlayerPed(-1), Config.Decontamination.weapon, 0, false, false)
            SetCurrentPedWeapon(GetPlayerPed(-1), Config.Decontamination.weapon, true)
        end
    end, false)
end