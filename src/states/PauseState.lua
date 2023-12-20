PauseState = Class{__includes = BaseState}

function PauseState:init()
end

function PauseState:update(dt)
end

function PauseState:draw(dt)
    g.print("PAUSE", 100, 150)
end