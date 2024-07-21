--                     /*--------------------------------------
--     % Made with ❤️ for: Rytrak Store
--     % Author: Rytrak https://rytrak.fr
--     % Script documentation: https://docs.rytrak.fr/scripts/advanced-megaphone-system
--     % Full support on discord: https://discord.gg/k22buEjnpZ
--     --------------------------------------*/

-- table.insert(Cfg.voiceModes, {40.0, 'Megaphone'}) -- Here you can change the distance of megaphone

-- exports('setMegaphone', function(bool, value)
--     if bool then
--         mode = #Cfg.voiceModes
--         setProximityState(Cfg.voiceModes[#Cfg.voiceModes][1], true)
--         TriggerEvent('pma-voice:setTalkingMode', #Cfg.voiceModes)
--     else
--         mode = value
--         setProximityState(Cfg.voiceModes[value][1], false)
--         TriggerEvent('pma-voice:setTalkingMode', value)
--     end
-- end)

-- exports('getMegaphone', function()
--     return mode
-- end)
