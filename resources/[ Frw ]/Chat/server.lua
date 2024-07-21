RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:server:ClearChat')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
	if not message or not author then
		return
	end

	TriggerEvent('chatMessage', source, author, message)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, author, {255, 255, 255}, message)
	end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
	local name = GetPlayerName(source)

	TriggerEvent('chatMessage', source, name, '/' .. command)

	if not WasEventCanceled() then
		TriggerClientEvent('chatMessage', -1, name, {255, 255, 255}, '/' .. command) 
	end

	CancelEvent()
end)

local function refreshCommands(player)
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()

		local suggestions = {}

		for _, command in ipairs(registeredCommands) do
			if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
				table.insert(suggestions, {
					name = '/' .. command.name,
					help = ''
				})
			end
		end

		TriggerClientEvent('chat:addSuggestions', player, suggestions)
	end
end

AddEventHandler('onServerResourceStart', function(resName)
	Wait(500)

	for _, player in ipairs(GetPlayers()) do
		refreshCommands(player)
	end
end)

RegisterNetEvent('chatMessage')
AddEventHandler("chatMessage", function(source, color, message)
	local src = source
	args = stringsplit(message, " ")
	CancelEvent()
	if string.find(args[1], "/") then
		local cmd = args[1]
		table.remove(args, 1)
	end
end)

commands = {}
commandSuggestions = {}

function starts_with(str, start)
	return str:sub(1, #start) == start
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

AddEventHandler('chatMessage', function(author, color, message)
    local pseudo  = GetPlayerName(author)
    
    local webhookLink = "https://discord.com/api/webhooks/1226959464457044120/-RUs2S7AtUluPTuobLk4ARe1qy1FZrV-A9U4-kvtt2OGDIzZtaSsHYyC6AGq5wcccWr1"
	local local_date = os.date('%H:%M:%S', os.time())

    local content = {
        {
            ["title"] = "**__Information :__**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = pseudo },
                { name = "- Message :", value = message },
            },
            ["type"]  = "rich",
            ["color"] = 11750815,
            ["footer"] =  {
                ["text"] = "Logs Chat",
            },
        }
    }
    PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs Chat Message", embeds = content}), { ['Content-Type'] = 'application/json' })
end)