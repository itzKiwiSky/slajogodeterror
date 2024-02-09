return function()
    slab.BeginWindow("objectManagerWindow", {Title = "Object Manager", AllowMove = true, AllowResize = false, X = love.graphics.getWidth() - 270, Y = 90})
        slab.BeginListBox("objectManagerListBox", {W = 256, H = 256})
            for o = 1, #_sceneObjects, 1 do
                slab.BeginListBoxItem("objectManagerListBoxItem" .. o, {Selected = _selectedObjectIndex == o})
                    if AssetQueue.images[_sceneObjects[o].textureid] then
                        slab.Image("objectManagerImage", {Image = AssetQueue.images[_sceneObjects[o].textureid], W = 32, H = 32})
                    else
                        slab.Image("objectManagerImage", {Image = AssetQueue.images.no_texture, W = 32, H = 32})
                    end
                    slab.SameLine({CenterY = true})
                    slab.Text(_sceneObjects[o].name)

                    if slab.IsListBoxItemClicked() then
                        _selectedObjectIndex = o
                    end
                slab.EndListBoxItem()
            end
        slab.EndListBox()
        if slab.Button("+") then
            local object = {
                name = "object" .. #_sceneObjects,
                textureid = "",
                properties = {
                    position = {_editorPosition[1], _editorPosition[2]},
                    order = 1,
                    scale = {1, 1},
                    origin = {0, 0},
                    angle = 0,
                    color = {1, 1, 1, 1},
                },
                meta = {
                    selected = false,
                }
            }
            table.insert(_sceneObjects, #_sceneObjects + 1, object)
        end
        slab.SameLine()
        if slab.Button("-") then
            if #_sceneObjects > 0 then
                if _selectedObjectIndex ~= nil and #_selectedObjectIndex > 0 then
                    table.remove(_sceneObjects, _selectedObjectIndex)
                    _selectedObjectIndex = nil
                else
                    table.remove(_sceneObjects, #_sceneObjects)
                end
            end
        end
    slab.EndWindow()
end