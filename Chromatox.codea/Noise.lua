Noise = class()

function Noise:init()
    -- Expose some parameters to control our noise
    --parameter.number("noiseScale", 1/30, 1, 1/5)
    --parameter.number("noiseSpeed", 0.05, 1, 0.2)
    self.noiseScale = 0.5
    self.noiseSpeed = 0.02

    -- How big each grid square is
    self.tileXSize = WIDTH/5
    self.tileYSize = HEIGHT/6
    

    -- "Position" in the noise field
    self.noisePos = vec2(0,0)

    -- This initializes our 2D array of noise values
    self.tiles = {}
    for x = 1, WIDTH/self.tileXSize do
        self.tiles[x] = {}
        for y = 1, HEIGHT/self.tileYSize do
            self.tiles[x][y] = noise(x * self.noiseScale, y * self.noiseScale)
        end
    end
end

-- This function updates our 2D array of noise values
function Noise:update()
    for x,column in pairs(self.tiles) do
        for y,value in pairs(column) do
            self.tiles[x][y] = noise(x * self.noiseScale + self.noisePos.x, y * self.noiseScale + self.noisePos.y)
        end
    end
    self.noisePos = self.noisePos + vec2(0.5,0.3) * self.noiseSpeed
end

function Noise:draw()
    --background(0, 0, 0, 255)
    
    -- Disable stroke and smooth
    noStroke()
    noSmooth()
 
    -- Iterate through our noise values and 
    --  render a rect() for each value   
    for x,column in pairs(self.tiles) do
        for y,value in pairs(column) do
            fill((value+1)*0.9*55 + 200)
            rect((x-1)*self.tileXSize, (y-1)*self.tileYSize, self.tileXSize, self.tileYSize)
        end
    end
    
    -- Update the noise position


    -- Update all the noise values
    --moveNoise()
end
