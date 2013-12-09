Enemy = class()

function Enemy:init(args)
    self.position = vec2(args.x, args.y)
    self.speed = math.random(1.5, 4.5) + math.random()
    self.color = args.colorVal
    --could get rid of swapcolor with 2 color pointers, less swapping, more memory
    self.swapColor = nil
    self.mainColor = args.mainColor
    self.glowColor = args.glowColor
    self.glowSize = 0
    self.size = args.size or 25
    self.radius = math.floor(self.size / 2.1)
    --self.radius = self.size
    self.state = args.state or -100
end

function Enemy:draw()
    strokeWidth(self.glowSize)
    stroke(self.glowColor)
    fill(self.mainColor)
    ellipse(self.position.x, self.position.y, self.size, self.size)
    --fill(self.glowColor)
    --ellipse(self.position.x, self.position.y, self.glowSize, self.glowSize)
end

function Enemy:update()
    self.position.y = self.position.y - self.speed
    self.glowSize = self.glowSize + 1
    if self.glowSize > self.radius then
        self.glowSize = 0
        self.swapColor = self.mainColor
        self.mainColor = self.glowColor
        self.glowColor = self.swapColor
    end
end

function Enemy:isTouching(touch)
    return self.position:dist(vec2(touch.x, touch.y)) < (self.size * 1)
end

function Enemy:touched(touch)
    local touched = touch.state == BEGAN and self:isTouching(touch)
    return touched
end