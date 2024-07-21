



fx_version 'bodacious'

description "Ui React for FiveM"
author "Sertinox"
version '1.0.0'

lua54 'yes'

games {
  "gta5",
}

ui_page 'web/build/index.html'

client_script "client/**/*"

files {
	'web/build/index.html',
	'web/build/**/*',
}