local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.TriggerServerCallback('gunTextureSystem:getGunTextures', function(textures)
        Config.GunTextures = textures
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if DoesEntityExist(playerPed) then
            for weaponHash, texture in pairs(Config.GunTextures) do
                if HasPedGotWeapon(playerPed, GetHashKey(weaponHash), false) then
                    SetPedWeaponTintIndex(playerPed, GetHashKey(weaponHash), texture)
                end
            end
        end
    end
end)