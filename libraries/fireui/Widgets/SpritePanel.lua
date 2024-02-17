local spritepanel = {}
spritepanel.__index = spritepanel

local function new(_filename, _options)
    _options = _options or {}
    _filename = _filename or fireui.base:gsub("%.", "/") .. "/Resources/ui_pieces"
    print(_filename)
    assert(type(_filename) == "string", "[ERROR] : Invalid argument type, expected 'string' got " .. type(_filename))
    assert(type(_options) == "table", "[ERROR] : Invalid argument type, expected 'table' got " .. type(_options))

    local self = setmetatable({}, spritepanel)

    self.image, self.quads = love.graphics.getQuads(_filename)
    self.x = _options.x or 0
    self.y = _options.y or 0
    self.w = _options.w or 64
    self.h = _options.h or 64
    self.id = _options.id or ""
    self.draw = _options.draw or function()
        local top, bottom, left, right = self.y, self.y + self.h, self.x, self.x + self.w
        local qx, qy, qw, qh = self.quads[1]:getViewport()

        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.draw(self.image, self.quads[1], left, top)
        love.graphics.draw(self.image, self.quads[3], right, top)
        love.graphics.draw(self.image, self.quads[7], left, bottom)
        love.graphics.draw(self.image, self.quads[9], right, bottom)

        love.graphics.draw(self.image, self.quads[2], left + 32, top, 0, (self.w / qw) - 1, 1)
        love.graphics.draw(self.image, self.quads[8], left + 32, bottom, 0, (self.w / qw) - 1, 1)

        love.graphics.draw(self.image, self.quads[4], left, top + 32, 0, 1, (self.h / qh) - 1)
        love.graphics.draw(self.image, self.quads[6], right, top + 32, 0, 1, (self.h / qh) - 1)

        love.graphics.draw(self.image, self.quads[5], left + 32, top + 32, 0, (self.w / qw) - 1, (self.h / qh) - 1)
    end

    table.insert(fireui.elements, self)
    return self
end

function spritepanel:draw()
    self.draw()
end

function spritepanel:attachToParent(_parent, _x, _y)
    self.x, self.y = _parent.x + _x, _parent.y + _y
end

return setmetatable(spritepanel, {__call = function(_, ...) return new(...) end})