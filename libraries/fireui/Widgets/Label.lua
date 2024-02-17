local label = {}
label.__index = label

local function new(_text, _options)
    _options = _options or {}
    _text = _text or ""
    assert(type(_text) == "string", "[ERROR] : Invalid argument type, expected 'string' got " .. type(_text))
    assert(type(_options) == "table", "[ERROR] : Invalid argument type, expected 'table' got " .. type(_options))
    local self = setmetatable({}, label)
    self.x = _options.x or 0
    self.y = _options.y or 0
    self.w = _options.w or fireui.theme.defaultFont:getWidth(_text)
    self.h = _options.h or fireui.theme.defaultFont:getHeight()
    self.id = _options.id or ""
    self.text = _text or ""

    self.hitbox = {}
    self.hitbox.x = self.x
    self.hitbox.y = self.y
    self.hitbox.w = _options.w or self.w
    self.hitbox.h = _options.h or self.h

    self.draw = _options.draw or function()
        love.graphics.printf(_text, fireui.theme.defaultFont, self.x, self.y, self.w, "center")
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

function label:draw()
    self.draw()
end

function label:update(elapsed)
    local mx, my = love.mouse.getPosition()
    if mx >= self.hitbox.x and mx <= self.hitbox.x + self.hitbox.w and my >= self.hitbox.y and my <= self.hitbox.y + self.hitbox.h then
        self.onHover()
    end
end

function label:mousepressed(x, y, button)
    local mx, my = love.mouse.getPosition()
    if mx >= self.hitbox.x and mx <= self.hitbox.x + self.hitbox.w and my >= self.hitbox.y and my <= self.hitbox.y + self.hitbox.h then
        if love.mouse.isDown(1) then
            self.onClick()
        end
    end
end

function label:attachToParent(_parent, _x, _y)
    self.x, self.y = _parent.x + _x, _parent.y + _y
    self.hitbox.x, self.hitbox.y = self.x, self.y
end

return setmetatable(label, {__call = function(_, ...) return new(...) end})