local slider = {}
slider.__index = slider

local function new(_options)
    _options = _options or {}
    assert(type(_options) == "table", "[ERROR] : Invalid argument type, expected 'table' got " .. type(_options))

    local self = setmetatable({}, slider)
    self.id = _options.id or ""
    self.min = _options.min or 0
    self.max = _options.max or 100
    self.value = (_options.value or 0 -self.min or _options.min) / (self.max or _options.max - self.min or _options.min)
    self.setter = _options.onUpdate or function()
        print("updated")
    end
    self.x = _options.x or 0
    self.y = _options.y or 0
    self.length = _options.length or 128
    self.orientation = _options.orientation or "horizontal"
    self.w = _options.w or self.length * 0.1

    self.grabbed = false
    self.wasDown = true
    self.ox = 0
    self.oy = 0

    self.draw = _options.draw or function()
        if self.orientation == "horizontal" then
            love.graphics.line(self.x - self.length / 2, self.y, self.x + self.length / 2, self.y)
        else
            love.graphics.line(self.x, self.y - self.length / 2, self.x, self.y + self.length / 2)
        end

        local knobX = self.x
        local knobY = self.y

        if self.orientation == "horizontal" then
            knobX = self.x - self.length / 2 + self.length * self.value
        else
            knobY = self.y + self.length / 2 - self.length * self.value
        end

        love.graphics.circle('fill', knobX, knobY, self.w / 2)
    end

    self.update = _options.update or function(elapsed)
        local mx, my = love.mouse.getPosition()
        local down = love.mouse.isDown(1)
    
        local knobX = self.x
        local knobY = self.y

        if self.orientation == "horizontal" then
            knobX = self.x - self.length / 2 + self.length * self.value
        else
            knobY = self.y + self.length / 2 - self.length * self.value
        end

        local ox = mx - knobX 
        local oy = my - knobY
        local dx = ox - self.ox
        local dy = oy - self.oy

        if down then
            if self.grabbed then
                if self.orientation == "horizontal" then
                    self.value = self.value + dx / self.length
                else
                    self.value = self.value - dy / self.length
                end
            elseif mx > knobX - self.w / 2 and mx < knobX + self.w / 2 and my > knobY - self.w / 2 and my < knobY + self.w / 2 and not self.wasDown then
                self.ox = ox
                self.oy = oy
                self.grabbed = true
            end
        else
            self.grabbed = false
        end

        self.value = math.max(0, math.min(1, self.value))
        self.wasDown = down
    end

    table.insert(fireui.elements, self)
    return self
end

function slider:draw()
    self.draw()
end

function slider:update(elapsed)
    self.update(elapsed)
end

function slider:getValue()
    return self.min + self.value * (self.max - self.min)
end

function slider:attachToParent(_parent, _x, _y)
    self.x, self.y = _parent.x + _x, _parent.y + _y
end

return setmetatable(slider, {__call = function(_, ...) return new(...) end})