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
local mecanoDeTesMort = RageUI.CreateMenu('Garage', 'Interaction')
mecanoDeTesMort.Display.Header = true 
mecanoDeTesMort.Closed = function()
  open = false
end

function OpenTesMortmecano()
     if open then 
         open = false
         RageUI.Visible(mecanoDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(mecanoDeTesMort, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mecanoDeTesMort,function() 

              RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                  if dist4 < 4 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                end
              end, })


               RageUI.Separator("↓ ~b~Gestion Véhicule ~s~ ↓")

                RageUI.Button("Transporteur remorque", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                      local model = GetHashKey("flatbed")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, -29.25, -1017.02, 28.83, 70.57, true, true)
                    end
                })

                
                RageUI.Button("Dépaneuse", nil, {RightLabel = "→→"}, true , {
                  onSelected = function()
                    local model = GetHashKey("towtruck")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, -29.25, -1017.02, 28.83, 70.57, true, true)
                  end
              })

              RageUI.Button("2ème Dépaneuse", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local model = GetHashKey("towtruck2")
                  RequestModel(model)
                  while not HasModelLoaded(model) do Citizen.Wait(10) end
                  local pos = GetEntityCoords(PlayerPedId())
                  local vehicle = CreateVehicle(model, -29.25, -1017.02, 28.83, 70.57, true, true)
                end
            })


           end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = -33.77, y = -1021.35, z = 28.88}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(36, -33.7, -1021.35, 28.88, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 235, 59, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  OpenTesMortmecano()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

--- BLIPS ---

Citizen.CreateThread(function()

  local blip = AddBlipForCoord(-44.79, -1043.35, 28.78) 

  SetBlipSprite (blip, 402) -- Model du blip
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.9) -- Taille du blip
  SetBlipColour (blip, 66) -- Couleur du blip
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName('STRING')
  AddTextComponentSubstringPlayerName('Mécano')
  EndTextCommandSetBlipName(blip)
end)

