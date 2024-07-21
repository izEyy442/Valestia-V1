--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function AddLicense(target, type, cb)
	local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
		['@type'] = type,
		['@owner'] = xPlayer.identifier
	}, function(rowsChanged)
		if cb then
			cb()
		end
	end)
end

function RemoveLicense(target, type, cb)
	local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type'] = type,
		['@owner'] = xPlayer.identifier
	}, function(rowsChanged)
		if cb then
			cb()
		end
	end)
end

function GetLicense(type, cb)
	MySQL.Async.fetchAll('SELECT * FROM licenses WHERE type = @type', {
		['@type'] = type
	}, function(result)
		local data = {
			type = type,
			label = result[1].label
		}

		cb(data)
	end)
end

function GetLicenses(target, cb, format)

	local player_selected = ESX.GetPlayerFromId(tonumber(target))

	if (not player_selected) then
		return
	end

	local player_selected_licenses = MySQL.query.await("SELECT * FROM user_licenses WHERE owner = ?", {
		player_selected.getIdentifier()
	})
	local player_selected_licenses_formatted

	if (format == true) then

		player_selected_licenses_formatted = {}

		for i = 1, #player_selected_licenses do

			local player_license_selected = player_selected_licenses[i]

			if (player_license_selected ~= nil) then

				player_selected_licenses_formatted[player_license_selected.type] = true;

			end

		end

	end

	cb((format == true and type(player_selected_licenses_formatted) == "table" and player_selected_licenses_formatted) or player_selected_licenses)

end

function CheckLicense(target, type, cb)

	local player_selected = ESX.GetPlayerFromId(target)

	if (not player_selected) then
		return
	end

	local player_have_license = MySQL.query.await("SELECT * FROM user_licenses WHERE type = ? AND owner = ?", {
		type,
		player_selected.getIdentifier()
	})

	cb((player_have_license ~= nil and player_have_license[1] ~= nil and true or false))

end

function GetLicensesList(cb)
	MySQL.Async.fetchAll('SELECT * FROM licenses', {
		['@type'] = type
	}, function(result)
		local licenses = {}

		for i = 1, #result, 1 do
			table.insert(licenses, {
				type = result[i].type,
				label = result[i].label
			})
		end

		cb(licenses)
	end)
end

AddEventHandler('esx_license:addLicense', function(target, type, cb)
	AddLicense(target, type, cb)
end)

AddEventHandler('esx_license:removeLicense', function(target, type, cb)
	RemoveLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicense', function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler('esx_license:getLicenses', function(target, cb, format)
	GetLicenses(target, cb, format)
end)

AddEventHandler('esx_license:checkLicense', function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicensesList', function(cb)
	GetLicensesList(cb)
end)

ESX.RegisterServerCallback('esx_license:getLicense', function(_, cb, type)
	GetLicense(type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicenses', function(source, cb, target, format)
	GetLicenses(((type(target) == "number" and target) or source), cb, format)
end)

ESX.RegisterServerCallback('esx_license:checkLicense', function(source, cb, target, type)
	CheckLicense(((type(target) == "number" and target) or source), type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicensesList', function(_, cb)
	GetLicensesList(cb)
end)