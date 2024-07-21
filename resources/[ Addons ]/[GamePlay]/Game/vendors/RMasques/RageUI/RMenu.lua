---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/10/2019 02:40
---

---@class RageUIMasques
RageUIMasques = {}

---@class Item
RageUIMasques.Item = {}

---@class Panel
RageUIMasques.Panel = {}

---@class Window
RageUIMasques.Window = {}

---@class RMenuMasques
RMenuMasques = setmetatable({}, RMenuMasques)

---@type table
local TotalMenus = {}

---Add
---@param Type string
---@param Name string
---@param Menu table
---@return RMenuMasques
---@public
function RMenuMasques.Add(Type, Name, Menu)
    if RMenuMasques[Type] ~= nil then
        RMenuMasques[Type][Name] = {
            Menu = Menu
        }
    else
        RMenuMasques[Type] = {}
        RMenuMasques[Type][Name] = {
            Menu = Menu
        }
    end
    return table.insert(TotalMenus, Menu)
end

---Get
---@param Type string
---@param Name string
---@return table
---@public
function RMenuMasques:Get(Type, Name)
    if self[Type] ~= nil and self[Type][Name] ~= nil then
        return self[Type][Name].Menu
    end
end

---GetType
---@param Type string
---@return table
---@public
function RMenuMasques:GetType(Type)
    if self[Type] ~= nil then
        return self[Type]
    end
end

---Settings
---@param Type string
---@param Name string
---@param Settings string
---@param Value any optional
---@return void
---@public
function RMenuMasques:Settings(Type, Name, Settings, Value)
    if Value ~= nil then
        self[Type][Name][Settings] = Value
    else
        return self[Type][Name][Settings]
    end
end

---Delete
---@param Type string
---@param Name string
---@return void
---@public
function RMenuMasques:Delete(Type, Name)
    self[Type][Name] = nil
    collectgarbage()
end

---DeleteType
---@param Type string
---@return void
---@public
function RMenuMasques:DeleteType(Type)
    self[Type] = nil
    collectgarbage()
end
