return function()
    slab.BeginWindow("actionBoxesManagerWindow", {Title = "Object Manager", AllowMove = true, AllowResize = false, X = love.graphics.getWidth() - 270, Y = 90})
        slab.BeginListBox("actionBoxesManagerListBox", {W = 256, H = 256})
            for o = 1, #_sceneActionBoxes, 1 do
                slab.BeginListBoxItem("actionBoxesManagerListBoxItem" .. o, {Selected = _selectedActionBoxIndex == o})
                    if AssetQueue.images[_sceneActionBoxes[o].textureid] then
                        slab.Image("actionBoxesManagerImage", {Image = AssetQueue.images[_sceneActionBoxes[o].textureid], W = 32, H = 32})
                    else
                        slab.Image("actionBoxesManagerImage", {Image = AssetQueue.images.no_texture, W = 32, H = 32})
                    end
                    slab.SameLine({CenterY = true})
                    slab.Text(_sceneActionBoxes[o].name)

                    if slab.IsListBoxItemClicked() then
                        _selectedActionBoxIndex = o
                    end
                slab.EndListBoxItem()
            end
        slab.EndListBox()
        if slab.Button("+") then
            local actionbox = {
                name = "actionBox" .. #_sceneActionBoxes,
                properties = {
                    x = _editorPosition[1], 
                    y = _editorPosition[2],
                    w = 32,
                    h = 32,
                    hitted = false
                },
                onAction = {},
                onHit = {},
            }
            table.insert(_sceneActionBoxes, #_sceneActionBoxes + 1, actionbox)
        end
        slab.SameLine()
        if slab.Button("-") then
            if #_sceneActionBoxes > 0 then
                if _selectedActionBoxIndex ~= nil and _selectedActionBoxIndex > 0 then
                    table.remove(_sceneActionBoxes, _selectedActionBoxIndex)
                    _selectedActionBoxIndex = nil
                else
                    table.remove(_sceneActionBoxes, #_sceneActionBoxes)
                end
            end
        end
    slab.EndWindow()
end