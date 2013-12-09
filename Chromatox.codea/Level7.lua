Level7 = class(BaseLevel)

function Level7:init(args)
    BaseLevel.init(self, args)
    self.description = "Red dots combined with blue dots make purple dots"
end

function Level7:spawnInitialEnemies()
    self:spawnEnemies(1, 2)
    self:spawnEnemies(2, 2)
    self:spawnEnemies(3, 2)
end

function Level7:setLevelBackground()
    self.background = Noise()
end

function Level7:spawnNextPhase()
    self:spawnEnemies(1, 1)
    self:spawnEnemies(2, 1)
    self:spawnEnemies(3, 1)
end