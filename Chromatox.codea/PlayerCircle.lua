PlayerCircle = class()

function PlayerCircle:init(args)
    self.position = vec2(args.x, args.y)
    self.circleSize = 100
    self.borderSize = 3
    self.borderIncrement = .25
    self.touchId = nil
    self.touchingStrokeColor = args.touchingStrokeColor or color(0, 255, 0, 255)
    self.normalStrokeColor = args.normalStrokeColor or color(200, 200, 200, 255)
    self.strokeColor = self.normalStrokeColor
    self.fillColor = args.fillColor
    self.color = args.colorVal
end

function PlayerCircle:update()
    self.borderSize = self.borderSize + self.borderIncrement
    if self.borderSize > 7 then
        self.borderIncrement = -.25
    elseif self.borderSize < 3 then
        self.borderIncrement = .25
    end
end

function PlayerCircle:draw()
    strokeWidth(self.borderSize)
    stroke(self.strokeColor)
    fill(self.fillColor)
    ellipse(self.position.x, self.position.y, self.circleSize, self.circleSize)
end

function PlayerCircle:isTouching(touch)
    return self.position:dist(vec2(touch.x, touch.y)) < self.circleSize
end

function PlayerCircle:touched(touch)
    if touch.state == BEGAN and self.touchId == nil and self:isTouching(touch) then
        self.touchId = touch.id
        self.strokeColor = self.touchingStrokeColor
        self.position.x = math.min(WIDTH - 50, math.max(50, touch.x))
        self.position.y = math.min(HEIGHT - 50, math.max(50, touch.y))
        return true
    elseif touch.state == MOVING and touch.id == self.touchId then
        self.position.x = math.min(WIDTH - 50, math.max(50, touch.x))
        self.position.y = math.min(HEIGHT - 50, math.max(50, touch.y))
        return true
    elseif touch.state == ENDED and touch.id == self.touchId then
        self.touchId = nil
        self.strokeColor = self.normalStrokeColor
        return true
    end
    return false
end