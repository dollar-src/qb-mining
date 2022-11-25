local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("mt-mining:server:DarPedras")
AddEventHandler("mt-mining:server:DarPedras", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem("stone", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["stone"], "add", 1)
        TriggerClientEvent('QBCore:Notify', src, 'You broke Stone!.')
        
end)

RegisterServerEvent("mt-mining:server:LavarPedras")
AddEventHandler("mt-mining:server:LavarPedras", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local stone = Player.Functions.GetItemByName("stone")
    if stone ~= nil then

        if stone.amount >= 1 then
            Player.Functions.RemoveItem("stone", 1)
            Player.Functions.AddItem("washedstone", 1)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["washedstone"], "add", 1)
            TriggerClientEvent('QBCore:Notify', src, 'Stones Whashed.')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You dont have the rigth items...', 'error')
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "Missing something...", "error")
    end
end)

RegisterNetEvent('mt-mining:server:VenderPedras', function(level) 
  local payment = 2
 
      
   if level >= 100  and level <= 200 then
        payment = payment  + 10

    elseif level >= 200 and level <= 400 then
        payment = payment  + 15

    elseif level >= 400 and level <= 800 then
        payment = payment  + 20
    elseif level >= 800 and level <= 1600 then
        payment = payment  + 25

    elseif level >= 1600 and level <= 3200 then
        payment = payment  + 25

    elseif level >= 3200 and level <= 6400 then
        payment = payment  + 30

    elseif level >= 6400 and level <= 12800 then
        payment = payment  + 50
    elseif level > 12800 then
        payment = payment  + 100

    end
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
		local washedstone = Player.Functions.GetItemByName("washedstone")
		if washedstone ~= nil then
            washedstoneamount = washedstone.amount
			Player.Functions.RemoveItem("washedstone", washedstoneamount)
			Player.Functions.AddMoney('bank', payment * washedstoneamount , "washedstone-sell")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["washedstone"], "remove", washedstoneamount)
			TriggerClientEvent('QBCore:Notify', src, washedstoneamount.." x  sell for $"..payment, "success")
			TriggerClientEvent("mt-drugdealer:client:venda", source)
		else
		    TriggerClientEvent('QBCore:Notify', src, "There Is No Item", "error")
        end 

end)




