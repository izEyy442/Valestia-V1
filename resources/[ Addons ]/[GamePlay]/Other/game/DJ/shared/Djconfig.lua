
ConfigDj = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder à la table DJ.',
        ['title_does_not_exist'] = '~r~Ce titre n\'existe pas !',
    }
}

ConfigDj.Locale = 'en'

ConfigDj.useESX = true
ConfigDj.enableCommand = false

ConfigDj.enableMarker = true

ConfigDj.DJPositions = {
    {
        name = 'unicorn',
        pos = vector3(119.3774, -1300.0509, 29.2189),
        requiredJob = 'unicorn', 
        range = 25.0, 
        volume = 1.0
    },
    {
        name = 'tequilala',
        pos = vector3(-560.7955, 281.7652, 85.70),
        requiredJob = 'tequilala',
        range = 40.0,
        volume = 1.5
    },
    {
        name = 'label',
        pos = vector3(500.32,-74.35,58.16),
        requiredJob = 'label',
        range = 40.0,
        volume = 1.5
    }
}