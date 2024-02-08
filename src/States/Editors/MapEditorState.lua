mapeditorstate = {}

function mapeditorstate:enter()
    _popupCreateMapVisible = false
    _popupLoadMapVisible = false
    _confirmPopupVisible = false
    _confirmedExit = false
    _isMapLoaded = false

    slab.Initialize()
end

function mapeditorstate:draw()
    love.graphics.setColor(1, 1, 1, 1)
    slab.Draw()
    love.graphics.setColor(1, 1, 1, 1)
end

function mapeditorstate:update(elapsed)
    slab.Update(elapsed)

end

return mapeditorstate