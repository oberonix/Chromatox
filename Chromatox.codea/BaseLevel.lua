BaseLevel = class()

function BaseLevel:init(args)
    self.onLevelEnded = args.onLevelEnded
    self.description = "Default Description"
end

function BaseLevel:startLevel()
    self.circles = {
        PlayerCircle{
            x = 300, 
            y = 200,
            colorVal = 1,
            fillColor = color(204, 43, 43, 255)
        },
        PlayerCircle{
            x = 600,
            y = 200,
            colorVal = 2,
            fillColor = color(69, 78, 204, 255)
        }
    }
    self.score = 0
    self.enemies = {}
    self.phase = 1
    self.gameDuration = 30
    self.startTime = os.clock()
    self.currTime = 0
    self:spawnInitialEnemies()
    self:setLevelBackground()
end

function BaseLevel:spawnInitialEnemies()
    --sublclass only
end

function BaseLevel:setLevelBackground()
    --subclasses only
end

function BaseLevel:endLevel()
    self.circles = nil
    self.score = nil
    self.enemies = nil
    self.phase = nil
    self.gameDuration = nil
    self.background = nil
    collectgarbage()
end

function BaseLevel:draw()
    background(255, 255, 255, 255)
    self.background:draw(currTime)
    for i,v in ipairs(self.enemies) do
        v:draw()
    end
    
    strokeWidth(5)
    for i, c in ipairs(self.circles) do
        c:draw()
    end
    
    font("Copperplate-Bold")
    fontSize(30)
    fill(39, 174, 96, 255)
    textAlign(LEFT)
    textMode(CORNER)
    text("score: "..self.score.." time: "..self.currTime, 20, HEIGHT - 50)
end

function BaseLevel:update()
    self.currTime = self:getTime()
    if self.currTime < 0 then
        self.onLevelEnded(self.score)
        return
    elseif (self.gameDuration - self.currTime) / 5 > self.phase then
        self.phase = self.phase + 1
        self:spawnNextPhase()
    end
    
    for i,v in ipairs(self.enemies) do
        v:update()        
        if v.position.y < -v.size then
            table.remove(self.enemies, i)
            if not (v.color == 4) then
                self:spawnEnemy(v.color)
            end
            if v.color == 3 then
                self.score = self.score - 10
            elseif v.color == 5 then
                self.score = self.score + 10
            end
        elseif v.position.y < v.state then
            v.mainColor = GLOBAL.color.enemy[7]
            v.glowColor = GLOBAL.color.enemyGlow[7]
            v.color = 7
            v.state = -100
        else
            for k, c in ipairs(self.circles) do
                if c.position:dist(v.position) < 57 then
                    table.remove(self.enemies, i)
                    if c.color == v.color or v.color == 3 or v.color == 7 then
                        self.score = self.score + 10
                    elseif v.color == 4 then
                        self.score = self.score + 100
                    else
                        self.score = self.score - 10
                    end
                    if not (v.color == 4) then
                        self:spawnEnemy(v.color)
                    end
                end
            end
        end
    end
    for k, c in ipairs(self.circles) do
        c:update()
    end
    self.background:update()
end

function BaseLevel:spawnNextPhase()
    --subclass only
end

function BaseLevel:touched(touch)
    local touched = false
    for i, c in ipairs(self.circles) do
        touched = c:touched(touch)
        if c:touched(touch) then
            break
        end
    end
end

function BaseLevel:spawnEnemy(colorVal)
    self:spawnEnemies(colorVal, 1)
end

function BaseLevel:spawnEnemies(colorVal, count)
    if colorVal == 7 then
        colorVal = 6
    end
    for i = 1, count do
        local newX = math.random(25, WIDTH - 25)
        local newY = HEIGHT + 25
        local newEnemy =  Enemy{
            x = newX,
            y = newY,
            colorVal = colorVal,
            mainColor = GLOBAL.color.enemy[colorVal],
            glowColor = GLOBAL.color.enemyGlow[colorVal]
        }
        if colorVal == 6 then
            newEnemy.state = math.random(-25, HEIGHT + 25)
        elseif colorVal == 4 then
            newEnemy.speed = 12
        end
        table.insert(self.enemies, newEnemy)
    end
end

function BaseLevel:getTime()
    local elapsed = self.gameDuration - (os.clock() - self.startTime)
    return math.floor(elapsed * 100) / 100
end