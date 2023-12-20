Class = require 'lib/class'

require 'constants'
require 'colors'

require 'src/states/BaseState'
require 'src/states/StateStack'
require 'src/states/OpeningState'
require 'src/states/MenuState'
require 'src/states/GameState'
require 'src/states/PauseState'
require 'src/states/GameOverState'

require 'src/Bullet'
require 'src/Button'
require 'src/Enemy'
require 'src/Explosion'
require 'src/Ship'
require 'src/Star'

g = love.graphics
e = love.event
m = love.mouse
t = love.touch
s = love.system
debug = true

scaleX = 1
scaleY = 1

function love.load(arg)
    gStateStack = StateStack()
    gStateStack:clear()
    --gStateStack:push(MenuState())
    gStateStack:push(GameState())
end

function love.update(dt)
    gStateStack:update(dt)
end

function love.draw(dt)
    local width, height = love.graphics.getDimensions()
    scaleX, scaleY = width / WINDOW_WIDTH, height / WINDOW_HEIGHT
    g.scale(scaleX, scaleY)

    gStateStack:draw()
end

function love.keypressed(key, scancode, isrepeat)
    --print('key:', key)
    if key == "escape" then
        love.event.quit()
    end
    --print('state:', state)
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    gStateStack:touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    gStateStack:touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    gStateStack:touchmoved(id, x, y, dx, dy, pressure)
end