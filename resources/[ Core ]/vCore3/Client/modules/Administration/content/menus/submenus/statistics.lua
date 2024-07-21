---@type Storage
local AdminStorage = Shared.Storage:Get("Administration");

---@type UIMenu
local stats = AdminStorage:Get("admin_statistics");

stats:IsVisible(function(Items)
	local data = AdminStorage:Get("report_stats");

	if (type(data) ~= "table") then
		Items:Separator("Chargement en cours...");
	else
		if (next(data) == nil) then
			Items:Separator("Aucun statistique n'a été trouvé.");
		else
			for i = 1, #data do
				if (type(data[i]) == "table") then
					Items:Button(("%s:"):format(data[i].name), nil, {
						RightLabel = ("~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~(~s~%s~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~)~s~ Traité"):format(data[i].count)
					}, true, {});
				end
			end
		end
	end
end);