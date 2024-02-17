local button = {}
button.__index = button

local function new(_text, _options)
    _text = _text or ""
    _options = _options or {}
    assert(type(_text) == "string", "[ERROR] : Invalid argument type, expected 'string' got " .. type(_text))
    assert(type(_options) == "table", "[ERROR] : Invalid argument type, expected 'table' got " .. type(_options))

    local self = setmetatable({}, button)

    self.id = _options.id or ""
    self.text = _text or ""
    self.x = _options.x or 0
    self.y = _options.y or 0
    self.w = _options.w or fireui.theme.defaultFont:getWidth(self.text) + 16
    self.h = _options.h or 24
    self.state = "idle"
    self.hitbox = {}
    self.hitbox.x = self.x
    self.hitbox.y = self.y
    self.hitbox.w = _options.w or fireui.theme.defaultFont:getWidth(self.text) + 16
    self.hitbox.h = _options.h or 24
    self.draw = _options.draw or function()
        love.graphics.setColor(fireui.theme.state[self.state].background[1] / 255, fireui.theme.state[self.state].background[2] / 255, fireui.theme.state[self.state].background[3] / 255)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 5)
        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.setColor(fireui.theme.state[self.state].foreground[1] / 255, fireui.theme.state[self.state].foreground[2] / 255, fireui.theme.state[self.state].foreground[3] / 255)
        love.graphics.printf(self.text, fireui.theme.defaultFont, self.x, self.y + self.h / fireui.theme.defaultFont:getHeight(), self.w, "center")
        love.graphics.setColor(1, 1, 1, 1)
    end
    self.onClick = _options.onClick or function()
        print("hello world")
    end
    
    self.onHover = _options.onHover or function()
        print("is hover")
    end

    table.insert(fireui.elements, self)
    return self
end

function button:draw()
    self.draw()
end

function button:update(elapsed)
    if self.state ~= "inactive" then
        local mx, my = love.mouse.getPosition()
        if mx >= self.hitbox.x and mx <= self.hitbox.x + self.hitbox.w and my >= self.hitbox.y and my <= self.hitbox.y + self.hitbox.h then
            self.state = "hovered"
            self.onHover()
        else
            self.state = "idle"
        end
    end
end

function button:mousepressed(x, y, button)
    local mx, my = x, y
    if self.state ~= "inactive" then
        if mx >= self.hitbox.x and mx <= self.hitbox.x + self.hitbox.w and my >= self.hitbox.y and my <= self.hitbox.y + self.hitbox.h then
            if button == 1 then
                self.state = "active"
                self.onClick()
            end
        else
            self.state = "idle"
        end
    end
end

function button:attachToParent(_parent, _x, _y)
    self.x, self.y = _parent.x + _x, _parent.y + _y
    self.hitbox.x, self.hitbox.y = self.x, self.y
end

return setmetatable(button, {__call = function(_, ...) return new(...) end})