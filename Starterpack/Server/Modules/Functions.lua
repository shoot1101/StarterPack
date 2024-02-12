usedPlayers = {}

checkIfUsed = function(id, cb)
    local _src = id
    local _ply = ESX.GetPlayerFromId(_src)
    for k, v in pairs(usedPlayers) do
        if v.id == _src then
            print("[INFO] Checked player trying to get his pack back")
            if cb then
                return cb(true)
            else
                return true
            end
        end
    end
    MySQL.Async.fetchAll("SELECT getStarter FROM users WHERE identifier = @identifier", {
        ['@identifier'] = _ply.identifier
    }, function(result)
        if result then
            if result[1]['getStarter'] == 1 then
                table.insert(usedPlayers, {id = _src})
                if cb then
                    return cb(true)
                else
                    return true
                end
            else
                if cb then
                    return cb(false)
                else
                    return false
                end
            end
        else
            if cb then
                return cb(false)
            else
                return false
            end
        end
    end)
end

updateUser = function(id, cb)
    local _src = id
    local _ply = ESX.GetPlayerFromId(_src)
    table.insert(usedPlayers, {id = _src})
    MySQL.Async.execute("UPDATE users SET getStarter = @getStarter WHERE identifier = @identifier", {
        ['@getStarter'] = 1,
        ['@identifier'] = _ply.identifier,
    }, function(row)
        if row then
            if cb then
                return cb(true)
            else
                return true
            end
        else
            if cb then
                return cb(false)
            else
                return false
            end
        end
    end)
    if cb then
        return cb(false)
    else
        return false
    end
end