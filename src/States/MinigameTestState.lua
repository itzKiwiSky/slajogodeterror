minigamestate = {}

function minigamestate:enter()
    cup = require 'src.Components.Objects.MinigameState.Cup'
    shaderchain  = require 'src.Components.ChainShader'

    chromatic = love.graphics.newShader("resources/shaders/chromatic.glsl")
    chromatic:send("aberration", 0)
    shaderchain.clearAppended()
    shaderchain.resize(1280, 720)
    shaderchain.append(chromatic)

    cups = {}
    cuptypes = {
        "wine_cup",
        "tequila_cup",
        "vodka_cup",
        "whiky_cup",
        "beer_cup",
    }
    beers = {
        "vinho",
        "tequila",
        "vodka",
        "whisky",
        "cerveja"
    }
    id = math.random(1, 5)
    cupGenTimer = timer.new()
    cupGenTimer:every(5, function()
        local shitCup = cup.new(0, 256)
        shitCup.id = cuptypes[math.random(1, 5)]
        shitCup.speed = shitCup.speed + 30
        print("buceta")
        table.insert(cups, shitCup)
    end)

    sob = 0

    target = {
        x = love.graphics.getWidth() / 2 - (32 * 5) / 2,
        y = 340,
        w = (32 * 5),
        h = (32 * 5)
    }
end

function minigamestate:draw()
    shaderchain.start()
    love.graphics.setColor(0.7, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 340, love.graphics.getWidth(), 256)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setColor(0.5, 0, 0, 1)
    love.graphics.rectangle("fill", 0, 512, love.graphics.getWidth(), 512)
    love.graphics.setColor(1, 1, 1, 1)
    for _, cup in ipairs(cups) do
        cup:draw()
    end

    love.graphics.rectangle("line", target.x, target.y, target.w, target.h)

    love.graphics.draw(AssetQueue.images.shit_hand, 350, 400, 0, 8, 8, AssetQueue.images.shit_hand:getWidth() / 2, AssetQueue.images.shit_hand:getHeight() / 2)
    love.graphics.draw(AssetQueue.images.shit_hand, 950, 400, 0, -8, 8, AssetQueue.images.shit_hand:getWidth() / 2, AssetQueue.images.shit_hand:getHeight() / 2)

    love.graphics.print(beers[id], 90, 90)
    shaderchain.stop()
end

function minigamestate:update(elapsed)
    cupGenTimer:update(elapsed)
    for _, cup in ipairs(cups) do
        cup:update(elapsed)
        if cup.x > love.graphics.getWidth() + AssetQueue.images[cup.id]:getWidth() * 5 then
            table.remove(cups, _)
        end
    end
    chromatic:send("aberration", sob)
end

function minigamestate:keypressed(k)
    if k == "space" then
        for _, cup in ipairs(cups) do
            if collision.rectRect(target, cup.hitbox) then
                if cup.id == cuptypes[id] then
                    sob = sob + 0.1
                else
                    sob = sob + 0.3
                end
                table.remove(cups, _)
            end
        end
    end
end

return minigamestate