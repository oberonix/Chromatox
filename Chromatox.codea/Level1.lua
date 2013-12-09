Level1 = class(BaseLevel)

function Level1:init(args)
    BaseLevel.init(self, args)
    self.description = "Use your fingers to move the large circles\nCollect all of the purple orbs\n\n+10 for each orb collected\n-10 for each orb missed"
end

function Level1:spawnInitialEnemies()
    self:spawnEnemies(3, 3)
end

function Level1:setLevelBackground()
    self.background = StreamingLines()
end

function Level1:spawnNextPhase()
    self:spawnEnemies(3, 1)
end