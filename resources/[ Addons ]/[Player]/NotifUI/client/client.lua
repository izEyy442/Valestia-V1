RegisterNetEvent('SHOW_NOTIFTOP')
AddEventHandler('SHOW_NOTIFTOP', function(show, text, icon, bordercolor)
    if show then
        SendReactMessage('SHOW_DRAWTOPNOTIF', { show = true, text = text, icon = icon, bordercolor = bordercolor })
    else
        SendReactMessage('SHOW_DRAWTOPNOTIF', { show = false, text = text, icon = icon , bordercolor = bordercolor })
    end
end)

RegisterNetEvent('SHOW_NOTIF')
AddEventHandler('SHOW_NOTIF', function(text, color, icon, jobname, phone, withaccept, announcement)
    SendReactMessage('SHOW_NOTIF', { text = text, bordercolor = color, icon = icon, jobname = jobname, phone = phone, withaccept = withaccept, announcement = announcement})
end)

RegisterNetEvent('SHOW_NOTIF_BASIC')
AddEventHandler('SHOW_NOTIF_BASIC', function(text, color, icon)
    SendReactMessage('SHOW_NOTIF_BASIC', { text = text })
end)

RegisterNetEvent('SHOW_IMAGE')
AddEventHandler('SHOW_IMAGE', function(show, url, left, top, width, height)
    SendReactMessage('SHOW_IMAGE', { show = show, url = url, left = left, top = top, width = width, height = height})
end)

RegisterCommand("showImage", function(source,args)

end)

-- RegisterCommand('showtestnotif', function()
--     TriggerEvent('SHOW_NOTIFTOP', true, 'Test Notification', 'https://www.svgrepo.com/show/532033/cloud.svg', 'rgba(255, 255, 255, 0.5)')
-- end)

-- RegisterCommand('hidetestnotif', function()
--     TriggerEvent('SHOW_NOTIFTOP', false, 'Test Notification', 'https://www.svgrepo.com/show/532033/cloud.svg', 'rgba(255, 255, 255, 0.5)')
-- end)