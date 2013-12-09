TiltedCrosses = class()

function TiltedCrosses:init()
    self.circles = {}
    self.maxCircleSize = 50
    self.minIncrement = 1
    self.maxIncrement = 3
    self.minColorVal = 230
    self.maxColorVal = 255
    self.maxCircles = 20
end

function TiltedCrosses:draw()
    noFill()
    noSmooth()
    for i,v in ipairs(self.circles) do
        strokeWidth(v.strokeWidth)
        stroke(v.color)
        line(v.x - v.size / 2, v.y - v.size / 2, v.x + v.size / 2, v.y + v.size / 2)
        line(v.x + v.size / 2, v.y - v.size / 2, v.x - v.size / 2, v.y + v.size / 2)
        --rect(v.x - v.size / 2, v.y - v.size / 2, v.size, v.size)
    end
end

function TiltedCrosses:update()
    for i,v in ipairs(self.circles) do
        v.size = v.size + v.increment
        if v.size > self.maxCircleSize then
            v.increment = -v.increment
        end
        if v.size < 0 then
            table.remove(self.circles, i)
        end
    end
    if table.getn(self.circles) < self.maxCircles then
        table.insert(self.circles, {
            x = math.random(0, WIDTH),
            y = math.random(0, HEIGHT),
            color = color(math.random(self.minColorVal, self.maxColorVal), math.random(self.minColorVal, self.maxColorVal), math.random(self.minColorVal, self.maxColorVal), 255),
            increment = math.random(self.minIncrement, self.maxIncrement),
            size = 0,
            strokeWidth = math.random(1, 5)
        })
    end
end