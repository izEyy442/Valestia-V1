--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = exports["Framework"]:getSharedObject();

local IsInPVP = false;

AddEventHandler("vCore3:Valestia:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

local playercount = 0;
CreateThread(function()
  while true do
	Wait(10000)
    ESX.TriggerServerCallback("iZeyy:RPCPlayerCount", function(count)
      playercount = count
	  AddTextEntry('FE_THDR_GTAO', ("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Valestia ~c~| ~s~%s~s~ ~c~|~s~ ID : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ ~c~|~s~ Connecté(s) : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..playercount.." ~c~|~s~ Discord.gg/~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ValestiaRP~s~"):format(
		GetPlayerName(PlayerId()),
		GetPlayerServerId(PlayerId())
	  ));
    end)
  end
end)

Citizen.CreateThread(function()
	SetDiscordAppId(1223656693523812484)
	SetDiscordRichPresenceAsset('valestia')
	SetRichPresence(GetPlayerName(PlayerId()) .." ["..GetPlayerServerId(PlayerId()).."]")
	SetDiscordRichPresenceAction(0, "🤖 Rejoindre le discord 🤖", "https://discord.gg/valestiarp")
	SetDiscordRichPresenceAction(1, "🎮 Se Connecter 🎮", "https://discord.gg/valestiarp")
	AddTextEntry('PM_PANE_LEAVE', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Retourner sur la liste des serveurs.')
	AddTextEntry('PM_PANE_QUIT', 'Quitter ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~FiveM')
	AddTextEntry('PM_SCR_MAP', 'CARTE')
	AddTextEntry('PM_SCR_GAM', 'DOUANE')
	AddTextEntry('PM_SCR_INF', 'LOGS DU JEU')
	AddTextEntry('PM_SCR_SET', 'CONFIG FIVEM')
	AddTextEntry('PM_SCR_STA', 'STATISTIQUES')
	AddTextEntry('PM_SCR_RPL', '~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Éditeur ∑')
	AddTextEntry('FE_THDR_GTAO', ("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~Valestia ~c~| ~s~%s~s~ ~c~|~s~ ID : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s~s~ ~c~|~s~ Connecté(s) : ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~"..playercount.." ~c~|~s~ Discord.gg/~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~ValestiaRP~s~"):format(
   	GetPlayerName(PlayerId()),
   	GetPlayerServerId(PlayerId())
	));
	AddTextEntry("PM_PANE_CFX", "Valestia")
	ReplaceHudColourWithRgba(116, 45, 110, 185, 255)

	 local wait = 15
	 local count = 60
	 local KO = false

	 while true do
		--local isHurt = exports.GameCore:IsHurt()
	 	if (not IsInPVP) then
	 		if IsPedInMeleeCombat(PlayerPedId()) then
	 			if GetEntityHealth(PlayerPedId()) < 115 then
					ESX.ShowAdvancedNotification('Notification', "K.O", "Vous êtes assommé", 'CHAR_CALL911', 8)
	 				wait = 15
	 				KO = true
	 				SetEntityHealth(PlayerPedId(), 116)
	 			end
	 		end

	 		if KO then
	 			SetPlayerInvincible(PlayerId(), true)
	 			DisablePlayerFiring(PlayerId(), true)
	 			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
	 			ResetPedRagdollTimer(PlayerPedId())

	 			if wait >= 0 then
	 				count = count - 1

	 				if count == 0 then
	 					count = 60
	 					wait = wait - 1
	 					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 4)
	 				end
	 			else
	 				SetPlayerInvincible(PlayerId(), false)
	 				KO = false
	 			end
	 		end
	 	end
		Wait(0)
	end
end)