return function(_camX, _camY)
    viewport.locked = false 
    camTarget.x = tonumber(_camX) or 0
    camTarget.y = tonumber(_camY) or 0
end