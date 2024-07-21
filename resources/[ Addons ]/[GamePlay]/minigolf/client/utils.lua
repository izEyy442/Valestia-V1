-- Author : Morow
-- Github : https://github.com/Morow73

-- list of materials https://pastebin.com/PBE6wQSG

Utils = {}
Utils.materials = {-840216541, -1693813558, -754997699, -1469616465, 1926285543, -1369136684}
Utils.__index = Utils

local cam = nil

function Utils:getEntityCoords(entity)
    return GetEntityCoords(entity)
end

function Utils:setEntityCoords(entity, new_coords)
    SetEntityCoords(entity, new_coords, false, false, false, false)
end

function Utils:getEntityHeading(entity)
    return GetEntityHeading(entity)
end

function Utils:setEntityHeading(entity, new_heading)
    SetEntityHeading(entity, new_heading)
end

function Utils:freezeEntity(entity, toggle)
    FreezeEntityPosition(entity, toggle)
end

function Utils:placePed(h)
    SetEntityHeading(c.ball.object, h+360.0)
    AttachEntityToEntity(c.ped(), c.ball.object, 20, 0.14, -0.62, 0.99, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
    DetachEntity(c.ped(), true, true)
    SetEntityHeading(c.ball.object, 0.0)
end

function Utils:createCamera()
    cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
    RenderScriptCams(true,  false,  0,  true,  true)
    SetCamFov(cam, 90.0)
    AttachCamToEntity(cam, c.ball.object, -0.2, 0.0, 1.0099, false)
end

function Utils:deleteCamera()
    if cam then
        DestroyCam(cam, true)
        RenderScriptCams(false,  false,  0,  true,  true)
        cam = nil
    end
end

function Utils:playAnimation(dict, anim, coords, duration, loop)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Wait(1)
    end

    if HasAnimDictLoaded(dict) then
        local x, y, z = false, false, false

        if coords then
            x = coords.x
            y = coords.y
            z = coords.z
        end

        TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, duration or -1, loop or 0, 0, x, y, z)
    end
end

function Utils:playSoundFromEntity(sound)
    PlaySoundFromEntity(-1, sound, PlayerPedId(), 0, 0, 0)
end

function Utils:groundMaterial()
    local ballCoords = self:getEntityCoords(c.ball.object)
    local shape = StartShapeTestCapsule(ballCoords.x, ballCoords.y, ballCoords.z + 4, ballCoords.x, ballCoords.y, ballCoords.z - 0.03, 2, -1, c.ball.object, 7)
    local result, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResultIncludingMaterial(shape)

    if materialHash == 0 then
        materialHash = GetLastMaterialHitByEntity(c.ball.object)
    end

    for i = 1, #self.materials, 1 do
        local material = self.materials[i]
        --print(material, materialHash)
        if material == materialHash or materialHash == 0 then
            return true
        end
    end

    return false
end

function Utils:deg(x, y)
    local heading = math.atan2(x, y)

    if heading < 0 then
        heading = math.deg(math.abs(heading))
    else
        heading = math.deg(2 * math.pi - heading)
    end

    heading = heading + 90.0

    return heading
end

function Utils:rotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function Utils:rayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = self:rotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return c
end