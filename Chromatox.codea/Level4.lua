Level4 = class(BaseLevel)

function Level4:init(args)
    BaseLevel.init(self, args)
    self.description = "Avoid the white orbs\n\n+10 for each orb missed\n-10 for each orb collected"
end

function Level4:spawnInitialEnemies()
    self:spawnEnemies(5, 3)
end

function Level4:setLevelBackground()
    self.background = Squares()
end

function Level4:spawnNextPhase()
    self:spawnEnemies(5, 3)
end