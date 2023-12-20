Star = Class{}

function Star:new(x, y)
    local star = setmetatable({}, self)
    
    star.active = true
    star.x = x or math.random(0, WINDOW_WIDTH)
    star.y = y or STAR_INITIAL_Y
    star.width = 1
    star.height = 1
    star.color = COLOR_WHITE
    star.speed = STAR_SPEED
    
    return star
end

function Star:draw()
    if self.active then
        g.setColor(self.color)
        g.points({ self.x, self.y })
    end
end

function Star:update(dt)
    if self.active then
        self.y = self.y + (dt * self.speed)
        if self.y > WINDOW_HEIGHT then
            self.active = false
        end
    end
end

function Star:isActive()
    return self.active
end