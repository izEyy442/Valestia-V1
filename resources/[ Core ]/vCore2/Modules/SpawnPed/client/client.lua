CreateThread(function()
    local hash = GetHashKey("a_f_m_bevhills_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(2000)
    end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "a_f_m_bevhills_02", -694.3489, -645.7226, 20.1428, 356.5452, false, true)  
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
end)

CreateThread(function()
    local hash = GetHashKey("s_m_m_highsec_01") --Karting garde
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(2000)
    end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_highsec_01", 2064.0752, 3942.1899, 34.0393, 127.3859, false, true)  
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
end)

CreateThread(function()
    local hash = GetHashKey("s_m_m_highsec_01") --Karting garde
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(2000)
    end
    local ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_highsec_01", 2066.0623, 3938.9297, 34.0530, 120.9092, false, true)  
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
end) 