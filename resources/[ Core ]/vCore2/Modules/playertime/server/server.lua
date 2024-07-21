PlayeTime = {}

AddEventHandler('esx:playerLoaded', function(source)
    StartPlayerTime(source)
end)
AddEventHandler('esx:playerDropped', function(source)
	SaveTimePlayed(source)
end)


function StartPlayerTime(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM playtime WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent("PlayerTime:StartTimer", source, result[1].timeplayed)
        else
            MySQL.Async.execute("INSERT INTO playtime (identifier, timeplayed) VALUES (@identifier, @timeplayed)", {
                ['@identifier'] = xPlayer.identifier,
                ['@timeplayed'] = 0
            }, function(rowsChanged)
                TriggerClientEvent("PlayerTime:StartTimer", source, 0)
                -- print("^2[SILKY]^7 le temps de jeux de "..xPlayer.identifier.." a bien été crée")
            end)
        end
    end)
end

function SaveTimePlayed(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(PlayeTime) do
        if v.source == source then
            MySQL.Async.execute("UPDATE playtime SET timeplayed = @timeplayed WHERE identifier = @identifier", {
                ['@identifier'] = xPlayer.identifier,
                ['@timeplayed'] = v.timeplayed
            }, function(rowsChanged)
                -- print("^2[SILKY]^7 le temps de jeux de "..xPlayer.identifier.." a bien été sauvegardé")
            end)
            return
        end
    end
end

RegisterServerEvent("PlayerTime:UpdateTimer")
AddEventHandler("PlayerTime:UpdateTimer", function(timeplayed)
    local xPlayer = ESX.GetPlayerFromId(source)
    if PlayeTime[source] == nil then
        table.insert(PlayeTime, {
            source = source,
            timeplayed = timeplayed
        })
    else
        for k,v in pairs(PlayeTime) do
            if v.source == source then
                v.timeplayed = timeplayed
            end
        end
    end
end)