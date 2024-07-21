Config = {}

Config.debug = false

--------------------------------------------------------
--------------------------------------------------------
--- MAKE SURE THAT THE CORRECT FRAMEWORK IS ENABLED ! --
--------------------------------------------------------
--------------------------------------------------------

--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = true,
    -- Whether or not to use the new ESX export method
    useNewESXExport = true
}

--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = false,
    sqlDriver = 'oxmysql', -- oxmysql or ghmattimysql
    useNewQBExport = true, -- Make sure to uncomment the old export inside fxmanifest.lua if you're still using it
    oldOxmysql = false,
}


Config.target = {
    enabled = false,
    system = 'ox_target' -- 'qtarget' or 'qb-target' or 'ox_target' (Other systems might work as well)
}

-- Outfitbag command settings
Config.command = {
    enabled = true,
    command = 'outfitbag',
    shortCommand = 'ob'
}

-- Bag item
Config.bagItem = 'kq_outfitbag'


-- If you want to have different kind of bags you can add them here (These will have separate inventories)
-- Make sure to add the item to your database / file
Config.additionalItems = {
}

--[[ EXAMPLE
Config.additionalItems = {
    'kq_outfitbag_2',
}
]]--


-- Maxmimum amount of outfits that people can save
Config.maxOutfits = 15

-- Whether or not to allow players to share their outfits
Config.allowBagSharing = true

-- The 3d object of the bag
Config.bagObject = 'prop_big_bag_01'

-- Whether or not to delete the previous bag if player is placing a new one on the ground
Config.onlyAllowOneBagOnGround = true

Config.bagAnimation = {
    enabled = true,
    dict = 'amb@medic@standing@tendtodead@idle_a',
    anim = 'idle_a',
}

Config.outfitChangeAnimation = {
    enabled = true,
    duration = 5000,
    dict = 'mp_safehouseshower@male@',
    anim = 'male_shower_towel_dry_to_get_dressed',
}

-- Keybinds (only applicable if no targeting system is enabled)
Config.keybinds = {
    public = 'ENTER',
    open = 'E',
    pickup = 'H',
}
