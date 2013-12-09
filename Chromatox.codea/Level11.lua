Level11 = class(BaseLevel)

function Level11:init(args)
    BaseLevel.init(self, args)
    self.description = "Memory overload"
end

function Level11:spawnInitialEnemies()
    self:spawnEnemies(1, 1)
    self:spawnEnemies(2, 1)
    self:spawnEnemies(3, 1)
    self:spawnEnemies(4, 1)
    self:spawnEnemies(5, 1)
    self:spawnEnemies(6, 1)
end

function Level11:setLevelBackground()
    self.background = Noise()
end

function Level11:spawnNextPhase()
    self:spawnEnemies(1, 1)
    self:spawnEnemies(2, 1)
    self:spawnEnemies(3, 1)
    self:spawnEnemies(4, 1)
    self:spawnEnemies(5, 1)
    self:spawnEnemies(6, 1)
end