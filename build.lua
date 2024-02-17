local settings = {}

settings.name = 'PinkBird-Alpha' -- name of the game for your executable
settings.developer = 'EmptyDoll Productions' -- dev name used in metadata of the file
settings.output = 'output' -- output location for your game, defaults to $SAVE_DIRECTORY
settings.version = '0.0.1' -- 'version' of your game, used to make a version folder in output
settings.love = '11.5' -- version of LÖVE to use, must match github releases
settings.ignore = {'dist', '.DS_Store'} -- folders/files to ignore in your project
settings.icon = 'icon.png' -- 256x256px PNG icon for game, will be converted for you

-- optional settings:
settings.se32bit = false -- set true to build windows 32-bit as well as 64-bit
settings.identifier = 'com.emptydoll.pinkbird' -- macos team identifier, defaults to game.developer.name
settings.libs = {'bin/windows/https.dll'} -- files to place in output directly rather than fuse
settings.platforms = {'windows'} -- set if you only want to build for a specific platform

return settings