return function(_filename, _width, _height)
    local scene = {
        scene = {
            properties = {
                size = {
                    width = _width,
                    height = _height,
                },
                camera = {
                    position = {0, 0},
                    rotation = 0,
                    zoom = 1,
                    smooth = 0.3,
                    isStatic =  false
                },
                player = {
                    position = {0, 0}
                },
                backgroundColor = {0, 0, 0}
            },
            objects = {},
            actionBoxes = {},
            meta = {
                gameversion = _gameVersion,
                description = "Powered by LuminixSDK"
            }
        }
    }

    local file = love.filesystem.newFile("dev/scenes/" .. _filename .. ".scene", "w")
    file:write(json.encode(scene))
    file:close()
end