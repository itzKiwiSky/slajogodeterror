local function _seconds(str)
    local time = string.tokenize(str, ":")
    return time[1] * 60 + time[2] + time[3] * 0.1
end

function toLast(t, value)
	t[#t+1] = value
end

textureDisplay = setmetatable({
	textures = {},
    size = 18,
    opacity = 1,
},
{__call = function(self, id, time)
    print(id, time)
	toLast(self.textures, {textureid = id, time = time})
end})

function textureDisplay.clear()
    lume.clear(textureDisplay.textures)
end

function textureDisplay.queue(_sub)
    for i = 1, #_sub, 1 do
        local _time2
        local _time1 = _seconds(_sub[i].time)
        if _sub[i + 1] == nil then
            _time2 =  _seconds(_sub[i].time)
        else
            _time2 = _seconds(_sub[i + 1].time)
        end
        --local _time2 = _seconds(_sub[i + 1].time) or 0
        textureDisplay(_sub[i].displayTexture, _time2 - _time1)
    end
end

function textureDisplay:draw()
    if #self.textures > 0 then
        print(debug.getTableContent(self))
        love.graphics.setColor(self.opacity, self.opacity, self.opacity, 1)
        if AssetQueue.images[self.textures[1].textureid] then
            love.graphics.draw(AssetQueue.images[self.textures[1].textureid], 0, 0)
        end
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function textureDisplay:update(elapsed)
    if #self.textures > 0 then
        if self.textures[1].time > 0.4 then
            self.textures[1].time = self.textures[1].time - elapsed
            if self.opacity < 0.8 then
                self.opacity = self. opacity + 2 * elapsed
            end
        else
            if self.opacity > 0 then
                self.opacity = self.opacity - 2 * elapsed
            else
                table.remove(self.textures, 1)
            end
        end
    end
end

return textureDisplay