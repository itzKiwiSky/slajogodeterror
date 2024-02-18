local chapterselectionsubstate = {}

local function _roundedImage()
    for r = 1, 4, 1 do
        local chapterListBoxW = love.graphics.getWidth() - 256
        local fraction = chapterListBoxW / 4
        local chapterBoxW = fraction - 10
        local chapterBoxX = 128 + r * fraction - fraction / 2 - chapterBoxW / 2
        love.graphics.rectangle("fill", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)
    end
end

local function _clickzone(_x, _y, _w, _h)
    return {
        x = _x,
        y = _y,
        w = _w,
        h = _h
    }
end

function chapterselectionsubstate:enter()
    clickzones = {}

    for c = 1, 4, 1 do
        local chapterListBoxW = love.graphics.getWidth() - 256
        local fraction = chapterListBoxW / 4
        local chapterBoxW = fraction - 10
        local chapterBoxX = 128 + c * fraction - fraction / 2 - chapterBoxW / 2
        table.insert(clickzones, _clickzone(chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 246))
    end
end

function chapterselectionsubstate:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 128, 128, love.graphics.getWidth() - 256, love.graphics.getHeight() - 246, 10)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 128, 128, love.graphics.getWidth() - 256, love.graphics.getHeight() - 246, 10)
    love.graphics.printf("Chapter Selection", 128, 100, love.graphics.getWidth() - 256, "center")

    for c = 1, 4, 1 do
        local chapterListBoxW = love.graphics.getWidth() - 256
        local fraction = chapterListBoxW / 4
        local chapterBoxW = fraction - 10
        local chapterBoxX = 128 + c * fraction - fraction / 2 - chapterBoxW / 2
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)

        love.graphics.stencil(_roundedImage, "replace", 1)
        love.graphics.setStencilTest("equal", 1) 
        love.graphics.draw(AssetQueue.images.chapter_image, chapterBoxX, 136)
        love.graphics.setStencilTest() 

        if lollipop.currentSave.game.chapters[c].isLocked then
            love.graphics.setColor(0, 0, 0, 0.8)
            love.graphics.rectangle("fill", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end

function chapterselectionsubstate:update(elapsed)
    for c = 1, #clickzones, 1 do
        if x >= clickzones[c].x and x <= clickzones[c].x + clickzones[c].w and y >= clickzones[c].y and y <= clickzones[c].y + clickzones[c].h then
            if not lollipop.currentSave.game.chapters[c].isLocked then
                print(c)
            end
        end
    end
end

function chapterselectionsubstate:mousepressed(x, y, button)
    for c = 1, #clickzones, 1 do
        if x >= clickzones[c].x and x <= clickzones[c].x + clickzones[c].w and y >= clickzones[c].y and y <= clickzones[c].y + clickzones[c].h then
            if not lollipop.currentSave.game.chapters[c].isLocked then
                print(c)
            end
        end
    end
end

return chapterselectionsubstate