function_inv = {}


function function_inv:RequestAnimDict(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(100)
		end
	end

	if cb then
		cb()
	end
end