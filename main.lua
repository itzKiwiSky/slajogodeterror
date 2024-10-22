require('src.Components.Initialization.Run')
--require('src.Components.Initialization.ErrorHandler')
preloader = require 'src.Components.Initialization.Preloader'

_gameVer = 0

local function _installLib()
    love.filesystem.createDirectory("bin")
    if love.system.getOS() == "Windows" then
        love.filesystem.write("bin/devi.dll", love.filesystem.read("libraries/devi/bin/devi.dll"))
    elseif love.system.getOS() == "OS X" then
        love.filesystem.write("bin/devi.dylib", love.filesystem.read("libraries/devi/bin/devi.dylib"))
    elseif love.system.getOS() == "Linux" then
        love.filesystem.write("bin/devi.so", love.filesystem.read("libraries/devi/bin/devi.so"))
    end
end

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
    lume = require 'libraries.lume'
    fireui = require 'libraries.fireui'
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

    _installLib()
    devi.init(love.filesystem.getSaveDirectory() .. "/bin")

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

    --% Save setup %--
    lollipop.currentSave.game = {
        achievments = {},
        settings = {
            graphics = {
                useShaders = true,
                vsync = false,
                filter = false,
                lowDetailMode = false
            },
            audio = {
                master = 10,
                music = 10,
                sfx = 10,
                playVoices = true,
                voicesVolume = 10
            },
            misc = {
                subtitles = true,
                language = "en",
                langID = 1
            }
        },
        chapters = {
            {
                isLocked = false,
                completed = false
            },
            {
                isLocked = true,
                completed = false
            },
            {
                isLocked = true,
                completed = false
            },
            {
                isLocked = true,
                completed = false
            },
        }
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
    birdImage = devi.newImage("resources/bird2.gif")


    AssetQueue = {
        images = {},
        sounds = {},
        fonts = {},
    }


    --% Asset preloading %--
    preloader.clear()

    preloader.init("images", "resources/chunks/menu/images")
    preloader.present("images")

    preloader.init("sounds", "resources/chunks/menu/sounds")
    preloader.present("sounds")

    preloader.init("fonts", "resources/chunks/menu/fonts")
    preloader.present("fonts")

    fontmanager.updateFontList()

    --% Release unused assets %--
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
    gamestate.switch(mainmenustate)
end

function love.draw()
    local graph = [[
FPS: %s
TextureMemory: %.2f mb
Drawcalls: %s
Images: %s
    ]]
    gamestate.current():draw()
    love.graphics.print(
        string.format(
            graph, 
            love.timer.getFPS(),
            love.graphics.getStats().texturememory / 1024 / 1024,
            love.graphics.getStats().drawcalls,
            love.graphics.getStats().images
        ),
        10, 10
    )
end

function love.keypressed(k)
    if k == "f11" then
        if love.graphics.isWireframe() then
            love.graphics.setWireframe(false)
        else
            love.graphics.setWireframe(true)
        end
    end
end