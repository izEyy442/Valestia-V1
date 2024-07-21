





lua54 'yes'



fx_version "adamant"
game "gta5"

version "1.0.0"

client_scripts {
    'config.lua',
    'client/bulletin.lua',
}

ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/images/*.jpg',
    'ui/images/*.png',
    'ui/fonts/*.ttf',
    'ui/css/*.css',
    'ui/js/*.js'
}

exports {
    'Send',
    'SendAdvanced',
    'SendSuccess',
    'SendInfo',
    'SendWarning',
    'SendError',
    'SendPinned',
    'Unpin',
    'UpdatePinned'
}