local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('gunTextureSystem:getGunTextures', function(source, cb)
    MySQL.Async.fetchAll('SELECT weapon_name, texture_name FROM ' .. Config.Database.TableName, {}, function(result)
        local textures = {}
        for i=1, #result, 1 do
            textures[result[i].weapon_name] = result[i].texture_name
        end
        cb(textures)
    end)
end)

RegisterCommand('setguntexture', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        if #args == 2 then
            local weaponName = args[1]
            local textureName = args[2]
            MySQL.Async.execute('INSERT INTO ' .. Config.Database.TableName .. ' (weapon_name, texture_name) VALUES (@weaponName, @textureName) ON DUPLICATE KEY UPDATE texture_name = @textureName', {
                ['@weaponName'] = weaponName,
                ['@textureName'] = textureName
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('esx:showNotification', source, 'Texture updated successfully.')
                else
                    TriggerClientEvent('esx:showNotification', source, 'Failed to update texture.')
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Invalid arguments. Usage: /setguntexture <weaponName> <textureName>')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'You do not have permission to use this command.')
    end
end, false)