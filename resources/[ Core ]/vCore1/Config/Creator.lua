Config["Creator"] = {}

Config["Creator"]["spawnpoint"] = {x = -1369.7514648438, y = 56.268817901611, z = 53.703678131104, h = 94.93055725097656}

Config["Creator"]["categories"] = {
    ['identity'] = {
        icon = 'tabler:dna-2',
        components = {'face_md_weight', 'skin_md_weight'}
    },
    ['face'] = {
        icon = 'mingcute:face-fill',
        components = {'cheeks_1', 'cheeks_2', 'cheeks_3', 'jaw_1', 'jaw_2', 'chin_1', 'chin_2', 'chin_3', 'chin_4', 'neck_thickness'}
    },
    ['hair'] = {
        icon = 'mingcute:hair-2-fill',
        components = {'hair_1', 'hair_2', 'hair_color_1', 'hair_color_2'}
    },
    ['nose'] = {
        icon = 'mingcute:nose-fill',
        components = {'nose_1', 'nose_2', 'nose_3', 'nose_4', 'nose_5', 'nose_6'}
    },
    ['eyes'] = {
        icon = 'mingcute:eye-2-fill',
        components = {'eye_color', 'eye_squint', 'eyebrows_1', 'eyebrows_2', 'eyebrows_3', 'eyebrows_4', 'eyebrows_5', 'eyebrows_6'}
    },
    ['beard'] = {
        icon = 'game-icons:beard',
        components = {'beard_1', 'beard_2', 'beard_3'}
    }
}

Config["Creator"]["refreshComponent"] = {
    ['hair_1'] = {'hair_2'}
}