fx_version 'cerulean'

game 'gta5'

author "Bobs & Co"
description "Starterpack pour esx"
version '1.0.0'

shared_script '@es_extended/imports.lua'

client_scripts {
  'Client/Modules/*.lua',
  'Client/*.lua',

}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'Server/Modules/Functions.lua',
  'Server/*.lua',
}

shared_scripts {
  'Config.lua'
}

