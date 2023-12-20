--[[
    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StateStack = Class{}

function StateStack:init()
    self.states = {}
end

function StateStack:update(dt)
    self.states[#self.states]:update(dt)
end

function StateStack:draw()
    --for i, state in ipairs(self.states) do
    --    state:draw()
    --end
    self.states[#self.states]:draw()
end

function StateStack:touchpressed(id, x, y, dx, dy, pressure)
    --for i, state in ipairs(self.states) do
    --    state:touchpressed(id, x, y, dx, dy, pressure)
    --end
    self.states[#self.states]:touchpressed(id, x, y, dx, dy, pressure)
end

function StateStack:touchreleased(id, x, y, dx, dy, pressure)
    --for i, state in ipairs(self.states) do
    --    state:touchreleased(id, x, y, dx, dy, pressure)
    --end
    self.states[#self.states]:touchreleased(id, x, y, dx, dy, pressure)
end

function StateStack:touchmoved(id, x, y, dx, dy, pressure)
    --for i, state in ipairs(self.states) do
    --    state:touchmoved(id, x, y, dx, dy, pressure)
    --end
    self.states[#self.states]:touchmoved(id, x, y, dx, dy, pressure)
end

function StateStack:processAI(params, dt)
    self.states[#self.states]:processAI(params, dt)
end

function StateStack:clear()
    self.states = {}
end

function StateStack:push(state)
    table.insert(self.states, state)
    state:enter()
end

function StateStack:pop()
    self.states[#self.states]:exit()
    table.remove(self.states)
end