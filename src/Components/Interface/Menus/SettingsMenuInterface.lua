local langsName = {
    "en",
    "pt",
    "es"
}

local langs = {
    "English",
    "Portugues",
    "Español"
}

return function()
    slab.BeginWindow("settingsWindow", {Title = "Settings", AllowResize = false, W = 640, H = 480})
        if slab.Button("Graphics") then
            tab = "graphics"
        end
        slab.SameLine()
        if slab.Button("Audio") then
            tab = "audio"
        end
        slab.SameLine()
        if slab.Button("Miscellaneous") then
            tab = "misc"
        end
        slab.Separator()
            if tab == "graphics" then
                if slab.CheckBox(lollipop.currentSave.game.settings.graphics.useShaders, "Enable Shaders") then
                    lollipop.currentSave.game.settings.graphics.useShaders = not lollipop.currentSave.game.settings.graphics.useShaders
                end
                
                if slab.CheckBox(lollipop.currentSave.game.settings.graphics.vsync, "Enable V-Sync") then
                    lollipop.currentSave.game.settings.graphics.vsync = not lollipop.currentSave.game.settings.graphics.vsync
                end

                if slab.CheckBox(lollipop.currentSave.game.settings.graphics.filter, "Antialiasing") then
                    lollipop.currentSave.game.settings.graphics.filter = not lollipop.currentSave.game.settings.graphics.filter
                end

                if slab.CheckBox(lollipop.currentSave.game.settings.graphics.lowDetailMode, "Low Detail Mode") then
                    lollipop.currentSave.game.settings.graphics.lowDetailMode = not lollipop.currentSave.game.settings.graphics.lowDetailMode
                end
            elseif tab == "audio" then
                slab.Text("Master Volume")
                slab.SameLine()
                if slab.Input("masterVolumeInput", {Text = tostring(lollipop.currentSave.game.settings.audio.master), NumbersOnly = true, MinNumber = 0, MaxNumber = 10}) then
                    lollipop.currentSave.game.settings.audio.master = slab.GetInputNumber()
                end
                slab.Text("Music Volume")
                slab.SameLine()
                if slab.Input("musicVolumeInput", {Text = tostring(lollipop.currentSave.game.settings.audio.music), NumbersOnly = true, MinNumber = 0, MaxNumber = 10}) then
                    lollipop.currentSave.game.settings.audio.music = slab.GetInputNumber()
                end
                slab.Text("Sound Effecs Volume")
                slab.SameLine()
                if slab.Input("sfxVolumeInput", {Text = tostring(lollipop.currentSave.game.settings.audio.sfx), NumbersOnly = true, MinNumber = 0, MaxNumber = 10}) then
                    lollipop.currentSave.game.settings.audio.sfx = slab.GetInputNumber()
                end
                if slab.CheckBox(lollipop.currentSave.game.settings.audio.playVoices, "Enable Voice lines") then
                    lollipop.currentSave.game.settings.audio.playVoices = not lollipop.currentSave.game.settings.audio.playVoices
                end
                slab.Text("Voice line Volume")
                slab.SameLine()
                if slab.Input("voicelineVolumeInput", {Text = tostring(lollipop.currentSave.game.settings.audio.voicesVolume), NumbersOnly = true, MinNumber = 0, MaxNumber = 10}) then
                    lollipop.currentSave.game.settings.audio.voicesVolume = slab.GetInputNumber()
                end
            elseif tab == "misc" then
                slab.Text("Language")
                slab.SameLine()
                if slab.BeginComboBox("languageComboBox", {Selected = lollipop.currentSave.game.settings.misc.language}) then
                    for l = 1, #langsName, 1 do
                        if slab.TextSelectable(langs[l]) then
                            lollipop.currentSave.game.settings.misc.language = langsName[l]
                        end
                    end
                    slab.EndComboBox()
                end

                if slab.CheckBox(lollipop.currentSave.game.settings.misc.subtitles, "Subtitles") then
                    lollipop.currentSave.game.settings.misc.subtitles = not lollipop.currentSave.game.settings.misc.subtitles
                end
            end
        slab.Separator()
        if slab.Button("Save changes") then
            lollipop.saveCurrentSlot()
            settingsVisible = false
        end
    slab.EndWindow()
end