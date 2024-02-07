return function()
    if viewport.x < love.graphics.getWidth() / 2 then
        viewport.x = love.graphics.getWidth() / 2
    end
    if viewport.y < love.graphics.getHeight() / 2 then
        viewport.y = love.graphics.getHeight() / 2
    end
    if viewport.x > scenedata.scene.properties.size.width - love.graphics.getWidth() / 2 then
        viewport.x = scenedata.scene.properties.size.width - love.graphics.getWidth() / 2
    end
    if viewport.y > scenedata.scene.properties.size.height - love.graphics.getHeight() / 2 then
        viewport.y = scenedata.scene.properties.size.height - love.graphics.getHeight() / 2
    end
end