return function()
    slab.BeginWindow("mapPropertiesWindow", {Title = "Map Properties", AllowResize = false})
        slab.Text("Scene Size")
        slab.Text("Width")
        slab.SameLine()
        if slab.Input("mapPropertesWidthInput", {Text = _mapData.scene.properties.size.width, NumbersOnly = true}) then
            _mapData.scene.properties.size.width = slab.GetInputNumber()
        end
        slab.Text("Height")
        slab.SameLine()
        if slab.Input("mapPropertesHeightInput", {Text = _mapData.scene.properties.size.height, NumbersOnly = true}) then
            _mapData.scene.properties.size.height = slab.GetInputNumber()
        end
        slab.Separator()
        slab.Text("Camera Settings")
        slab.Text("Position X")
        slab.SameLine()
        if slab.Input("mapPropertesCamXInput", {Text = _mapData.scene.properties.camera.position[1], NumbersOnly = true}) then
            _mapData.scene.properties.camera.position[1] = slab.GetInputNumber()
        end
        slab.Text("Position Y")
        slab.SameLine()
        if slab.Input("mapPropertesCamYInput", {Text = _mapData.scene.properties.camera.position[2], NumbersOnly = true}) then
            _mapData.scene.properties.camera.position[2] = slab.GetInputNumber()
        end
        slab.Text("Zoom")
        slab.SameLine()
        if slab.Input("mapPropertesCamZoomInput", {Text = _mapData.scene.properties.camera.zoom, NumbersOnly = true}) then
            _mapData.scene.properties.camera.zoom = slab.GetInputNumber()
        end
        slab.Text("Rotation")
        slab.SameLine()
        if slab.Input("mapPropertesCamRotationInput", {Text = _mapData.scene.properties.camera.rotation, NumbersOnly = true}) then
            _mapData.scene.properties.camera.rotation = slab.GetInputNumber()
        end
        slab.Text("Smooth factor")
        slab.SameLine()
        if slab.Input("mapPropertesCamRotationInput", {Text = _mapData.scene.properties.camera.smooth, NumbersOnly = true}) then
            _mapData.scene.properties.camera.smooth = slab.GetInputNumber()
        end
        if slab.CheckBox(_mapData.scene.properties.camera.isStatic, "Is Static") then
            _mapData.scene.properties.camera.isStatic = not _mapData.scene.properties.camera.isStatic
        end
        slab.Text("Set Background Color")
        if slab.Button("...") then
            _mapPropertiesEditorColorPickerVisible = true
        end
        if slab.Button("OK") then
            _mapPropertiesEditorVisible = false
        end
    slab.EndWindow()
    if _mapPropertiesEditorColorPickerVisible then
        local result = slab.ColorPicker({Color = _mapData.scene.properties.backgroundColor})
        _mapData.scene.properties.backgroundColor = result.Color
        if result.Button ~= 0 then
            _mapPropertiesEditorColorPickerVisible = false
        end
    end
end