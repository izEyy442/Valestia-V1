DrugsHandler.SceneDicts = {
    Cocaine = {
        [1] = 'anim@amb@business@coc@coc_unpack_cut_left@',
        [2] = 'anim@amb@business@coc@coc_packing_hi@',
    },
    Meth = {
        [1] = 'anim@amb@business@meth@meth_monitoring_cooking@cooking@',
        [2] = 'anim@amb@business@meth@meth_smash_weight_check@',
    },
}

DrugsHandler.PlayerAnims = {
    Cocaine = {
        [1] = 'coke_cut_v5_coccutter',
        [2] = 'full_cycle_v3_pressoperator'
    },
    Meth = {
        [1] = 'chemical_pour_short_cooker',
        [2] = 'break_weigh_v3_char01',
    },
}

DrugsHandler.AnimsList = {
    Cocaine = {
        [1] = {
            bakingsoda = 'coke_cut_v5_bakingsoda',
            creditcard1 = 'coke_cut_v5_creditcard',
            creditcard2 = 'coke_cut_v5_creditcard^1',
        },
        [2] = {
            scoop = 'full_cycle_v3_scoop',
            box1 = 'full_cycle_v3_FoldedBox',
            dollmold = 'full_cycle_v3_dollmould',
            dollcast1 = 'full_cycle_v3_dollcast',
            dollcast2 = 'full_cycle_v3_dollCast^1',
            dollcast3 = 'full_cycle_v3_dollCast^2',
            dollcast4 = 'full_cycle_v3_dollCast^3',
            press = 'full_cycle_v3_cokePress',
            doll = 'full_cycle_v3_cocdoll',
            bowl = 'full_cycle_v3_cocbowl',
            boxed = 'full_cycle_v3_boxedDoll',
        },
    },
    Meth = {
        [1] = {
            ammonia = 'chemical_pour_short_ammonia',
            clipboard = 'chemical_pour_short_clipboard',
            pencil = 'chemical_pour_short_pencil',
            sacid = 'chemical_pour_short_sacid',
        },
        [2] = {
            box1 = 'break_weigh_v3_box01',
            box2 = 'break_weigh_v3_box01^1',
            clipboard = 'break_weigh_v3_clipboard',
            methbag1 = 'break_weigh_v3_methbag01',
            methbag2 = 'break_weigh_v3_methbag01^1',
            methbag3 = 'break_weigh_v3_methbag01^2',
            methbag4 = 'break_weigh_v3_methbag01^3',
            methbag5 = 'break_weigh_v3_methbag01^4',
            methbag6 = 'break_weigh_v3_methbag01^5',
            methbag7 = 'break_weigh_v3_methbag01^6',
            pen = 'break_weigh_v3_pen',
            scale = 'break_weigh_v3_scale',
            scoop = 'break_weigh_v3_scoop',
        },
    },

}

DrugsHandler.ScenesList = {
    Cocaine = {
        [1] = {
            bakingsoda = 'bkr_prop_coke_bakingsoda_o',
            creditcard1 = 'prop_cs_credit_card',
            creditcard2 = 'prop_cs_credit_card',
        },
        [2] = {
            scoop = 'bkr_prop_coke_fullscoop_01a',
            doll = 'bkr_prop_coke_doll',
            boxed = 'bkr_prop_coke_boxedDoll',
            dollcast1 = 'bkr_prop_coke_dollCast',
            dollcast2 = 'bkr_prop_coke_dollCast',
            dollcast3 = 'bkr_prop_coke_dollCast',
            dollcast4 = 'bkr_prop_coke_dollCast',
            dollmold = 'bkr_prop_coke_dollmould',
            bowl = 'bkr_prop_coke_fullmetalbowl_02',
            press = 'bkr_prop_coke_press_01b',
            box1 = 'bkr_prop_coke_dollboxfolded',
        },
    },
    Meth = {
        [1] = {
            ammonia = 'bkr_prop_meth_ammonia',
            clipboard = 'bkr_prop_fakeid_clipboard_01a',
            pencil = 'bkr_prop_fakeid_penclipboard',
            sacid = 'bkr_prop_meth_sacid',
        },
        [2] = {
            box1 = 'bkr_prop_meth_bigbag_04a',
            box2 = 'bkr_prop_meth_bigbag_03a',
            clipboard = 'bkr_prop_fakeid_clipboard_01a',
            methbag1 = 'bkr_prop_meth_openbag_02',
            methbag2 = 'bkr_prop_meth_openbag_02',
            methbag3 = 'bkr_prop_meth_openbag_02',
            methbag4 = 'bkr_prop_meth_openbag_02',
            methbag5 = 'bkr_prop_meth_openbag_02',
            methbag6 = 'bkr_prop_meth_openbag_02',
            methbag7 = 'bkr_prop_meth_openbag_02',
            pen = 'bkr_prop_fakeid_penclipboard',
            scale = 'bkr_prop_coke_scale_01',
            scoop = 'bkr_prop_meth_scoop_01a',
        }
    }
}

DrugsHandler.Actions = {
    {    
        offset = vector3(1.911, 0.31, 0.0),
        rotation = vector3(0.0, 0.0, 0.0),
        time = 25000,
        act = "Cocaine",
        scene = 1,
    },
    {    
        offset = vector3(7.663, -2.222, 0.395),
        rotation = vector3(0.0, 0.0, 0.0),
        time = 60000,
        act = "Cocaine",
        scene = 2,
    },
    {
        offset = vector3(-4.88, -1.95, 0.0),
        rotation = vector3(0.0, 0.0, 0.0),
        time = 70000,
        act = "Meth",
        scene = 1,
    },
    {
        offset = vector3(4.48, 1.7, 1.0),
        rotation = vector3(0.0, 0.0, 0.0),
        time = 45000,
        act = "Meth",
        scene = 2,
    }
}