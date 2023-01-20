TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'mecano', 'alerte mecano', true, true)

TriggerEvent('esx_society:registerSociety', 'mecano', 'mecano', 'society_mecano', 'society_mecano', 'society_mecano', {type = 'public'})

RegisterServerEvent('Ouvre:mecano')
AddEventHandler('Ouvre:mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mécano', '~r~Annonce', 'Le Mécano est désormais ~g~Ouvert~s~ !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('Ferme:mecano')
AddEventHandler('Ferme:mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mécano', '~r~Annonce', 'Le Mécano est désormais ~r~Fermer~s~ !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('Recru:mecano')
AddEventHandler('Recru:mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Mécano', '~g~Annonce', '~y~Recrutement en cours, rendez-vous au Mécano !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('esx_mecanojob:prendreitems')
AddEventHandler('esx_mecanojob:prendreitems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('esx_mecanojob:stockitem')
AddEventHandler('esx_mecanojob:stockitem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('esx_mecanojob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_mecanojob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)
		cb(inventory.items)
	end)
end)

--------------------------------------------------- FARMS ------------------------------------------------------

RegisterNetEvent('recoltepiece') -- récolte
AddEventHandler('recoltepiece', function()
    local item = "piecedetache"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire!")
        recoltepossible = false
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
		return
    end
end)

RegisterNetEvent('traitementrepair') -- Traitement
AddEventHandler('traitementrepair', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local piecedetache = xPlayer.getInventoryItem('piecedetache').count
    local repairkit = xPlayer.getInventoryItem('repairkit').count

    if repairkit > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Tu à ateint la limite')
    elseif piecedetache < 2 then
        TriggerClientEvent('esx:showNotification', source, '~r~tu n\'as plus de piece détacher')
    else
        xPlayer.removeInventoryItem('piecedetache', 2)
        xPlayer.addInventoryItem('repairkit', 1)    
    end
end)