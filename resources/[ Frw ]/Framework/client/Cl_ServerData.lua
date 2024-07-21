local Server = GetConvar('sv_type', 'FA')
local Servers = {
	['DEV'] = {
		uiComponents = {'infos', 'statuts'},
		crosshairDisabled = true,
		disablePopulation = false
	},
	['FA'] = {
		uiComponents = {'infos', 'statuts'},
		crosshairDisabled = false,
		disablePopulation = true
	},
	['WL'] = {
		uiComponents = {'statuts'},
		crosshairDisabled = true,
		disablePopulation = false
	}
}

exports('GetData', function(key)
	return Servers[Server][key]
end)