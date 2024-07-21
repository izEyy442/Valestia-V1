ESX = {}
ESX.DB = {}
ESX.Players = {}
ESX.Commands = {}
ESX.CommandsSuggestions = {}
---@type Group[]
ESX.Groups = {}
ESX.Jobs = {}
ESX.Items = {}
ESX.UsableItemsCallbacks = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

exports('getSharedObject', getSharedObject);

MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM addon_account_data WHERE `money` = 0', {})
	MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE `count` = 0', {})
	MySQL.Async.execute('DELETE FROM datastore_data WHERE `data` = \'{}\'', {})

	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for i = 1, #result, 1 do
			ESX.Items[result[i].name] = {
				label = result[i].label,
				weight = result[i].weight,
				canRemove = toboolean(result[i].can_remove),
				unique = toboolean(result[i].unique)
			}
		end
	end)

	MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
		for i = 1, #result do
			ESX.Jobs[result[i].name] = result[i]
			ESX.Jobs[result[i].name].grades = {}
		end

		MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(result2)
			for i = 1, #result2 do
				if ESX.Jobs[result2[i].job_name] then
					ESX.Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
				else
					print(('[^3WARNING^7] Invalid job "%s" from table job_grades ignored'):format(result2[i].job_name))
				end
			end

			for k, v in pairs(ESX.Jobs) do
				if ESX.Table.SizeOf(v.grades) == 0 then
					ESX.Jobs[v.name] = nil
					print(('[^3WARNING^7] Ignoring job "%s" due to missing job grades'):format(v.name))
				end
			end

			TriggerEvent('esx:JobsLoaded', ESX.Jobs);
		end)
	end)

	RegisterPVPCommands()

end)

AddEventHandler("esx:SocietyAdded", function(society, societyType)
	if (not ESX.Jobs[society.name]) then

		local grades = society.grades;

		for k, v in pairs(grades) do

			if (v) then

				grades[tostring(k)] = v;

			end
		end

		ESX.Jobs[society.name] = {
			name = society.name,
			label = society.label,
			societyType = societyType ~= nil and societyType or 1,
			canWashMoney = society.canWashMoney ~= nil and society.canWashMoney or false,
			canUseOffshore = society.canUseOffshore ~= nil and society.canUseOffshore or false,
			grades = grades
		};

		TriggerEvent('esx:JobLoaded', ESX.Jobs[society.name]);

	else

		ESX.Logs.Info("Society " .. society.name .. " already exists, ignoring it.");

	end
end);

AddEventHandler("esx:SocietyRemoved", function(societyName)
	ESX.Jobs[societyName] = nil;
	ESX.Logs.Info("Society " .. societyName .. " removed.");
end);

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
	local _source = source
	ESX.TriggerServerCallback(name, requestId, _source, function(...)
		TriggerClientEvent('esx:serverCallback', _source, requestId, ...)
	end, ...)
end)