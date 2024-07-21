local lib = exports.loaf_lib:GetLib()

RegisterNUICallback("Wallet", function(data, cb)
    local action = data.action
    if action == "getData" then
        lib.TriggerCallback("phone:wallet:getData", cb)
    elseif action == "doesNumberExist" then
        lib.TriggerCallback("phone:wallet:doesNumberExist", cb, data.number)
    elseif action == "sendPayment" then
        lib.TriggerCallback("phone:wallet:sendPayment", cb, {
            amount = data.amount,
            phoneNumber = data.number
        })
    end
end)

RegisterNetEvent("phone:wallet:addTransaction", function(transaction)
    SendReactMessage("wallet:addTransaction", transaction)
end)