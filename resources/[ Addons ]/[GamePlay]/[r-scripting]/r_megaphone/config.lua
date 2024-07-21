/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-megaphone-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

-- [[ Configuration ]]

Config = {
    Language = 'fr', -- Language library used for the script, see the last lines to modify the text of the language. (Config.Languages)

    UseOutdatedVersion = true, -- Enable this parameter to suppress alert messages in the console if you wish to use an older version of the script.

    /*---------------------------------------------------------------------------------
                                          IMPORTANT
    If you are using ESX or QBCore, please set the UseFramework variable to true below, then follow 
    the video tutorial in our documentation to make the script compatible.
    This variable is used to remove the command to give the weapon and thus use it from your inventory.

    For ESX: https://docs.rytrak.fr/framework-compatibility/add-a-custom-weapon-on-esx
    For QBCore: https://docs.rytrak.fr/framework-compatibility/add-a-custom-weapon-on-qbcore
                                          IMPORTANT
    ---------------------------------------------------------------------------------*/
    UseFramework = false,

    MegaphoneWeaponWheelName = "Megaphone", -- Name for WT_MEGAPHONE

    Compatibility = {
        SaltyChat = false,
        Others = {
            enabled = false, -- If you use mumble-voip, activate this parameter (USE OUR DOCUMENTATION BEFORE ACTIVATING MUMBLE-VOIP https://docs.rytrak.fr/scripts/advanced-megaphone-system/adapt-our-script-with-mumble-voip)
            
            /*---------------------------------------------------------------------------------
                                            IMPORTANT FOR PMA-VOICE
            Don't forget that you must start pma-voice before starting r_megaphone in the server.cfg file!
            Then add these two lines if they are not present in the pma-voice configuration:
            setr voice_useNativeAudio true
            setr voice_enableSubmix 1

            More information: https://docs.rytrak.fr/scripts/advanced-megaphone-system/adapt-our-script-with-pma-voice
                                            IMPORTANT FOR PMA-VOICE
            ---------------------------------------------------------------------------------*/
            pma = {
                enabled = true,
                resourceName = 'pma-voice' -- Resource name
            },
            autoTalk = true, -- Allows you to automatically press the push to talk button when using the megaphone
            distance = 40.0, -- Distance to speak (when you use pma-voice, modify directly the distance in the @pma-voice/client/megaphone.lua file of the pma-voice script, for more information please refer to our documentation)
            manageVolume = true, -- Enable or disable the use of the megaphone volume control.
            volume = 1.0,
            effects = { -- Voice effects
                freq_low = 200.0,
                freq_hi = 9000.0
            }
        }
    },

    Vehicles = {
        enabled = true, -- Activate or not the use of the megaphone in the cars
        hint = { -- Enable or disable the display of notifications in the top left corner when you are in a vehicle
            enabled = true, -- Boolean for displaying the hint
            timeout = 4000 -- Time at which the hint will be displayed (0 = infinite)
        }, 
        emergency = true, -- Enable or disable the use of the megaphone in emergency vehicles
        list = { -- List of vehicles that can use the megaphone (Config.Vehicles.emergency MUST BE IN FALSE TO USE THIS LIST!)
            `police`,
            `fbi`
        },
        manageSeat = {-1, 0} -- Seats to use the megaphone
    },

    Weapon = `WEAPON_MEGAPHONE` -- Weapon of the megaphone
}

-- https://docs.fivem.net/docs/game-references/controls/
Config.Keys = {
    SpeakKey = 92, -- Key to speak
    SpeakKeyString = '~INPUT_VEH_PASSENGER_ATTACK~', -- Key string to speak

    SpeakCarKey = 137, -- Key to speak in vehicle
    SpeakCarKeyString = '~INPUT_SPECIAL_ABILITY_PC~', -- Key string to speak in vehicle
}

-- Libraries of languages.
Config.Languages = {
    ['en'] = {
        ['speak'] = 'To speak with megaphone press '..Config.Keys.SpeakKeyString,
        ['speakcar'] = 'To speak with megaphone press '..Config.Keys.SpeakCarKeyString,
        ['managevolume'] = 'Volume: ~r~{s}%',
    },
    ['fr'] = {
        ['speak'] = 'Pour parlez dans le mégaphone appuyez sur '..Config.Keys.SpeakKeyString,
        ['speakcar'] = 'Pour parlez dans le mégaphone appuyez sur '..Config.Keys.SpeakCarKeyString,
        ['managevolume'] = 'Volume: ~r~{s}%',
    }
}