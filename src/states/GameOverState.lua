GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:update(dt)
end

function GameOverState:draw(dt)
    g.print("GAME OVER", 100, 150)
end