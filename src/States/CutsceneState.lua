cutscenestate = {}

cutscenestate.fileToLoad = "Cutscene"

local function seconds(str)
    local time = string.tokenize(str, ":")
    return time[1] * 60 + time[2] + time[3] * 0.1
end


function cutscenestate:enter()
    subtitles = require 'src.Components.Subtitles'
    cinematicDisplay = require 'src.Components.CinematicDisplay'

    love.graphics.setBackgroundColor(0.3, 0.3, 0.3)

    -- load scene --
    scenedata = json.decode(love.filesystem.read("resources/data/cutscenes/" .. cutscenestate.fileToLoad .. ".scene"))

    -- load dialogue file --
    scenestring = json.decode(love.filesystem.read("resources/data/strings/" .. lollipop.currentSave.game.settings.misc.language .. "/" .. scenedata.scene.useFile))

    cinematicDisplay.clear()
    cinematicDisplay.queue(scenedata.scene.section)

    subtitles.clear()
    subtitles.queue(scenestring.dialogues)
end

function cutscenestate:draw()
    --love.graphics.draw(AssetQueue.images[scenedata.scene.sections[_sceneSection].sectionConfig.displayTexture], 0, 0)
    cinematicDisplay:draw()
    subtitles:draw()
end

function cutscenestate:update(elapsed)
    cinematicDisplay:update(elapsed)
    subtitles:update(elapsed)
end

return cutscenestate