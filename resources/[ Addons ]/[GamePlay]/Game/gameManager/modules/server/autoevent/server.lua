--[[
  This file is part of Valestia RolePlay.
  Copyright (c) Valestia RolePlay - All Rights Reserved
  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

onPlayerEvent = {}

Event = {
    {
        type = "money",
        message = "Un fourgon blindé vient de se faire pété ! Viens récupérer l'argent avant la police !",
        possibleZone = {
            vector3(-576.4575, 327.1224, 83.9983-0.2),
            vector3(-262.2542, 195.8889, 84.50397-0.2),
            vector3(-12.40661, -685.8273, 31.66441-0.2),
            vector3(40.24453, -868.2159, 30.48704-0.2),
            vector3(18.79272, -1073.074, 38.15213-0.2),
            vector3(55.42496, -1672.947, 29.29726-0.2),
            vector3(776.0305, -2064.744, 29.3819-0.2),
            vector3(862.7224, -913.9108, 25.94606-0.2),
            vector3(44.508647918701,-855.24334716797,30.522575378418),
            vector3(109.65296936035,-716.67163085938,32.956405639648),
            vector3(69.607955932617,-389.39685058594,39.743537902832),
            vector3(-162.48498535156,-167.76351928711,43.445838928223),
            vector3(-388.10986328125,-76.429176330566,54.246162414551),
            vector3(-1056.1090087891,-221.73802185059,37.825839996338),
            vector3(-1146.9686279297,-215.294921875,37.778312683105),
            vector3(-1231.6203613281,-378.67230224609,59.110469818115),
            vector3(-1516.2371826172,-551.7333984375,32.922027587891),
            vector3(-1629.3898925781,-982.97308349609,12.833065032959),
            vector3(-1728.9680175781,-726.94061279297,10.170539855957),
            vector3(-1284.0313720703,-1395.9266357422,4.3253421783447),
            vector3(-1193.2202148438,-1489.4852294922,4.1873631477356),
            vector3(-916.17529296875,-1535.1591796875,4.8299140930176),
            vector3(-842.18572998047,-1196.0794677734,5.976854801178),
            vector3(-410.70254516602,-2270.7292480469,7.4166917800903),
            vector3(-126.00426483154,-2253.4067382812,7.6193857192993),
            vector3(-109.74016571045,-2129.7438964844,16.512741088867),
            vector3(284.59783935547,-2556.3095703125,5.5090126991272),
            vector3(182.73645019531,-3061.7541503906,5.5533690452576),
            vector3(286.0251159668,-3133.9931640625,5.4973101615906),
            vector3(712.88201904297,-2780.4765625,6.1892805099487),
            vector3(886.40557861328,-2925.8955078125,5.7240676879883),
            vector3(1144.3104248047,-3277.6350097656,5.724142074585),
            vector3(704.71380615234,-1579.3781738281,9.5196018218994),
            vector3(906.06011962891,-1740.5269775391,30.307287216187),
            vector3(1416.7257080078,-1636.5122070312,59.90217590332),
            vector3(2435.9040527344,-699.00244140625,62.490283966064),
            vector3(2539.0964355469,-283.2392578125,92.816223144531),
            vector3(2577.1010742188,340.95190429688,108.28024291992),
            vector3(1802.1491699219,3271.2346191406,42.544738769531),
            vector3(1724.0079345703,3462.0205078125,38.791934967041),
            vector3(1428.7514648438,3596.9448242188,34.780849456787),
            vector3(2301.9841308594,3259.0270996094,47.805084228516),
            vector3(2114.9985351562,4801.6342773438,41.006496429443),
            vector3(1713.5242919922,4704.2431640625,42.567485809326),
            vector3(1725.3286132812,6398.056640625,34.269393920898),
            vector3(332.51138305664,6573.66015625,28.644231796265),
            vector3(144.44445800781,6581.4599609375,31.688913345337),
            vector3(-288.80541992188,6124.0361328125,31.329196929932),
            vector3(-387.89297485352,6062.1098632812,31.322967529297),
            vector3(-768.39691162109,5536.3666992188,33.308128356934),
            vector3(-1206.1502685547,5258.3798828125,50.998889923096),
            vector3(-1409.7192382812,5094.2666015625,60.795486450195),
            vector3(-2256.3344726562,4295.2333984375,46.809066772461),
            vector3(-2529.8032226562,3850.5109863281,4.2960648536682),
            vector3(-2594.3005371094,3121.7629394531,14.786252975464),
            vector3(-2576.390625,2322.8098144531,32.882995605469),
            vector3(-1892.7729492188,2010.5272216797,141.3313293457),
            vector3(418.21337890625,6586.2006835938,27.019443511963),
            vector3(1751.9677734375,4586.4697265625,39.328845977783),
            vector3(1801.0540771484,2914.3793945312,45.530391693115),
            vector3(570.38934326172,2728.6589355469,41.881278991699),
            vector3(869.32641601562,-20.146514892578,78.584465026855),
            vector3(1376.6740722656,-741.01947021484,67.054244995117),
            vector3(-1076.4240722656,215.05696105957,61.918956756592),



        },
        prop = {
            "bkr_prop_moneypack_01a",
            "bkr_prop_moneypack_02a",
            "bkr_prop_moneypack_03a",
        },
    },
    {
        type = "avion",
        message = "Un avion s'est écrasé ! Viens vite récupérer ce qu'il contient avant la guardia !",
        possibleZone = {
            vector3(-2037.2150878906,-534.10076904297,9.1065301895142),
            vector3(-2795.2983398438,-57.6403465271,3.9453246593475),
            vector3(-1560.6170654297,-2599.4155273438,14.054743766785),
            vector3(-1661.0623779297,-3145.9506835938,14.102290153503),
            vector3(-1151.2659912109,-3364.9750976562,14.05003452301),
            vector3(-1085.0434570312,-3026.4338378906,14.055919647217),
            vector3(-980.25354003906,-2998.8647460938,14.055479049683),
            vector3(-1153.3996582031,-2392.8901367188,14.101335525513),
            vector3(-481.71481323242,-2738.009765625,6.1606187820435),
            vector3(1029.7686767578,-3173.75,6.0468645095825),
            vector3(2688.8803710938,1474.6291503906,24.684965133667),
            vector3(1248.5206298828,3133.3088378906,40.524719238281),
            vector3(1732.1381835938,3312.1628417969,41.332862854004),
            vector3(1659.5555419922,3246.634765625,40.730754852295),
            vector3(1496.7447509766,3101.1918945312,40.641128540039),
            vector3(1697.2551269531,4485.1196289062,31.706853866577),
            vector3(252.78726196289,3582.48828125,34.280319213867),
            vector3(-1052.6536865234,5470.3544921875,4.0152225494385),
            vector3(-306.65182495117,6522.6967773438,3.0143208503723),
            vector3(570.62451171875,6661.7436523438,9.9287195205688),
            vector3(3628.7817382812,4548.4375,32.057022094727),
            vector3(-2042.3546142578,2669.6506347656,1.7242373228073),
            vector3(-633.38177490234,2915.2111816406,15.227046966553),
            vector3(340.94326782227,3576.6958007812,33.565162658691),
            vector3(1577.4953613281,3901.59375,32.091259002686),
            vector3(2044.49609375,3927.9982910156,33.25617980957),
            vector3(2088.27734375,4792.5439453125,41.233066558838),
            vector3(1294.6910400391,-1054.2198486328,39.433197021484),
            vector3(-2071.1765136719,4579.34765625,2.7266054153442),
            vector3(-937.39971923828,6190.2670898438,4.0652680397034),
            vector3(2024.8953857422,2796.6997070312,50.734397888184),


        },
        prop = {
            "ex_prop_adv_case_sm_03",
        },
        item = {
            "weed_pooch",
            "coke_pooch",
            "meth_pooch",
            "coke",
            "weed",
            "meth",
        },
    },
}


local currentEventZone;
local minute = 60*1000
local eventStarted = true
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(3600000*4)
		local i = math.random(1, #Event)
		local randomEvent = Event[i]
		local i2 = math.random(1, #randomEvent.possibleZone)
		local zone = randomEvent.possibleZone[i2]
        currentEventZone = zone;
        onPlayerEvent = {}
        local players = ESX.GetPlayers()
        for i = 1, #players do
            onPlayerEvent[tonumber(players[i])] = true
        end
        TriggerClientEvent("RS_AutoEvents_SendEvent", -1, randomEvent, zone)
        --if not onPlayerEvent[source] then return print(GetPlayerName(source).." n'est pas dans l'event !") end
		Citizen.Wait(600000)
		if eventStarted then
            onPlayerEvent = {}
            --if not onPlayerEvent[source] then return print(GetPlayerName(source).." n'est pas dans l'event !") end
            TriggerClientEvent("RS_AutoEvents_StopEvent", -1)
            currentEventZone = nil;
		end
		Citizen.Wait(2000)
	end
end)


RegisterNetEvent("RS_AUTOEVENT:Recuperer")
AddEventHandler("RS_AUTOEVENT:Recuperer", function()
	TriggerClientEvent("RS_AutoEvents_StopEvent", -1)
    onPlayerEvent = {}
	eventStarted = false
    currentEventZone = nil;
end)

RegisterNetEvent("RS_AUTOEVENT:GetItem", function(item, nombre)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local price = math.random(500,1263)

    local ped = GetPlayerPed(xPlayer.source);
    local coords = GetEntityCoords(ped);

    if (currentEventZone ~= nil) then
        if (#(coords - currentEventZone) <= 30) then

            if xPlayer.canCarryItem(item, nombre) then
                xPlayer.addInventoryItem(item, nombre)
                xPlayer.addAccountMoney('dirtycash', price)
            else
                xPlayer.showNotification("Vous n'avez pas assez de place sur vous")
            end

        end
    end
end)

RegisterNetEvent("RS_AUTOEVENT:GetArgent", function(nombre)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

    local ped = GetPlayerPed(xPlayer.source);
    local coords = GetEntityCoords(ped);

    if (currentEventZone ~= nil) then

        if (#(coords - currentEventZone) <= 30) then
            xPlayer.addAccountMoney('dirtycash', nombre);
        end

    end
end)