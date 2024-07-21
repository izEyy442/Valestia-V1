ESX.RegisterServerCallback("pnj:getPlayerCount", function(_, cb)
	cb(GetNumPlayerIndices());
end);