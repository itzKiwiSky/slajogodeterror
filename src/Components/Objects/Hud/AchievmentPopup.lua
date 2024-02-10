local achievmentpopup = {}
achievmentpopup.__index = achievmentpopup

function achievmentpopup.new(_data)
    _data = _data or {}
    local self = setmetatable({}, achievmentpopup)
    self.x = 0
    self.y = 0
    self.w = 32
    self.h = 32
    self.cornersRound = 5
    self.icon = ""
    self.title = ""
    self.description = ""
    return self
end

function achievmentpopup:draw()
    
end

function achievmentpopup:update(elapsed)
    
end

return achievmentpopup