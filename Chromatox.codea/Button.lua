Button = class()

function Button:init(args)
    self.text = args.text or "Button"
    self.size = args.size or 30
    self.x = args.x or 100
    self.y = args.y or 100
    self.textColor = args.textColor or color(255, 255, 255, 255)
    self.outlineColor = args.textColor or color(255, 255, 255, 255)
    self.highlightTextColor = args.highlightTextColor or color(255, 255, 255, 255)
    self.highlightOutlineColor = args.textColor or color(255, 0, 0, 255)
    self.backgroundColor = args.backgroundColor or color(255, 0, 0, 255)
    self.backgroundHighlightColor = args.backgroundHighlightColor or color(255, 0, 0, 255)
    self.strokeWidth = args.strokeWidth or 5
    self.hPadding = args.hPadding or 20
    self.vPadding = args.vPadding or 10
    self.align = args.align or "left"
    self.delay = args.delay or .5
    self.timer = ElapsedTime
    self.active = false
    
    self.onTouchEnded = args.onTouchEnded or function() end
    
    self.currentTextColor = self.textColor
    self.currentOutlineColor = color(200, 200, 200)
    self.currentBackgroundColor = color(200, 200, 200)
    self.position = vec2(args.x, args.y)
    
    --read the size of the text to determine how big to make the button
    font("Futura-Medium")
    fontSize(self.size)
    w,h = textSize(self.text)
    self.w = w
    self.h = h
    
    if self.align == "center" then
        self.x = self.x - w / 2
        self.y = self.y - h / 2
    end
    
    --precalculate the absolute bounds for use in the common methods
    self.totalWidth = self.w + (self.hPadding * 2)
    self.totalHeight = self.h + (self.vPadding * 2)
    self.left = self.x - self.hPadding
    self.top = self.y - self.vPadding
    self.right = self.x + self.totalWidth
    self.bottom = self.y + self.totalHeight
end

function Button:update()    
    if not self.active and ElapsedTime - self.timer > self.delay then
        self.active = true
        self.currentOutlineColor = self.outlineColor
        self.currentBackgroundColor = self.backgroundColor
    end
end

function Button:draw()
    font("Futura-Medium")
    fontSize(self.size)
    
    noStroke()
    fill(self.currentBackgroundColor)
    rect(self.left, self.top, self.totalWidth, self.totalHeight)
    
    noFill()
    strokeWidth(self.strokeWidth)
    stroke(self.currentOutlineColor)
    rect(self.left, self.top, self.totalWidth, self.totalHeight)
    
    fill(self.currentTextColor)
    textAlign(CENTER)
    textMode(CORNER)
    text(self.text, self.x, self.y)
end

function Button:isTouching(touch)
    return touch.x > self.left and touch.x < self.right and touch.y > self.top and touch.y < self.bottom
end

function Button:touched(touch)
    if self.active then
        --could optimize to only change stuff on touch state change
        isTouching = self:isTouching(touch)
        if not isTouching then
            self.currentTextColor = self.textColor
            self.currentOutlineColor = self.outlineColor        
            self.currentBackgroundColor = self.backgroundColor
            return false
        elseif touch.state == BEGAN then
            self.currentTextColor = self.highlightTextColor
            self.currentOutlineColor = self.highlightOutlineColor
            self.currentBackgroundColor = self.backgroundHighlightColor
            return true
        elseif touch.state == ENDED then
            print("ote")
            self:onTouchEnded()
            self.currentTextColor = self.textColor
            self.currentOutlineColor = self.outlineColor
            self.currentBackgroundColor = self.backgroundColor
            return false
        end
    end
    return false
end

function Button:reset()
    self.timer = ElapsedTime
end
