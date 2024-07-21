if Framework.Active == 4 then
    ESX = {}

    ESX.RegisterUsableItem = function(itemName, callBack)

    end

    ESX.GetPlayerFromId = function(source)
        local xPlayer = {}
        ---------
        xPlayer.identifier = "UniqueIdentifier"
        ---------
        xPlayer.license = "UniqueLicense"
        ---------
        xPlayer.job = {
            name = "unemployed",
            label = "unemployed",
            grade = {
                name = "unemployed",
                level = 0
            }
        }
        ---------
        xPlayer.getGroup = function()
            -- gets player ground (admin, mod, player...)
            return "player"
        end
        ---------
        xPlayer.getJob = function()
            return {
                grade = 0,
                grade_name = "unemployed",
                name = "unemployed"
            }
        end
        ---------
        xPlayer.getName = function()
            return GetPlayerName(source)
        end
        ---------
        xPlayer.getTotalAmount = function(item)
            return 123
        end
        ---------
        xPlayer.addInventoryItem = function(item, count)
            -- implement function that gives items
        end
        ---------
        xPlayer.removeInventoryItem = function(item, count)
             -- implement function that removes items
        end
        ---------
        xPlayer.getMoney = function()
             -- implement function that gets money
            return 123
        end
        ---------
        xPlayer.addMoney = function(money)
           -- implement function that adds money
        end
        ---------
        xPlayer.addAccountMoney = function(type, money)
            if type == "money" then
                type = "cash"
            end
            -- implement function that adds account money
        end
        ---------
        xPlayer.getAccount = function(type)
            -- implement function that gets money
            return {
                money = 123
            }
        end
        ---------
        xPlayer.removeAccountMoney = function(type, money)
            -- implement function that removes account money
        end
        ---------
        xPlayer.removeMoney = function(money)
            -- implement function that removes money
        end
        ---------
        xPlayer.getInventoryItem = function(itemName)
              -- implement function that gets inventory item info
            local ItemInfo = {
                name = itemName,
                count = 123,
                label = itemName,
                weight = 0,
                usable = false,
                rare = false,
                canRemove = false
            }
            return ItemInfo
        end
        ---------
        return xPlayer
    end
end
