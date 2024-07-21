local unarmed = GetHashKey("WEAPON_UNARMED");

CreateThread(function()
	while true do
		local players = GetPlayers();
		for i = 1, #players do
			local src = tonumber(players[i]);
			if (src) then
				local isOnline = ESX.IsPlayerValid(src);
				if (isOnline) then
					local ped = GetPlayerPed(src);
					local weapon = GetSelectedPedWeapon(ped);
					if (weapon ~= unarmed) then
						local player = ESX.GetPlayerFromId(src);
						if (not player) then
							DropPlayer(src, "Cheating: Invalid player detected.");
						else
							local inPVP = ESX.GetPlayerInPVPMode(player.identifier);
							if (not inPVP) then
								local registered = ESX.GetWeaponFromHash(weapon);
								if (registered) then
									local invWeapon = player.getWeapon(registered.name);
									if (not invWeapon) then
										player.kick("Cheating: Invalid weapon detected (Not in inventory).");
									end
								end
							end
						end
					end
				end
			end
		end
		Wait(1000);
	end
end);