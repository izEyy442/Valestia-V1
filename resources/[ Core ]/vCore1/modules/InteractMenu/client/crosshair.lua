local crosshairParameters = {	
	["width"] = {

		["label"] = "Largeur",
		["allValues"] = {0.002, 0.0025, 0.003, 0.0035, 0.004, 0.0045, 0.005, 0.0055, 0.006, 0.0065, 0.007, 0.0075, 0.008, 0.0085, 0.009, 0.0095, 0.010, 
		0.0105, 0.011, 0.0115, 0.012, 0.0125, 0.013, 0.0135, 0.014, 0.0145, 0.015, 0.0155, 0.016, 0.0165, 0.017, 0.0175, 0.018, 0.0185, 0.019, 0.0195, 0.02},
		["currentValue"] = 3,
	},
	["gap"] = {

		["label"] = "Écart",
		["allValues"] = {0.0, 0.0005, 0.001, 0.0015, 0.002, 0.0025, 0.003, 0.0035, 0.004, 0.0045, 0.005, 0.0055, 0.006, 0.0065, 0.007, 0.0075, 0.008, 0.0085, 0.009, 0.0095, 0.01},
		["currentValue"] = 3,

	},
	["dot"] = {

		["label"] = "Point",
		["allValues"] = {false, true},
		["currentValue"] = 2,

	},
	["thickness"] = {

		["label"] = "Épaisseur",
		["allValues"] = {0.002, 0.004, 0.006, 0.008, 0.01, 0.012, 0.014, 0.016, 0.018, 0.02},
		["currentValue"] = 1,

	},
	["gtacross"] = {

		["label"] = "Crosshair GTA (1 = Désactivé)",
		["allValues"] = {false, true},
		["currentValue"] = 2,
		
	},
	["color"] = {

		["label"] = "Couleur",
		["allValues"] = {
			{R = 255,	G = 255,	B = 255},{R = 0,	G = 0,	B = 0},{R = 255,	G = 0,	B = 0},{R = 0,	G = 255,	B = 0},{R = 0,	G = 0,	B = 255},{R = 255,	G = 255,	B = 0},
			{R = 255,	G = 0,	B = 255},{R = 0,	G = 255,	B = 255},{R = 255,	G = 165,	B = 0},{R = 0,	G = 128,	B = 0},{R = 128,	G = 0,	B = 128},
		},
		["currentValue"] = 1,

	},
	["opacity"] = {

		["label"] = "Opacité",
		["allValues"] = {25, 50, 75, 100, 125, 150, 175, 200, 225, 255},
		["currentValue"] = 10,

	},
}

local allDefaultValues = {
	{param = "thickness", value = 1},
	{param = "width", value = 3},
	{param = "gap", value = 3},
	{param = "dot", value = 2},
	{param = "gtacross", value = 2},
	{param = "color", value = 1},
	{param = "opacity", value = 10},
}

local parameters = {"width", "gap", "dot", "thickness", "gtacross", "color", "opacity"}

local currentParamIndex = 1
local customCrosshairState = true

local function GetInitialDatas()
	local customCrosshairData = GetResourceKvpInt("crosshair_custom")
	if not customCrosshairData or customCrosshairData == 0 then
		customCrosshairData = 1
		SetResourceKvpInt("crosshair_custom", 1)
	end

	if customCrosshairData == 1 then
		customCrosshairState = false
	else
		customCrosshairState = true
	end

	for k,v in pairs(allDefaultValues) do
		local currentData = GetResourceKvpInt("crosshair_" .. v.param)
		if not currentData or currentData == 0 then
			SetResourceKvpInt("crosshair_" .. v.param, v.value)
		else
			crosshairParameters[v.param]["currentValue"] = currentData
		end
	end
end

local function SaveDatas()
	for k,v in pairs(allDefaultValues) do
		SetResourceKvpInt("crosshair_" .. v.param, crosshairParameters[v.param]["currentValue"])
	end

	ESX.ShowNotification("Crosshair sauvegardé")
end

local function ResetDatas()
	local allSettings =
	{
		{param = "thickness", value = 1},
		{param = "width", value = 3},
		{param = "gap", value = 3},
		{param = "dot", value = 2},
		{param = "gtacross", value = 2},
		{param = "color", value = 1},
		{param = "opacity", value = 10},
	}
	for k,v in pairs(allSettings) do
		SetResourceKvpInt("crosshair_" .. v.param, v.value)
	end
	ESX.ShowNotification("Crosshair rénitialisé")
	GetInitialDatas()
end


local isActive = false
RegisterNetEvent("sertyy:crosshair:active", function()
	isActive = not isActive

	GetInitialDatas()
	CreateThread(function()
		while isActive do
			local ratio = GetAspectRatio()
			local thickness = crosshairParameters["thickness"]["allValues"][crosshairParameters["thickness"]["currentValue"]]
			local width	 = crosshairParameters["width"]["allValues"][crosshairParameters["width"]["currentValue"]]
			local gap = crosshairParameters["gap"]["allValues"][crosshairParameters["gap"]["currentValue"]]
			local dot = crosshairParameters["dot"]["allValues"][crosshairParameters["dot"]["currentValue"]]
			local colorSelected = crosshairParameters["color"]["currentValue"]
			local colorR = crosshairParameters["color"]["allValues"][colorSelected].R
			local colorG = crosshairParameters["color"]["allValues"][colorSelected].G
			local colorB = crosshairParameters["color"]["allValues"][colorSelected].B
			local colorOpacity	= crosshairParameters["opacity"]["allValues"][crosshairParameters["opacity"]["currentValue"]]

			DrawRect(0.5 - gap - width / 2, 0.5, width, thickness, colorR, colorG, colorB, colorOpacity)
			DrawRect(0.5 + gap + width / 2, 0.5, width, thickness, colorR, colorG, colorB, colorOpacity)
			DrawRect(0.5, 0.5 - (gap*ratio) - (width*ratio) / 2, thickness / ratio, width * ratio, colorR, colorG, colorB, colorOpacity)
			DrawRect(0.5, 0.5 + (gap*ratio) + (width*ratio) / 2, thickness / ratio, width * ratio, colorR, colorG, colorB, colorOpacity)

			if not crosshairParameters["gtacross"]["allValues"][crosshairParameters["gtacross"]["currentValue"]] then
				HideHudComponentThisFrame(14)
			end

			if dot then
				DrawRect(0.5, 0.5, (thickness/2), (thickness/2) * ratio, colorR, colorG, colorB, colorOpacity)
			end

			Wait(0)
		end
	end)
end)

local isEditing = false
RegisterNetEvent("sertyy:crosshair:edit", function()
	isEditing = not isEditing

	if not isActive then
		TriggerEvent("sertyy:crosshair:active")
	end

	CreateThread(function()
		while isEditing do
			local currentParameter = parameters[currentParamIndex]

            ESX.ShowHelpNotification("~INPUT_CELLPHONE_UP~ " .. crosshairParameters[currentParameter]["label"] .. "\n~INPUT_REPLAY_ADVANCE~ " .. crosshairParameters[currentParameter]["currentValue"] .. "\n~INPUT_CONTEXT~ Sauvegarder")

			if IsControlJustPressed(1, 172) then
				currentParamIndex = currentParamIndex + 1
				if currentParamIndex > #parameters then 
					currentParamIndex = 1 
				end
			elseif IsControlJustPressed(1, 173) then
				currentParamIndex = currentParamIndex - 1
				if currentParamIndex < 1 then 
					currentParamIndex = #parameters 
				end
			elseif IsControlJustPressed(1, 307) then
				local currentValue = crosshairParameters[currentParameter]["currentValue"] + 1
				if currentValue > #crosshairParameters[currentParameter]["allValues"] then 
					currentValue = 1 
				end
				crosshairParameters[currentParameter]["currentValue"] = currentValue
			elseif IsControlJustPressed(1, 308) then
				local currentValue = crosshairParameters[currentParameter]["currentValue"] - 1
				if currentValue < 1 then 
					currentValue = #crosshairParameters[currentParameter]["allValues"] 
				end
				crosshairParameters[currentParameter]["currentValue"] = currentValue
			elseif IsControlJustPressed(1, 51) then
				SaveDatas()
				isEditing = false
			end

			Wait(0)
		end
	end)
end)

RegisterNetEvent("sertyy:crosshair:reset", function()
	ResetDatas()
end)