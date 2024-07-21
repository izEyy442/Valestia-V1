ViceClientUtils = {}

ViceClientUtils.toServer = function(eventName, ...)
    TriggerServerEvent("Valestia:" .. Valestia.hash(eventName), ...)
end