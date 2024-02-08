local cup = {}
cup.__index = cup

function cup.new(_x, _y)
    local self = setmetatable({}, cup)
    self.x = _x
    self.y = _y
    self.speed = 500
    self.id = "wine_cup"
    self.hitted = false
    self.hitbox = {}
    self.hitbox.x = self.x
    self.hitbox.y = self.y
    self.hitbox.w = 32 * 5
    self.hitbox.h = 32 * 5
    return self
end

function cup:draw()
    love.graphics.draw(AssetQueue.images[self.id], self.x, self.y, 0, 5, 5)
    local text = "hitted:%s\nSpeed: %s"
    love.graphics.print(string.format(text, self.hitted, self.speed), self.x, self.y - 50)
end

function cup:update(elapsed)
    self.hitbox.x = self.x
    self.hitbox.y = self.y
    self.x = self.x + self.speed * elapsed
    if self.speed >= 30 then
        self.speed = self.speed - 100 * elapsed
    end
end

return cup