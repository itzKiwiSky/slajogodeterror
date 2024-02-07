return function()
    eventmanager.registerEvent("setCamFocus", function(_x, _y)
        viewport.locked = true
        camTarget.x = _x
        camTarget.y = _y
    end)

    eventmanager.registerEvent("setStatic", function(_enable, _x, _y)
        viewport.locked = true
        camTarget.x = _x
        camTarget.y = _y
    end)

    eventmanager.registerEvent("startSceneDialogue", function(_filename)
        selectionstate.fileToRun = _filename
        gamestate.switch(selectionstate)
    end)

    eventmanager.registerEvent("callScript", function(_script, _args)
        local script = love.filesystem.load(_script)
        script(unpack(_args))
    end)
end