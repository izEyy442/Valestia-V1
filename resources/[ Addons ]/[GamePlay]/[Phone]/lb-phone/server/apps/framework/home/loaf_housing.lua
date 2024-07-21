CreateThread(function()
    if Config.HouseScript ~= "loaf_housing" then
        return
    end

    local lib = exports.loaf_lib:GetLib()

    lib.RegisterCallback("phone:home:toggleLocked", function(source, cb, id, uniqueId)
        local keyName = ("housing_key_%i_%s"):format(id, uniqueId)
        local hasKey = exports.loaf_keysystem:HasKey(source, keyName)
        if not hasKey then
            cb(false)
            return
        end

        local locked = exports["loaf_housing"]:IsDoorLocked(id, uniqueId)
        exports["loaf_housing"]:SetDoorLocked(id, uniqueId, not locked)
        cb(not locked)
    end)
end)