require('src.Components.Initialization.Run')
require('src.Components.Initialization.ErrorHandler')
preloader = require 'src.Components.Initialization.Preloader'

_gameVer = 0

function love.load()
    --% lib sources %--
    math.randomseed(os.time())

    devi = require 'libraries.devi'
    anima = require 'libraries.anima'
    json = require 'libraries.json'
    g3d = require 'libraries.g3d'
    camera = require 'libraries.camera'
    deep = require 'libraries.deep'
    gamestate = require 'libraries.gamestate'
    timer = require 'libraries.timer'
    lip = require 'libraries.lip'
    nativefs = require 'libraries.nativefs'
    xml = require 'libraries.xml'
    slab = require 'libraries.slab'
    suit = require 'libraries.suit'
    bump = require 'libraries.bump'
    moonshine = require 'libraries.moonshine'
    sunlight = require 'libraries.sunlight'
    lollipop = require 'libraries.lollipop'
    object = require 'libraries.object'
    thirst = require 'libraries.thirst'
    collision = require 'libraries.collision'
    recursiveLoader = require 'src.Components.Initialization.RecursiveLoader'
    eventmanager = require 'src.Components.EventManager'

    devi.init("libraries/devi/bin")

    viewport = camera()
    viewport.locked = false

    -- camera smooth config --
    scrollingCam = object.new()
    scrollingCam.properties.scrollX = scrollingCam.x
    scrollingCam.properties.scrollY = scrollingCam.y
    -- camera target object --
    camTarget = object.new()

    love.graphics.setDefaultFilter("nearest", "nearest")

    --% Console setup %--
    slab.SetINIStatePath(nil)

    --% Game registers %--
    registers = {
        system = {
            fontSize = 20
        },
        dev = {
            enableEditors = true
        },
        game = {
            globalvaribles = {}
        }
    }

    --% Addon loader %--
    recursiveLoader("src/Addons")


    --% State loader %--
    recursiveLoader("src/States")

    local eventInitialization = require('src.Components.Initialization.EventDeclaration')()

    --% Helper functions %--
    fontmanager = require 'src.Components.Helpers.FontManager'
    lovecallbacks = require 'src.Components.Helpers.LoveCallbacks'

    --% Save setup %--
    lollipop.currentSave.game = {
        achievments = {},
        settings = {},
    }

    lollipop.initializeSlot("bird")

    --% Content management %--
    if love.filesystem.isFused() then
        local sucess1 = love.filesystem.mount(love.filesystem.getSourceBaseDirectory(), "source") 
        local sucess2 = love.filesystem.mount(love.filesystem.newFileData(love.filesystem.read("source/game.assetdata"), "gameassets.zip"), "resources")

        if not sucess1 then
            love.window.showMessageBox("Luminix Error", "An Error occurred and the engine could not be initialized", "error")
            love.event.quit()
        end

        if not sucess2 then
            love.window.showMessageBox("Luminix Error", "An Error occurred during load folder 'resources'. The file does not exist.", "error")
            love.event.quit()
        end
    end

    --% Asset queue %--
    loveimage = love.graphics.newImage("resources/images/love.png")
    lmxsdk = love.graphics.newImage("resources/images/luminixsdk.png")
    plus = love.graphics.newImage("resources/images/plus.png")
    birdIamge = love.graphics.newImage("resources/images/bird.png")


    AssetQueue = {
        images = {},
        sounds = {},
        fonts = {},
    }


    --% Asset preloading %--
    preloader.init("images", "resources/images")
    preloader.present("images")

    preloader.init("sounds", "resources/sounds")
    preloader.present("sounds")

    preloader.init("fonts", "resources/fonts")
    preloader.present("fonts")

    fontmanager.updateFontList()

    --% Release unused assets %--
    loveimage:release()
    lmxsdk:release()
    plus:release()
    birdIamge:release()
    collectgarbage("collect")

    if registers.dev.enableEditors then
        love.filesystem.createDirectory("dev")
        love.filesystem.createDirectory("dev/scenes")
    end

    gamestate.registerEvents({
        'update', 
        'mousepressed', 
        'mousereleased', 
        'keypressed', 
        'keyreleased', 
        'wheelmoved',
    })
    gamestate.switch(mapeditorstate)
end

function love.draw()
    gamestate.current():draw()
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

