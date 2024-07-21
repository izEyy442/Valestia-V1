/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-megaphone-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Functions ]]

-- You can modify the notification system of the script (do not change the name of the function)
function Hint(message)
    AddTextEntry('NewTxtEntry', message)
    BeginTextCommandDisplayHelp('NewTxtEntry')
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end

-- [[ Command ]]

-- Megaphone command
if not Config.UseFramework then
	RegisterCommand('megaphone', function(_, Args)
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.Weapon then
			RemoveWeaponFromPed(GetPlayerPed(-1), Config.Weapon)
		else
			GiveWeaponToPed(GetPlayerPed(-1), Config.Weapon, 10, false, false)
			SetCurrentPedWeapon(GetPlayerPed(-1), Config.Weapon, true)
		end
	end)
end