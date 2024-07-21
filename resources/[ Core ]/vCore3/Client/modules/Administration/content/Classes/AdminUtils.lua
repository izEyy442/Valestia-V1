---
--- @author Kadir#6666
--- Create at [26/04/2023] 20:26:41
--- Current project [Valestia-V1]
--- File name [AdminUtils]
---


---@overload fun(): AdminUtils
AdminUtils = Class.new(function(class)

    ---@class AdminUtils: BaseObject
    local self = class;

    function self:Constructor()

        self.items = {}

        self.INPUT_LOOK_LR = 1
        self.INPUT_LOOK_UD = 2
        self.INPUT_COVER = 44
        self.INPUT_MULTIPLAYER_INFO = 20
        self.INPUT_MOVE_UD = 31
        self.INPUT_MOVE_LR = 30
        self._internal_camera = nil
        self._internal_isFrozen = false
        self._internal_pos = nil
        self._internal_rot = nil
        self._internal_fov = nil
        self._internal_vecX = nil
        self._internal_vecY = nil
        self._internal_vecZ = nil
        self.settings = {
            --Camera
            fov = 45.0,
            -- Mouse
            mouseSensitivityX = 5,
            mouseSensitivityY = 5,
            -- Movement
            normalMoveMultiplier = 1,
            fastMoveMultiplier = 10,
            slowMoveMultiplier = 0.1,
            -- On enable/disable
            enableEasing = false,
            easingDuration = 1000
        }
        self.controls = {12, 13, 14, 15, 16, 17, 18, 19, 50, 85, 96, 97, 99, 115, 180, 181, 198, 261, 262}

        self.blips = {}
        self.tags = {}

    end

    function self:GetItems()

        return self.items

    end

    function self:SetItems(list)

        if (list == nil or type(list) ~= "table") then
            return
        end

        self.items = list;

    end

    function self:SetNoClipAttributes(ped, status)
        if status then
            FreezeEntityPosition(ped, true)
            SetEntityCollision(ped, false, false)
        else
            FreezeEntityPosition(ped, false)
            SetEntityCollision(ped, true, true)
        end
    end

    function self:IsFreecamFrozen()
        return self._internal_isFrozen;
    end

    function self:SetFreecamFrozen(frozen)
        self._internal_isFrozen = frozen == true
    end

    function self:GetFreecamPosition()
        return self._internal_pos
    end

    function self:SetFreecamPosition(x, y, z)
        local pos = vector3(x, y, z)
        SetCamCoord(self._internal_camera, pos)

        self._internal_pos = pos
    end

    function self:GetFreecamRotation()
        return self._internal_rot
    end

    function self:SetFreecamRotation(x, y, z)
        local x = self:Clamp(x, -90.0, 90.0)
        local y = y % 360
        local z = z % 360
        local rot = vector3(x, y, z)
        local vecX, vecY, vecZ = self:EulerToMatrix(x, y, z)

        LockMinimapAngle(math.floor(z))
        SetCamRot(self._internal_camera, rot)

        self._internal_rot = rot
        self._internal_vecX = vecX
        self._internal_vecY = vecY
        self._internal_vecZ = vecZ
    end

    function self:GetFreecamFov()
        return self._internal_fov
    end

    function self:SetFreecamFov(fov)
        local fov = self:Clamp(fov or 45.0, 0.0, 90.0)
        SetCamFov(self._internal_camera, fov)
        self._internal_fov = fov
    end

    function self:GetFreecamMatrix()
        return self._internal_vecX, self._internal_vecY, self._internal_vecZ, self._internal_pos
    end

    function self:GetFreecamTarget(distance)
        local target = self._internal_pos + (self._internal_vecY * distance)
        return target
    end

    function self:IsFreecamEnabled()
        return IsCamActive(self._internal_camera) == 1
    end

    function self:LockControls()
        for _, v in pairs(self.controls) do
            DisableControlAction(0, v, true)
        end
        EnableControlAction(0, 166, true)
    end

    function self:SetFreecamEnabled(enable)

        if (enable == self:IsFreecamEnabled()) then
            return
        end

        if (enable) then
            local pos = GetGameplayCamCoord();
            local rot = GetGameplayCamRot();

            self._internal_camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true);

            self:SetFreecamFov(self.settings.fov or 45.0)
            self:SetFreecamPosition(pos.x, pos.y, pos.z)
            self:SetFreecamRotation(rot.x or 0, rot.y, rot.z)
        else

            DestroyCam(self._internal_camera);
            ClearFocus();
            UnlockMinimapPosition();
            UnlockMinimapAngle();

        end

        --SetPlayerControl(PlayerId(), not enable)
        RenderScriptCams(enable, self.settings.enableEasing, self.settings.easingDuration);

    end

    function self:IsCamEnabled()
        return self:IsFreecamEnabled()
    end

    function self:SetCamEnabled(enable)
        return self:SetFreecamEnabled(enable)
    end

    function self:IsCamFrozen()
        return self:IsFreecamFrozen()
    end

    function self:SetCamFrozen(frozen)
        return self:SetFreecamFrozen(frozen)
    end

    function self:GetCamFov()
        return self:GetFreecamFov()
    end

    function self:SetCamFov(fov)
        return self:SetFreecamFov(fov)
    end

    function self:GetCamTarget(distance)
        return {table.unpack(self:GetFreecamTarget(distance))}
    end

    function self:GetCamPosition()
        return {table.unpack(self:GetFreecamPosition())}
    end

    function self:SetCamPosition(x, y, z)
        return self:SetFreecamPosition(x, y, z)
    end

    function self:GetCamRotation()
        return {table.unpack(self:GetFreecamRotation())}
    end

    function self:SetCamRotation(x, y, z)
        return self:SetFreecamRotation(x, y, z)
    end

    function self:GetCamPitch()
        return self:GetFreecamRotation().x
    end

    function self:GetCamRoll()
        return self:GetFreecamRotation().y
    end

    function self:GetCamYaw()
        return self:GetFreecamRotation().z
    end

    function self:GetSpeedMultiplier()
        if IsDisabledControlPressed(0, 180) then
            if self.settings.normalMoveMultiplier > 1.0 then
                self.settings.normalMoveMultiplier = self.settings.normalMoveMultiplier - 0.5
            elseif self.settings.normalMoveMultiplier > 0.2 then
                self.settings.normalMoveMultiplier = self.settings.normalMoveMultiplier - 0.1
            else
                self.settings.normalMoveMultiplier = self.settings.normalMoveMultiplier - 0.01
            end
        elseif IsDisabledControlPressed(0, 181) then
            if self.settings.normalMoveMultiplier < 0.2 then
                self.settings.normalMoveMultiplier = self.settings.normalMoveMultiplier + 0.01
            elseif self.settings.normalMoveMultiplier > 1.0 then
                self.settings.normalMoveMultiplier = self.settings.normalMoveMultiplier + 0.5
            else
                self.settings.normalMoveMultiplier = self.settings.normalMoveMultiplier + 0.1
            end
        end

        if self.settings.normalMoveMultiplier < 0 then
            self.settings.normalMoveMultiplier = 0
        end

        return self.settings.normalMoveMultiplier
    end

    function self:CameraLoop()
        if IsPauseMenuActive() then
            return
        end
        if not self:IsFreecamFrozen() then
            local ped = PlayerPedId();
            local vecX, vecY = self:GetFreecamMatrix()
            local vecZ = vector3(0, 0, 1)
            local pos = self:GetFreecamPosition()
            local rot = self:GetFreecamRotation()
            -- Get speed multiplier for movement
            local frameMultiplier = GetFrameTime() * 60
            local speedMultiplier = self:GetSpeedMultiplier() * frameMultiplier
            -- Get mouse input
            local mouseX = GetDisabledControlNormal(0, self.INPUT_LOOK_LR)
            local mouseY = GetDisabledControlNormal(0, self.INPUT_LOOK_UD)
            -- Get keyboard input
            local moveWS = GetDisabledControlNormal(0, self.INPUT_MOVE_UD)
            local moveAD = GetDisabledControlNormal(0, self.INPUT_MOVE_LR)
            local moveQZ = self:GetDisabledControlNormalBetween(0, self.INPUT_COVER, self.INPUT_MULTIPLAYER_INFO)
            -- Calculate new rotation.
            local rotX = rot.x + (-mouseY * self.settings.mouseSensitivityY)
            local rotZ = rot.z + (-mouseX * self.settings.mouseSensitivityX)
            local rotY = 0.0
            -- Adjust position relative to camera rotation.
            pos = pos + (vecX * moveAD * speedMultiplier)
            pos = pos + (vecY * -moveWS * speedMultiplier)
            pos = pos + (vecZ * moveQZ * speedMultiplier)

            if #(pos - GetEntityCoords(ped)) > 20.0 then
                pos = GetEntityCoords(ped)
            end

            -- Adjust new rotation
            rot = vector3(rotX, rotY, rotZ)
            -- Update camera
            self:SetFreecamPosition(pos.x, pos.y, pos.z)
            self:SetFreecamRotation(rot.x, rot.y, rot.z)

            self:LockControls()
            SetEntityCoordsNoOffset(ped, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0)
        end
    end

    function self:Clamp(x, min, max)
        return math.min(math.max(x, min), max)
    end

    function self:GetDisabledControlNormalBetween(inputGroup, control1, control2)
        local normal1 = GetDisabledControlNormal(inputGroup, control1)
        local normal2 = GetDisabledControlNormal(inputGroup, control2)
        return normal1 - normal2
    end

    function self:EulerToMatrix(rotX, rotY, rotZ)
        local radX = math.rad(rotX)
        local radY = math.rad(rotY)
        local radZ = math.rad(rotZ)

        local sinX = math.sin(radX)
        local sinY = math.sin(radY)
        local sinZ = math.sin(radZ)
        local cosX = math.cos(radX)
        local cosY = math.cos(radY)
        local cosZ = math.cos(radZ)

        local vecX = {}
        local vecY = {}
        local vecZ = {}

        vecX.x = cosY * cosZ
        vecX.y = cosY * sinZ
        vecX.z = -sinY

        vecY.x = cosZ * sinX * sinY - cosX * sinZ
        vecY.y = cosX * cosZ - sinX * sinY * sinZ
        vecY.z = cosY * sinX

        vecZ.x = -cosX * cosZ * sinY + sinX * sinZ
        vecZ.y = -cosZ * sinX + cosX * sinY * sinZ
        vecZ.z = cosX * cosY

        vecX = vector3(vecX.x, vecX.y, vecX.z)
        vecY = vector3(vecY.x, vecY.y, vecY.z)
        vecZ = vector3(vecZ.x, vecZ.y, vecZ.z)

        return vecX, vecY, vecZ
    end

    function self:GetBlips()
        return (type(self.blips) == "table" and self.blips or {})
    end

    function self:GetBlipFromPlayer(player_id)

        if (type(player_id) ~= "number") then
            return
        end

        return (type(self.blips) == "table" and self.blips[player_id] or false)

    end

    function self:AddBlipForPlayer(player_id)

        if (type(player_id) ~= "number") then
            return
        end

        local blip_exist = self:GetBlipFromPlayer(player_id)

        if (blip_exist ~= nil) then
            self:RemoveBlipForPlayer(player_id)
        end

        local player_data = Client.PlayersManager:GetFromId(player_id)
        local player_selected = GetPlayerFromServerId(player_id)
        local player_ped = ((player_selected ~= -1 and GetPlayerPed(player_selected)) or false)
        local player_coords = ((player_ped ~= false and GetEntityCoords(GetPlayerPed(player_selected))) or player_data["coords"])

        if (type(player_data) == "table" and type(player_coords) == "vector3") then

            self.blips[player_id] = true;

            local blip_on_create = ((player_ped ~= false and AddBlipForEntity(player_ped)) or AddBlipForCoord(player_coords.x, player_coords.y, player_coords.z))

            SetBlipCategory(blip_on_create, 7)
            SetBlipScale(blip_on_create,  0.85)
            ShowHeadingIndicatorOnBlip(blip_on_create, true)
            SetBlipSprite(blip_on_create, 1)
            SetBlipColour(blip_on_create, (player_selected ~= -1 and 0) or 7)

            if (player_ped ~= false) then

                local blipSprite = GetBlipSprite(blip_on_create)
                local player_selected_vehicle = GetVehiclePedIsIn(player_ped, false)

                if IsEntityDead(player_ped) then

                    if blipSprite ~= 303 then

                        SetBlipSprite( blip_on_create, 303)
                        SetBlipColour(blip_on_create, 1)
                        ShowHeadingIndicatorOnBlip( blip_on_create, false)

                    end

                elseif player_selected_vehicle ~= nil then

                    if IsPedInAnyBoat(player_ped) then

                        if blipSprite ~= 427 then

                            SetBlipSprite(blip_on_create, 427)
                            SetBlipColour(blip_on_create, 0)
                            ShowHeadingIndicatorOnBlip(blip_on_create, false)

                        end

                    elseif IsPedInAnyHeli(player_ped) then

                        if blipSprite ~= 43 then

                            SetBlipSprite(blip_on_create, 43)
                            SetBlipColour(blip_on_create, 0)
                            ShowHeadingIndicatorOnBlip(blip_on_create, false)

                        end

                    elseif IsPedInAnyPlane(player_ped) then

                        if blipSprite ~= 423 then

                            SetBlipSprite(blip_on_create, 423)
                            SetBlipColour(blip_on_create, 0)
                            ShowHeadingIndicatorOnBlip(blip_on_create, false)

                        end

                    elseif IsPedInAnyPoliceVehicle(player_ped) then

                        if blipSprite ~= 137 then

                            SetBlipSprite(blip_on_create, 137)
                            SetBlipColour(blip_on_create, 0)
                            ShowHeadingIndicatorOnBlip(blip_on_create, false)

                        end

                    elseif IsPedInAnySub(player_ped) then

                        if blipSprite ~= 308 then

                            SetBlipSprite(blip_on_create, 308)
                            SetBlipColour(blip_on_create, 0)
                            ShowHeadingIndicatorOnBlip(blip_on_create, false)

                        end

                    elseif IsPedInAnyVehicle(player_ped) then

                        if blipSprite ~= 225 then

                            SetBlipSprite(blip_on_create, 225)
                            SetBlipColour(blip_on_create, 0)
                            ShowHeadingIndicatorOnBlip(blip_on_create, false)

                        end

                    else

                        if blipSprite ~= 1 then

                            SetBlipSprite(blip_on_create, 1)
                            SetBlipColour(blip_on_create, 0)
                            ShowHeadingIndicatorOnBlip( blip_on_create, true)

                        end

                    end

                else

                    if blipSprite ~= 1 then

                        SetBlipSprite(blip_on_create, 1)
                        SetBlipColour(blip_on_create, 0)
                        ShowHeadingIndicatorOnBlip(blip_on_create, true)

                    end

                end

                if player_selected_vehicle then

                    SetBlipRotation(blip_on_create, math.ceil(GetEntityHeading(player_selected_vehicle)))

                else

                    SetBlipRotation(blip_on_create, math.ceil(GetEntityHeading(player_ped)))

                end

            end

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(("(%s) - %s"):format(player_id, player_data.name))
            EndTextCommandSetBlipName(blip_on_create)

            self.blips[player_id] = blip_on_create;

        end

    end

    function self:RemoveBlipForPlayer(player_id)

        if (type(player_id) ~= "number") then
            return
        end

        local blip_exist = self:GetBlipFromPlayer(player_id)

        if (not blip_exist or not DoesBlipExist(blip_exist)) then
            return
        end

        RemoveBlip(blip_exist);
        self.blips[player_id] = nil;

    end

    function self:GetTags()
        return (type(self.tags) == "table" and self.tags or {})
    end

    function self:GetTagFromPlayer(player_id)

        if (type(player_id) ~= "number") then
            return
        end

        return (type(self.tags) == "table" and self.tags[player_id] or false)

    end

    function self:AddTagForPlayer(player_id)

        if (type(player_id) ~= "number") then
            return
        end

        local client_player_coords = Client.Player:GetCoords()
        local player_data = Client.PlayersManager:GetFromId(player_id)
        local player_selected = GetPlayerFromServerId(player_id)
        local player_ped = ((player_selected ~= -1 and GetPlayerPed(player_selected)) or false)
        local player_coords = ((player_ped ~= false and GetEntityCoords(GetPlayerPed(player_selected))) or player_data["coords"])

        if ((type(player_data) == "table" and type(player_coords) == "vector3") and (#(player_coords-client_player_coords) < 10000.0)) then

            self.tags[player_id] = true;

            local tag_on_create = CreateFakeMpGamerTag(player_ped, ('[%s] %s | %s'):format(player_id, player_data.name, player_data.identity), false, false, '', 0)

            SetMpGamerTagAlpha(tag_on_create, 0, 255)
            SetMpGamerTagAlpha(tag_on_create, 2, 255)
            SetMpGamerTagAlpha(tag_on_create, 4, 255)
            SetMpGamerTagAlpha(tag_on_create, 7, 255)

            SetMpGamerTagVisibility(tag_on_create, 0, true)
            SetMpGamerTagVisibility(tag_on_create, 2, true)
            SetMpGamerTagVisibility(tag_on_create, 4, NetworkIsPlayerTalking(player_selected))
            SetMpGamerTagVisibility(tag_on_create, 5, (GetEntityHealth(player_ped) > GetEntityMaxHealth(player_ped) or GetPlayerInvincible(player_selected) or GetPlayerInvincible_2(player_selected)))
            SetMpGamerTagVisibility(tag_on_create, 7, player_data.group ~= "user")
            SetMpGamerTagVisibility(tag_on_create, 14, Client.Admin:StaffGetValue(player_id, "state") == true)

            SetMpGamerTagColour(tag_on_create, 5, 0)
            SetMpGamerTagColour(tag_on_create, 7, 49)
            SetMpGamerTagColour(tag_on_create, 14, 49)

            if NetworkIsPlayerTalking(player_selected) then

                SetMpGamerTagHealthBarColour(tag_on_create, 49)
                SetMpGamerTagColour(tag_on_create, 0, 49)

            else

                SetMpGamerTagHealthBarColour(tag_on_create, 0)
                SetMpGamerTagColour(tag_on_create, 0, 0)

            end

            self.tags[player_id] = tag_on_create;

        elseif ((type(player_data) == "table" and type(player_coords) == "vector3") and (#(player_coords-client_player_coords) > 10000.0) and self:GetTagFromPlayer(player_id)) then

            self:RemoveTagForPlayer(player_id)

        end

    end

    function self:RemoveTagForPlayer(player_id)

        if (type(player_id) ~= "number") then
            return
        end

        local tag_exist = self:GetTagFromPlayer(player_id)

        if (not tag_exist) then
            return
        end

        RemoveMpGamerTag(tag_exist);
        self.tags[player_id] = nil;

    end

    return self;

end);