Bullet = Class{}

function Bullet:new(x, y)
    local bullet = setmetatable({}, self)

    bullet.active = true
    bullet.color = {0.4, 0.4, 1}
    bullet.speed = BULLET_SPEED
    bullet.width = 2
    bullet.height = 4
    
    bullet.x = x - (bullet.width / 2)
    bullet.y = y
    
    return bullet
end

function Bullet:draw()
    if self.active then
        g.setColor(self.color)
        g.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end

function Bullet:update(dt)
    if self.active then
        self.y = self.y - (dt * self.speed)
        if self.y < 0 then
            self.active = false
        end
    end
end

function Bullet:isActive()
    return self.active
end