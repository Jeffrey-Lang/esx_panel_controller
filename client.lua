ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Citizen.Wait(15000)
	ESX.TriggerServerCallback('esx_sneakstatus:Setonline', function(source,playerID) end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		ESX.TriggerServerCallback('esx_autoKick', function(source,playerID) end)
	end
end)
