CreateThread(function()
	while true do
		TriggerClientEvent('ui:update', -1, GetNumPlayerIndices())
		Wait(10000)
	end
end)