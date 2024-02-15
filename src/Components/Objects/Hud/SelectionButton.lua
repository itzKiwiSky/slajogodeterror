local selectionbutton = {}
selectionbutton.__index = selectionbutton

function selectionbutton.new(_text, _x, _y, _onSelected)
    local self = setmetatable({}, selectionbutton)
    self.x = _x
end

return selectionbutton