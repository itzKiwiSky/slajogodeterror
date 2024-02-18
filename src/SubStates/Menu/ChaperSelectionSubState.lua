local chapterselectionsubstate = {}

local function _roundedImage()
    for r = 1, 4, 1 do
        love.graphics.rectangle("fill", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)
    end
end

function chapterselectionsubstate:enter()
    interfacechapter = suit.new()

    interfacechapter.theme = setmetatable({}, {__index = suit.theme})

    interfacechapter.theme.color = {
        normal = {bg = {0, 0, 0, 0}, fg = {0, 0, 0, 0}},
        hovered = {bg = {0, 0, 0, 0}, fg = {0, 0, 0, 0}},
        active = {bg = {0, 0, 0, 00}, fg = {0, 0, 0, 0}}
    }
end

function chapterselectionsubstate:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 128, 128, love.graphics.getWidth() - 256, love.graphics.getHeight() - 246, 10)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle("line", 128, 128, love.graphics.getWidth() - 256, love.graphics.getHeight() - 246, 10)
    love.graphics.printf("Chapter Selection", 128, 100, love.graphics.getWidth() - 256, "center")

    interfacechapter:draw()

    for c = 1, 4, 1 do
        local chapterListBoxW = love.graphics.getWidth() - 256
        local fraction = chapterListBoxW / 4
        chapterBoxW = fraction - 10
        chapterBoxX = 128 + c * fraction - fraction / 2 - chapterBoxW / 2
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle("fill", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle("line", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)

        love.graphics.stencil(_roundedImage, "replace", 1)
        love.graphics.setStencilTest("equal", 1) 
        love.graphics.draw(AssetQueue.images.chapter_image, chapterBoxX, 136)
        love.graphics.setStencilTest() 

        love.graphics.setColor(0, 0, 0, 0.8)
        love.graphics.rectangle("fill", chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256, 10)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function chapterselectionsubstate:update(elapsed)
    for c = 1, 4, 1 do
        local chapterListBoxW = love.graphics.getWidth() - 256
        local fraction = chapterListBoxW / 4
        local chapterBoxW = fraction - 10
        local chapterBoxX = 128 + c * fraction - fraction / 2 - chapterBoxW / 2

        if interfacechapter:Button("", { id = "chapterButton" .. c }, chapterBoxX, 136, chapterBoxW, love.graphics.getHeight() - 256).hit then
            print(c)
        end
    end
end

return chapterselectionsubstate