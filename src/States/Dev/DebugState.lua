debugstate = {}

function debugstate:enter()
    text = [[
[1] - Save achievment
[2] - Reset
    ]]

    bird = devi.newImage("resources/images/testbird.gif", { minDelay = 0.01})
end

function debugstate:draw()
    bird:draw(90, 90, 0, 0.5, 0.5)
end

function debugstate:update()
    
end

return debugstate