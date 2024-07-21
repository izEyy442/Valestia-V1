if Framework.Active == 2 then
    ESX = {}
    GetCoreObject(Framework.Active, Framework.QB_CORE_RESOURCE_NAME, function(object)
        ESX.QBCore = object
        QBCore = object

        ESX.RegisterUsableItem = function(itemName, callBack)
            QBCore.Functions.CreateUseableItem(itemName, callBack)
        end

        ESX.GetPlayerFromId = function(source)
            local xPlayer = {}
            local qbPlayer = QBCore.Functions.GetPlayer(source)
            ---------
            if not qbPlayer then
                return nil
            end
            ---------
            xPlayer.identifier = qbPlayer.PlayerData.citizenid
            ---------
            xPlayer.license = qbPlayer.PlayerData.license
            ---------
            local gradeName = "none"
            local gradeLevel = -1

            if qbPlayer.PlayerData.job.grade then
                gradeName = qbPlayer.PlayerData.job.grade.name
                gradeLevel = qbPlayer.PlayerData.job.grade.level
            elseif qbPlayer.PlayerData.job.grades then
                gradeLevel = GetGreatestNumber(qbPlayer.PlayerData.job.grades)
            end

            xPlayer.job = {
                name = qbPlayer.PlayerData.job.name,
                label = qbPlayer.PlayerData.job.label,
                grade = {
                    name = gradeName,
                    level = gradeLevel
                }
            }
            ---------
            xPlayer.playerData = qbPlayer.PlayerData
            ---------
            xPlayer.getGroup = function()
                return QBCore.Functions.GetPermission(source)
            end
            ---------
            xPlayer.getJob = function()
                if not qbPlayer.PlayerData.job or not qbPlayer.PlayerData.job.grade then
                    return {
                        grade = 0,
                        grade_name = nil,
                        name = nil
                    }
                end

                local gradeName = "none"
                local gradeLevel = -1

                if qbPlayer.PlayerData.job.grade then
                    gradeName = qbPlayer.PlayerData.job.grade.name
                    gradeLevel = qbPlayer.PlayerData.job.grade.level
                elseif qbPlayer.PlayerData.job.grades then
                    gradeLevel = GetGreatestNumber(qbPlayer.PlayerData.job.grades)
                end

                return {
                    grade = gradeLevel,
                    grade_name = gradeName,
                    name = qbPlayer.PlayerData.job.name or "none"
                }
            end
            ---------
            xPlayer.getName = function()
                if qbPlayer.PlayerData.charinfo and qbPlayer.PlayerData.charinfo.firstname then
                    return qbPlayer.PlayerData.charinfo.firstname
                else
                    return qbPlayer.PlayerData.name
                end
            end
            ---------
            xPlayer.setInventoryItem = function(item, count)
                local qbItem = qbPlayer.Functions.GetItemByName(item) or {}
                qbPlayer.Functions.RemoveItem(item, qbItem.amount or qbItem.count or 0)
                qbPlayer.Functions.AddItem(item, count)
            end
            ---------
            xPlayer.getTotalAmount = function(item)
                local totalAmount = 0
                for slot = 1, 50, 1 do
                    local i = qbPlayer.PlayerData.items[slot]
                    if i and i.name == item and (i.amount or i.count) then
                        totalAmount = totalAmount + (i.amount or i.count)
                    end
                end
                return totalAmount
            end
            ---------
            xPlayer.mergeItems = function(item, append)
                -- merge all casino items of the same type together to one slot
                local firstSlot = nil
                local totalAmount = 0
                for slot = 1, 50, 1 do
                    local i = qbPlayer.PlayerData.items[slot]
                    if i and i.name == item and (i.amount or i.count) then
                        if not firstSlot then
                            firstSlot = slot
                        end
                        totalAmount = totalAmount + (i.amount or i.count)
                        qbPlayer.Functions.RemoveItem(item, i.amount or i.count, slot)
                    end
                end
                totalAmount = totalAmount + append
                if totalAmount > 0 then
                    qbPlayer.Functions.AddItem(item, totalAmount, firstSlot)
                end
            end
            ---------
            xPlayer.addInventoryItem = function(item, count)
                xPlayer.mergeItems(item, count)
            end
            ---------
            xPlayer.removeInventoryItem = function(item, count)
                xPlayer.mergeItems(item, -count)
            end
            ---------
            xPlayer.getMoney = function()
                return qbPlayer.Functions.GetMoney("cash")
            end
            ---------
            xPlayer.addMoney = function(money)
                qbPlayer.Functions.AddMoney("cash", money)
            end
            ---------
            xPlayer.addAccountMoney = function(type, money)
                if type == "money" then
                    type = "cash"
                end
                qbPlayer.Functions.AddMoney(type, money)
            end
            ---------
            xPlayer.getAccount = function(type)
                return {
                    money = qbPlayer.Functions.GetMoney(type) or 0
                }
            end
            ---------
            xPlayer.removeAccountMoney = function(type, money)
                qbPlayer.Functions.RemoveMoney(type, money)
            end
            ---------
            xPlayer.removeMoney = function(money)
                qbPlayer.Functions.RemoveMoney("cash", money)
            end
            ---------
            xPlayer.getInventoryItem = function(itemName)
                local item = qbPlayer.Functions.GetItemByName(itemName) or {}

                local ItemInfo = {
                    name = itemName,
                    count = item.amount or item.count or 0,
                    label = item.label or "none",
                    weight = item.weight or 0,
                    usable = item.useable or false,
                    rare = false,
                    canRemove = false
                }
                return ItemInfo
            end
            ---------

            return xPlayer
        end
    end)
end
