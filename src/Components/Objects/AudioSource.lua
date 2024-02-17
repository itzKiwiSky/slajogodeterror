local audiosource = {}
audiosource.__index = audiosource

local function _new(_id, _x, _y, _areaRadius, _maxVolume)
    local self = setmetatable({}, audiosource)
    self.id = _id
    self.x = _x or 0
    self.y = _y or 0
    self.r = _areaRadius or 32
    self.maxVolume = _maxVolume or 100
    self.meta = {}
    self.meta.volume = 0
    return self
end

function audiosource:play()
    AssetQueue.sounds[self.id]:play()
end

function audiosource:stop()
    AssetQueue.sounds[self.id]:stop()
end

function audiosource:pause()
    AssetQueue.sounds[self.id]:pause()
end

function audiosource:loop(_bool)
    AssetQueue.sounds[self.id]:setLooping(_bool)
end

function audiosource:draw()
    --love.graphics.rectangle("line", self.x + self.w / 2 - 8, self.y + self.w / 2 - 8, 16, 16)
    love.graphics.draw(AssetQueue.images.audio_icon, self.x, self.y, 0, 1, 1, AssetQueue.images.audio_icon:getWidth() / 2, AssetQueue.images.audio_icon:getHeight() / 2)
    love.graphics.circle("line", self.x, self.y, self.r)
end

function audiosource:update(elapsed)
    if collision.circRect(self, player.hitbox) then
        if self.meta.volume < 0 then
            self.meta.volume = 0
        else
            self.meta.volume = math.clamp(1 - (math.distance(player.hitbox.x, player.hitbox.y, self.x, self.y) / self.r), 0, self.maxVolume)
        end
    else
        self.meta.volume = 0
    end
    AssetQueue.sounds[self.id]:setVolume(self.meta.volume)

end

return setmetatable(audiosource, { __call = function(_, ...) return _new(...) end })