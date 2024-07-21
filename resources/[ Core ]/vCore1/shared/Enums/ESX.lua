Enums.ESX = {
    Player = {

        Inventory = {

            Server = {
                ---@param type string @["item_standard"] | ["item_account"] | ["item_weapon"] | ["item_ammo"]
                ---@param itemName string
                ---@param itemCount number
                dropItem = function(type, itemName, itemCount)
                    return "esx:dropInventoryItem";
                end,

                ---@param target number
                ---@param type string @["item_standard"] | ["item_account"] | ["item_weapon"] | ["item_ammo"]
                ---@param itemName string
                ---@param itemCount number
                giveItem = function(target, type, itemName, itemCount)
                    return "esx:giveInventoryItem";
                end,

                ---@param itemName string
                useItem = function(itemName)
                    return "esx:useItem";
                end,
            },

            Client = {

                ---@param item table
                addItem = function(item)
                    return "esx:addInventoryItem";
                end,

                ---@param item table
                ---@param identifier string
                removeItem = function(item, identifier)
                    return "esx:removeInventoryItem";
                end,

                ---@param add boolean
                ---@param itemName string
                ---@param count number
                updateItemCount = function(add, itemName, count)
                    return "esx:updateItemCount";
                end,

                ---@param weaponName string
                ---@param ammo number
                addWeapon = function(weaponName, ammo)
                    return "esx:addWeapon";
                end,

                ---@param weaponName string
                ---@param weaponComponent string
                addWeaponComponent = function(weaponName, weaponComponent)
                    return "esx:addWeaponComponent";
                end,

                ---@param weaponName string
                ---@param ammo number
                removeWeapon = function(weaponName, ammo)
                    return "esx:removeWeapon";
                end,

                ---@param weaponName string
                ---@param ammo number
                setWeaponAmmo = function(weaponName, ammo)
                    return "esx:setWeaponAmmo";
                end,

                ---@param weaponName string
                ---@param weaponComponent string
                removeWeaponComponent = function(weaponName, weaponComponent)
                    return "esx:removeWeaponComponent";
                end,

                ---@param account table
                setAccountMoney = function(account)
                    return "esx:setAccountMoney";
                end,

            }

        },

        Job = {

            Server = {

                ---@param playerId number
                ---@param job table
                ---@param lastJob table
                setJob = function(playerId, job, lastJob)
                    return "esx:setJob";
                end,

                ---@param playerId number
                ---@param job2 table
                ---@param lastJob2 table
                setJob2 = function(playerId, job2, lastJob2)
                    return "esx:setJob2";
                end,

            },

            Client = {

                ---@param job table
                setJob = function(job)
                    return "esx:setJob";
                end,

                ---@param job2 table
                setJob2 = function(job2)
                    return "esx:setJob2";
                end,

            }

        },

    },
    Societies = {
        jobsLoaded = "esx:JobsLoaded",
        societyAdded = "esx:SocietyAdded",
        societyRemoved = "esx:SocietyRemoved",
        jobLoaded = "esx:JobLoaded",
    }
};