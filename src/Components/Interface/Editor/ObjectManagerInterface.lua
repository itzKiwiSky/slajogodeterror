return function()
    slab.BeginWindow("objectManagerWindow", {Title = "Object Manager", AllowMove = true, AllowResize = false, X = love.graphics.getWidth() - 270, Y = 90})
        slab.BeginListBox("objectManagerListBox", {W = 256, H = 256})
            for o = 1, #levelData.objects, 1 do
                slab.BeginListBoxItem("objectManagerListBoxItem" .. o, {Selected = _selectedObjectIndex == o})
                    if _textureQueue[levelData.objects[o].textureid] then
                        slab.Image("objectManagerImage", {Image = _textureQueue[levelData.objects[o].textureid], W = 32, H = 32})
                    else
                        slab.Image("objectManagerImage", {Image = AssetQueue.images.nothumb, W = 32, H = 32})
                    end
                    slab.SameLine({CenterY = true})
                    slab.Text(levelData.objects[o].name)

                    if slab.IsListBoxItemClicked() then
                        _selectedObjectIndex = o
                    end
                slab.EndListBoxItem()
            end
        slab.EndListBox()
        if slab.Button("+") then
            local object = {
                name = "active" .. #levelData.objects,
                textureid = "square",
                eid = uuid(),
                properties = {
                    position = {_editorPosition[1], _editorPosition[2]},
                    layer = 1,
                    size = {32, 32},
                    origin = {0.5, 0.5},
                    angle = 0,
                    filter = "default",
                    color = {1, 1, 1, 1},
                },
                hitbox = {
                    type = "rect",
                    active = true,
                    properties = {
                        offsetX = 0,
                        offsetY = 0,
                        w = 32,
                        h = 32,
                        angle = 0,
                    }
                },
                meta = {
                    dragging = { 
                        active = false,
                        diffX = 0, 
                        diffY = 0 
                    },
                    selected = false,
                }
            }
            table.insert(levelData.objects, #levelData.objects, object)

            local shape
            if object.hitbox.type == "rect" then
                shape = collider:rectangle(
                    object.properties.position[1] + object.hitbox.properties.offsetX,
                    object.properties.position[2] + object.hitbox.properties.offsetY,
                    object.hitbox.properties.w,
                    object.hitbox.properties.h
                )
            end
    
            shape:moveTo(
                object.properties.position[1] + object.hitbox.properties.offsetX,
                object.properties.position[2] + object.hitbox.properties.offsetY
            )
    
            shape:setRotation(math.rad(object.hitbox.properties.angle))
    
            table.insert(colliders, #colliders, shape)
        end
        slab.SameLine()
        if slab.Button("-") then
            if #levelData.objects > 0 then
                if #colliders > 0 then
                    table.remove(levelData.objects, _selectedObjectIndex)
                    table.remove(colliders, _selectedObjectIndex)
                    _selectedObjectIndex = nil
                end
            end
        end
    slab.EndWindow()
end