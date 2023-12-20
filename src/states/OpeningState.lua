OpeningState = Class{__includes = BaseState}

function OpeningState:init()
end

function OpeningState:update(dt)
end

function OpeningState:draw(dt)
    g.print("Playing Opening Cutscene", 100, 150)
end