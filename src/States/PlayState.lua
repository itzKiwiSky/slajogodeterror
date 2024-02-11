playstate = {}

playstate.sceneFile = "Scene1"

function playstate:genStage()
    sceneObjects = {}
    sceneActionBoxes = {}
    scenedata = json.decode(love.filesystem.read("resources/data/scenes/" .. playstate.sceneFile .. ".scene"))
    -- do object handling -- 
    sceneObjects = scenedata.scene.objects
    -- do action boxes handling --
    sceneActionBoxes = scenedata.scene.actionBoxes
end

function playstate:enter()
    -- import components --
    controls = require 'src.Components.Controls'
    player = require 'src.Components.Objects.Player'
    _cameraClamp = require 'src.Components.Snippets.PlayState.CameraClamp'

    -- object holder --
    sceneObjects = {}
    sceneActionBoxes = {}

    playstate:genStage()

    -- camera config based on the  file specifications --
    camTarget.x, camTarget.y = scenedata.scene.properties.camera.position[1], scenedata.scene.properties.camera.position[2]
    viewport:zoomTo(scenedata.scene.properties.camera.zoom)


    -- some variables --
    _isLockedToPlayer = true

    -- player config --
    player:init(scenedata.scene.properties.player.position[1], scenedata.scene.properties.player.position[2])
end

function playstate:draw()
    viewport:attach()
    -- do scene object draw --
    for _, obj in ipairs(sceneObjects) do
        if AssetQueue.images[obj.textureid] then
            love.graphics.draw(
                AssetQueue.images[obj.textureid], 
                obj.properties.position[1], 
                obj.properties.position[2], 
                math.rad(obj.properties.rotation), 
                obj.properties.scale[1], 
                obj.properties.scale[2], 
                obj.properties.origin[1], 
                obj.properties.origin[2]
            )
        end
    end

    for _, ht in ipairs(sceneActionBoxes) do
        love.graphics.rectangle("line", ht.properties.x, ht.properties.y, ht.properties.w, ht.properties.h)
        love.graphics.print(tostring(ht.properties.hitted), ht.properties.x, ht.properties.y - 10)
    end

    player:draw()
    love.graphics.rectangle("line", 0, 0, scenedata.scene.properties.size.width, scenedata.scene.properties.size.height)
    viewport:detach()
end

function playstate:update(elapsed)
    player:update(elapsed)
    
    if not scenedata.scene.properties.camera.isStatic then
        scrollingCam.properties.scrollX = scrollingCam.properties.scrollX - (scrollingCam.properties.scrollX - camTarget.x) * scenedata.scene.properties.camera.smooth
        scrollingCam.properties.scrollY = scrollingCam.properties.scrollY - (scrollingCam.properties.scrollY - camTarget.y) * scenedata.scene.properties.camera.smooth
        scrollingCam.x = scrollingCam.properties.scrollX
        scrollingCam.y = scrollingCam.properties.scrollY

        if not viewport.locked then
            camTarget.x, camTarget.y = player.x, player.y
        end

        viewport:lookAt(scrollingCam.x, scrollingCam.y)
    end

    -- clamp camera on the scene size --
    _cameraClamp()
    
    -- player event handling -- 
    for _, ht in ipairs(sceneActionBoxes) do
        if collision.rectRect(player.hitbox, ht.properties) and not ht.properties.hitted then
            if #ht.onHit > 1 then
                for e = 1, #ht.onHit, 1 do
                    eventmanager.triggerEvent(ht.onHit[e].id, unpack(ht.onHit[e].args))
                end
                ht.properties.hitted = true
            end
        end

        if not collision.rectRect(player.hitbox, ht.properties) and ht.properties.hitted then
            ht.properties.hitted = false
        end
    end
end

return playstate