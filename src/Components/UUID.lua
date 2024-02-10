local uuid = {}
uuid.__index = uuid

local function _new()
    local template ='xxyy-xxxx-yyyy-xyyx-xyxy-' .. _gameVer
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and love.math.random(0, 0xf) or love.math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

return setmetatable(uuid, { __call = function(_, ...) return _new() end })