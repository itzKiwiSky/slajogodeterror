local achievementmanager = {}

function achievementmanager.initialize()
    if not lollipop.currentSave.game.achievments then
        lollipop.currentSave.game.achievments = {}
        lollipop.saveSlot("bird")
    end
end

function achievementmanager.registerAchievment(_achievementData)
    lollipop.currentSave.game.achievments[_achievementData.id] = {
        name = _achievementData.name or "default",
        description = _achievementData.description or "no description provided",
        meta = {
            isUnlocked = false,
            unlockDate = "-",
            iconID = _achievementData.icon or "luminixsdk"
        }
    }
end

function achievementmanager.unlockAchievment(_id)
    lollipop.currentSave.game.achievments[_id].meta.isUnlocked = true
    lollipop.currentSave.game.achievments[_id].meta.unlockDate = os.date("%Y-%m-%d %H:%M:%S")
end

return achievementmanager