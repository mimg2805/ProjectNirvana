Ship = Class{}

function Ship:init()
    local ship = setmetatable({}, self)

    ship.sprite = g.newImage('assets/player.png')
    ship.color = COLOR_PURPLE
    ship.width = ship.sprite:getWidth()
    ship.height = ship.sprite:getHeight()

    ship.x = WINDOW_WIDTH_HALF - (ship.width / 2)
    ship.y = SHIP_INITIAL_Y
    ship.speed = SHIP_SPEED

    return ship
end

function Ship:draw(dt)
    g.setColor(self.color)
    g.draw(self.sprite, self.x, self.y)
    g.setColor(COLOR_WHITE)
end

function Ship:update(dt)
    self:move(dt, direction)
end

function Ship:move(dt, direction)
    if direction == 'left' then
        self.x = self.x - (dt * self.speed)
    elseif direction == 'right' then
        self.x = self.x + (dt * self.speed)
    end

    self:collision(dt)
end

function Ship:collision(dt)
    if self.x < 0 then
        self.x = 0
    elseif self.x > WINDOW_WIDTH - self.width then
        self.x = WINDOW_WIDTH - self.width
    elseif self.y < 0 then
        self.y = 0
    elseif self.y > WINDOW_HEIGHT - self.height then
        self.y = WINDOW_HEIGHT - self.height
    end
end

function Ship:fire(bullets)
    local bulletX = self.x + (self.width / 2)
    table.insert(bullets, Bullet:new(bulletX, self.y))
end