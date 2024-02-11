return function()
    slab.BeginWindow("actionBoxesEventSelectorWindow", {Title = "Event Selector", W = 256, H = 256, X = love.graphics.getWidth() - 250, Y = 180})
        for e = 1, #eventmanager.eventNames, 1 do
            if slab.TextSelectable(eventmanager.eventNames[e]) then
                local event = {
                    id = eventmanager.eventNames[e],
                    args = {},
                    metaArgs = {}
                }

                for p = 1, debug.getinfo(eventmanager.events[eventmanager.eventNames[e]]).nparams, 1 do
                    event.metaArgs[p] = tostring(debug.getlocal(eventmanager.events[eventmanager.eventNames[e]], p))
                end

                if _eventType == "onAction" then
                    table.insert(_sceneActionBoxes[_selectedActionBoxIndex].onAction, #_sceneActionBoxes[_selectedActionBoxIndex].onAction + 1, event)
                elseif _eventType == "onHit" then
                    table.insert(_sceneActionBoxes[_selectedActionBoxIndex].onHit, #_sceneActionBoxes[_selectedActionBoxIndex].onHit + 1, event)
                end

                _eventSelectionPopupVisible = false
            end
        end
        slab.Separator()
        if slab.Button("Cancel") then
            _eventSelectionPopupVisible = false
        end
    slab.EndWindow()
end