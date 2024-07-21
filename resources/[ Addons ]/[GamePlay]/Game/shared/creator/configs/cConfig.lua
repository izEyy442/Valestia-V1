CreatorConfig = {
    getESX = "esx:getSharedObject", --> Trigger de déclaration ESX | Défaut : esx:getSharedObject
    consoleLogs = true, --> Activer/Désactiver les print dans la console
    serverName = "Valestia RP", --> Nom de votre serveur rp
    afterMessage = true, --> Message de bienvenue après la création

    use = {calif = true}, --> Si vous utilisez la base calif : true | Sinon si ESX normal : false

    events = { --> Vos events & préfix d'events (si base calif, rajouter votre préfix | exemple : ::{korioz#0110}::
        showNotification = "esx:showNotification", --> Calif = ::{korioz#0110}::esx:showNotification
        skinchanger = "skinchanger", --> Calif = ::{korioz#0110}::skinchanger
        skin = "esx_skin", --> Calif = ::{korioz#0110}::esx_skin
    },

    starterPack = {
        enable = false, --> Activer/Désactiver le système de starterPack
        legal = { --> Configuration du pack legal
            ["cash"] = 5000,
            ["bank"] = 25000,
        },
        illegal = { --> Configuration du pack illegal
            ["bank"] = 15000,
            ["black_money"] = 25000,
            ["weapon"] = "weapon_wrench",
        },
    },

    afterSpawn = { --> Lieu de spawn possible après la création du perso
        {name = 'Ville', pos = vector3(-693.6185, -612.5870, 32.1438), head = 174.9672
    },
    },  
    firstSpawn = { --> Premier lieu de spawn du joueur lors de la création
        pos = vector3(-68.655960083008, -804.80639648438, 243.48519897461-0.9),
        heading = 164.91937255859375,
    },
    cloakRoom = { --> Une fois l'identité validé, le lieu où l'on change l'apparence
        pos = vector3(-78.98319, -811.1042, 243.3858-1),
        heading = 336.61776733398,
    },
    kitchen = { --> Une fois le personnage validé, le lieu où l'on choisit son kit de départ
        pos = vector3(-70.72, -804.8737, 243.3858-1),
        heading = 16709131240845,
    },
    lift = { --> Lieu où l'on choisit l'endroit de spawn du personnage
        pos = vector3(-70.72, -804.8737, 243.3858-1),
        heading = 16709131240845,
    },

    outfit = { --> Configuration des tenues prédéfinies
    {label = "Tenue détente",
        clothes = {
            ["male"] = {
                bags_1 = 0, bags_2 = 0,
                tshirt_1 = 15, tshirt_2 = 0,
                torso_1 = 0, torso_2 = 4,
                arms = 0,
                pants_1 = 82, pants_2 = 0,
                shoes_1 = 9, shoes_2 = 0,
                mask_1 = -1, mask_2 = 0,
                bproof_1 = -1, bproof_2 = 0,
                helmet_1 = -1, helmet_2 = 0,
                chain_1 = -1, chain_2 = 0,
                decals_1 = 0, decals_2 = 0,
            },
            ["female"] = {
                bags_1 = -1, bags_2 = 0,
                tshirt_1 = 11, tshirt_2 = 1,
                torso_1 = 1, torso_2 = 4,
                arms = 1,
                pants_1 = 0, pants_2 = 1,
                shoes_1 = 40, shoes_2 = 0,
                mask_1 = -1, mask_2 = 0,
                bproof_1 = -1, bproof_2 = 0,
                helmet_1 = -1, helmet_2 = 0,
                glasses_1 = -1, glasses_2 = 0,
                chain_1 = -1, chain_2 = 0,
                decals_1 = -1, decals_2 = 0,
            }, 
        },
    },
    {label = "Tenue d'affaires",
        clothes = {
            ["male"] = {
                bags_1 = -1, bags_2 = 0,
                tshirt_1 = 124, tshirt_2 = 3,
                torso_1 = 106, torso_2 = 0,
                arms = 1,
                pants_1 = 43, pants_2 = 0,
                shoes_1 = 33, shoes_2 = 0,
                mask_1 = -1, mask_2 = 0,
                bproof_1 = -1, bproof_2 = 0,
                helmet_1 = -1, helmet_2 = 0,
                chain_1 = 10, chain_2 = 2,
                decals_1 = -1, decals_2 = 0,
            },
            ["female"] = {
                bags_1 = -1, bags_2 = 0,
                tshirt_1 = 112, tshirt_2 = 1,
                torso_1 = 94, torso_2 = 0,
                arms = 1,
                pants_1 = 42, pants_2 = 0,
                shoes_1 = 33, shoes_2 = 3,
                mask_1 = 0, mask_2 = 0,
                bproof_1 = -1, bproof_2 = 0,
                helmet_1 = -1, helmet_2 = 0,
                glasses_1 = -1, glasses_2 = 0,
                chain_1 = -1, chain_2 = 0,
                decals_1 = -1, decals_2 = 0,
            },
        },
    },
},
}

_Client = _Client or {};
_Client.open = {};
_Prefix = "creator";
Render = {};
arrow = "";