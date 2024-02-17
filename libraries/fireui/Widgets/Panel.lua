local panel = {}
panel.__index = panel

local function new(_options)
    _options = _options or {}
    assert(type(_options) == "table", "[ERROR] : Invalid argument type, expected 'table' got " .. type(_options))

    local self = setmetatable({}, panel)

    self.id = _options.id or ""
    self.x = _options.x or 0
    self.y = _options.y or 0
    self.w = _options.w or 24
    self.h = _options.h or 24
    self.draw = _options.draw or function()
        love.graphics.setColor(fireui.theme.state.inactive.background[1] / 255, fireui.theme.state.inactive.background[2] / 255, fireui.theme.state.inactive.background[3] / 255)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 5)
        love.graphics.setColor(1, 1, 1, 1)
    end

    table.insert(fireui.elements, self)
    return self
end

function panel:draw()
    self.draw()
end

function panel:attachToParent(_parent, _x, _y)
    self.x, self.y = _parent.x + _x, _parent.y + _y
end

return setmetatable(panel, {__call = function(_, ...) return new(...) end})