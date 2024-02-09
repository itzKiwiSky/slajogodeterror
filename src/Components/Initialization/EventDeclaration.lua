return function()
    eventmanager.registerEvent("setCamFocus", function(_x, _y)
        viewport.locked = true or true
        camTarget.x = _x or 0
        camTarget.y = _y or 0
    end)

    eventmanager.registerEvent("setStatic", function(_enable, _x, _y)
        viewport.locked = _enable or true
        camTarget.x = _x or 0
        camTarget.y = _y or 0
    end)

    eventmanager.registerEvent("startSceneDialogue", function(_filename)
        if love.filesystem.getInfo(_filename) == nil then
            return 
        end
        selectionstate.fileToRun = _filename
        gamestate.switch(selectionstate)
    end)

    eventmanager.registerEvent("callScript", function(_script, _args)
        if love.filesystem.getInfo(_script) == nil then
            return 
        end
        local script = love.filesystem.load(_script)
        script(unpack(_args))
    end)

    eventmanager.registerEvent("setScene", function(_filename)
        if _filename == nil then
            return 
        end
        if love.filesystem.getInfo(_filename) == nil then
            return 
        end

        playstate.sceneFile = _filename
        playstate:enter()
    end)
end