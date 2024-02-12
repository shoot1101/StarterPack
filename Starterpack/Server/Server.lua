--[[ ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)  ]]


ESX.RegisterServerCallback('apx_starterpack:server:checkIfUsed', function(source,cb) 
    local _src = source
    checkIfUsed(_src, function(result)
        if result then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent("apx_starterpack:server:markAsUsed")
AddEventHandler("apx_starterpack:server:markAsUsed", function()
    local _src = source
    local _ply = ESX.GetPlayerFromId(_src)
    _ply.addInventoryItem('pack1', 1)
    eLogsDiscord("[Pack] **"..xPlayer.getName().."** a pris une pack légal *", Config.logs.pack)

    TriggerClientEvent('okokNotify:Alert', source, 'Pack', 'Vous avez reçu votre pack', 3000, 'success')

    updateUser(_src, function(result)
        if result then
        end
    end)
end)

RegisterServerEvent("apx_starterpack:server:markAsUsed2")
AddEventHandler("apx_starterpack:server:markAsUsed2", function()
    local _src = source
    local _ply = ESX.GetPlayerFromId(_src)
    local xPlayer = ESX.GetPlayerFromId(_src)
    _ply.addInventoryItem('pack2', 1)
    eLogsDiscord("[Pack] **"..xPlayer.getName().."** a pris une pack illégal**", Config.logs.pack)

    TriggerClientEvent('okokNotify:Alert', source, 'Pack', 'Vous avez reçu votre pack', 3000, 'success')

    updateUser(_src, function(result)
        if result then
        end
    end)
end)

ESX.RegisterUsableItem('pack1', function(playerId)
    print(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    for k,v in pairs(Config.itemslegal) do
        xPlayer.addInventoryItem(k, v.nbr)
        xPlayer.removeInventoryItem("pack1", 1)
    end
    TriggerClientEvent('okokNotify:Alert', source, 'Pack', 'Vous ouvrez votre pack', 3000, 'info')

    eLogsDiscord("[Pack] **"..xPlayer.getName().."** a utilisé un pack légal**", Config.logs.pack)
end)

ESX.RegisterUsableItem('pack2', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)

    for k,v in pairs(Config.itemsillegal) do
        xPlayer.addInventoryItem(k, v.nbr)
        xPlayer.removeInventoryItem("pack2", 1)
    end
    TriggerClientEvent('okokNotify:Alert', source, 'Pack', 'Vous ouvrez votre pack', 3000, 'info')
    eLogsDiscord("[Pack] **"..xPlayer.getName().."** a utilisé un pack illégal**", Config.logs.pack)
end)

---------------- LOGS
function eLogsDiscord(message,url)
    local DiscordWebHook = url
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.logs.NameLogs, content = message}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('eMAcdo:logsEvent')
AddEventHandler('eMAcdo:logsEvent', function(message, url)
	eLogsDiscord(message,url)
end)