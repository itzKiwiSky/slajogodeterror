local preloader = {}

local function _findAssets(_type, _path)
    local items = love.filesystem.getDirectoryItems(_path)
    for item = 1, #items, 1 do
        local path = _path .. "/" .. items[item]
        if love.filesystem.getInfo(path).type == "directory" then
            _findAssets(_type, path)
        end
        if love.filesystem.getInfo(path).type == "file" then
            if _type == "images" then
                if string.match(path, "[^.]+$") == "png" then
                    table.insert(preloader.assetsPath, path)
                end
            elseif _type == "sounds" then
                if string.match(path, "[^.]+$") == "ogg" then
                    table.insert(preloader.assetsPath, path)
                end
            elseif _type == "fonts" then
                if string.match(path, "[^.]+$") == "ttf" then
                    table.insert(preloader.assetsPath, path)
                end
            end
        end
    end
end

local function _doLoad(_type, _index)
    if _type == "images" then
        if string.find(preloader.assetsPath[_index], "_sheet") then
            local sheetimage, sheetquads =  love.graphics.getQuads(preloader.assetsPath[_index]:gsub(".[^.]+$", ""))
            AssetQueue.images[(preloader.assetsPath[_index]:match("[^/]+$")):gsub(".png", "")] = {image = sheetimage, quads = sheetquads}
        else
            AssetQueue.images[(preloader.assetsPath[_index]:match("[^/]+$")):gsub(".png", "")] = love.graphics.newImage(preloader.assetsPath[_index])
        end
    elseif _type == "sounds" then
        AssetQueue.sounds[(preloader.assetsPath[_index]:match("[^/]+$")):gsub(".ogg", "")] = love.audio.newSource(preloader.assetsPath[_index], "static")
    elseif _type == "fonts" then
        AssetQueue.fonts[(preloader.assetsPath[_index]:match("[^/]+$")):gsub(".ttf", "")] = love.graphics.newFont(preloader.assetsPath[_index], registers.system.fontSize)
    end
    preloader.assetProgress = preloader.assetProgress + 1
end

function preloader.init(_typesrc, _pathsrc)
    preloader.assetProgress = 0
    preloader.assetsPath = {}
    _findAssets(_typesrc, _pathsrc)
end

function preloader.present(_type)
    for a = 1, #preloader.assetsPath, 1 do
        love.graphics.clear(0, 0, 0)
    
        birdImage:draw(love.graphics.getWidth() - 100, 680, 0, 0.3, 0.3, birdImage:getWidth() / 2, birdImage:getHeight() / 2)
        --love.graphics.draw(loveimage, love.graphics.getWidth() - loveimage:getWidth() * 0.1 - (plus:getWidth() * 1.5) * 2, love.graphics.getHeight() - loveimage:getHeight() * 0.1, 0, 0.1, 0.1)
        --love.graphics.draw(plus, love.graphics.getWidth() - plus:getWidth() * 1.5 - (lmxsdk:getWidth() * 1.5), love.graphics.getHeight() - plus:getHeight() * 1.5, 0, 1.5)
        --love.graphics.draw(lmxsdk, love.graphics.getWidth() - (lmxsdk:getWidth() * 1.5), love.graphics.getHeight() - lmxsdk:getHeight() * 1.5, 0, 1.5, 1.5)
        love.graphics.present()
        
        _doLoad(_type, a)
    end
end

function preloader.clear()
    for _, v in pairs(AssetQueue.images) do
        AssetQueue.images[_]:release()
    end

    for _, v in pairs(AssetQueue.sounds) do
        AssetQueue.sounds[_]:release()
    end

    for _, v in pairs(AssetQueue.fonts) do
        AssetQueue.fonts[_]:release()
    end


    lume.clear(AssetQueue.images)
    lume.clear(AssetQueue.sounds)
    lume.clear(AssetQueue.fonts)

    collectgarbage("collect")
end

return preloader