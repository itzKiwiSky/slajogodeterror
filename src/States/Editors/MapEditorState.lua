mapeditorstate = {}

mapeditorstate.fileToEdit = ""
function mapeditorstate:enter()
    -- helpers --
    grid = require 'src.Components.Snippets.Editors.SceneEditor.Grid'
    createSceneFile = require 'src.Components.Snippets.Editors.SceneEditor.CreateSceneFile'

    -- interfaces --
    menubar = require 'src.Components.Interface.Editor.MenuBar'
    loadMapPopup = require 'src.Components.Interface.Editor.OpenScene'
    createMapPopup = require 'src.Components.Interface.Editor.CreateScene'

    _selectedFileId = nil
    -- scene metadata --
    _sceneFilename = ""
    _sceneSizes = {
        _width = 1280,
        _height = 768,
    }

    _popupCreateMapVisible = false
    _popupLoadMapVisible = false
    _popupScenePropertiesEditor = false
    _confirmPopupVisible = false
    _confirmedExit = false
    _isMapLoaded = false
    _colorSelectorOpen = false

    _mapData = {}

    editorViewport = camera()
    _editorPosition = {editorViewport.x, editorViewport.y}
    _editorSpeed = 5

    _sceneObjects = {}
    _sceneActionBoxes = {}

    _allowGrid = true
    _zoom = 1

    slab.Initialize({"NoDocks"})
end

function mapeditorstate:draw()
    love.graphics.setColor(1, 1, 1, 1)
    slab.Draw()
    love.graphics.setColor(1, 1, 1, 1)

    if _isMapLoaded then
        love.graphics.setBackgroundColor(_mapData.scene.properties.backgroundColor)

        grid()

        editorViewport:attach()
            love.graphics.rectangle("line", 0, 0, _mapData.scene.properties.size.width, _mapData.scene.properties.size.height)
        editorViewport:detach()

        love.graphics.line(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 - 16, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 16)
        love.graphics.line(love.graphics.getWidth() / 2 - 16, love.graphics.getHeight() / 2, love.graphics.getWidth() / 2 + 16, love.graphics.getHeight() / 2)
    end
end

function mapeditorstate:update(elapsed)
    slab.Update(elapsed)

    -- interface update --
    if _popupCreateMapVisible then
        createMapPopup()
    end
    if _popupLoadMapVisible then
        loadMapPopup()
    end
    if _confirmPopupVisible then
        local result = slab.MessageBox("Confirm exit", "Before you exit, please check if you save the file.", {Buttons = {"Yes", "No"}})
        if result == "Yes" then
            love.event.quit()
        elseif result == "No" then
            _confirmPopupVisible = false
        end
    end 
    menubar()

    -- actual logic shit --
    if _isMapLoaded then
        if _zoom < 0.5 then
            _zoom = 0.5
        end
        if _zoom > 2 then
            _zoom = 2
        end
    
        if love.keyboard.isDown("lctrl") then
            _editorSpeed = 10
        else
            _editorSpeed = 5
        end
    
        if love.keyboard.isDown("d") then
            _editorPosition[1] = _editorPosition[1] + _editorSpeed
        end
        if love.keyboard.isDown("a") then
            _editorPosition[1] = _editorPosition[1] - _editorSpeed
        end
        if love.keyboard.isDown("w") then
            _editorPosition[2] = _editorPosition[2] - _editorSpeed
        end
        if love.keyboard.isDown("s") then
            _editorPosition[2] = _editorPosition[2] + _editorSpeed
        end
    
        editorViewport:zoomTo(_zoom)
        editorViewport:lookAt(_editorPosition[1], _editorPosition[2])
    end
end

function mapeditorstate:wheelmoved(x, y)
    if y < 0 then
        _zoom = _zoom - 0.1
    end
    if y > 0 then
        _zoom = _zoom + 0.1
    end
end

return mapeditorstate