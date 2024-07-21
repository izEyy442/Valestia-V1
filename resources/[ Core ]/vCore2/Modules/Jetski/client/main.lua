function MenuJetski()
    local main = RageUI.CreateMenu("", "Location de Jetski")
    RageUI.Visible(main, not RageUI.Visible(main))
    Citizen.CreateThread(function()
        while main do
            Citizen.Wait(0)
            RageUI.IsVisible(main, function()
                RageUI.Button("SeaShark (~g~500$~s~)", ("Loue un SeaShark (JetSki) pour ~g~500$~s~ !"), { LeftBadge = RageUI.BadgeStyle.Star }, true, {
                    onSelected = function()
                        TriggerServerEvent('izeyy:locajetski')
                        RageUI.CloseAll()
                    end
                })
            end, function()
            end)
            if not RageUI.Visible(main) then
                main = RMenu:DeleteType('main', true)
            end            
        end
    end)
end

local mamadouCoords = {x = -1604.936, y = -1166.869, z = 0.279, h = 277.032}
local ped = 0

Citizen.CreateThread(function()
	local hash = GetHashKey("u_m_y_cyclist_01")
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVFEMALE", "u_m_y_cyclist_01", mamadouCoords.x, mamadouCoords.y, mamadouCoords.z, mamadouCoords.h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)