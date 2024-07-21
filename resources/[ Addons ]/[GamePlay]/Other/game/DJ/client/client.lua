
ESX = nil

xSound = exports.xsound


if ConfigDj.useESX then
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(500)
        end
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(500)
        end

        ESX.PlayerData = ESX.GetPlayerData()

        -- sync

        ESX.TriggerServerCallback('myDJ:receiveRunningSongs', function(DJPositions)
        
            if DJPositions ~= nil then
                for k, v in pairs(DJPositions) do
                    if v.currentData ~= nil then
                        if v.currentData.titleFromPlaylist then
                            playTitleFromPlaylist(v.name, v.pos, v.range, v.currentData.currentLink, v.currentData.currentPlaylist)
                        else
                            playSong(v.name, v.pos, v.range, v.currentData.currentLink)
                            isMusicPaused = false
                        end

                        if xSound:soundExists(v.name) then
                            xSound:setTimeStamp(v.name, v.currentData.currentTime)
                            if not v.currentData.currentlyPlaying then
                                startStopSong(v.name)
                            end
                        end

                    end
                end
            end
    
        end)


    end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) 
    ESX.PlayerData.job = job
end)



local isNearDJ = false
local isAtDJ = false
local currentDJ = ConfigDj.DJPositions[1]
local isSongRunning = true
local isMusicPaused = false

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    while true do

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed, true) 

        isAtDJ = false
        isNearDJ = false

        for k, v in pairs(ConfigDj.DJPositions) do
            if ESX.PlayerData.job.name == v.requiredJob then
                local distance = Vdist(playerCoords, v.pos.x, v.pos.y, v.pos.z)

                if distance < 2.0 then
                    currentDJ = v
                    isAtDJ = true
                    isNearDJ = true
                elseif distance < 25.0 then
                    isNearDJ = true
                    currentDJ = v
                end
            end
        end

        Wait(500)
    end

end)

CreateThread(function()
    while true do

        if ConfigDj.enableMarker then
            if isNearDJ then
                DrawMarker(27, currentDJ.pos.x, currentDJ.pos.y, currentDJ.pos.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*1.5, 1.0*1.5, 1.0, 136, 0, 136, 75, false, false, 2, false, false, false, false)
            end
        end

        if isAtDJ then
            showInfobar(Translation[ConfigDj.Locale]['DJ_interact'])
            if IsControlJustReleased(0, 38) then
                -- open DJ Interface
                SetNuiFocus(true, true)
                isDjOpen = true
                SendNUIMessage({type = 'open'})
                ESX.TriggerServerCallback('myDJ:requestPlaylistsAndSongs', function(playlists, songs)
                    SendNUIMessage({type = 'getPlaylists', playlists = playlists, songs = songs})
                end)
            end
        end

        Wait(1)
    end
end)

RegisterNetEvent('myDj:open')
AddEventHandler('myDj:open', function()
    SetNuiFocus(true, true)
    isDjOpen = true
    SendNUIMessage({type = 'open'})
    ESX.TriggerServerCallback('myDJ:requestPlaylistsAndSongs', function(playlists, songs)
        SendNUIMessage({type = 'getPlaylists', playlists = playlists, songs = songs})
    end)
end)

-- sync timestamps
CreateThread(function()
    while true do

        if currentDJ ~= nil then
            if xSound ~= nil and xSound:soundExists(currentDJ.name) then
                --print('Sound running: ' .. xSound:getTimeStamp(currentDJ.name) .. ' / ' .. xSound:getMaxDuration(currentDJ.name))
                
                if xSound:isPlaying(currentDJ.name) then
                    --print('Currently playing: ' .. xSound:getLink(currentDJ.name))
                    SendNUIMessage({type = 'updateSeconds', maxDuration = xSound:getMaxDuration(currentDJ.name), secs = xSound:getTimeStamp(currentDJ.name)})
                end
            end
        end

        Wait(1500)
    end
end)

function playSong(DJName, DJPos, DJRange, songlink)
    local options =
    {
        onPlayStart = function(event) -- event argument returns getInfo(id)
            --print("oh yeah! PARTY!")
        end,
        onPlayEnd = function(event) 
            --print("oh... already end ? :( Song name ? pls")
            --print(event.url)
        end,
    }   

    xSound:PlayUrlPos(DJName, songlink, 1, DJPos, false, options)
    xSound:Distance(DJName, 22)
    SendNUIMessage({type = 'updateSonginfos', link = songlink})
end

function startStopSong(DJName)

    if xSound:soundExists(DJName) and isMusicPaused then
        xSound:Resume(DJName) 
        isMusicPaused = false
    elseif xSound:soundExists(DJName) and not isMusicPaused then
        xSound:Pause(DJName)
        isMusicPaused = true

    end

end

function stopSong(DJName)
    xSound:Destroy(DJName) 
end

function rewindSong(DJName)
    if currentDJ ~= nil then
		if xSound:soundExists(DJName) then
			if xSound:isPlaying(DJName) then
				local currTimestamp = xSound:getTimeStamp(DJName)
				if currTimestamp - 10 < 0 then
					xSound:setTimeStamp(0)
				else
					xSound:setTimeStamp(DJName, currTimestamp - 10)
				end
				
			end
		end
	end
end

function forwardSong(DJName)
    if currentDJ ~= nil then
		if xSound:soundExists(DJName) then
			if xSound:isPlaying(DJName) then
				local currTimestamp = xSound:getTimeStamp(DJName)
				xSound:setTimeStamp(DJName, currTimestamp + 10)
			end
		end
	end
end

function volumeUp(DJName)
    if xSound:soundExists(DJName) then
        if currentDJ.volume + 0.1 >= 1 then
            currentDJ.volume = 1.0
            xSound:setVolume(DJName, 1.0)
            --ShowNotification('~g~Maximum volume reached')
        else
            currentDJ.volume = currentDJ.volume + 0.1
            xSound:setVolume(DJName, currentDJ.volume + 0.1)
            --ShowNotification('~g~Volume set to: ' .. (currentDJ.volume + 0.1) * 100 .. '%')
        end
        
    end
end

function volumeDown(DJName)
    if xSound:soundExists(DJName) then

        local currentVolume = 1.0

        for k,v in pairs(ConfigDj.DJPositions) do
            if v.name == DJName then
                currentVolume = v.volume
            end
        end

        if currentDJ.volume - 0.1 <= 0 then
            currentDJ.volume = 0.0
            xSound:setVolume(DJName, 0.0)
            --ShowNotification('~g~Minimum volume reached')
        else
            currentDJ.volume = currentDJ.volume - 0.1
            xSound:setVolume(DJName, currentDJ.volume - 0.1)
            --ShowNotification('~g~Volume set to: ' .. (currentDJ.volume - 0.1) * 100 .. '%')
        end
        
    end
end

function playTitleFromPlaylist(DJName, DJPos, DJRange, link, playlistId)
    ESX.TriggerServerCallback('myDJ:requestPlaylistById', function(playlistSongs)
		if playlistSongs ~= nil then
			for k, v in pairs(playlistSongs) do
				if v.link == link then
					startSongFromPlaylist(DJName, DJPos, DJRange, k, playlistSongs)
				end
			end
		end
	end, playlistId)
end

function startSongFromPlaylist(DJName, DJPos, DJRange, startIndex, playlist)

    --isSongRunning = true

    for i = startIndex, #playlist, 1 do

        --print('started a new song # ' .. i)

        local options =
        {
            onPlayStart = function(event) -- event argument returns getInfo(id)
                --print('Song started')
                isSongRunning = true
            end,
            onPlayEnd = function(event) 
                --print("oh... already end ? :( Song name ? pls")
                isSongRunning = false
            end,
        }   
    
        xSound:PlayUrlPos(DJName, playlist[i].link, 1, DJPos, false, options)
        xSound:Distance(DJName, DJRange)

        while isSongRunning do
            Citizen.Wait(1500)
            --print('Song is running, wait until end')
        end

        --print('now you can start a new song')

    end

end

if ConfigDj.enableCommand then
    RegisterCommand('openDJ', function(source, args, rawCommand)
        SetNuiFocus(true, true)
        isDjOpen = true
        SendNUIMessage({type = 'open'})
        ESX.TriggerServerCallback('myDJ:requestPlaylistsAndSongs', function(playlists, songs)
            SendNUIMessage({type = 'getPlaylists', playlists = playlists, songs = songs})
        end)
    end, false)
end

RegisterNUICallback('close', function(data, cb) 
    SetNuiFocus(false, false)
    isDjOpen = false
end)

RegisterNetEvent('myDj:clientStartStop')
AddEventHandler('myDj:clientStartStop', function(DJName)
    startStopSong(DJName)
end)

RegisterNUICallback('togglePlaystate', function(data, cb)
    --print('gotPlaystateTrigger')
    TriggerServerEvent('myDj:syncStartStop', currentDJ.name)
    --print('server triggered')
end)

RegisterNetEvent('myDj:clientPlaySong')
AddEventHandler('myDj:clientPlaySong', function(DJName, DJPos, DJRange, link)
    --print('got server trigger: play ' .. link)
    playSong(DJName, DJPos, DJRange, link)
    isMusicPaused = false
end)

RegisterNUICallback('playNewSong', function(data, cb) 
    --print(data.link) -- der Link zur Musik
    --print('got NUI trigger')
    --print('play now ' .. data.link .. 'at ' .. tostring(currentDJ.pos))
    TriggerServerEvent('myDj:syncPlaySong', currentDJ.name, currentDJ.pos, currentDJ.range, data.link)
end)

RegisterNetEvent('myDj:clientPlaySongFromPlaylist')
AddEventHandler('myDj:clientPlaySongFromPlaylist', function(DJName, DJPos, DJRange, link, playlistId)
    playTitleFromPlaylist(DJName, DJPos, DJRange, link, playlistId)
end)

RegisterNUICallback('playSongFromPlaylist', function(data, cb)
    -- Song ID = data.id
    -- Playlist ID = data.playlistId
    -- Songlink = data.link
	--playTitleFromPlaylist(currentDJ.name, currentDJ.pos, data.link, data.playlistId)
	TriggerServerEvent('myDj:syncPlaySongFromPlaylist', currentDJ.name, currentDJ.pos, currentDJ.range, data.link, data.playlistId)
end)

RegisterNetEvent('myDj:clientRewind')
AddEventHandler('myDj:clientRewind', function(DJName)
    rewindSong(DJName)
end)

RegisterNUICallback('rewind', function(data, cb)
    -- 10 secs zurück 
	-- rewindSong(currentDJ.name)
    TriggerServerEvent('myDj:syncRewind', currentDJ.name)
end)

RegisterNetEvent('myDj:clientForward')
AddEventHandler('myDj:clientForward', function(DJName)
    forwardSong(DJName)
end)

RegisterNUICallback('forward', function(data, cb)
    -- 10 secs vorwärts 
	TriggerServerEvent('myDj:syncForward', currentDJ.name)
end)

RegisterNetEvent('myDj:clientVolumeDown')
AddEventHandler('myDj:clientVolumeDown', function(DJName)
    volumeDown(DJName)
end)

RegisterNUICallback('down', function(data, cb)
    -- leiser machen
    TriggerServerEvent('myDj:syncVolumeDown', currentDJ.name)
    if currentDJ.volume <= 0.0 then
        ShowNotification('~g~Volume minimum atteint !')
    end
end)

RegisterNetEvent('myDj:clientVolumeUp')
AddEventHandler('myDj:clientVolumeUp', function(DJName)
    volumeUp(DJName)
end)

RegisterNUICallback('up', function(data, cb)
    -- lauter machen
    TriggerServerEvent('myDj:syncVolumeUp', currentDJ.name)
    if currentDJ.volume >= 1.0 then
        ShowNotification('~g~Volume maximum atteint !')
    end
end)

RegisterNUICallback('addPlayList', function(data, cb)
    -- Playlist hinzufügen
    -- label = data.name
    TriggerServerEvent('myDJ:addPlaylist', data.name)
end)

RegisterNUICallback('addSongToPlaylist', function(data, cb)
    -- link = data.link
    -- Playlist ID = data.id
    -- Ich würde das jetzt zum Server senden dort in die DB inserten und dann wieder auslesen und zurück zum Client schicken und dann wieder an das UI schicken
    --print('add song: ' .. data.id .. ' : ' .. data.link)
    TriggerServerEvent('myDJ:addSongToPlaylist', data.id, tostring(data.link))
    --TriggerServerEvent('myDJ:addSongToPlaylist', 1, 'data.link')

    Wait(100)
    ESX.TriggerServerCallback('myDJ:requestPlaylistsAndSongs', function(playlists, songs)
        SendNUIMessage({type = 'getPlaylists', playlists = playlists, songs = songs})
    end)
end)

RegisterNUICallback('deleteSong', function(data, cb)
    -- Song ID = data.id
    -- Playlist ID = data.playlistId
    --print('remove: ' .. data.id)
	TriggerServerEvent('myDJ:removeSongFromPlaylist', data.id)
end)

RegisterNUICallback('deletePlaylist', function(data, cb)
    -- Song ID = data.id
    -- Playlist ID = data.playlistId
    --print('remove playlist: ' .. data.id)
	TriggerServerEvent('myDJ:removePlaylist', data.id)
end)



RegisterNUICallback('noSongtitle', function(data, cb)
    -- gibt keinen Song title oder kann nicht abgerufen werden
	ShowNotification(Translation[ConfigDj.Locale]['title_does_not_exist'])
end)


function ShowNotification(text)
	SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
	DrawNotification(false, true)
end

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end