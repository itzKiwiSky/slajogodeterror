local eventmanager = {}

eventmanager.events = {}
eventmanager.eventNames = {}

function eventmanager.registerEvent(_eventName, _func)
    eventmanager.events[_eventName] = _func
    eventmanager.eventNames[#eventmanager.eventNames + 1] = _eventName
end

function eventmanager.update(elapsed)
    
end

function eventmanager.triggerEvent(_eventName, _args)
    eventmanager.events[_eventName].eventfunc(unpack({_args}))
end

function eventmanager.triggerScript(_scriptName, _func, _args)
    
end

return eventmanager