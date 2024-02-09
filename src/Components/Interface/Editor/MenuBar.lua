return function()
    if slab.BeginMainMenuBar() then
        if slab.BeginMenu("File") then
            if slab.MenuItem("New Scene") then
                _popupCreateMapVisible = true
            end
            if slab.MenuItem("Load Scene") then
                _popupLoadMapVisible = true
            end
            if slab.MenuItem("Save") then
                if _isMapLoaded then
                    _mapData.scene.objects = _sceneObjects
                    _mapData.scene.actionBoxes = _sceneActionBoxes
                    love.filesystem.write(mapeditorstate.fileToEdit, json.encode(_mapData))
                end
            end
            slab.Separator()
            if slab.MenuItem("Quit") then
                _confirmPopupVisible = true
            end
            slab.EndMenu()
        end
        if slab.BeginMenu("Edit") then
            if slab.MenuItem("Open scenes folder") then
                love.system.openURL("file://" .. love.filesystem.getSaveDirectory() .. "/dev/scenes")
            end
            slab.EndMenu()
        end
        if slab.BeginMenu("View") then
            if slab.MenuItem("Toggle grid") then
                _allowGrid = not _allowGrid
            end
            slab.EndMenu()
        end
        slab.EndMainMenuBar()
    end
end