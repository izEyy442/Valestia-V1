---@return xPlayer
function CreatePlayer(source, identifier, userData)
	---@class xPlayer
	local self = {};

	self.source = source
	self.identifier = identifier

	self.character_id = userData.character_id
	self.name = userData.name
	self.accounts = userData.accounts
	self.job = userData.job
	self.job2 = userData.job2
	self.inventory = userData.inventory
	self.loadout = userData.loadout
	self.weapons = {};
	self.lastPosition = userData.lastPosition
	self.maxWeight = Config.MaxWeight
	self.xp = userData.xp;
	self.vip = userData.vip;
	self.firstname = userData.firstname;
	self.lastname = userData.lastname;
	self.ammo = userData.ammo;
	self.dead = (userData.isDead == 1 and true) or false;
	self.hurt = (userData.isHurt == 1 and true) or false;

	self.positionSaveReady = false

	for i = 1, #self.loadout do
		self.weapons[self.loadout[i].name] = i;
	end

	---@return boolean
	self.isDead = function()
		return self.dead;
	end

	---@return boolean
	self.isHurt = function()
		return self.hurt;
	end

	---@param hurt boolean | number 0 or 1
	self.setHurt = function(hurt)

		local isHurt = (hurt == 1 or hurt == true and 1) or 0;

		self.hurt = (isHurt == 1 and true) or false;

		MySQL.update('UPDATE users SET IsHurt = ? WHERE identifier = ?', {
			isHurt,
			self.identifier
		});

	end

	---@param dead boolean | number 0 or 1
	self.setDead = function(dead)

		local isDead = (dead == 1 or dead == true and 1) or 0;

		self.dead = (isDead == 1 and true) or false;

		if (self.dead) then
			if (self.hasWeapon('gadget_parachute')) then
				self.removeWeapon('gadget_parachute');
			end
		end

		MySQL.update('UPDATE users SET isDead = ? WHERE identifier = ?', {

			isDead,
			self.identifier

		});

	end

	self.onRevive = function()

		for i = 1, #self.loadout do
			if (type(self.loadout[i]) == "table") then
				if (not ESX.IsWeaponPermanent(self.loadout[i].name)) then
					self.removeWeapon(self.loadout[i].name);
				end
			end
		end

		self.updateVIP(function(vip)
			if (vip == 0) then
				self.setAmmoData({});
				self.showNotification("Vous avez ~y~perdu~s~ toutes vos armes ~c~(~y~sauf les armes permanentes~c~)~s~ ainsi que toutes vos munitions !");
			else
				self.showNotification("Vous avez ~y~perdu~s~ toutes vos armes ~c~(~y~sauf les armes permanentes~c~)~s~ !");
			end
		end);
	end

	---@return string
	self.getFirstName = function()
		return self.firstname;
	end

	---@return string
	self.getLastName = function()
		return self.lastname;
	end

	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	self.chatMessage = function(msg, author, color)
		self.triggerEvent('chat:addMessage', {color = color or {0, 0, 0}, args = {author or 'SYSTEME', msg or ''}})
	end

	---@param callback fun(vip: number)
	function self.updateVIP(callback)

		local truncateIdentifier = string.sub(identifier, 9, identifier:len());

		MySQL.Async.fetchAll('SELECT * FROM tebex_accounts WHERE steam = @steam', {
			['@steam'] = truncateIdentifier
		}, function(result)

			if (result[1]) then
				self.vip = result[1].vip;
			end

			if (callback) then callback((self.vip or 0)) end

		end);

	end

	function self.getVIP()
		return self.vip;
	end

	function self.getXP()
		return self.xp;
	end

	function self.setXP(xp)
		self.xp = xp;
		self.saveXP();
		self.triggerEvent("vCore3:updateXP", self.xp);
	end

	function self.addXP(xp)
		self.updateVIP(function()
			local xpToSend = xp * (self.getVIP() == 2 and 2 or self.getVIP() == 3 and 4 or 1);
			self.xp = self.xp + xpToSend;
			self.saveXP();
			self.triggerEvent("vCore3:addXP", xpToSend);
		end);
	end

	function self.removeXP(xp)
		self.xp = self.xp - xp;
		self.saveXP();
		self.triggerEvent("vCore3:removeXP", xp);
	end

	function self.saveXP()
		MySQL.Async.execute('UPDATE users SET xp = @xp WHERE identifier = @identifier', {
			['@identifier'] = self.identifier,
			['@xp'] = self.xp
		});
	end

	self.kick = function(reason)
		DropPlayer(self.source, ("\n\nVous avez été kick :\n\n%s\n\ndiscord.gg/valestiarp"):format(reason))
	end

	self.set = function(key, value)
		self[key] = value
	end

	self.get = function(key)
		return self[key]
	end

	self.getGroup = function()
		return exports["vCore3"]:GetPlayerGroup(self) or "user"
	end


	self.setGroup = function(groupName)
		local lastGroup = self.getGroup();

		if exports["vCore3"]:GetGroup(groupName) ~= nil then

			exports["vCore3"]:AddPlayerToGroup(self, groupName)
			TriggerEvent('esx:setGroup', self.source, groupName, lastGroup);
			self.triggerEvent('esx:setGroup', groupName, lastGroup);
		else

			print(('[^3WARNING^7] Ignoring invalid .setGroup() usage for "%s"'):format(self.identifier))
		end

	end

	self.getLevel = function()
		local player_group = self.getGroup()
		return (player_group ~= nil and exports["vCore3"]:GetGroup(player_group) ~= nil and exports["vCore3"]:GetGroup(player_group).level or 0)
	end

	self.getAccount = function(accountName)
		for i = 1, #self.accounts, 1 do
			if self.accounts[i].name == accountName then
				return self.accounts[i]
			end
		end
	end

	self.getAccounts = function(minimal)
		if minimal then
			local minimalAccounts = {}

			for i = 1, #self.accounts, 1 do
				table.insert(minimalAccounts, {
					name = self.accounts[i].name,
					money = self.accounts[i].money
				})
			end

			return minimalAccounts
		else
			return self.accounts
		end
	end

	self.getCharacter = function()
		return self.character_id
	end

	self.getIdentifier = function()
		return self.identifier
	end

	self.getInventory = function(minimal)
		if minimal then
			local minimalInventory = {}

			for i = 1, #self.inventory, 1 do
				table.insert(minimalInventory, {
					name = self.inventory[i].name,
					count = self.inventory[i].count,
					extra = ESX.Items[self.inventory[i].name].unique and self.inventory[i].extra or nil
				})
			end

			return minimalInventory
		else
			return self.inventory
		end
	end

	self.getLoadout = function()
		return self.loadout
	end

	self.getJob = function()
		return self.job
	end

	self.getJob2 = function()
		return self.job2
	end

	self.getName = function()
		return self.name
	end

	self.setName = function(name)
		self.name = name
	end

	self.getCoords = function()
		local coords = GetEntityCoords(GetPlayerPed(self.source))

		if type(coords) ~= 'vector3' or ((coords.x >= -1.0 and coords.x <= 1.0) and (coords.y >= -1.0 and coords.y <= 1.0) and (coords.z >= -1.0 and coords.z <= 1.0)) then
			coords = self.getLastPosition()
		end

		return coords
	end

	self.getLastPosition = function()
		return self.lastPosition
	end

	self.setLastPosition = function(coords)
		self.lastPosition = coords
	end

	self.setAccountMoney = function(accountName, money)
		money = ESX.Math.Check(ESX.Math.Round(money))

		if money >= 0 then
			local account = self.getAccount(accountName)

			if account then
				account.money = money
				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.addAccountMoney = function(accountName, money)
		money = ESX.Math.Check(ESX.Math.Round(money))

		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = ESX.Math.Check(account.money + money)
				account.money = newMoney
				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.removeAccountMoney = function(accountName, money)
		money = ESX.Math.Check(ESX.Math.Round(money))

		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = ESX.Math.Check(account.money - money)
				account.money = newMoney
				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.hasInventoryItem = function(name)
		for i = 1, #self.inventory, 1 do
			if self.inventory[i].name == name then
				return true
			end
		end

		return false
	end

	self.getInventoryItem = function(name, identifier)
		for i = 1, #self.inventory, 1 do
			if self.inventory[i].name == name and (not identifier or (ESX.Items[name].unique and self.inventory[i].extra.identifier == identifier)) then
				return self.inventory[i], i
			end
		end

		return {
			name = name,
			count = 0,
			label = ESX.Items[name].label or 'Undefined',
			weight = ESX.Items[name].weight or 1.0,
			canRemove = ESX.Items[name].canRemove or false,
			unique = ESX.Items[name].unique or false,
			extra = ESX.Items[name].unique and {} or nil
		}, false
	end

	self.addInventoryItem = function(name, count, extra)
		if type(name) ~= 'string' then return end
		if type(count) ~= 'number' then return end
		if ESX.Items[name] == nil then return end
		count = ESX.Math.Round(count)
		if count < 1 then return end

		local item, itemIndex = self.getInventoryItem(name, false)

		if ESX.Items[name].unique then
			local item = {
				name = name,
				count = 1,
				label = ESX.Items[name].label or 'Undefined',
				weight = ESX.Items[name].weight or 1.0,
				canRemove = ESX.Items[name].canRemove or false,
				unique = ESX.Items[name].unique or false,
				extra = extra or {}
			}

			table.insert(self.inventory, item)
			TriggerEvent('esx:onAddInventoryItem', self.source, item)
			self.triggerEvent('esx:addInventoryItem', item)
		else
			if item and itemIndex then
				local newCount = item.count + count

				if newCount > 0 then
					item.count = newCount
					TriggerEvent('esx:onUpdateItemCount', self.source, true, item.name, newCount)
					self.triggerEvent('esx:updateItemCount', item.name, newCount)
				end
			else
				local item = {
					name = name,
					count = count,
					label = ESX.Items[name].label or 'Undefined',
					weight = ESX.Items[name].weight or 1.0,
					canRemove = ESX.Items[name].canRemove or false,
					unique = ESX.Items[name].unique or false
				}

				table.insert(self.inventory, item)
				TriggerEvent('esx:onAddInventoryItem', self.source, item)
				self.triggerEvent('esx:addInventoryItem', item)
			end
		end
	end

	self.removeInventoryItem = function(name, count, identifier)
		if type(name) ~= 'string' then return end
		if type(count) ~= 'number' then return end
		if ESX.Items[name] == nil then return end
		count = ESX.Math.Round(count)
		if count < 1 then return end

		local item, itemIndex = self.getInventoryItem(name, identifier)

		if item and itemIndex then
			if ESX.Items[name].unique then
				table.remove(self.inventory, itemIndex)
				TriggerEvent('esx:onRemoveInventoryItem', self.source, item)
				self.triggerEvent('esx:removeInventoryItem', item)
			else
				local newCount = item.count - count

				if newCount > 0 then
					item.count = newCount
					TriggerEvent('esx:onUpdateItemCount', self.source, false, item.name, newCount)
					self.triggerEvent('esx:updateItemCount', item.name, newCount)
				else
					table.remove(self.inventory, itemIndex)
					TriggerEvent('esx:onRemoveInventoryItem', self.source, item)
					self.triggerEvent('esx:removeInventoryItem', item)
				end
			end
		end
	end

	self.setInventoryItem = function(name, count, identifier)
		local item = self.getInventoryItem(name, identifier)

		if item and count >= 0 then
			count = ESX.Math.Round(count)

			if count > item.count then
				self.addInventoryItem(item.name, count - item.count)
			else
				self.removeInventoryItem(item.name, item.count - count)
			end
		end
	end

	self.getWeight = function()
		local inventoryWeight = 0

		for i = 1, #self.inventory, 1 do
			inventoryWeight = inventoryWeight + (self.inventory[i].count * self.inventory[i].weight)
		end

		return inventoryWeight
	end

	self.canCarryItem = function(name, count)
		local currentWeight, itemWeight = self.getWeight(), ESX.Items[name].weight
		local newWeight = currentWeight + (itemWeight * count)

		return newWeight <= self.maxWeight
	end

	self.canSwapItem = function(firstItem, firstItemCount, testItem, testItemCount)
		local firstItemObject = self.getInventoryItem(firstItem)

		if firstItemObject.count >= firstItemCount then
			local weightWithoutFirstItem = ESX.Math.Round(self.getWeight() - (ESX.Items[firstItem].weight * firstItemCount))
			local weightWithTestItem = ESX.Math.Round(weightWithoutFirstItem + (ESX.Items[testItem].weight * testItemCount))

			return weightWithTestItem <= self.maxWeight
		end

		return false
	end

	---@param weaponType string
	function self.GetAmmoForWeaponType(weaponType)
		return self.ammo[weaponType] ~= nil and self.ammo[weaponType] or 0
	end

	function self.GetAmmo()
		return self.ammo
	end

	function self.setLoadoutData(loadoutData)
		self.loadout = loadoutData;
	end

	function self.setAmmoData(ammoData)
		self.ammo = ammoData;
		self.triggerEvent('esx:refreshLoadout', self.loadout, self.ammo);
	end

	---@param weaponName string
	---@param ammo number
	---@return boolean
	function self.addGroupAmmo(weaponName, ammo)

        ammo = ammo and tonumber(ammo) or 0;

		local weaponType = ESX.GetWeaponType(weaponName);

		if (weaponType) then

			if (not self.ammo[weaponType]) then

				self.ammo[weaponType] = ammo;

			else

				self.ammo[weaponType] = self.ammo[weaponType] + ammo;

			end

			return self.ammo[weaponType];
		end

		return 0;

	end

	---@param weaponName string
	---@param ammo number
	---@return boolean
	function self.removeGroupAmmo(weaponName, ammo)

		ammo = ammo and tonumber(ammo) or 0;

		local weaponType = ESX.GetWeaponType(weaponName);

		if (weaponType) then

			if (not self.ammo[weaponType]) then

				self.ammo[weaponType] = 0;
				return self.ammo[weaponType];

			end

			if (not ammo) then

				return self.ammo[weaponType];

			end

			if (self.ammo[weaponType] and self.ammo[weaponType] - tonumber(ammo) < 0) then
				return false;
			end

			self.ammo[weaponType] = self.ammo[weaponType] - ammo;

			return self.ammo[weaponType];
		end

		return 0;

	end

	---@param weaponName string
	---@param ammo number
	---@return boolean
	function self.updateGroupAmmo(weaponName, ammo)

		ammo = ammo and tonumber(ammo) or 0;

		local weaponType = ESX.GetWeaponType(weaponName);

		if (weaponType) then

			if (ammo < 0) then
				return false;
			end

			if (not self.ammo[weaponType]) then
				self.ammo[weaponType] = 0;
			end

			self.ammo[weaponType] = ammo;

			return self.ammo[weaponType];
		end

		return 0;

	end

	---@param weaponName string
	---@param ammo number
	---@return boolean
	self.addWeapon = function(weaponName, ammo)

		if type(weaponName) ~= 'string' then return end
		weaponName = string.upper(weaponName);

		if not self.hasWeapon(weaponName) then
			local weaponLabel = ESX.GetWeaponLabel(weaponName);
			local weaponAmmo = self.addGroupAmmo(weaponName, tonumber(ammo));

			if (weaponAmmo ~= false) then

				table.insert(self.loadout, {
					name = weaponName,
					label = weaponLabel,
					components = {}
				})

				self.triggerEvent('esx:addWeapon', weaponName, weaponAmmo ~= false and weaponAmmo or 0);
				return true;

			end

			self.weapons = {};
			for i = 1, #self.loadout do
				self.weapons[self.loadout[i].name] = i;
			end

		end

		return false;

	end

	---@param weaponArray table
	self.addWeaponArray = function(weaponArray, callback, refresh)

		if type(weaponArray) ~= 'table' then return; end

		for _, weapon in pairs(weaponArray) do

			if (type(weapon) == "table" and weapon.name) then
				if not self.hasWeapon(weapon.name) then
					local weaponLabel = ESX.GetWeaponLabel(weapon.name);

					table.insert(self.loadout, {
						name = weapon.name,
						label = weaponLabel,
						components = type(weapon.components) == "table" and weapon.components or {}
					});

				end
			end

		end

		self.weapons = {};
		for i = 1, #self.loadout do
			self.weapons[self.loadout[i].name] = i;
		end

		if (callback) then  callback(); end

		if (refresh) then
			self.triggerEvent('esx:refreshLoadout', self.loadout, self.ammo);
		end

	end

	self.addWeaponComponent = function(weaponName, weaponComponent)
		if type(weaponName) ~= 'string' then return; end
		if type(weaponComponent) ~= 'string' then return; end
		weaponName = string.upper(weaponName)
		weaponComponent = string.lower(weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if not self.hasWeaponComponent(weaponName, weaponComponent) then
					table.insert(self.loadout[loadoutNum].components, weaponComponent)
					self.triggerEvent('esx:addWeaponComponent', weaponName, weaponComponent)
				end
			end
		end
	end

	self.addWeaponAmmo = function(weaponName, ammoCount)
		if type(weaponName) ~= 'string' then return end
		weaponName = string.upper(weaponName)
		ammoCount = tonumber(ammoCount) or 0
		local _, weapon = self.getWeapon(weaponName);

		if (weapon) then

			local weaponAmmo = self.addGroupAmmo(weaponName, tonumber(ammoCount));

			if (weaponAmmo) then

				self.triggerEvent('esx:setWeaponAmmo', weaponName, weaponAmmo);
				return true;

			end
		end

		return false;
	end

	self.removeWeapon = function(weaponName, ammo)
		if type(weaponName) ~= 'string' then return end
		weaponName = string.upper(weaponName)
		ammo = ammo and tonumber(ammo) or 0

		local weaponAmmo = self.removeGroupAmmo(weaponName, tonumber(ammo));

		for i = 1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName then

				for j = 1, #self.loadout[i].components, 1 do
					self.removeWeaponComponent(weaponName, self.loadout[i].components[j]);
				end
				table.remove(self.loadout, i);
				self.triggerEvent('esx:removeWeapon', weaponName, weaponAmmo ~= false and weaponAmmo or 0);
				break
			end
		end

		self.weapons = {};
		for i = 1, #self.loadout do
			self.weapons[self.loadout[i].name] = i;
		end
		return true;

	end

	---@param weaponArray table
	function self.removeWeaponArray(weaponArray, refresh)

		if type(weaponArray) ~= 'table' then return end

		for _, weapon in pairs(weaponArray) do

			if (type(weapon) == "table" and weapon.name ~= nil) then
				for i = 1, #self.loadout, 1 do
					if (self.loadout[i]) then
						if (self.loadout[i].name == weapon.name) then

							for j = 1, #self.loadout[i].components, 1 do
								self.removeWeaponComponent(weapon.name, self.loadout[i].components[j]);
							end

							table.remove(self.loadout, i);
							break;
						end
					end
				end

				self.weapons = {};
				for i = 1, #self.loadout do
					self.weapons[self.loadout[i].name] = i;
				end

			end

		end

		if (refresh) then
			self.triggerEvent('esx:refreshLoadout', self.loadout, self.ammo);
		end

	end

	---Remove all weapon from player
	---@param callback? function
	function self.removeAllWeapons(callback, refresh)

		for i = 1, #self.loadout, 1 do
			if (type(self.loadout[i]) == "table" and self.loadout[i].name ~= nil) then

				local weaponName = self.loadout[i].name;
				local weaponType = ESX.GetWeaponType(self.loadout[i].name);
				local weaponAmmo = self.removeGroupAmmo(weaponName, self.GetAmmoForWeaponType(weaponType));
				RemoveWeaponFromPed(GetPlayerPed(self.source), GetHashKey(weaponName));
				table.remove(self.loadout, i);
			end
		end

		self.loadout = {};
		self.weapons = {};

		if (refresh) then
			self.triggerEvent('esx:refreshLoadout', {}, self.ammo);
		end

		if (callback) then callback(); end

	end

	function self.refreshWeaponsAndAmmo()
		self.triggerEvent('esx:refreshLoadout', self.loadout, self.ammo);
	end

	self.removeWeaponComponent = function(weaponName, weaponComponent)
		if type(weaponName) ~= 'string' then return end
		if type(weaponComponent) ~= 'string' then return end
		weaponName = string.upper(weaponName)
		weaponComponent = string.lower(weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if self.hasWeaponComponent(weaponName, weaponComponent) then
					for i = 1, #self.loadout[loadoutNum].components, 1 do
						if self.loadout[loadoutNum].components[i] == weaponComponent then
							table.remove(self.loadout[loadoutNum].components, i)
							break
						end
					end

					self.triggerEvent('esx:removeWeaponComponent', weaponName, weaponComponent)
				end
			end
		end
	end

	self.removeWeaponAmmo = function(weaponName, ammoCount)
		if type(weaponName) ~= 'string' then return end
		weaponName = string.upper(weaponName)
		local _, weapon = self.getWeapon(weaponName)

		if weapon then

			local weaponAmmo = self.removeGroupAmmo(weaponName, tonumber(ammoCount));

			if (weaponAmmo) then

				self.triggerEvent('esx:setWeaponAmmo', weaponName, weaponAmmo);
				return true;
			end
		end

		return false;
	end

	self.hasWeaponComponent = function(weaponName, weaponComponent)
		if type(weaponName) ~= 'string' then return end
		if type(weaponComponent) ~= 'string' then return end
		weaponName = string.upper(weaponName)
		weaponComponent = string.lower(weaponComponent)
		local _, weapon = self.getWeapon(weaponName)

		if weapon then
			for i = 1, #weapon.components, 1 do
				if weapon.components[i] == weaponComponent then
					return true
				end
			end

			return false
		else
			return false
		end
	end

    self.hasWeapon = function(weaponName)
        if type(weaponName) ~= 'string' then return end
        weaponName = string.upper(weaponName)

        for i = 1, #self.loadout, 1 do
            if self.loadout[i].name == weaponName or tostring(GetHashKey(self.loadout[i].name)) == tostring(weaponName) then
                return true
            end
        end

        return false
    end

	---@param weaponName string
	---@return number | nil
	self.GetWeaponIndex = function(weaponName)

		local name = type(weaponName) == 'string' and string.upper(weaponName) or nil;

		if (name) then
			return self.weapons[name];
		end
		return nil;

	end

	self.getWeapon = function(weaponName)
		if type(weaponName) ~= 'string' then return end
		weaponName = string.upper(weaponName)

		for i = 1, #self.loadout, 1 do
			if self.loadout[i].name == weaponName or tostring(GetHashKey(self.loadout[i].name)) == tostring(weaponName) then
				return i, self.loadout[i]
			end
		end

		return
	end

	self.setJob = function(job, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.job))

		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			local skins = ESX.ConvertJobSkins(gradeObject);

			self.job.id = jobObject.id or nil
			self.job.name = jobObject.name
			self.job.label = jobObject.label
			self.job.canWashMoney = jobObject.canWashMoney
			self.job.canUseOffshore = jobObject.canUseOffshore

			self.job.grade = tonumber(grade)
			self.job.grade_name = gradeObject.name
			self.job.grade_label = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			if gradeObject.skin_male then
				self.job.skin_male = skins["male"];
			end

			if gradeObject.skin_female then
				self.job.skin_female = skins["female"];
			end

			TriggerEvent('esx:setJob', self.source, self.job, lastJob)
			self.triggerEvent('esx:setJob', self.job)
		else
			print(('[^3WARNING^7] Ignoring invalid .setJob() usage for "%s"'):format(self.identifier))
		end
	end

	self.setJob2 = function(job2, grade2)
		grade2 = tostring(grade2)
		local lastJob2 = json.decode(json.encode(self.job2))

		if ESX.DoesJobExist(job2, grade2) then
			local job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]

			local skins = ESX.ConvertJobSkins(grade2Object);

			self.job2.id = job2Object.id
			self.job2.name = job2Object.name
			self.job2.label = job2Object.label
			self.job2.canWashMoney = job2Object.canWashMoney
			self.job2.canUseOffshore = job2Object.canUseOffshore

			self.job2.grade = tonumber(grade2)
			self.job2.grade_name = grade2Object.name
			self.job2.grade_label = grade2Object.label
			self.job2.grade_salary = grade2Object.salary

			if grade2Object.skin_male ~= nil then
				self.job2.skin_male = skins["male"];
			end

			if grade2Object.skin_female ~= nil then
				self.job2.skin_female = skins["female"];
			end

			TriggerEvent('esx:setJob2', self.source, self.job2, lastJob2)
			self.triggerEvent('esx:setJob2', self.job2)
		else

			print(('[^3WARNING^7] Ignoring invalid .setJob() usage for "%s"'):format(self.identifier))

		end
	end

	self.setMaxWeight = function(newWeight)
		newWeight = ESX.Math.Round(newWeight)

		if newWeight > 0 then
			self.maxWeight = newWeight
			self.triggerEvent('esx:setMaxWeight', self.maxWeight)
		end
	end

	self.showNotification = function(msg, hudColorIndex)
		self.triggerEvent('esx:showNotification', msg, hudColorIndex)
	end

	self.showAdvancedNotification = function(title, subject, msg, icon, iconType, hudColorIndex)
		self.triggerEvent('esx:showAdvancedNotification', title, subject, msg, icon, iconType, hudColorIndex)
	end

	self.showHelpNotification = function(msg)
		self.triggerEvent('esx:showHelpNotification', msg)
	end

	---@param time number
	---@param message string
	self.ban = function(time, message)
		TriggerClientEvent("playsongtroll", self.source)
		exports["WaveShield"]:banPlayer(self.source, "Valestia banned", message, "Main", 31536000)
	end

	ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.identifier, self.getGroup()))

	return self
end
