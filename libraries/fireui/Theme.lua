return {
    defaultFont = love.graphics.newFont(14),
    state = {
        idle = {
            foreground = {255, 255, 255, 255},
            background = {243, 115, 25, 255},
        },
        hovered = {
            foreground = {255, 255, 255, 255},
            background = {255, 161, 96, 255},
        },
        active = {
            foreground = {255, 255, 255, 255},
            background = {255, 230, 190, 255},
        },
        inactive = {
            foreground = {150, 150, 150, 255},
            background = {120, 59, 18, 255},
        },
    }
}