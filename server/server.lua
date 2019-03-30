local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()
	MySQL.Async.execute('UPDATE users SET online = 0, server = 0  WHERE online = 1 AND server = @server',{ ['@server'] = Config.Server },
	function (result)
		print('All users have been set to offline')
	end)
end)

ESX.RegisterServerCallback('esx_sneakstatus:Setonline', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local identifier =  xPlayer.identifier
		MySQL.Async.execute('UPDATE users SET online = 1, server = @server WHERE identifier = @identifier',
			{
				['@identifier'] =  identifier,
				['@server'] =  Config.Server
			},
			function (result)
			end)
	end
end)


AddEventHandler('playerDropped', function(reason)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		local identifier =  xPlayer.identifier
		MySQL.Async.execute('UPDATE users SET online = 0 WHERE identifier = @identifier',
		{
			['@identifier'] =  identifier
		},
		function (result)
		end)
	end
end)

-- Report Users
TriggerEvent('es:addGroupCommand', 'reportplayer', 'user', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil and args[2] ~= nil and args[3] ~= nil  then
				local _source  = source
				local xPlayer  = ESX.GetPlayerFromId(_source)
				local xPlayerReport  = ESX.GetPlayerFromId(args[1])
				local playerName = GetPlayerName(source)
				local reportedplayer = xPlayerReport.identifier
				MySQL.Async.fetchAll('SELECT id FROM users WHERE identifier = @identifier LIMIT 1',
				{
					['@identifier'] =  reportedplayer
				},
				function (result)
					userid = result[1].id
					MySQL.Async.execute(
						"INSERT INTO user_reports (reported_by,report_type ,report_comment,userid) VALUES (@reportedby,@report_type,@report_comment,@userid)",{
							['@reportedby'] = playerName,
							['@report_type'] = args[2],
							['@report_comment'] = args[3],
							['@userid'] = userid
						},
						function(result)
							TriggerClientEvent('chatMessage', source, "SYSTEM", {34, 34, 29}, "User has been reported")
						end)
				end)
		else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Invalid input example: /report 22 rdm Player just drove me over.")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end,
{help = 'Report player',
 params = {
	 {name = "id", help = 'Player id'},
	 {name = "Type", help = 'Examples vdm,rdm,fail-rp,rude,cheating'},
	 {name = "Comment", help = 'Player drove me over'},
 	}
 })

---
--- DO NOT TOUCH THIS
--- DO NOT TOUCH THIS
--- DO NOT TOUCH THIS
--- DO NOT TOUCH THIS

-- KickPlayer
function kickPlayer()
	MySQL.Async.fetchAll('SELECT * FROM kicks', {},
		function (result)
			if result[1] ~= nil then
				for i=1, #result, 1 do
					local steamid = result[i].steamid
					local reason = result[i].reason
					local kickid = result[i].id

					if result[i].steamid ~= nil then
						steamid = result[i].steamid
					end
					local findIdentifier = steamid
					MySQL.Async.fetchAll('SELECT identifier,online FROM users WHERE online = @online AND identifier = @identifier',
						{
							['@online'] = 1,
							['@identifier'] = findIdentifier
						},
						function (data)
							for i=1, #data, 1 do
								if data[i].identifier == findIdentifier then
									local foundPlayer = ESX.GetPlayerFromIdentifier(data[i].identifier)
									if foundPlayer ~= nil then
										local playerServerId = foundPlayer.source
										foundPlayer.kick(reason)
										print(kickid)
										MySQL.Async.execute('DELETE FROM kicks WHERE id = @id',{ ['@id'] = kickid })
									end
								end
							end
						end)
				end
			end
		end)
end
-- End Kick Player

function loopCheckCommands()
	kickPlayer()
	SetTimeout(60000, function()
		loopCheckCommands()
	end)
end

AddEventHandler('onMySQLReady', function()
	loopCheckCommands()
end)


