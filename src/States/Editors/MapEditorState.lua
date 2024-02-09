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
    objectManager = require 'src.Components.Interface.Editor.ObjectManagerInterface'
    objectEditor = require 'src.Components.Interface.Editor.ObjectEditorInterface'
    actionBoxesManager = require 'src.Components.Interface.Editor.ActionBoxesManagerInterface'

    _selectedFileId = nil
    -- scene metadata --
    _sceneFilename = ""
    _sceneSizes = {
        _width = 1280,
        _height = 768,
    }

    -- interface manager variables --
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

    _selectedObjectIndex = nil
    _selectedActionBoxIndex = nil

    _editorMode = 0
    _allowGrid = true
    _zoom = 1
    _allowMouseAction = true
    _allowToMove = false

    slab.Initialize({"NoDocks"})
end

function mapeditorstate:draw()
    if _isMapLoaded then
        love.graphics.setBackgroundColor(_mapData.scene.properties.backgroundColor)

        editorViewport:attach()

            for _, obj in ipairs(_sceneObjects) do
                love.graphics.setColor(obj.properties.color)
                deep.queue(obj.properties.order, function()
                    if AssetQueue.images[obj.textureid] then
                        love.graphics.draw(
                            AssetQueue.images[obj.textureid],
                            obj.properties.position[1],
                            obj.properties.position[2],
                            obj.properties.rotation,
                            obj.properties.scale[1],
                            obj.properties.scale[2],
                            obj.properties.origin[1],
                            obj.properties.origin[2]
                        )
                    else
                        love.graphics.draw(
                            AssetQueue.images.no_texture,
                            obj.properties.position[1],
                            obj.properties.position[2],
                            obj.properties.rotation,
                            obj.properties.scale[1],
                            obj.properties.scale[2],
                            obj.properties.origin[1],
                            obj.properties.origin[2]
                        )
                    end
                end)
            end
            
            deep.execute()

            for _, box in ipairs(_sceneActionBoxes) do
                love.graphics.rectangle("line", box.properties.x, box.properties.y, box.properties.w, box.properties.h)
            end

            love.graphics.rectangle("line", 0, 0, _mapData.scene.properties.size.width, _mapData.scene.properties.size.height)
        editorViewport:detach()

        if _allowGrid then
            grid()
        end

        love.graphics.line(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 - 16, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 16)
        love.graphics.line(love.graphics.getWidth() / 2 - 16, love.graphics.getHeight() / 2, love.graphics.getWidth() / 2 + 16, love.graphics.getHeight() / 2)
    end

    love.graphics.setColor(1, 1, 1, 1)
    slab.Draw()
    love.graphics.setColor(1, 1, 1, 1)
end

function mapeditorstate:update(elapsed)
    slab.Update(elapsed)

    _allowMouseAction = slab.IsVoidHovered()

    -- interface update --
    if _popupCreateMapVisible then
        createMapPopup()
    end
    if _popupLoadMapVisible then
        loadMapPopup()
    end
    if _confirmPopupVisible then
        local result = slab.MessageBox("Confirm exit", "Are you sure you want exit? Before you exit, please check if you save the file.", {Buttons = {"Yes", "No"}})
        if result == "Yes" then
            love.event.quit()
        elseif result == "No" then
            _confirmPopupVisible = false
        end
    end 

    if _isMapLoaded then
        if _editorMode == 0 then
            objectManager()
            objectEditor()
        elseif _editorMode == 1 then
            actionBoxesManager()
        end
    end

    if _editorMode > 1 then
        _editorMode = 0
    end

    menubar()

    -- actual logic shit --
    if _isMapLoaded then
        if _zoom < 0.1 then
            _zoom = 0.1
        end
        if _zoom > 2 then
            _zoom = 2
        end
    
        if love.keyboard.isDown("lctrl") then
            _editorSpeed = 20
        else
            _editorSpeed = 10
        end

        _allowToMove = love.mouse.isDown(2)
    
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

function mapeditorstate:keypressed(k)
    if k == "tab" then
        _editorMode = _editorMode + 1
    end
end

function mapeditorstate:wheelmoved(x, y)
    if _allowMouseAction then
        if y < 0 then
            _zoom = _zoom - 0.1
        end
        if y > 0 then
            _zoom = _zoom + 0.1
        end
    end
end

return mapeditorstate