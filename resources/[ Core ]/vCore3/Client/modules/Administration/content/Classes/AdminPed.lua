---
--- @author Kadir#6666
--- Create at [26/04/2023] 20:26:52
--- Current project [Valestia-V1]
--- File name [AdminPed]
---

---@overload fun(): AdminPed
AdminPed = Class.new(function(class)

    ---@class AdminPed: BaseObject
    local self = class;

    function self:Constructor()

        self.invisible      = false;
        self.godmode        = false;
        self.noclip         = false;

        Shared:RegisterKeyMapping("admin:toggle_noclip", {
            label = "admin_noclip_toggle"
        }, "F10", function ()

            if (Client.Admin:IsInStaffMode()) then

                self:SetNoClipActive(not self:HasNoClipActive());
                self:OnNoClip();

            end

        end);

        Shared:RegisterKeyMapping("admin:use_tpm", {
            label = "admin_use_tpm"
        }, "F11", function ()

            if (Client.Admin:IsInStaffMode()) then

                self:TeleportToMarker()

            end

        end);

    end

    function self:Start()
        Client.Admin.Ped:SetNoClipActive(false);
        Client.Admin.Ped:OnNoClip();
    end

    function self:Stop()

        self:SetNoClipActive(false);
        self:DisableNoClip();

        self:SetInvisible(false);
        self:SetGodMode(false);

    end

    ---@return boolean
    function self:HasNoClipActive()
        return self.noclip
    end

    ---@param bool boolean
    function self:SetNoClipActive(bool)
        self.noclip = bool
    end

    function self:OnNoClip()
        CreateThread(function()
            local ped = PlayerPedId()
            if self:HasNoClipActive() then
                Client.Admin.Utils:SetFreecamEnabled(true);
                while self:HasNoClipActive() do
                    Client.Admin.Utils:CameraLoop();
                    self:SetGodMode(true);
                    Client.Admin.Utils:SetNoClipAttributes(ped, true);
                    self:SetInvisible(true);
                    Wait(0)
                end
                self:SetGodMode(false);
            else
                self:DisableNoClip();
            end
        end)
    end

    function self:DisableNoClip()
        local ped = PlayerPedId()
        Client.Admin.Utils:SetFreecamEnabled(false);
        local pCoords = GetEntityCoords(ped);
        Client.Admin.Utils:SetNoClipAttributes(ped, false);
        self:SetInvisible(false);
        local get, z = GetGroundZFor_3dCoord(pCoords.x, pCoords.y, pCoords.z, true, 0);
        if get then
            SetEntityCoordsNoOffset(PlayerPedId(), pCoords.x, pCoords.y, z + 1.0, 0.0, 0.0, 0.0);
        end
    end

    ---@return boolean
    function self:IsInvisible()
        return self.invisible
    end

    ---@param bool boolean
    function self:SetInvisible(bool)
        self.invisible = bool
        SetEntityVisible(PlayerPedId(), not self.invisible, false)
    end

    ---@return boolean
    function self:IsInGodMode()
        return self.godmode;
    end

    ---@param bool boolean
    function self:SetGodMode(bool)
        self.godmode = bool;
        SetEntityInvincible(PlayerPedId(), self.godmode);
    end

    ---Disable all option toggle in menu
    function self:DisableAllOptions()
        self:SetNoClipActive(false);
        self:DisableNoClip();
        self:SetInvisible(false);
        --self:SetGodMode(false); --NO GODMODE UPDATE
    end

    function self:TeleportToMarker()

        local blipMarker = GetFirstBlipInfoId(8)
        if not DoesBlipExist(blipMarker) then
            return
        end

        DoScreenFadeOut(650)
        while not IsScreenFadedOut() do
            Wait(0)
        end

        local ped, coords = PlayerPedId(), GetBlipInfoIdCoord(blipMarker)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local oldCoords = GetEntityCoords(ped)

        local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
        local found = false

        if vehicle > 0 then
            FreezeEntityPosition(vehicle, true)
        else
            FreezeEntityPosition(ped, true)
        end

        for i = Z_START, 0, -25.0 do

            local z = i
            if (i % 2) ~= 0 then
                z = Z_START - i
            end

            NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)

            local curTime = GetGameTimer()
            while IsNetworkLoadingScene() do
                if GetGameTimer() - curTime > 1000 then
                    break
                end
                Wait(0)
            end

            NewLoadSceneStop()
            SetPedCoordsKeepVehicle(ped, x, y, z)

            while not HasCollisionLoadedAroundEntity(ped) do
                RequestCollisionAtCoord(x, y, z)
                if GetGameTimer() - curTime > 1000 then
                    break
                end
                Wait(0)
            end

            found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
            if found then
                Wait(0)
                SetPedCoordsKeepVehicle(ped, x, y, groundZ)
                break
            end

            Wait(0)

        end

        DoScreenFadeIn(650)

        if vehicle > 0 then
            FreezeEntityPosition(vehicle, false)
        else
            FreezeEntityPosition(ped, false)
        end

        if not found then
            SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
        end

        SetPedCoordsKeepVehicle(ped, x, y, groundZ)

    end

    return self;

end);