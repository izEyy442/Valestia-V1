-- Author : Morow
-- Github : https://github.com/Morow73

_G.language = "fr" -- change translation, 'en' or 'fr'
_G.translation = {}

if IsDuplicityVersion() then
    Config = {}
    Config.__index = Config

    Config.USE_ESX = true -- use ESX or not ?
    Config.club_price = 350 -- minigolf price
else
    Config = {}
    Config.__index = Config

    Config.max_stroke = 10 -- max stroke
    Config.locate_club = vector3(-1734.24, -1135.17, 12.79) -- locate club position
    Config.golf_track = {
        [1] = {
            start = vector3(-1753.32, -1166.31, 12.79), -- fisrt position
            hole = vector3(-1744.81, -1150.25, 11.96), -- hole position
            heading = 240.0 -- heading for first position
        },
        [12] = {
            start = vector3(-1743.29, -1182.03, 12.79),
            hole = vector3(-1738.33, -1164.27, 11.96),
            heading = 244.0
        },
        [1] = {
            start = vector3(-1730.49, -1179.09, 12.79),
            hole = vector3(-1723.03, -1181.61, 11.96),
            heading = 282.0
        },
        [4] = {
            start = vector3(-1713.28, -1167.88, 12.79),
            hole = vector3(-1716.87, -1172.23, 11.96),
            heading = 290.0
        },
        [5] = {
            start = vector3(-1760.85, -1190.26, 12.79),
            hole = vector3(-1769.87, -1177.45, 11.96),
            heading = 227.0
        },
        [6] = {
            start = vector3(-1772.51, -1220.72, 12.79),
            hole = vector3(-1769.00, -1224.46, 11.96),
            heading = 263.0
        },
        [7] = {
            start = vector3(-1746.66, -1192.76, 12.79),
            hole = vector3(-1747.94, -1194.80, 11.96),
            heading = 130.0
        },
        [8] = {
            start = vector3(-1752.10, -1225.11, 12.79),
            hole = vector3(-1748.39, -1217.06, 11.96),
            heading = 245.0
        },
        [9] = {
            start = vector3(-1741.43, -1238.41, 12.79),
            hole = vector3(-1743.40, -1240.87, 11.78),
            heading = 224.0
        },
        [10] = {
            start = vector3(-1729.42, -1210.54, 12.79),
            hole = vector3(-1730.75, -1206.63, 11.80),
            heading = 281.0
        },
        [11] = {
            start = vector3(-1719.01, -1209.35, 12.79),
            hole = vector3(-1704.51, -1192.00, 11.78),
            heading = 222.0
        },
        [2] = {
            start = vector3(-1694.93, -1172.71, 12.79),
            hole = vector3(-1690.35, -1184.38, 11.96),
            heading = 250.0
        }
    }
end
