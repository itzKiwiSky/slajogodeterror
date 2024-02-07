local player = {}

function player:init(_x, _y)
    self.x = _x or 0
    self.y = _y or 0
    self.hitbox = {}
    self.hitbox.x = self.x
    self.hitbox.y = self.y
    self.hitbox.w = 32
    self.hitbox.h = 64
    self.speed = 3
end

function player:draw()
    love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.w, self.hitbox.h)
end

function player:update(elapsed)
    self.hitbox.x, self.hitbox.y = self.x, self.y

    if love.keyboard.isDown(controls.keyboard.left) then
        self.x = self.x - self.speed
    end
    if love.keyboard.isDown(controls.keyboard.right) then
        self.x = self.x + self.speed
    end
end

return player