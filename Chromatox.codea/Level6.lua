Level6 = class(BaseLevel)

function Level6:init(args)
    BaseLevel.init(self, args)
    self.description = "Green dots are rare\nGreen dots are fast\nGreen dots are worth 100 points"
end

function Level6:spawnInitialEnemies()
    self:spawnEnemies(1, 3)
    self:spawnEnemies(2, 3)
end

function Level6:setLevelBackground()
    self.background = Noise()
end

function Level6:spawnNextPhase()
    self:spawnEnemies(1, 2)
    self:spawnEnemies(2, 2)
    self:spawnEnemies(4, 1)
end