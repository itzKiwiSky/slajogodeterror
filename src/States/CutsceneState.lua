cutscenestate = {}

cutscenestate.fileToLoad = "Cutscene"

function cutscenestate:enter()
    -- load scene --
    scenedata = json.decode(love.filesystem.read("resources/data/cutscenes/" .. cutscenestate.fileToLoad .. ".scene"))
    print(debug.getTableContent(love.filesystem.getDirectoryItems("resources/data/strings/en")))
    -- require file dialog -- 
    scenestrings = json.decode(love.filesystem.read("resources/data/strings/" .. lollipop.currentSave.game.settings.misc.language .. "/" .. scenedata.scene.useFile))
    print(debug.getTableContent(scenestrings))
    -- vars initialization --
    _sceneSection = 1
    _sceneSelectionTimer = 0
    _sceneDialogTimer = 0
    _sceneSectionStageDialog = 1
    _fadeTimer = 0
    _selectionActive = false

    -- starting shit --
    _sceneSelectionTimer = scenedata.scene.sections[_sceneSection].sectionConfig.selection.selectionTimer


    for e = 1, #scenedata.scene.onStart, 1 do
        eventmanager.triggerEvent(scenedata.scene.onStart[e].id, unpack(scenedata.scene.onStart[e].args))
    end
end

function cutscenestate:draw()
    love.graphics.draw(AssetQueue.images[scenedata.scene.sections[_sceneSection].sectionConfig.displayTexture], 0, 0)
end

function cutscenestate:update(elapsed)
    _sceneDialogTimer = _sceneDialogTimer + elapsed
    if _sceneDialogTimer > scenestrings.sections[_sceneSection].dialogues[_sceneSectionStageDialog].delay then
        _sceneDialogTimer = 0
        _sceneSectionStageDialog = _sceneSectionStageDialog + 1

        if _sceneSectionStageDialog > #scenestrings.sections[_sceneSection].dialogues[_sceneSectionStageDialog] then
            _sceneSection = _sceneSection + 1
            _sceneSectionStageDialog = 1
        end
    end
    if _sceneSection > #scenedata.scene.sections[_sceneSection] then
        _sceneSection = 1
    end
end

return cutscenestate