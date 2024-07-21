ESX = nil
ESXLoaded = false
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
    ESXLoaded = true
end)

PermanentWeapon = {
	['WEAPON_ASSAULTRIFLE'] = true,
	['WEAPON_PAN'] = true,
	['WEAPON_KATANA'] = true,
	['WEAPON_TRIDAGGER'] = true,
	['WEAPON_LUCILE'] = true,
	['WEAPON_BAYONET'] = true,
	['WEAPON_KARAMBIT'] = true,
    ['WEAPON_HEAVYSNIPER'] = true,
    ['WEAPON_CARBINERIFLE_MK2'] = true,
    ['WEAPON_ASSAULTSHOTGUN'] = true,
    ['WEAPON_SPECIALCARBINE'] = true,
    ['WEAPON_COMBATPDW'] = true,
    ['WEAPON_REVOLVER_MK2'] = true,
    ['WEAPON_BAT'] = true,
    ['WEAPON_MARSKSMANRIFLE'] = true,
    ['weapon_combatmg_mk2'] = true,
    ['WEAPON_M4A1FM'] = true,
    ['WEAPON_SCAR17FM'] = true,
    ['weapon_heavyshotgun'] = true,
    ['weapon_heavysniper_mk2'] = true,
	['WEAPON_MP5SDFM'] = true,
	['WEAPON_SR25'] = true,
}