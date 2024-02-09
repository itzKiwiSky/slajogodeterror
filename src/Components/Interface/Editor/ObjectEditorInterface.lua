return function()
    local obj = _sceneObjects[_selectedObjectIndex or 1]
    slab.BeginWindow("objectEditorWindow", {Title = "Object Manager", AllowMove = true, AllowResize = false, X = love.graphics.getWidth() - 390, Y = 390})
        if _selectedObjectIndex ~= nil then
            slab.Text("Object Name:")
            slab.SameLine()
            if slab.Input("objectEditorNameInput", {Text = obj.name}) then
                obj.name = slab.GetInputText()
            end

            slab.Text("Texture")
            slab.SameLine()
            if slab.Input("objectEditorTextureInput", {Text = obj.textureid}) then
                obj.textureid = slab.GetInputText()
            end

            slab.Text("Properties")
            slab.Separator()

            slab.Text("Position")
            slab.Text("X:")
            slab.SameLine()
            if slab.Input("objectEditorPositionXInput", {Text = obj.properties.position[1], NumbersOnly = true}) then
                obj.properties.position[1] = slab.GetInputNumber()
            end
            slab.SameLine()
            slab.Text("Y:")
            slab.SameLine()
            if slab.Input("objectEditorPositionYInput", {Text = obj.properties.position[2], NumbersOnly = true}) then
                obj.properties.position[2] = slab.GetInputNumber()
            end

            slab.Text("Order ID:")
            slab.SameLine()
            if slab.Input("objectEditorPositionZInput", {Text = obj.properties.order, NumbersOnly = true}) then
                obj.properties.order = slab.GetInputNumber()
            end

            slab.Text("Rotation:")
            slab.SameLine()
            if slab.Input("objectEditorRotationInput", {Text = obj.properties.angle, NumbersOnly = true}) then
                obj.properties.angle = slab.GetInputNumber()
            end

            slab.Text("Scale")
            slab.Text("X:")
            slab.SameLine()
            if slab.Input("objectEditorScaleXInput", {Text = obj.properties.scale[1], NumbersOnly = true}) then
                obj.properties.scale[1] = slab.GetInputNumber()
            end
            slab.SameLine()
            slab.Text("Y:")
            slab.SameLine()
            if slab.Input("objectEditorScaleYInput", {Text = obj.properties.scale[2], NumbersOnly = true}) then
                obj.properties.scale[2] = slab.GetInputNumber()
            end

            slab.Text("Origin")
            slab.Text("X:")
            slab.SameLine()
            if slab.Input("objectEditorOriginXInput", {Text = obj.properties.origin[1], NumbersOnly = true}) then
                obj.properties.origin[1] = slab.GetInputNumber()
            end
            slab.SameLine()
            slab.Text("Y:")
            slab.SameLine()
            if slab.Input("objectEditorOriginYInput", {Text = obj.properties.origin[2], NumbersOnly = true}) then
                obj.properties.origin[2] = slab.GetInputNumber()
            end
            if slab.Button("Center Origin") then
                if AssetQueue.images[obj.textureid] then
                    obj.properties.origin[1] = AssetQueue.images[obj.textureid]:getWidth() / 2
                    obj.properties.origin[2] = AssetQueue.images[obj.textureid]:getHeight() / 2
                else
                    obj.properties.origin[1] = AssetQueue.images.no_texture:getWidth() / 2
                    obj.properties.origin[2] = AssetQueue.images.no_texture:getHeight() / 2
                end
            end
            slab.Rectangle({Mode = "fill", W = 16, H = 16, Color = obj.properties.color, Rounding = 5})
            slab.SameLine()
            if slab.Button("pick color") then
                _colorSelectorOpen = true
            end
        end
    slab.EndWindow()
    if _selectedObjectIndex ~= 0 and _selectedObjectIndex ~= nil then
        if _colorSelectorOpen then
            local result = slab.ColorPicker({Color = obj.properties.color})
            obj.properties.color = result.Color
            if result.Button ~= 0 then
                _colorSelectorOpen = false
            end
        end
    end
end