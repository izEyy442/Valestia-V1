---@class rdmSellDrug
---@field min number
---@field max number

---@param xPlayer xPlayer
local function call_cops(xPlayer)
    local xPlayers = ESX.GetPlayers();
    local ped = GetPlayerPed(xPlayer.source);
    local coords = GetEntityCoords(ped);

    local info_possibility = math.random(1, 3);

    if (info_possibility == 1) then
        xPlayer.showNotification("Le client n'avait pas l'air très serein");
    end

    for i = 1, #xPlayers do
        local xCop = ESX.GetPlayerFromId(xPlayers[i]);
        if (xCop) then
            if (xCop.job.name == 'police' or xCop.job.name == 'bcso') then
                xCop.triggerEvent('sell_drug:call_cops', coords);
            end
        end
    end
end

---@param item_name string
---@param quantity number
---@param xPlayer xPlayer
---@param rdm rdmSellDrug
---@param response fun(success: boolean)
local function sell(item_name, quantity, xPlayer, rdm, response)
    local cancel_probability = math.random(1, 5);
    local item = xPlayer.getInventoryItem(item_name);
    if (not item or item.count <= 0) then
        xPlayer.showNotification("Tu n'as pas de ".. item.label .." sur toi !");
        response(false, false);
        return;
    end

    if (cancel_probability == 1) then
        local cops_call_probability = math.random(1, 4);
        if (cops_call_probability == 1) then
            call_cops(xPlayer);
        end
        response(false, false);
        return;
    end

    if (item.count >= quantity) then
        local price = math.random(rdm.min, rdm.max);
        local final_price = price;
        xPlayer.removeInventoryItem(item.name, quantity);
        xPlayer.addAccountMoney('dirtycash', final_price);
        xPlayer.showNotification("Tu as vendu ~HUD_COLOUR_NET_PLAYER1~"..quantity.. " ~w~".. item.label .." pour ~HUD_COLOUR_NET_PLAYER1~"..final_price.."$");
        xPlayer.addXP(math.random(10, 100));
        response(true, false);
        return;
    else
        xPlayer.showNotification("Le clients voulait plus de drogues que se que tu avais.");
        response(false, true);
        return;
    end
end

---@return number
local function get_cops()
    local cops = 0;
    local xPlayers = ESX.GetPlayers();
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i]);
        if (xPlayer) then
            if xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
                cops = cops + 1;
            end
        end
	end
    return cops;
end

ESX.RegisterServerCallback('sell_drug:sell', function(source, cb, drug_type)
	local xPlayer = ESX.GetPlayerFromId(source);

    if (not xPlayer) then return; end

	local cops = get_cops();

    if (cops <= 0) then
        xPlayer.showNotification("Il n'y a pas assez de ~HUD_COLOUR_NET_PLAYER1~flics ~w~en service !");
        return;
    end

    if drug_type == 'Weed' then
        sell("weed_pooch", 10, xPlayer, {min = 660, max = 750}, cb);
    elseif drug_type == 'Coke' then
        sell("coke_pooch", 10, xPlayer, {min = 760, max = 850}, cb);
    elseif drug_type == 'Meth' then
        sell("meth_pooch", 10, xPlayer, {min = 860, max = 950}, cb);
    elseif drug_type == 'Opium' then
        sell("opium_pooch", 10, xPlayer, {min = 960, max = 1050}, cb);
    elseif drug_type == 'Ketamine' then
        sell("ketamine_pooch", 10, xPlayer, {min = 1020, max = 1110}, cb);
    end
end);