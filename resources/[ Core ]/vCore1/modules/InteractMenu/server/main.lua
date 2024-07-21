local identifier
local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }
local RockstarRanks = {800, 2100, 3800, 6100, 9500, 12500, 16000, 19800, 24000, 28500, 33400, 38700, 44200, 50200,56400, 63000, 69900, 77100, 84700, 92500, 100700, 109200, 118000, 127100, 136500, 146200, 156200,166500, 177100, 188000, 199200, 210700, 222400, 234500, 246800, 259400, 272300, 285500, 299000,312700, 326800, 341000, 355600, 370500, 385600, 401000, 416600, 432600, 448800, 465200, 482000,499000, 516300, 533800, 551600, 569600, 588000, 606500, 625400, 644500, 663800, 683400, 703300,723400, 743800, 764500, 785400, 806500, 827900, 849600, 871500, 893600, 916000, 938700, 961600,984700, 1008100, 1031800, 1055700, 1079800, 1104200, 1128800, 1153700, 1178800, 1204200, 1229800,1255600, 1281700, 1308100, 1334600, 1361400, 1388500, 1415800, 1443300, 1471100, 1499100,1527300, 1555800, 1584350}

---@param playerId number
local function GetIdentifier(playerId)
    for k, v in ipairs(GetPlayerIdentifiers(playerId)) do
    	if string.match(v, 'fivem:') then
        	local identifier = string.gsub(v, 'fivem:', '')
        	return identifier
      	end
    end

    return false
end
  
local function CreateRandomPlateTextForXP()
    local plate = ""

    math.randomseed(GetGameTimer())

    for i = 1, 4 do
        plate = plate .. characters[math.random(1, #characters)]
    end

    plate = plate .. ""

    for i = 1, 4 do
        plate = plate .. math.random(1, 9)
    end

    return plate
end

local function is_int(n)
    if type(n) == "number" then

        if math.floor(n) == n then
            return true
        end

    end
	
    return false
end

local players = {}
local playersTimed = {}
  
RegisterNetEvent('vCore1:pass:gift', function(level)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = GetIdentifier(source)

	if (not playersTimed[xPlayer.identifier] or GetGameTimer() - playersTimed[xPlayer.identifier] > 1000) then
		playersTimed[xPlayer.identifier] = GetGameTimer()

		if (identifier) then

			if (xPlayer) then

				if (players[xPlayer.identifier]) then

					if (players[xPlayer.identifier] >= level) then 
						return xPlayer.showNotification("Vous avez déjà reçu cette récompense")
					end

					if (players[xPlayer.identifier] <= level) then
						local closestReward = Config["BattlePass"]["Gift"][1]

						for i = 2, #Config["BattlePass"]["Gift"] do
							if math.abs(Config["BattlePass"]["Gift"][i].level - level) < math.abs(closestReward.level - level) then
								closestReward = Config["BattlePass"]["Gift"][i]
							end
						end

						if closestReward.gift_type == 'car' then
							local plate = CreateRandomPlateTextForXP()

							MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state, boutique) VALUES (@owner, @plate, @vehicle, @state, @boutique)', {
								['@owner']   = xPlayer.identifier,
								['@plate']   = plate,
								['@vehicle'] = json.encode({ model = GetHashKey(closestReward.gift), plate = plate }),
								['@state']   = 1,
								['@boutique']  = 1
							}, function(rowsChange) end)
							
							ESX.GiveCarKey(xPlayer, plate)

						elseif closestReward.gift_type  == 'coins' then

							MySQL.Async.execute('INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@identifiers, @transaction, @price, @currency, @points)', {
								['@identifiers'] = identifier,
								['@transaction'] = 'Récompense VicePass',
								['@price'] = 0,
								['@currency'] = 'Points',
								['@points'] = closestReward.gift
							}, function(rowsChange) end)

						elseif closestReward.gift_type  == 'money' then
							xPlayer.addAccountMoney('cash', closestReward.gift)
						elseif closestReward.gift_type == 'item' then
							xPlayer.addInventoryItem(closestReward.gift, closestReward.count)
						end

						MySQL.Async.execute("UPDATE vicepass SET palier = palier + 5 WHERE identifier = @identifier", {["@identifier"] = xPlayer.identifier}, function() end)
						players[xPlayer.identifier] = players[xPlayer.identifier] + 5
						TriggerClientEvent("esx:showAdvancedNotification", xPlayer.source, "Notification", "Valestia", "Vous avez récupérer votre récompense !","CHAR_KIRINSPECTEUR", 7)
					end
				end
			end
		else
			xPlayer.showNotification("Vous n'avez pas lier votre FiveM")
		end
	else
		xPlayer.showNotification("Éviter de faire ceci trop rapidement")
	end
end)
  

  
AddEventHandler('esx:playerLoaded', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer) then

		TriggerClientEvent("vCore1:interactMenu:receiveData", source, xPlayer.getFirstName(), xPlayer.getLastName(), xPlayer.getVIP())
        MySQL.Async.fetchAll('SELECT * FROM vicepass WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
        }, function(result)
            if #result == 0 then
                MySQL.Async.execute('INSERT INTO vicepass (identifier,palier) VALUES (@identifier,@palier)', {
                    ['@identifier'] = xPlayer.identifier,
                    ['@palier'] = 0,
                })
                players[xPlayer.identifier] = 0
            else
                players[xPlayer.identifier] = tonumber(result[1].palier)
            end
        end)
        
    end
end)
  
  AddEventHandler("esx:playerDropped", function(src)
      local xPlayer = ESX.GetPlayerFromId(src)
	  
      if (xPlayer) then
          players[xPlayer.identifier] = nil
      end
  end)