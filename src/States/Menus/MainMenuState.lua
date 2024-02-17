mainmenustate = {}

function mainmenustate:enter()
    settingsPopupInterface = require 'src.Components.Interface.Menus.SettingsMenuInterface'

    interface = suit.new()

    slab.Initialize({"NoDocks"})

    tab = "graphics"
    settingsVisible = false
end

function mainmenustate:draw()
    love.graphics.setColor(1, 1, 1, 1)
    interface:draw()
    slab.Draw()
    love.graphics.setColor(1, 1, 1, 1)
end

function mainmenustate:update(elapsed)
    slab.Update(elapsed)

    if interface:Button("New game", { id = "newGameButton" }, 90, (love.graphics.getHeight() - 360) - 80, 128, 32).hit then
        
    end
    if interface:Button("Continue", { id = "continueButton" }, 90, (love.graphics.getHeight() - 360) - 40, 128, 32).hit then
        
    end
    if interface:Button("Settings", { id = "settingsButton" }, 90, (love.graphics.getHeight() - 360), 128, 32).hit then
        settingsVisible = true
    end

    if settingsVisible then
        settingsPopupInterface()
    end
end

return mainmenustate