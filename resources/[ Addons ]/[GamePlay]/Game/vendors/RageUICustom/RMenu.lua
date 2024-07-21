---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/10/2019 02:40
---

---@class RageUICustom
RageUICustom = {}

---@class Item
RageUICustom.Item = {}

---@class Panel
RageUICustom.Panel = {}

---@class Window
RageUICustom.Window = {}

---@class RMenuCustom
RMenuCustom = setmetatable({}, RMenuCustom)

---@type table
local TotalMenus = {}

---Add
---@param Type string
---@param Name string
---@param Menu table
---@return RMenuCustom
---@public
function RMenuCustom.Add(Type, Name, Menu)
    if RMenuCustom[Type] ~= nil then
        RMenuCustom[Type][Name] = {
            Menu = Menu
        }
    else
        RMenuCustom[Type] = {}
        RMenuCustom[Type][Name] = {
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
function RMenuCustom:Get(Type, Name)
    if self[Type] ~= nil and self[Type][Name] ~= nil then
        return self[Type][Name].Menu
    end
end

---GetType
---@param Type string
---@return table
---@public
function RMenuCustom:GetType(Type)
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
function RMenuCustom:Settings(Type, Name, Settings, Value)
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
function RMenuCustom:Delete(Type, Name)
    self[Type][Name] = nil
    collectgarbage()
end

---DeleteType
---@param Type string
---@return void
---@public
function RMenuCustom:DeleteType(Type)
    self[Type] = nil
    collectgarbage()
end