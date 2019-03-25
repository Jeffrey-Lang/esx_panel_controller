ESX = nil
setOnline = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		ESX.TriggerServerCallback('esx_autoKick', function(source,playerID) end)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Citizen.Wait(15000)
	while ESX ~= nil and not setOnline do
		ESX.TriggerServerCallback('esx_sneakstatus:Setonline', function(source,playerID) end)
		setOnline = true
	end
end)