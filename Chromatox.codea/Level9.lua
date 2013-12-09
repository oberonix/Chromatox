Level9 = class(BaseLevel)

function Level9:init(args)
    BaseLevel.init(self, args)
    self.description = "Purple and white\nwith a splash of green"
end

function Level9:spawnInitialEnemies()
    self:spawnEnemies(3, 1)
    self:spawnEnemies(5, 3)
end

function Level9:setLevelBackground()
    self.background = Noise()
end

function Level9:spawnNextPhase()
    self:spawnEnemies(4, 1)
    self:spawnEnemies(3, 1)
    self:spawnEnemies(5, 2)
end