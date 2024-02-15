local subtitle = setmetatable({
    text = {},
    opacity = 1,
}, { __call = function(_, _text, _time) self.text[#self.text + 1] = { text = _text, time = _time} end })

local function _seconds(str)
    local time = string.tokenize(str, ":")
    return time[1] * 60 + time[2] + time[3] * 0.1
end

function subtitle.clear()
    for i = 1, #subtitle.text, 1 do
        subtitle.text[i] = nil
    end
    collectgarbage("collect")
end

function subtitle.queue(_sub)
    for i = 1, #_sub, 1 do
        local _time2
        local _time1 = _seconds(_sub[i].time)
        if _sub[i + 1] == nil then
            _time2 =  _seconds(_sub[i].time)
        else
            _time2 = _seconds(_sub[i + 1].time)
        end
        --local _time2 = _seconds(_sub[i + 1].time) or 0
        subtitle(_sub[i].text, _time2 - _time1)
    end
end

function subtitle.draw()
    if #self.text == 0 then
        return
    end

    local _, lines = love.graphics.getFont():getWrap(self.text[1][1], 750)
end