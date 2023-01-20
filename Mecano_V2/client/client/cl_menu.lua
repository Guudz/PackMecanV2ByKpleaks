Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


-- MENU FUNCTION --

local open = false 
local mecanoMain2 = RageUI.CreateMenu('Mécano', 'Interaction')
local subMenu5 = RageUI.CreateSubMenu(mecanoMain2, "Annonces", "Interaction")
local mecanoMenu6 = RageUI.CreateSubMenu(mecanoMain2, "Véhicule", "Interaction")
local mecanoMenu8 = RageUI.CreateSubMenu(mecanoMain2, "Point Farm", "Interaction")
mecanoMain2.Display.Header = true 
mecanoMain2.Closed = function()
  open = false
end

function OpenMenumecano()
	if open then 
		open = false
		RageUI.Visible(mecanoMain2, false)
		return
	else
		open = true 
		RageUI.Visible(mecanoMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mecanoMain2,function() 

			RageUI.Separator("↓ Annonces ↓")
			RageUI.Button("Annonces", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, subMenu5)


			RageUI.Separator("↓ Facture ↓")
			RageUI.Button("Faire une Facture", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					OpenBillingMenu2()
                    RageUI.CloseAll()
				end
			})

		
		
			RageUI.Separator("↓ Intéraction ↓")
			RageUI.Button("Intéractions sur véhicules", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, mecanoMenu6)

			RageUI.Separator("↓ Point Farm ↓")

			RageUI.Button("Pour accéder au point de farm", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
				end
			}, mecanoMenu8)

			end)
			


			RageUI.IsVisible(mecanoMenu6,function() 

				RageUI.Button("Réparer le véhicule", nil, {RightLabel = "→→"}, true , {
					onSelected = function()
					local playerPed = PlayerPedId()
					local vehicle   = ESX.Game.GetVehicleInDirection()
					local coords    = GetEntityCoords(playerPed)
		
					if IsPedSittingInAnyVehicle(playerPed) then
						ESX.ShowNotification('Vous ne pouvez pas effectuer cette action depuis un véhicule!')
						return
					end
		
					if DoesEntityExist(vehicle) then
						TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
						Citizen.CreateThread(function()
							Citizen.Wait(20000)
		
							SetVehicleFixed(vehicle)
							SetVehicleDeformationFixed(vehicle)
							SetVehicleUndriveable(vehicle, false)
							SetVehicleEngineOn(vehicle, true, true)
							ClearPedTasksImmediately(playerPed)
		
							ESX.ShowNotification('Voiture Reparée')
						end)
					else
						ESX.ShowNotification('~r~Aucun véhicule à proximité')
					end
				end
			})

			RageUI.Button("Nettoyer le véhicule", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					local playerPed = PlayerPedId()
					local vehicle   = ESX.Game.GetVehicleInDirection()
					local coords    = GetEntityCoords(playerPed)
		
					if IsPedSittingInAnyVehicle(playerPed) then
						ESX.ShowNotification('Vous ne pouvez pas effectuer cette action depuis un véhicule!')
						return
					end
		
					if DoesEntityExist(vehicle) then
						TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
						Citizen.CreateThread(function()
							Citizen.Wait(10000)
		
							SetVehicleDirtLevel(vehicle, 0)
							ClearPedTasksImmediately(playerPed)
		
							ESX.ShowNotification('Véhicule nettoyer')
						end)
					else
						ESX.ShowNotification('~r~Aucun véhicule à proximité')
					end
	
				end

		})

		RageUI.Button("Mettre en fourrière", nil, {RightLabel = "→→"}, true , {
			onSelected = function()
				if IsPedSittingInAnyVehicle(playerPed) then
                    local vehicle = GetVehiclePedIsIn(playerPed, false)

                    if GetPedInVehicleSeat(vehicle, -1) == playerPed then
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                        ESX.ShowNotification('~r~Le vehicule a été mis en fourrière')
                        ESX.Game.DeleteVehicle(vehicle)
                    else
                        ESX.ShowNotification('Vous devez être assis du ~r~côté conducteur!')
                    end
                else
                    local vehicle = ESX.Game.GetVehicleInDirection()

                    if DoesEntityExist(vehicle) then
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                        ESX.ShowNotification('~r~Le vehicule a été mis en fourrière')
                        ESX.Game.DeleteVehicle(vehicle)
                    else
                        ESX.ShowNotification('~g~Conseil~s~\nRapprochez vous d\'un véhicule.')
                    end
                end
			end
		})

		RageUI.Button("Crocheter le véhicule", nil, {RightLabel = "→→"}, true , {
			onSelected = function()
				local playerPed = PlayerPedId()
				local vehicle = ESX.Game.GetVehicleInDirection()
				local coords = GetEntityCoords(playerPed)
	
				if IsPedSittingInAnyVehicle(playerPed) then
					ESX.ShowNotification('Vous ne pouvez pas effectuer cette action depuis un véhicule!')
					return
				end
	
				if DoesEntityExist(vehicle) then
					isBusy = true
					TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
					Citizen.CreateThread(function()
						Citizen.Wait(10000)
	
						SetVehicleDoorsLocked(vehicle, 1)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
						ClearPedTasksImmediately(playerPed)
	
						ESX.ShowNotification('Véhicule ouvert')
					end)
				else
					ESX.ShowNotification('~~r~Aucun véhicule à proximité')
				end
			end
		})
	end)

			

			RageUI.IsVisible(mecanoMenu8,function() 

				RageUI.Button("Obtenir le point de récolte", nil, {RightLabel = "→→"}, true , {
					onSelected = function()
						SetNewWaypoint(495.62, -1340.28, 29.91)  
					end 
				})
	
				RageUI.Button("Obtenir le point de traitement", nil, {RightLabel = "→→"}, true , {
					onSelected = function()
						SetNewWaypoint(-37.44, -1038.33, 28.6) 
					end 
				})

			end)

			RageUI.IsVisible(subMenu5,function() 

				RageUI.Button("Annonce Ouvertures", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Ouvre:mecano')
					end
				})
	
				RageUI.Button("Annonce Fermetures", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Ferme:mecano')
					end
				})

				RageUI.Button("Annonce Recrutement", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						TriggerServerEvent('Recru:mecano')
					end
				})

				end)
		 Wait(0)
		end
	 end)
  end
end

-- FUNCTION BILLING --

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_mecano', ('mecano'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end

-- OUVERTURE DU MENU --

Keys.Register('F6', 'Mécano', 'Ouvrir le menu mecano', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then
    	OpenMenumecano()
	end
end)