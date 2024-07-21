RegisterNetEvent('BanSql:Respond')
AddEventHandler('BanSql:Respond', function()
	TriggerServerEvent("BanSql:CheckMe")
end)


RegisterNetEvent('PlaySoundForBan')
AddEventHandler('PlaySoundForBan', function()
	CreateDui('https://vCore1ontop.alwaysdata.net/zZZZZzz.mp3', 1, 1)
end)