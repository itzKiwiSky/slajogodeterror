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
        slab.EndMainMenuBar()
    end
end