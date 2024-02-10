return function(_script, _args)
    if love.filesystem.getInfo(_script) == nil then
        return 
    end
    local script = love.filesystem.load(_script)
    script(unpack({ _args }))
end