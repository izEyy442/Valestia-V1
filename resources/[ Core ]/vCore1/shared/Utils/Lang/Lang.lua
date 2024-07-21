---@type Lang
Lang = Class.new(function(class)

	---@class Lang: BaseObject
	local self = class;

	function self:Constructor()
		self.selected = Config["Language"] or "fr";
		self.languages = {};
	end

	---@param lang string
	function self:SetSelected(lang)
		self.selected = lang;
	end

	---@return string
	function self:GetSelected()
		return self.selected;
	end

	---@param langName string Name of the language
	---@param data table
	function self:Create(langName, data)
		self.languages[string.upper(langName)] = data
	end

	---@param langName string Name of the language
	---@param data table
	function self:Insert(langName, data)
		local lang = self.languages[string.upper(langName)];
		if (lang) then
			for key, value in pairs(data) do
				self.languages[string.upper(langName)][key] = value;
			end
		end
	end

	---@private
	---@param str string
	---@param ... any
	function self:Convert(str, ...)  -- Translate string

		if self.languages[string.upper(self.selected)] ~= nil then
			
			if self.languages[string.upper(self.selected)][str] ~= nil then
				return string.format(self.languages[string.upper(self.selected)][str], ...)
			else
				if (not IsDuplicityVersion()) then
					return 'Missing entry for [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~'..str..'~s~]'
				else
					return '^7Missing entry for ^0[^1'..str..'^0]^7'
				end
			end

		else
			if (not IsDuplicityVersion()) then
				return 'Locale [~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~' .. string.upper(self.selected) .. '~s~] does not exist, Please set it in the server.cfg'
			else
				return '^7Locale ^0[^1' .. string.upper(self.selected) .. '^0]^7 does not exist, Please set it in the server.cfg'
			end
		end

	end

	---@param str string
	---@param ... any
	function self:Translate(str, ...) -- Translate string first char uppercase
		return tostring(self:Convert(str, ...):gsub("^%l", string.upper));
	end

	return self;
end)