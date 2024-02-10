local function _recursiveLoader(_path, _tbl)
    local items = love.filesystem.getDirectoryItems(_path)
    for item = 1, #items, 1 do
        local path = _path .. "/" .. items[item]
        if love.filesystem.getInfo(path).type == "directory" then
            _recursiveLoader(path, _tbl)
        end
        if love.filesystem.getInfo(path).type == "file" then
            table.insert(_tbl, {
                name = items[item]:gsub(".lua", ""),
                func = require(path:gsub(".lua", ""))
            })
        end
    end
end

return function()
    local eventFuncs = {}
    _recursiveLoader("src/Components/Initialization/Events", eventFuncs)
    for e = 1, #eventFuncs, 1 do
        print("Loaded event: " .. eventFuncs[e].name)
        eventmanager.registerEvent(eventFuncs[e].name, eventFuncs[e].func)
    end
end