/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-pepper-spray
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Exports ]]

-- Put the effects of gassing on the player
exports('SetGassedPlayer', function(command)
    if Config.PepperSpray[command] ~= nil then
        gassedPlayer(command)
    end
end)

-- Removes the gas of the player
exports('RemoveGas', function()
    resetGassedPed()
end)

-- Define the amount of the player's spray he has on hand (pepper spray or decontamination spray)
exports('SetPepperQuantity', function(quantity)
    if pepperUse ~= nil then
        sprayQuantity[pepperUse] = quantity
    end
end)

-- Returns if the player is gassed
exports('IsGassed', function()
    if gassed == nil then
        return false
    else
        return true
    end
end)