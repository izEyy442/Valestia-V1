---
--- @author Azagal
--- Create at [01/11/2022] 20:15:54
--- Current project [Valestia-V1]
--- File name [_main]
---

Helipad = {}
Helipad.Config = {
    ["ambulance"] = {
        menuPosition = vector3(-1861.2778320312, -354.41180419922, 58.092735290527),
        spawnPosition = vector4(-1867.2764892578, -352.47875976562, 58.098510742188, 142.36203002929688),
        deletePosition = vector3(-1867.2764892578, -352.47875976562, 58.098510742188),
        models = {
            "nksvolitoems"
        }
    },
    ["police"] = {
        menuPosition = vector3(-594.0574, -424.6590, 51.3841),
        spawnPosition = vector4(-595.73846435547, -430.95068359375, 51.38415145874, 186.05999755859375),
        deletePosition = vector3(-595.73846435547, -430.95068359375, 51.38415145874),
        models = {
            "polmav",
        }
    },
    ["police"] = {
        menuPosition = vector3(-527.28387451172, -403.08279418945, 34.965961456299),
        spawnPosition = vector4(-520.62799072266, -395.41235351562, 35.060600280762, 354.90875244140625),
        deletePosition = vector3(-520.62799072266, -395.41235351562, 35.060600280762),
        models = {
            "pbus",
        }
    },
    ["bcso"] = {
        menuPosition = vector3(-493.2645, 5993.802, 31.29724),
        spawnPosition = vector4(-475.8103, 5987.935, 31.33647, 313.043),
        deletePosition = vector3(-475.8103, 5987.935, 31.33647),
        models = {
            "polmav"
        }
    },
    ["roxsherif"] = {
        menuPosition = vector3(-1006.055, 6659.674, 3.174594),
        spawnPosition = vector4(-1015.121, 6655.747, 3.166682, 76.450),
        deletePosition = vector3(-1015.121, 6655.747, 3.166682),
        models = {
            "roxpolmav"
        }
    },
    ["gouv"] = {
        menuPosition = vector3(-458.1751, 1137.8030, 327.8044),
        spawnPosition = vector4(-453.3994, 1145.3788, 327.6855, 343.6903),
        deletePosition = vector3(-453.3994, 1145.3788, 327.6855),
        models = {
            "presheli"
        }
    },
    ["fib"] = {
        menuPosition = vector3(2506.2036132813, -346.81015014648, 118.02417755127),
        spawnPosition = vector4(2510.5568847656, -341.8586730957, 118.1854095459, 227.38449096679688),
        deletePosition = vector3(2510.5568847656, -341.8586730957, 118.1854095459),
        models = {
            "frogger"
        }
    },
    ["police"] = {
        menuPosition = vector3(-527.67456054688, -405.56747436523, 34.925025939941),
        spawnPosition = vector4(-520.70056152344, -433.87661743164, 34.372501373291, 164.4951629638672),
        deletePosition = vector3(-520.70056152344, -433.87661743164, 34.372501373291),
        models = {
            "pbus"
        }
    },
    ["weazel"] = {
        menuPosition = vector3(-577.7748, -935.4452, 36.8347),
        spawnPosition = vector4(-583.3539, -930.2835, 36.8347, 101.0683),
        deletePosition = vector3(-583.3539, -930.2835, 36.8347),
        models = {
            "newsheli"
        }
    },
    playerLoad = {}
}

RegisterNetEvent("Helipad:Request:LoadConfig", function()
    local _src = source

    local xPlayer = ESX.GetPlayerFromId(_src)
    if (xPlayer ~= nil) then
        if (Helipad.Config.playerLoad[_src] == nil) then
            Helipad.Config.playerLoad[_src] = true
        else
            return
        end

        xPlayer.triggerEvent("Helipad:ClientReturn:Config", Helipad.Config)
    end
end)