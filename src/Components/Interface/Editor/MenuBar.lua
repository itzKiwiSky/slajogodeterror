return function()
    if slab.BeginMainMenuBar() then
        if slab.BeginMenu("File") then
            if slab.MenuItem("New Scene") then
                _popupCreateMapVisible = true
            end
            if slab.MenuItem("New Scene") then
                _popupLoadMapVisible = true
            end
            if slab.MenuItem("Save") then
                if _isMapLoaded then
                    
                end
            end
            slab.Separator()
            if slab.MenuItem("Quit") then
                _confirmPopupVisible = true
                if _confirmPopupVisible then
                    
                end
            end
            slab.EndMenu()
        end
        slab.EndMainMenuBar()
    end
end