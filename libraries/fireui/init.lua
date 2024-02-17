local fireui = {}
fireui.base = ...
fireui.elements = {}
fireui.registers = {
    debug = false,
}
fireui.theme = require(fireui.base .. ".Theme")
json = require(fireui.base .. ".ThirdParty.json")
require(fireui.base .. ".Components.LoveQuads")

local text = [[
Drawcalls : %s
TextureMemory : %s
Images : %s
]]

function fireui.initialize()
    --assert(type(_args) == "string", "[ERROR] : Invalid argument type, expected 'string' got " .. type(_args))

    local widgets = love.filesystem.getDirectoryItems(fireui.base:gsub("%.", "/") .. "/Widgets")
    for w = 1, #widgets, 1 do
        fireui[string.lower(string.gsub(widgets[w], ".lua", ""))] = require(fireui.base .. ".Widgets." .. string.gsub(widgets[w], ".lua", ""))
    end
end

function fireui.draw()
    for e = 1, #fireui.elements, 1 do
        if fireui.elements[e].draw then
            fireui.elements[e]:draw()
        end

        if fireui.registers.debug then
            if fireui.elements[e].hitbox then
                love.graphics.rectangle("line", fireui.elements[e].hitbox.x, fireui.elements[e].hitbox.y, fireui.elements[e].hitbox.w, fireui.elements[e].hitbox.h)
            end
        end
    end
    love.graphics.print(string.format(text, love.graphics.getStats().drawcalls, love.graphics.getStats().texturememory, love.graphics.getStats().images))
end

function fireui.update(elapsed)
    for e = 1, #fireui.elements, 1 do
        if fireui.elements[e].update then
            fireui.elements[e]:update(elapsed)
        end
    end
end

function fireui.mousepressed(x, y, button)
    for e = 1, #fireui.elements, 1 do
        if fireui.elements[e].mousepressed then
            fireui.elements[e]:mousepressed(x, y, button)
        end
    end
end

function fireui.getElementByID(_id)
    for e = 1, #fireui.elements, 1 do
        if fireui.elements[e].id == _id then
            return fireui.elements[e].id
        end
    end
end

return fireui