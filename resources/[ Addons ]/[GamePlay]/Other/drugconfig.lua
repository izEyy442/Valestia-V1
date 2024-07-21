DrugConfig = {
    log = false,
    --[[

        RewardType:
        0 : Argent propre
        1 : Argent sale

    ]]
    rewardType = 1,
    delayBetweenActions = 2000, -- 2 secondes
    allowedLicense = {
        -- ["license:c346c75203f7151afaa76405574b544d5ba393ea"] = true -- iZeyy 
        ["license:111d41054afb4f409a45b38a9b4e3146fecb8fe2"] = true, -- ZxnKa
        ["license:4d0fab85aa287ec29da0ad1479f38ab3d029579b"] = true -- SneaX
    },

    messages = {
        harvest = {
            enable = false,
            message = "~y~+1 ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s ~y~!"
        },

        transform = {
            onNoEnough = "~s~Vous n'avez pas assez de ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s ~s~pour faire la transformation !",
            onDone = "~s~Vous avez transformé ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x%i %s ~s~en ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x%i %s"
        },

        sell = {
            onNoEnough = "~s~Vous n'avez pas de ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%s ~s~sur vous !",
            onDone = "~s~Vous avez vendu ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~x%i %s ~s~pour ~HUD_COLOUR_PM_WEAPONS_PURCHASABLE~%i$"
        }
    }
}