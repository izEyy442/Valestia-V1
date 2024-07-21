--
--Created Date: 22:44 16/12/2022
--Author: vCore3
--Made with ❤
--
--File: [Weapons]
--
--Copyright (c) 2022 vCore3Work, All Rights Reserved.
--This file is part of vCore3Work project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
--

exports("GetPermanentWeapons", function()

    return Config["Weapons"]["PERMANENT_WEAPONS"];

end);

exports("IsWeaponPermanent", function(weaponName)

    return Shared:IsWeaponPermanent(weaponName);

end);