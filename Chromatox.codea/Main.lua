function setup()    
    displayMode(FULLSCREEN)
    supportedOrientations(PORTRAIT)
    levels = {
        Level1{
            onLevelEnded = onLevelEnded
        },
        Level2{
            onLevelEnded = onLevelEnded
        },
        Level3{
            onLevelEnded = onLevelEnded         
        },
        Level4{
            onLevelEnded = onLevelEnded         
        },
        Level5{
            onLevelEnded = onLevelEnded         
        },
        Level6{
            onLevelEnded = onLevelEnded         
        },
        Level7{
            onLevelEnded = onLevelEnded         
        },
        Level8{
            onLevelEnded = onLevelEnded         
        },
        Level9{
            onLevelEnded = onLevelEnded         
        },
        Level10{
            onLevelEnded = onLevelEnded         
        },
        Level11{
            onLevelEnded = onLevelEnded         
        }
    }
    highScore = {}
    for i=1,table.getn(levels) do
        highScore[i] = readLocalData("highscore_"..i)
        if highScore[i] == nil then
            highScore[i] = 0
            saveLocalData("highscore_"..i, highScore[i])
        end
    end
    lastScore = 0
    currentLevel = 0
    --smooth()
    state = "loaded"
    buttonBackgroundColor = color(41, 128, 185)
    buttonBackgroundHighlightColor = color(71, 168, 225, 255)
    playButton = Button{
        text = "Play",
        size = 50,
        x = WIDTH / 2,
        y = HEIGHT / 2.75,
        align = "center",
        onTouchEnded = startNextLevel,
        strokeWidth = 0,
        backgroundColor = buttonBackgroundColor,
        backgroundHighlightColor = buttonBackgroundHighlightColor,
        delay = 0
    }
    mainLevelSelectButton = Button{
        text = "Level Select",
        size = 30,
        x = WIDTH / 2,
        y = HEIGHT / 4,
        align = "center",
        onTouchEnded = showLevelSelect,
        strokeWidth = 0,
        backgroundColor = buttonBackgroundColor,
        backgroundHighlightColor = buttonBackgroundHighlightColor,
        delay = 0
    }
    nextButton = Button{
        text = "Next Level",
        size = 30,
        x = WIDTH / 2,
        y = HEIGHT / 3,
        align = "center",
        onTouchEnded = startNextLevel,
        strokeWidth = 0,
        backgroundColor = buttonBackgroundColor,
        backgroundHighlightColor = buttonBackgroundHighlightColor
    }
    restartButton = Button{
        text = "Play Again",
        size = 30,
        x = WIDTH / 2,
        y = HEIGHT / 4,
        align = "center",
        onTouchEnded = resetAndStart,
        strokeWidth = 0,
        backgroundColor = buttonBackgroundColor,
        backgroundHighlightColor = buttonBackgroundHighlightColor
    }
    levelSelectButton = Button{
        text = "Level Select",
        size = 30,
        x = WIDTH / 2,
        y = HEIGHT / 6,
        align = "center",
        onTouchEnded = showLevelSelect,
        strokeWidth = 0,
        backgroundColor = buttonBackgroundColor,
        backgroundHighlightColor = buttonBackgroundHighlightColor
    }
    startLevelButton = Button{
        text = "Start",
        size = 50,
        x = WIDTH / 2,
        y = HEIGHT / 3,
        align = "center",
        onTouchEnded = resetAndStart,
        strokeWidth = 0,
        backgroundColor = buttonBackgroundColor,
        backgroundHighlightColor = buttonBackgroundHighlightColor,
        delay = 0
    }
    levelButtons = {}
    levelTitle = ""
    levelDescription = ""
    fps = 60
    lowFPS = 60
    --watch("fps")
end

function dist(x1, x2, y1, y2)
    return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2)) 
end

function squareDist(x1, x2, y1, y2)
    return math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2)
end

function orientationChanged()
    return false 
end

function update()
    if state == "playing" then
        levels[currentLevel]:update()
    elseif state == "loaded" then
        playButton:update()
        mainLevelSelectButton:update()
    elseif state == "ended" then
        if currentLevel < table.getn(levels) then
            nextButton:update()
        end
        restartButton:update()
        levelSelectButton:update()
    elseif state == "intro" then
        startLevelButton:update()
    elseif state == "level_select" then
        for i,lb in pairs(levelButtons) do
            lb:update();
        end
    end
end

function draw()
    update()
    --background(236, 240, 241, 255)
    if state == "playing" or state == "paused" then
        levels[currentLevel]:draw()
    elseif state =="ended" then
        --dimScreen()
        background(255, 255, 255, 255)
        --background(0,0,0)
        drawTitleBox()
        writeCenterText("Level Complete", 90, WIDTH / 2, HEIGHT / 1.25)
        drawScoreBox()
        writeCenterText("Score: "..lastScore, 70, WIDTH / 2, HEIGHT / 1.8)
        writeCenterText("High Score: "..highScore[currentLevel], 40, WIDTH / 2, HEIGHT / 2.2)
        nextButton:draw()
        restartButton:draw()
        levelSelectButton:draw()
    elseif state == "loaded" then
        --dimScreen()
        background(255, 255, 255, 255)
        --background(0,0,0)
        drawTitleBox()
        writeCenterText("Chromatox", 100, WIDTH / 2, HEIGHT / 1.25)
        playButton:draw()
        mainLevelSelectButton:draw()
    elseif state == "level_select" then
        --dimScreen()
        background(255, 255, 255, 255)
        --background(0,0,0)
        drawTitleBox()
        writeCenterText("Chromatox", 100, WIDTH / 2, HEIGHT / 1.25)
        for i,lb in pairs(levelButtons) do
            lb:draw()
        end
    elseif state == "intro" then    
        background(255, 255, 255, 255)
        
        --background(0,0,0)
        drawTitleBox()
        --writeCenterText(levelTitle, 70, WIDTH / 2, HEIGHT / 1.25)
        --drawScoreBox()
        textWrapWidth(650)
        writeCenterText(levelDescription, 30, WIDTH / 2, HEIGHT / 1.5)
        startLevelButton:draw()
    end
    drawFPS()
end

function drawTitleBox()
    --fill(39, 174, 96, 255)
    --rect(0, 537, WIDTH, 150)
end

function drawScoreBox()
    --fill(189, 195, 199, 255)
    --rect(0, 307, WIDTH, 175)
end

function dimScreen()
    --draw dark screen
    strokeWidth(0)
    fill(0, 0, 0, 150)
    rect(0, 0, WIDTH, HEIGHT)
end

function drawFPS()
    fps = (fps * 0.95) + (0.05 / DeltaTime)
    --fps = math.floor(fps)
    if fps < lowFPS then
        lowFPS = fps
    end
    font("Futura-Medium")
    fontSize(15)
    fill(color(39, 174, 96, 255))
    textAlign(LEFT)
    textMode(CORNER)
    text("Low: "..lowFPS.." - FPS: "..fps, 15, WIDTH - 100, 10)
end

function writeCenterText(content, size, x, y, textColor)
    font("Futura-Medium")
    fontSize(size)
    fill(textColor or color(39, 174, 96, 255))
    textAlign(CENTER)
    textMode(CENTER)
    text(content, x, y)
end

function touched(touch)
    if state == "playing" then
        levels[currentLevel]:touched(touch)
    elseif state == "loaded" then
        playButton:touched(touch)
        mainLevelSelectButton:touched(touch)
    elseif state == "ended" then
        nextButton:touched(touch)
        restartButton:touched(touch)
        levelSelectButton:touched(touch)
    elseif state == "intro" then
        startLevelButton:touched(touch)
    elseif state == "level_select" then
        for i,lb in pairs(levelButtons) do
            lb:touched(touch)
        end
    end
end

function onLevelStarted()
    levelTitle = levels[currentLevel].title
    levelDescription = levels[currentLevel].description
    state = "intro"
    onStateChange()
    timer = 0
end

function resetAndStart()
    levels[currentLevel]:startLevel()
    state = "playing"
    onStateChange()
end

function startNextLevel()
    currentLevel = currentLevel + 1
    onLevelStarted()
end

function onLevelEnded(score)
    state = "ended"
    onStateChange()
    levels[currentLevel]:endLevel()
    lastScore = score
    if score > highScore[currentLevel] then
        highScore[currentLevel] = score
        saveLocalData("highscore_"..currentLevel, highScore[currentLevel])
    end
end

function onStateChange()
    if state == "loaded" then
        playButton:reset()
        mainLevelSelectButton:reset()
    elseif state == "ended" then
        nextButton:reset()
        restartButton:reset()
        levelSelectButton:reset()
    elseif state == "intro" then
        startLevelButton:reset()
    elseif state == "level_select" then
        for i,lb in pairs(levelButtons) do
            lb:reset();
        end
    end
end

function showLevelSelect()
    state = "level_select"
    onStateChange()
    levelButtons = {}
    for i,l in pairs(levels) do
        levelButtons[i] = Button{
            text = "level "..i,
            size = 30,
            x = (WIDTH / 3) * ((i - 1) % 3) + WIDTH / 6,
            y = (HEIGHT - 400) - (100 * (math.floor((i - 1) / 3))),
            align = "center",
            onTouchEnded = function()
                currentLevel = i
                onLevelStarted()
            end,
            strokeWidth = 0,
            backgroundColor = buttonBackgroundColor,
            backgroundHighlightColor = buttonBackgroundHighlightColor,
            delay = 0
        }
    end
end