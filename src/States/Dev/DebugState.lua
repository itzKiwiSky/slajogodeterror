debugstate = {}

function debugstate:enter()
    controls = require 'src.Components.Controls'
    player = require 'src.Components.Objects.Player'
    audiosource = require 'src.Components.Objects.AudioSource'

    audio = audiosource("test", 256, 480, 128, 1)
    audio:loop(true)
    audio:play()

    audio2 = audiosource("audio", 780, 480, 128, 0.5)
    audio2:loop(true)
    audio2:play()

    player:init(90, 480)
end

function debugstate:draw()
    player:draw()
    audio:draw()
    audio2:draw()
end 

function debugstate:update(elapsed)
    player:update(elapsed)
    audio:update(elapsed)
    audio2:update(elapsed)
end

function debugstate:keypressed(k)
    if k == "f3" then
        error("sex")
    end
end

return debugstate