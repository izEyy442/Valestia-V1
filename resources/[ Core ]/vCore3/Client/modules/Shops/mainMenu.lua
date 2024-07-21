ShopsManager = ShopsManager or {};
ShopsManager.currentCat = nil

local currentVip = 0
ShopsManager.mainMenu = RageUI.AddMenu("", "Invalid")
local subMenu = RageUI.AddSubMenu(ShopsManager.mainMenu, "", "Invalid")

local CanAccessFood = 1

local function toggleMenu(shpId, CCAF)
    CanAccessFood = CCAF
    local selectedShp = ShopsManager.GetFromId(shpId)
    if (selectedShp == nil) then return end

    TriggerServerEvent("shops:getVIP")

    local player_licenses = {};
    ESX.TriggerServerCallback("esx_license:getLicenses", function(results)
        player_licenses = results;
    end, false, true)

    local updateLicenses;
    updateLicenses = AddEventHandler("Shops:UpdateLicenses", function()
        ESX.TriggerServerCallback("esx_license:getLicenses", function(results)
            player_licenses = results;
        end, false, true)
    end)

    local function playerHaveLicenses(license_list)

        if (type(license_list) == "table" and #license_list > 0) then

            for i = 1, #license_list do

                local license_selected = license_list[i]

                if (license_selected ~= nil and player_licenses[license_selected] == true) then
                    return true
                end

            end

            return false

        else

            return true

        end

    end

    local function drawItemsByCat(cat_selected)

        for item, values in pairs(selectedShp.items) do

            if (values.cat == cat_selected) then

                Items:Button(values.label, nil, {
                    RightLabel = ("→ %s ~g~$~s~"):format(values.price)
                }, values.type == nil or not (values.type == "license" and player_licenses[item] == true), {
                    onSelected = function()

                        local amount

                        if (values.type == nil) then
                            amount = Shared:KeyboardInput("Combien voulez-vous en prendre ?", 2);
                            if (not Shared:InputIsValid(amount, "number") or tonumber(amount) < 0) then
                                return
                            end
                        end

                        TriggerServerEvent("Shops:BuyItem", shpId, (values.type or "standard"), item, amount)

                    end
                })

            end

        end

    end

    ShopsManager.mainMenu:SetSubtitle(selectedShp.label)

    local newCategories = {}
    for k, _ in pairs(selectedShp.categories) do
        table.insert(newCategories, k)
    end

    table.sort(newCategories, function(a, b)
        return (selectedShp.categories[a].placement < selectedShp.categories[b].placement)
    end)

    ShopsManager.mainMenu:IsVisible(function(Items)
        drawItemsByCat();
        for i = 1, #newCategories do
            local cat = newCategories[i]
            if ((cat == "food") or (cat == "drink")) and (CanAccessFood ~= 1) then
            else
                Items:Button(selectedShp.categories[cat].label, nil, {
                    RightLabel = "→"
                }, playerHaveLicenses(selectedShp.categories[cat].licenses), {
                    onSelected = function()
                        ShopsManager.currentCat = cat
                        subMenu:SetSubtitle(selectedShp.label.." : "..selectedShp.categories[cat].label)
                    end
                }, subMenu)
            end
        end
        -- if CanAccessFood ~= 0 then
        --     Items:Button("VIP", nil, {
        --         RightLabel = "→"
        --     }, currentVip ~= 1, {
        --         onSelected = function()
        --             ShopsManager.currentCat = "vip"
        --             subMenu:SetSubtitle(selectedShp.label.." : VIP")
        --         end
        --     }, subMenu)
        -- end

    end, function()  end, function()
        RemoveEventHandler(updateLicenses)
    end)

    subMenu:IsVisible(function()
        drawItemsByCat(ShopsManager.currentCat);
    end)

    ShopsManager.mainMenu:Toggle()

end

RegisterNetEvent("Shops:OpeningMenu", toggleMenu)

RegisterNetEvent("shops:setStatVip", function(vip)
    currentVip = vip
end)
