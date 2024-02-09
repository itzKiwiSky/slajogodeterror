return function()
    slab.BeginWindow("openFileWindow", {Title = "open Scene", AllowResize = false})
        slab.BeginListBox("openFileListBox", {W = 256, H = 480})
            local files = love.filesystem.getDirectoryItems("dev/scenes")
            for f = 1, #files, 1 do
                slab.BeginListBoxItem("openFileListBoxItem" .. f, {Selected = _selectedFileId == f})
                    if love.filesystem.getInfo("dev/scenes/" .. files[f]).type == "directory" then
                        return
                    else
                        slab.Image("openFileListBoxItemImage", {Image = AssetQueue.images.scenefile_icon, W = 16, H = 16})
                        slab.SameLine()
                        slab.Text(files[f])
                    end

                    if slab.IsListBoxItemClicked() then
                        _selectedFileId = f
                    end
                slab.EndListBoxItem()
            end
        slab.EndListBox()
        if slab.Button("Cancel") then
            _selectedFileId = nil
            _popupLoadMapVisible = false
        end
        slab.SameLine()
        if slab.Button("Load") then
            if _selectedFileId ~= nil then
                mapeditorstate.fileToEdit = "dev/scenes/" .. files[_selectedFileId]
                _mapData = json.decode(love.filesystem.read(mapeditorstate.fileToEdit))
                _sceneObjects = _mapData.scene.objects
                _sceneActionBoxes = _mapData.scene.actionBoxes
                _isMapLoaded = true
                _popupLoadMapVisible = false
            end
        end
    slab.EndWindow()
end