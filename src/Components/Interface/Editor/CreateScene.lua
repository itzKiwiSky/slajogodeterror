return function()
    slab.BeginWindow("createFileWindow", {Title = "open Scene", AllowResize = false})
        slab.Text("Scene filename:")
        slab.SameLine()
        if slab.Input("createFileFilenameInput", {Text = _sceneFilename}) then
            _sceneFilename = slab.GetInputText()
        end

        slab.Text("Scene Width:")
        slab.SameLine()
        if slab.Input("createFileWidthInput", {Text = _sceneSizes._width}) then
            _sceneSizes._width = slab.GetInputNumber()
        end
        slab.SameLine()
        slab.Text("Scene Height:")
        slab.SameLine()
        if slab.Input("createFileHeightInput", {Text = _sceneSizes._height}) then
            _sceneSizes._height = slab.GetInputNumber()
        end
        if slab.Button("Cancel") then
            _sceneFilename = ""
            _sceneSizes._width = 1280
            _sceneSizes._height = 768
            _popupCreateMapVisible = false
        end
        slab.SameLine()
        if slab.Button("Create") then
            createSceneFile(_sceneFilename, _sceneSizes._width, _sceneSizes._height)
            mapeditorstate.fileToEdit = "dev/scenes/" .. _sceneFilename .. ".scene"
            _mapData = json.decode(love.filesystem.read("dev/scenes/" .. _sceneFilename .. ".scene"))
            _sceneObjects = _mapData.objects
            _sceneActionBoxes = _mapData.actionBoxes
            _isMapLoaded = true
            _popupCreateMapVisible = false
        end
    slab.EndWindow()
end