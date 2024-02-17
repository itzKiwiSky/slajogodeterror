local checkbox = {}
checkbox.__index = checkbox

local function new(_text, _options)
    _text = _text or ""
    _options = _options or {}
    assert(type(_text) == "string", "[ERROR] : Invalid argument type, expected 'string' got " .. type(_text))
    assert(type(_options) == "table", "[ERROR] : Invalid argument type, expected 'table' got " .. type(_options))

    local self = setmetatable({}, checkbox)
    self.id = _options.id or ""
    self.text = _text or ""
    self.x = _options.x or 0
    self.y = _options.y or 0
    self.w = _options.w or 24
    self.h = _options.h or 24
    self.active = _options.active or true 
    self.hitbox = {}
    self.hitbox.x = self.x
    self.hitbox.y = self.y
    self.hitbox.w = self.w
    self.hitbox.h = self.h
    self.optionstate = _options.optionstate or false
    self.draw = _options.draw or function()
        if self.active then
            love.graphics.setColor(fireui.theme.state.idle.background[1] / 255, fireui.theme.state.idle.background[2] / 255, fireui.theme.state.idle.background[3] / 255)
        else
            love.graphics.setColor(fireui.theme.state.inactive.background[1] / 255, fireui.theme.state.inactive.background[2] / 255, fireui.theme.state.inactive.background[3] / 255)
        end
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 5)
        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.print(self.text, fireui.theme.defaultFont, (self.x + self.w) + 5, self.y + self.h / fireui.theme.defaultFont:getHeight())

        if self.optionstate then
            love.graphics.line(self.x, self.y, self.x + self.w, self.y + self.h)
            love.graphics.line(self.x, self.y + self.h, self.x + self.w, self.y)
        end
    end 

    table.insert(fireui.elements, self)
    return self
end

function checkbox:draw()
    self.draw()
end

function checkbox:mousepressed(x, y, button)
    local mx, my = x, y
    if self.active then
        if mx >= self.hitbox.x and mx <= self.hitbox.x + self.hitbox.w and my >= self.hitbox.y and my <= self.hitbox.y + self.hitbox.h then
            if button == 1 then
                if self.optionstate then
                    self.optionstate = false
                else
                    self.optionstate = true
                end
            end
        end
    end
end

function checkbox:attachToParent(_parent, _x, _y)
    self.x, self.y = _parent.x + _x, _parent.y + _y
    self.hitbox.x, self.hitbox.y = self.x, self.y
end

function checkbox:getState()
    return self.optionstate
end


return setmetatable(checkbox, { __call = function(_, ...) return new(...) end })