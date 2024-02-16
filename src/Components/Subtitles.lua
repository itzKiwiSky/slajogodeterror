local function _seconds(str)
    local time = string.tokenize(str, ":")
    return time[1] * 60 + time[2] + time[3] * 0.1
end

function toLast(t, value)
	t[#t+1] = value
end

subtitle = setmetatable({
	text = {},
    size = 18,
    opacity = 1,
},
{__call = function(self, text, time)
	toLast(self.text, {text = text, time = time})
end})

function subtitle.clear()
    lume.clear(subtitle.text)
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

function subtitle:draw()
    if #self.text == 0 then
		return
	end
    local _, _lines = love.graphics.getFont():getWrap(self.text[1].text, love.graphics.getWidth())

    love.graphics.setColor(0, 0, 0, self.opacity)
    love.graphics.printf(self.text[1].text, 0, (670 - love.graphics.getFont():getHeight() * #_lines) + 2, love.graphics.getWidth(), "center")
    love.graphics.setColor(1, 1, 1, self.opacity)
    love.graphics.printf(self.text[1].text, 0, 670 - love.graphics.getFont():getHeight() * #_lines, love.graphics.getWidth(), "center")
    love.graphics.setColor(1, 1, 1, 1)
end

function subtitle:update(elapsed)
	if #self.text == 0 then
		return
	end

    if self.text[1].time > 0.4 then
		self.text[1].time = self.text[1].time - elapsed
		if self.opacity < 0.8 then
			self.opacity = self. opacity + 2 * elapsed
		end
	else
		if self.opacity > 0 then
			self.opacity = self.opacity - 2 * elapsed
		else
			table.remove(self.text, 1)
		end
	end
end

return subtitle