



fx_version "cerulean"

game "gta5"

shared_script {
    "src/shared/**"
}

client_scripts {
    "src/client/**"
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "src/server/**"
}

ui_page{
    'html/index.html'
} 
files {
    'html/index.html',
    'html/assets/*.*',
}