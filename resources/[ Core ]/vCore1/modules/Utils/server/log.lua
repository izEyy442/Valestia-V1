function SendLogs(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["title"]= title,
			["description"]= message,
			["type"]= "rich",
			["color"] = Config["LogColorCode"],
			["footer"]= {
			    ["text"]= "Powered by "..Config["ServerName"].." ©   |  "..local_date.."",
				["icon_url"] = Config["ServerImage"]
			},
		}
	}
  
    if message == nil or message == '' then return false end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end