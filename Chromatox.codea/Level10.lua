Level10 = class(BaseLevel)

function Level10:init(args)
    BaseLevel.init(self, args)
    self.description = "Avoid and collect"
end

function Level10:spawnInitialEnemies()
    self:spawnEnemies(6, 2)
    self:spawnEnemies(5, 2)
end

function Level10:setLevelBackground()
    self.background = Noise()
end

function Level10:spawnNextPhase()
    self:spawnEnemies(4, 1)
    self:spawnEnemies(6, 1)
    self:spawnEnemies(5, 2)
end