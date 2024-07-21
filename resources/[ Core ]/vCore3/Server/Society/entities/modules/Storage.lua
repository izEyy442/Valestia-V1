--[[
--Created Date: Tuesday August 2nd 2022
--Author: vCore3
--Made with ❤
-------
--Last Modified: Tuesday August 2nd 2022 3:39:50 am
-------
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@type SocietyStorage
SocietyStorage = Class.new(function(class)

	---@class SocietyStorage: BaseObject
	local self = class;

	---@param storageData table
	function self:Constructor(storageData)

		self.name = storageData.name;
		self.label = storageData.label;
		self.data = {

			vehicles = storageData.vehicles ~= nil and type(storageData.vehicles) == "table" and storageData.vehicles or {},
			weapons = storageData.weapons ~= nil and type(storageData.weapons) == "table" and storageData.weapons or {},
			items = storageData.items ~= nil and type(storageData.items) == "table" and storageData.items or {},
			money = storageData.money ~= nil and type(storageData.money) == "number" and storageData.money or 0,
			dirty_money = storageData.dirty_money ~= nil and type(storageData.dirty_money) == "number" and storageData.dirty_money or 0,

		};
		self.vehiclesOut = {};
		self.weight = 0;
		self.maxWeight = Config["Society"]["MaxWeight"];

		self:UpdateWeight();

	end

	function self:GetName()
		return self.name;
	end

	function self:GetLabel()
		return self.label;
	end

	---@return table
	function self:GetVehicles()
		return self.data.vehicles;
	end

	---@param plate string
	---@return table
	function self:GetVehicle(plate)
		return self.data.vehicles[plate];
	end

	---@param plate string
	---@return table
	function self:GetVehicleProps(plate)
		return self.data.vehicles[plate] and self.data.vehicles[plate].data;
	end

	---@param plate string
	---@param vehicle table
	---@param owner string
	---@return boolean
	function self:AddVehicle(plate, vehicle, owner)

		if (not plate) then return false; end
		if (not vehicle) then return false; end

		if (not self.data.vehicles[plate]) then

			self.data.vehicles[plate] = {};

		end

		self.data.vehicles[plate].data = vehicle;
		self.data.vehicles[plate].stored = 1;

		if (owner) then

			self.data.vehicles[plate].owner = owner;

		end

		self:StoreVehicle(plate);

		self:Update("vehicles");

		return true;

	end

	---@param plate string
	---@param Vehicle Vehicle
	function self:RemoveVehicle(plate, Vehicle)
		if (self.data.vehicles[plate]) then

			self.data.vehicles[plate].stored = 0;
			self:SetVehicleOut(plate, Vehicle);
			self:Update("vehicles");

		end
	end

	---@param plate string
	function self:DeleteVehicle(plate)

		if (self.data.vehicles[plate]) then

			self.vehiclesOut[plate] = nil;
			self.data.vehicles[plate] = nil;
			self:Update("vehicles");

		end

	end

	---Reset all vehicles from society storage (Delete all vehicles from sql and storage)
	function self:ResetVehicles()
		self.data.vehicles = {};
		self:Update("vehicles");
	end

	---@param plate string
	---@return string
	function self:GetVehicleOwner(plate)
		return self.data.vehicles[plate] ~= nil and self.data.vehicles[plate].owner;
	end

	---@param plate string
	---@param owner string
	function self:SetVehicleOwner(plate, owner)

		if (self.data.vehicles[plate]) then

			self.data.vehicles[plate].owner = owner;
			self:Update("vehicles");

		end

	end

	---@return Vehicle[]
	function self:GetVehiclesOut()
		return self.vehiclesOut;
	end

	---@plate string
	---@param vehicle Vehicle
	function self:SetVehicleOut(plate, vehicle)
		self.vehiclesOut[plate] = vehicle:GetHandle();
	end

	---@param plate string
	---@return boolean
	function self:IsVehicleOut(plate)
		return self.data.vehicles[plate] and self.data.vehicles[plate].stored ~= 1 and self:DoesVehicleOutExist(plate);
	end

	---@plate string
	---@return boolean
	function self:DoesVehicleOutExist(plate)
		return self.vehiclesOut[plate] ~= nil and DoesEntityExist(self.vehiclesOut[plate]);
	end

	---@plate string
	function self:StoreVehicle(plate)

		if (self.vehiclesOut[plate]) then

			self.vehiclesOut[plate] = nil;

		end

	end

	---@return table
	function self:GetWeapons()
		return self.data.weapons;
	end

	---@param weaponName string
	---@return table | nil
	function self:GetWeapon(weaponName)
		return self.data.weapons[weaponName];
	end

	---@param weaponName string
	---@return boolean
	function self:HasWeapon(weaponName)
		return self.data.weapons[weaponName] ~= nil;
	end

	---@param weaponName string
	---@param weaponIndex number
	---@param components table
	---@return boolean
	function self:HasWeaponComponent(weaponName, weaponIndex, components)

		local weapon = self:GetWeapon(weaponName);

		if (weapon) then

			if (weapon[weaponIndex]) then

				for i = 1, #self.weapons[weaponName][weaponIndex].components do

					if (self.weapons[weaponName][weaponIndex].components[i] == components) then
						return true;
					end

				end

			end

		end

	end

	---@param weaponName string
	---@param weaponIndex number
	---@param componentsToCheck table
	---@return boolean
	function self:WeaponComponentsEqual(weaponName, weaponIndex, componentsToCheck)

		local weapon = self:GetWeapon(weaponName);

		if (weapon) then

			if (weapon[weaponIndex]) then

				local weaponComponents = weapon[weaponIndex].components;
				local weaponToCheckComponents = componentsToCheck and componentsToCheck;

				if (weaponToCheckComponents) then

					if (#weaponComponents == #weaponToCheckComponents) then

						for i = 1, #weaponComponents do

							if (not self:HasWeaponComponent(weaponName, weaponIndex, weaponToCheckComponents[i])) then
								return false;
							end

						end

						return true;

					end

				else

					return true;

				end

			end

		end

		return false;

	end

	---@param weaponName string
	---@param ammo number
	---@return boolean
	function self:HasWeaponWithAmmoAndComponents(weaponName, ammo, components)

		local weapon = self:GetWeapon(weaponName);

		if (weapon) then

			for i = 1, #weapon do

				if (weapon[i].ammo == tonumber(ammo)) then

					if (
						components == nil or
							(
								type(components) == "table"
								and weapon[i].components == 0
								and #components == 0
							)
					)
					then
						return true;
					elseif (
						(
							(
								components
								and type(components) == "table"
								and self:WeaponComponentsEqual(weaponName, i, components or {})
							)
						)
					)
					then

						return true;

					end

				end

			end

		end

		return false;

	end

	---@param weaponData table
	---@param ammo number
	function self:AddWeapon(weaponData, ammo)

		local weaponExist, weapon = ESX.GetWeapon(weaponData.name);

		if (weaponExist) then

			if (weaponData and type(weaponData) == "table") then

				if (not self.data.weapons[weapon.name]) then

					self.data.weapons[weapon.name] = {};

				end

				table.insert(
					self.data.weapons[weapon.name],
					{
						name = weapon.name,
						label = weapon.label,
						ammo = ammo and tonumber(ammo) or 0,
						components = weaponData.components,
					}
				);

				self:Update("weapons");

			end

		end

	end

	---@param weaponName string
	---@param ammo number
	---@param components table
	---@return boolean
	function self:RemoveWeapon(weaponName, ammo, components)

		if (self.data.weapons[weaponName]) then

			local storageWeapon = self:GetWeapon(weaponName);

			if (storageWeapon) then

				for i = 1, #storageWeapon do

					if (self:HasWeaponWithAmmoAndComponents(weaponName, tonumber(ammo), components)) then

						table.remove(storageWeapon, i);

						if (#storageWeapon == 0) then
							self.data.weapons[weaponName] = nil;
						end

						self:Update("weapons");

						return true;

					end

				end

			end

		end

		return false;

	end

	---Reset all weapons from society storage (Delete all weapons from sql and storage)
	function self:ResetWeapons()
		self.data.weapons = {};
		self:Update("weapons");
	end

	---@return number
	function self:GetMaxWeight()
		return self.maxWeight;
	end

	---@return number
	function self:GetWeight()
		return self.weight;
	end

	---Update the weight of the storage (Items only)
	function self:UpdateWeight()

		self.weight = 0;
		for itemName, storageItem in pairs(self.data.items) do

			local item = ESX.GetItem(itemName);

			if (item) then

				self.weight = self.weight + (item.weight * storageItem.count);

			end

		end

	end

	---@param itemName string
	---@param count number
	---@return boolean
	function self:CanAddItem(itemName, count)

		local item = ESX.GetItem(itemName);

		if (item) then
			return self.weight + (item.weight * count) <= self.maxWeight;
		end

		return false;

	end

	---@return table
	function self:GetItems()
		return self.data.items;
	end

	---@param itemName string
	---@return table | nil
	function self:GetItem(itemName)
		return self.data.items[itemName];
	end

	---@param itemName string
	---@return boolean
	function self:HasItem(itemName)
		return self.data.items[itemName] ~= nil;
	end

	---@param itemName string
	---@param count number
	---@return boolean
	function self:AddItem(itemName, count)

		local item = ESX.GetItem(itemName);

		if (item) then

			if (self:CanAddItem(itemName, count)) then

				if (not self.data.items[itemName]) then
					self.data.items[itemName] = {
						name = itemName,
						count = count,
						label = item.label
					};

					self:UpdateWeight();
					self:Update("items");

					return true;
				else

					self.data.items[itemName].count = self.data.items[itemName].count + count;
					self:UpdateWeight();
					self:Update("items");

					return true;

				end

			end

			return false;

		end

	end

	---@param itemName string
	---@param count number
	function self:RemoveItem(itemName, count)

		if (self.data.items[itemName]) then

			local oldCount = self.data.items[itemName].count;

			if (oldCount) then

				if (oldCount - count < 0) then
					return false;
				elseif (oldCount - count == 0) then
					self.data.items[itemName] = nil;
				else
					self.data.items[itemName].count = oldCount - count;
				end

				self:UpdateWeight();
				self:Update("items");

				return true;

			end

		end

		return false;

	end

	---Reset all items from society storage (Delete all items from sql and storage)
	function self:ResetItems()
		self.data.items = {};
		self:Update("items");
	end

	---@return number
	function self:GetMoney()
		return self.data.money;
	end

	---@param amount number
	function self:AddMoney(amount)
		self.data.money = self.data.money + tonumber(amount);
		self:Update("money");
	end

	---@param amount number
	function self:RemoveMoney(amount)
		self.data.money = self.data.money - tonumber(amount);
		self:Update("money");
	end

	---Reset all money from society storage (Delete all money from sql and storage)
	function self:ResetMoney()
		self.data.money = 0;
		self:Update("money");
	end

	---@return number
	function self:GetDirtyMoney()
		return self.data.dirty_money;
	end

	---@param amount number
	function self:AddDirtyMoney(amount)
		self.data.dirty_money = self.data.dirty_money + tonumber(amount);
		self:Update("dirty_money");
	end

	---@param amount number
	function self:RemoveDirtyMoney(amount)
		self.data.dirty_money = self.data.dirty_money - tonumber(amount);
		self:Update("dirty_money");
	end

	---Reset all DirtyMoney from society storage (Delete all DirtyMoney from sql and storage)
	function self:ResetDirtyMoney()
		self.data.dirty_money = 0;
		self:Update("dirty_money");
	end

	---@param dataType string
	function self:Update(dataType)

		if (not dataType) then

			MySQL.Async.execute("UPDATE `societies_storage` SET `vehicles` = @vehicles, `weapons` = @weapons, `items` = @items WHERE `name` = @name", {

				["@name"] = self.name,
				["@vehicles"] = json.encode(self.data["vehicles"]),
				["@weapons"] = json.encode(self.data["weapons"]),
				["@items"] = json.encode(self.data["items"]),
				["@money"] = self.data["money"],
				["@black_money"] = self.data["dirty_money"]

			});

		else

			if (self.data[dataType]) then

				MySQL.Async.execute(("UPDATE `societies_storage` SET `%s` = @%s WHERE `name` = @name"):format(dataType, dataType), {
					["@name"] = self.name,
					[("@%s"):format(dataType)] = json.encode(self.data[dataType])
				});

			end

		end

	end

	return self;

end);