return function()
    slab.BeginWindow("eventManagerWindow", {Title = "Event Manager"})
        slab.Text("Events")
        slab.SameLine()
        if slab.Button("onAction Event") then
            _eventType = "onAction"
        end
        slab.SameLine()
        if slab.Button("onHit Event") then
            _eventType = "onHit"
        end
        slab.Separator({Thickness = 5})
        if _eventType == "onAction" then
            for e = 1, #_sceneActionBoxes[_selectedActionBoxIndex].onAction, 1 do
                if _sceneActionBoxes[_selectedActionBoxIndex].onAction[e] then

                    slab.Text(_sceneActionBoxes[_selectedActionBoxIndex].onAction[e].id)
                    for a = 1, #_sceneActionBoxes[_selectedActionBoxIndex].onAction[e].metaArgs, 1 do
                        if _sceneActionBoxes[_selectedActionBoxIndex].onAction[e].metaArgs then
                            local params = _sceneActionBoxes[_selectedActionBoxIndex].onAction[e].metaArgs[a]:gsub("_", "")
                            slab.Text(tostring(params))
                            slab.SameLine()
                            local inputID = "eventArgumentInput_".. _sceneActionBoxes[_selectedActionBoxIndex].onAction[e].id .. e .. a
                            if slab.Input(inputID, {Text = _sceneActionBoxes[_selectedActionBoxIndex].onAction[e].args[a] or ""}) then
                                _sceneActionBoxes[_selectedActionBoxIndex].onAction[e].args[a] = slab.GetInputText()
                            end
                        end
                    end
                    if slab.Button("remove") then
                        table.remove(_sceneActionBoxes[_selectedActionBoxIndex].onAction, e)
                    end
                end
            end
        elseif _eventType == "onHit" then
            for e = 1, #_sceneActionBoxes[_selectedActionBoxIndex].onHit, 1 do
                if _sceneActionBoxes[_selectedActionBoxIndex].onHit[e] then
                    slab.Text(_sceneActionBoxes[_selectedActionBoxIndex].onHit[e].id)
                    for a = 1, #_sceneActionBoxes[_selectedActionBoxIndex].onHit[e].metaArgs, 1 do
                        if _sceneActionBoxes[_selectedActionBoxIndex].onHit[e].metaArgs then
                            local params = _sceneActionBoxes[_selectedActionBoxIndex].onHit[e].metaArgs[a]:gsub("_", "")
                            slab.Text(tostring(params))
                            slab.SameLine()
                            local inputID = "eventArgumentInput_".. _sceneActionBoxes[_selectedActionBoxIndex].onHit[e].id .. e .. a
                            if slab.Input(inputID, {Text = _sceneActionBoxes[_selectedActionBoxIndex].onHit[e].args[a] or ""}) then
                                _sceneActionBoxes[_selectedActionBoxIndex].onHit[e].args[a] = slab.GetInputText()
                            end
                        end
                    end
                    if slab.Button("remove") then
                        table.remove(_sceneActionBoxes[_selectedActionBoxIndex].onHit, e)
                    end
                end
            end
        end
        slab.Separator({Thickness = 5})
        if slab.Button("add Event") then
            _eventSelectionPopupVisible = true
        end
    slab.EndWindow()
end