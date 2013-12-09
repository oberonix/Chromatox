Level2 = class(BaseLevel)

function Level2:init(args)
    BaseLevel.init(self, args)
    self.description = "Collect the red orbs with only the red circle\n\n+10 for each matching orb collected\n-10 for each non-matching orb collected"
end

function Level2:spawnInitialEnemies()
    self:spawnEnemies(1, 3)
end

function Level2:setLevelBackground()
    self.background = Ripple()
end

function Level2:spawnNextPhase()
    self:spawnEnemies(1, 2)
end