Explosion = Class{}

function Explosion:new(x, y, color)
    local explosion = setmetatable({}, self)

    explosion.active = true
    explosion.originX = x
    explosion.originY = y
    explosion.speed = 60
    
    explosion.pointSize = 4
    explosion.pointColor = color or COLOR_RED
    explosion.pointAlpha = 1
    explosion.points = {
    	{ x - 1, y - 1, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha },
        { x, y - 1, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha },
        { x + 1, y - 1, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha },
        { x - 1, y, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha },
        { x + 1, y, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha },
        { x - 1, y + 1, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha },
        { x, y + 1, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha },
        { x + 1, y + 1, explosion.pointColor[1], explosion.pointColor[2], explosion.pointColor[3], explosion.pointAlpha }
    }

    return explosion
end

function Explosion:draw()
    if self.active then
        g.setColor(self.pointColor)
        g.setPointSize(self.pointSize)
        g.points(self.points)
        g.setPointSize(1)
    end
end

function Explosion:update(dt)
    if self.pointAlpha <= 0 then
        self.active = false
    end
    
    if self.active then
        self.points[1][1] = self.points[1][1] - dt * self.speed
        self.points[1][2] = self.points[1][2] - dt * self.speed
        self.points[2][2] = self.points[2][2] - dt * self.speed
        self.points[3][1] = self.points[3][1] + dt * self.speed
        self.points[3][2] = self.points[3][2] - dt * self.speed
        self.points[4][1] = self.points[4][1] - dt * self.speed
        self.points[5][1] = self.points[5][1] + dt * self.speed
        self.points[6][1] = self.points[6][1] - dt * self.speed
        self.points[6][2] = self.points[6][2] + dt * self.speed
        self.points[7][2] = self.points[7][2] + dt * self.speed
        self.points[8][1] = self.points[8][1] + dt * self.speed
        self.points[8][2] = self.points[8][2] + dt * self.speed

        self.pointAlpha = self.pointAlpha - dt
        for i = 1, 8 do
            self.points[i][6] = self.pointAlpha
        end
    end
end

function Explosion:isActive()
    return self.active
end
