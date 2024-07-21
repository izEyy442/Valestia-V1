local CHARACTERS = {[1] = 'A',[2] = 'B',[3] = 'C',[4] = 'D',[5] = 'E',[6] = 'F',[7] = 'G',[8] = 'H',[9] = 'I',[10] = 'J',[11] = 'K',[12] = 'L',[13] = 'M',[14] = 'N',[15] = 'O',[16] = 'P',[17] = 'Q',[18] = 'R',[19] = 'S',[20] = 'T',[21] = 'U',[22] = 'V',[23] = 'W',[24] = 'X',[25] = 'Y',[26] = 'Z'}
local SPECIALCHARACTERS = {[1] = "/", [2] = "*", [3] = "-", [4] = "+",[5] = "*",[6] = "ù",[7] = "%"}

local TOKEN = {}

green = 56108
grey = 8421504
red = 652101
orange = 16744192
blue = 2061822
purple = 11750815

function MomoLogs(webhook, name, message, color)
	-- Modify here your discordWebHook username = name, content = message,embeds = embeds
    local date = os.date('*t')
  
  if date.day < 10 then date.day = '0' .. tostring(date.day) end
  if date.month < 10 then date.month = '0' .. tostring(date.month) end
  if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
  if date.min < 10 then date.min = '0' .. tostring(date.min) end
  if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

  local time = '\nDate: **`' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. (date.hour) .. ':' .. date.min .. ':' .. date.sec .. '`**'

  local embeds = {
	  {
          ["title"]= message .. time,
		  ["type"]="rich",
		  ["color"] =color,
		  ["footer"]=  {
		  ["text"]= "Valestia-Logs",
		 },
	  }
  }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local source = source
    local numbers1 = math.random (9500, 15000)
    local numbers2 = math.random(7850, 27000)
    local numbers3 = math.random(500, 1000)
    local numbers4 = math.random(50000, 100000)
    local CharSpecialRandom1 = math.random(1,7)
    local CharSpecialRandom2 = math.random(1,7)
    local lettersrandom1 = math.random(1,26)
    local PLAYER_NAME = GetPlayerName(source)
    local PLAYER_STEAMHEX = GetPlayerIdentifier(source)

    local MONEY_IN_CASH = xPlayer.getAccount('cash').money
    local MONEY_AT_BANK = xPlayer.getAccount('bank').money
    local MONEY_IN_DIRT = xPlayer.getAccount('dirtycash').money
    local PLAYER_JOB = xPlayer.job.label
    local PLAYER_JOB_GRADE = xPlayer.job.grade_label
    local PLAYER_JOB2 = xPlayer.job2.label
    local PLAYER_JOB2_GRADE = xPlayer.job2.grade_label
    local MESSAGE_LINE = "─────────────────────"
    TOKEN[source] = {}
    TOKEN[source].token = SPECIALCHARACTERS[CharSpecialRandom1]..''..numbers4..''..numbers1..''..numbers4..''..SPECIALCHARACTERS[CharSpecialRandom2]..''..CHARACTERS[lettersrandom1]..'TOKENValestiaRP!!!!4/*-+'..numbers4..''..numbers3..''..numbers2
    TriggerClientEvent('Valestia:RetrieveToken', source, TOKEN[source].token)
    print('Génération du Token de [^2'..GetPlayerName(source)..' | '..TOKEN[source].token..'^0]')
    MomoLogs('https://discord.com/api/webhooks/1226973378561310820/YQgwDXee4IwuuD73DQGv4rvCq20ASjhQNl0D2Y0pg_EnP4Y9fGjzdhUjCppKVJD1Flcr', "Information du joueur", MESSAGE_LINE.."\nNom du Joueur: `"..PLAYER_NAME.."`\nID du Joueur : `"..source.."`\nSteam Hex : `"..PLAYER_STEAMHEX.."`\nToken : "..TOKEN[source].token.."\n"..MESSAGE_LINE.."\nArgent en cash : `"..MONEY_IN_CASH.." $`\nArgent en banque : `"..MONEY_AT_BANK.." $`\nArgent sale : `"..MONEY_IN_DIRT.." $`\n"..MESSAGE_LINE.."\nJob : `"..PLAYER_JOB.."` › Grade : `"..PLAYER_JOB_GRADE.."`\nOrganisation : `"..PLAYER_JOB2.."` › Grade : `"..PLAYER_JOB2_GRADE.."`", 56108)

end)

function VerifyToken(source, tokenReceive, eventName, onAccepted, onRefused)
    if TOKEN[source].token == tokenReceive then
        onAccepted();
    else
        onRefused();
        local xPlayer = ESX.GetPlayerFromId(source)
        MomoLogs('https://discord.com/api/webhooks/1226972968844787852/26kFuUa88vdIMC9q6QRvowDckhe4jT_dlYA6QnS7IYZJM6cVRPh3g8bvBTu3LfItd_Ym', "AntiCheat","**"..GetPlayerName(source).."** vient d'etre Kick \n**License** : "..xPlayer.identifier..'\nEvent : '..eventName, 56108)
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat [' ..eventName..']')
    end
end

ESX.RegisterServerCallback('eToken:verifToken', function(source, cb, token)
    if TOKEN[source].token == token then
        cb(true)
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        MomoLogs('https://discord.com/api/webhooks/1226972968844787852/26kFuUa88vdIMC9q6QRvowDckhe4jT_dlYA6QnS7IYZJM6cVRPh3g8bvBTu3LfItd_Ym', "AntiCheat","**"..GetPlayerName(xPlayer.source).."** vient d'etre Kick [ESX]\n**License** : "..xPlayer.identifier, 56108)
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat [ESX]')
    end
end)

RegisterCommand('inittoken', function(source,args,xPlayer)
    local numbers1 = math.random (9500, 15000)
    local numbers2 = math.random(7850, 27000)
    local numbers3 = math.random(500, 1000)
    local numbers4 = math.random(50000, 100000)
    local CharSpecialRandom1 = math.random(1,7)
    local CharSpecialRandom2 = math.random(1,7)
    local lettersrandom1 = math.random(1,26)
    TOKEN[source] = {}
    TOKEN[source].token = SPECIALCHARACTERS[CharSpecialRandom1]..''..numbers4..''..numbers1..''..numbers4..''..SPECIALCHARACTERS[CharSpecialRandom2]..''..CHARACTERS[lettersrandom1]..'TOKENValestiaRP!!!!4/*-+'..numbers4..''..numbers3..''..numbers2
    TriggerClientEvent('Valestia:RetrieveToken', source, TOKEN[source].token)
    print('Génération du Token de [^2'..GetPlayerName(source)..' | '..TOKEN[source].token..'^0]')
end)