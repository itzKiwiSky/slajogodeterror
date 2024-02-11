return function(_filename)
    if _filename == nil then
        return 
    end
    if love.filesystem.getInfo(_filename) == nil then
        return 
    end

    playstate.sceneFile = _filename
    playstate:genStage()
end