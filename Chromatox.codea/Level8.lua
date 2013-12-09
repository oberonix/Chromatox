Level8 = class(BaseLevel)

function Level8:init(args)
    BaseLevel.init(self, args)
    self.description = "Red, white, and blue"
end

function Level8:spawnInitialEnemies()
    self:spawnEnemies(1, 2)
    self:spawnEnemies(2, 2)
    self:spawnEnemies(5, 2)
end

function Level8:setLevelBackground()
    self.background = Noise()
end

function Level8:spawnNextPhase()
    self:spawnEnemies(1, 1)
    self:spawnEnemies(2, 1)
    self:spawnEnemies(5, 1)
end