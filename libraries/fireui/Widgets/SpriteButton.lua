local spritebutton = {}
spritebutton.__index = spritebutton

local function new(_filename, _options)
    _options = _options or {}
    _filename = _filename or fireui.base:gsub("%.", "/") .. "/Resources/grayButton"
    print(_filename)
    assert(type(_filename) == "string", "[ERROR] : Invalid argument type, expected 'string' got " .. type(_filename))
    assert(type(_options) == "table", "[ERROR] : Invalid argument type, expected 'table' got " .. type(_options))

    local self = setmetatable({}, spritebutton)

    self.image, self.quads = love.graphics.getQuads(_filename)
    self.x = _options.x or 0
    self.y = _options.y or 0
    self.w = _options.w or 64
    self.h = _options.h or 64
    self.id = _options.id or ""
    self.hitbox = {}
    self.hitbox.x = self.x
    self.hitbox.y = self.y
    self.hitbox.w = self.w
    self.hitbox.h = self.h
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
    self.onClick = _options.onClick or function()
        print("is clicked")
    end

    self.onHover = _options.onHover or function()
        print("is hover")
    end

    table.insert(fireui.elements, self)
    return self
end

function spritebutton:draw()
    self.draw()
end

function spritebutton:update(elapsed)
    local mx, my = love.mouse.getPosition()
    if mx >= self.hitbox.x and mx <= self.hitbox.x + self.hitbox.w and my >= self.hitbox.y and my <= self.hitbox.y + self.hitbox.h then
        self.onHover()
    end
end

function spritebutton:mousepressed(x, y, button)
    local mx, my = love.mouse.getPosition()
    if mx >= self.hitbox.x and mx <= self.hitbox.x + self.hitbox.w and my >= self.hitbox.y and my <= self.hitbox.y + self.hitbox.h then
        if love.mouse.isDown(1) then
            self.onClick()
        end
    end
end

function spritebutton:attachToParent(_parent, _x, _y)
    self.x, self.y = _parent.x + _x, _parent.y + _y
    self.hitbox.x, self.hitbox.y = self.x, self.y
end

return setmetatable(spritebutton, {__call = function(_, ...) return new(...) end})