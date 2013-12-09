Level5 = class(BaseLevel)

function Level5:init(args)
    BaseLevel.init(self, args)
    self.description = "Avoid the teal orbs\nCollect them once they turn orange\n\n+10 for each orange orb collected\n-10 for each teal orb collected"
end

function Level5:spawnInitialEnemies()
    self:spawnEnemies(6, 3)
end

function Level5:setLevelBackground()
    self.background = TiltedCrosses()
end

function Level5:spawnNextPhase()
    self:spawnEnemies(6, 3)
end