Level3 = class(BaseLevel)

function Level3:init(args)
    BaseLevel.init(self, args)
    self.description = "Collect the red orbs with the red circle\nCollect the blue orbs with the blue circle\n\n+10 for each matching orb collected\n-10 for each non-matching orb collected"
end

function Level3:spawnInitialEnemies()
    self:spawnEnemies(1, 3)
    self:spawnEnemies(2, 3)
end

function Level3:setLevelBackground()
    self.background = Noise()
end

function Level3:spawnNextPhase()
    self:spawnEnemies(1, 1)
    self:spawnEnemies(2, 1)
end