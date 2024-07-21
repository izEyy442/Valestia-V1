ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Wait(500)
    end
end)

Riiick = {}

function Riiick:new()
  local riiick = {}
  setmetatable(riiick, self)
  self.__index = self
  return riiick
end

function Riiick:KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
  AddTextEntry('FMMC_KEY_TIP1', TextEntry)
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
  blockinput = true

  while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
    Wait(0)
  end
  
  if UpdateOnscreenKeyboard() ~= 2 then
    local result = GetOnscreenKeyboardResult()
    Wait(500)
    blockinput = false
    return result
  else
    Wait(500)
    blockinput = false
    return nil
  end
end

function Riiick:drawTxt(text)
  if RageUI.GetCurrentMenu() == nil then 
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(tostring(text))
    DrawSubtitleTimed(1, 1)
  end
end

