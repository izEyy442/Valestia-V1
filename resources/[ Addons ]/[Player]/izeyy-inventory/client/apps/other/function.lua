Inventaire = {} or Inventaire
Inv = {} or Inv

function debugprint(msg)
    if Config.Debug then
        print('[izeyy-inventory] : '..msg)
    end
end


function Inventaire:PlayAnimAdvanced(wait, dict, name, posX, posY, posZ, rotX, rotY, rotZ, blendIn, blendOut, duration, flag, time)
	function_inv:RequestAnimDict(dict, function()
		TaskPlayAnimAdvanced(PlayerPedId(), dict, name, posX, posY, posZ, rotX, rotY, rotZ, blendIn, blendOut, duration, flag, time, 0, 0)
		RemoveAnimDict(dict)
	end)
	if wait > 0 then Wait(wait) end
end

function Inventaire:PlayAnim(wait, dict, name, blendIn, blendOut, duration, flag, rate, lockX, lockY, lockZ)
	function_inv:RequestAnimDict(dict, function()
		TaskPlayAnim(PlayerPedId(), dict, name, blendIn, blendOut, duration, flag, rate, lockX, lockY, lockZ)
		RemoveAnimDict(dict)
	end)
	if wait > 0 then Wait(wait) end
end


function Inventaire:startAnimAction(lib, anim)
	function_inv:RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end

function Inventaire:save()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent(Config.Trigger['saveSkin'], skin)
	end)
end



function Inventaire:CreateCharCam(type,coordsto,pointto, fov)
    local fov = 50.0
    local coords = vector3(0.0,0.0,0.0)
    local point = vector3(0.0,0.0,0.0)
    if type == "face" then
        fov = 10.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),31086,0.0,0.0,0.0)
    elseif type == "root" then
        fov = 15.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),0,0.0,0.0,0.0)
    elseif type == "pants" then
        fov = 20.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),16335,0.0,-0.3,0.0)
    elseif type == "torso" then
        fov = 20.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),0,0.0,0.0,0.2)
    elseif type == "shoes" then
        fov = 10.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,1.0)
        point = GetPedBoneCoords(PlayerPedId(),24806,0.0,0.2,0.0)
    elseif type ~= nil and type:find("ZONE") then
        fov = 60.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),coordsto.x,coordsto.y,coordsto.z)
        point = pointto
    else
        fov = fov or 40.0
        coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,3.0,0.5)
        point = pointto or GetPedBoneCoords(PlayerPedId(),0,0.0,0.0,0.0)
    end
    if CharCamera == nil then
        DestroyAllCams()
        CharCamera = CreateCamera(26379945,1)
        SetCamCoord(CharCamera, coords)
        SetCamFov(CharCamera, fov)
        PointCamAtCoord(CharCamera, point)
        SetCamShakeAmplitude(CharCamera, 13.0)
        RenderScriptCams(1, 1, 1500, 1, 1)
    else

        RageUI.PlaySound("MUGSHOT_CHARACTER_CREATION_SOUNDS","Zoom_In",false)
        SetCamCoord(CharCamera, coords)
        SetCamFov(CharCamera, fov)
        PointCamAtCoord(CharCamera, point)
        RenderScriptCams(1, 1, 1500, 1, 1)
    end
end

function Inventaire:DestroyCharCam()
    SetCamActive(CharCamera, false)
    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(CharCamera)
    CharCamera = nil
end



local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function GetObjects()
	local objects = {}

	for object in EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

function GetClosestObject(filter, coords)
	local objects = GetObjects()
	local closestDistance, closestObject = -1, -1

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		coords = GetEntityCoords(PlayerPedId(), false)
	end

	for i = 1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j = 1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					foundObject = true
					break
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i], false)
			local distance = #(objectCoords - coords)

			if closestDistance == -1 or closestDistance > distance then
				closestObject = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end