--
--Created Date: 17:38 11/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Inventory]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.addItem(), function(item)
    Client.Player:AddInventoryItem(item, item.count);
end);

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.removeItem(), function(item)
    Client.Player:RemoveInventoryItem(item);
end);

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.updateItemCount(), function(itemName, count)
    Client.Player:UpdateItemAmount(itemName, count);
end);

Shared.Events:OnNet(Enums.ESX.Player.Inventory.Client.setAccountMoney(), function(account)
    Client.Player:SetAccount(account);
end);