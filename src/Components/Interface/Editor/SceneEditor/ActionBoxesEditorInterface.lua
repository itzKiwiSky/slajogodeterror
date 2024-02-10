local uuid = require 'src.Components.UUID'
return function()
    local obj = _sceneActionBoxes[_selectedActionBoxIndex or 1]
    slab.BeginWindow("actionBoxesEditorWindow", {Title = "Action Boxes Editor", AllowMove = true, AllowResize = false, X = love.graphics.getWidth() - 390, Y = 390, H = 480})
        if _selectedActionBoxIndex ~= nil then
            slab.Text("ActionBox Name:")
            slab.SameLine()
            if slab.Input("actionBoxesEditorNameInput", {Text = obj.name}) then
                obj.name = slab.GetInputText()
            end

            slab.Text("Properties")
            slab.Separator()

            slab.Text("Position")
            slab.Text("X:")
            slab.SameLine()
            if slab.Input("actionBoxesEditorPositionXInput", {Text = obj.properties.x, NumbersOnly = true}) then
                obj.properties.x = slab.GetInputNumber()
            end
            slab.SameLine()
            slab.Text("Y:")
            slab.SameLine()
            if slab.Input("actionBoxesEditorPositionYInput", {Text = obj.properties.y, NumbersOnly = true}) then
                obj.properties.y = slab.GetInputNumber()
            end

            slab.Text("Scale")
            slab.Text("W:")
            slab.SameLine()
            if slab.Input("actionBoxesEditorScaleXInput", {Text = obj.properties.w, NumbersOnly = true}) then
                obj.properties.w = slab.GetInputNumber()
            end
            slab.SameLine()
            slab.Text("H:")
            slab.SameLine()
            if slab.Input("actionBoxesEditorScaleYInput", {Text = obj.properties.h, NumbersOnly = true}) then
                obj.properties.h = slab.GetInputNumber()
            end
            slab.Separator()
            if slab.Button("open event manager") then
                _eventManagerWindowVisible = true
            end
        end
    slab.EndWindow()
end