local achievementmanager = {}

function achievementmanager.initialize()
    if not lollipop.currentSave.game.achievments then
        lollipop.currentSave.game.achievments = {}
        lollipop.saveSlot("bird")
    end
end

function achievementmanager.registerAchievment(_achievementData)
    _achievementData = _achievementData or {
        name = "default",
        id = "default",
        description = "no description provided",
        icon = "luminixsdk",
    }
    lollipop.currentSave.game.achievments[_achievementData.id] = {
        name = _achievementData.name or "default",
        description = _achievementData.description or "no description provided",
        meta = {
            isUnlocked = false,
            unlockDate = "-",
            iconID = _achievementData.icon
        }
    }
end

function achievementmanager.unlockAchievment(_id)
    
end

return achievementmanager