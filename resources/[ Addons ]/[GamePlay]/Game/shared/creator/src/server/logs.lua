logs = {} or {};

function logs:sendToDiscord(wehbook, name, title, message, color)
    if title == nil or title == '' then return false end
    if message == nil or message == '' then return false end

    PLAYER_NAME, PLAYER_IP, PLAYER_STEAMHEX = GetPlayerName(source), GetPlayerEndpoint(source), GetPlayerIdentifier(source)
    PLAYER_DISCORD = "`Pas relié`"
    for _,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            PLAYER_DISCORD = "<@" .. discordid .. ">"
        end
    end

    local date = os.date('*t')

    if date.day < 10 then date.day = '' .. tostring(date.day) end
    if date.month < 10 then date.month = '' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
    if date.min < 10 then date.min = '' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '' .. tostring(date.sec) end

    local logsDate = date.day.."/"..date.month.."/"..date.year.." - "..date.hour..":"..date.min..":"..date.sec

    local embeds = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] = message,
            ["footer"] = {
                ["text"] = logsDate,
                ["icon_url"] = _ServerConfig.logo,
            },
        }
    }

    PerformHttpRequest(wehbook, function() end, 'POST', json.encode({username = name, embeds = embeds}), {['Content-Type'] = 'application/json'})
end