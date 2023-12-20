MenuState = Class{__includes = BaseState}

function MenuState:init()
    playBtn = Button:new()
    playBtn:setPosition(MENU_BUTTON_X, 100)
    playBtn:setColor(COLOR_GREEN)
    playBtn:setText("JUGAR", COLOR_BLACK)
    playBtn.exec = function()
        gStateStack:push(GameState())
    end
    
    optionsBtn = Button:new()
    optionsBtn:setPosition(MENU_BUTTON_X, 200)
    optionsBtn:setColor(COLOR_BLUE)
    optionsBtn:setText("OPCIONES", COLOR_BLACK)
    optionsBtn.exec = function()
        --gStateStack:push(GameState())
    end
    
    exitBtn = Button:new()
    exitBtn:setPosition(MENU_BUTTON_X, 300)
    exitBtn:setColor(COLOR_RED)
    exitBtn:setText("SALIR", COLOR_BLACK)
    exitBtn.exec = function()
        love.event.quit()
    end
end

function MenuState:update(dt)
    playBtn:checkClick()
    optionsBtn:checkClick()
    exitBtn:checkClick()
end

function MenuState:draw(dt)
    playBtn:draw()
    optionsBtn:draw()
    exitBtn:draw()
end

function MenuState:touchpressed(id, x, y, dx, dy, pressure)
    --playBtn:touchpressed(id, x, y, dx, dy, pressure)
    --optionsBtn:touchpressed(id, x, y, dx, dy, pressure)
    --exitBtn:touchpressed(id, x, y, dx, dy, pressure)
end

function MenuState:touchreleased(id, x, y, dx, dy, pressure) end