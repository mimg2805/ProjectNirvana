Enemy = Class{}

function Enemy:new()
    local enemy = setmetatable({}, self)

    enemy.sprite = g.newImage('assets/enemy.png')
    enemy.width = enemy.sprite:getWidth()
    enemy.height = enemy.sprite:getHeight()

    enemy.active = true
    enemy.direction = math.random() < 0.5 and 'left' or 'right'
    enemy.x = enemy.direction == 'left' and WINDOW_WIDTH + 10 or -20 -- math.random(enemy.width, WINDOW_WIDTH - enemy.width)
    enemy.collisionActive = false
    enemy.y = ENEMY_INITIAL_Y
    enemy.speed = ENEMY_SPEED

    enemy.health = math.random(4)

    return enemy
end

function Enemy:draw(dt)
    if self.active then
        if (self.health == 1) then
            self.color = COLOR_RED
        elseif (self.health == 2) then
            self.color = COLOR_BLUE
        elseif (self.health == 3) then
            self.color = COLOR_GREEN
        elseif (self.health == 4) then
            self.color = COLOR_YELLOW
        end

        g.setColor(self.color)
        g.draw(self.sprite, self.x, self.y)
        g.setColor(COLOR_WHITE)
    end
end

function Enemy:update(dt)
    self.active = self.health > 0
    self:move(dt)
end

function Enemy:move(dt)
    if self.direction == 'left' then
        self.x = self.x - (dt * self.speed)
    else
        self.x = self.x + (dt * self.speed)
    end
    --print(self.direction)
    --print(self.x)
    self:collision(dt)
end

function Enemy:collision(dt)
    if (self.x >= 0 and self.x <= WINDOW_WIDTH) then
        self.collisionActive = true
    end

    if (self.collisionActive) then
        if self.x <= 0 then
            self.x = 0
            self.direction = 'right'
        elseif self.x >= WINDOW_WIDTH - self.width then
            self.x = WINDOW_WIDTH - self.width
            self.direction = 'left'
        elseif self.y < 0 then
            self.y = 0
        elseif self.y > WINDOW_HEIGHT - self.height then
            self.y = WINDOW_HEIGHT - self.height
        end
    end
end

function Enemy:checkBullet(bullet)
    local res = false
    if (bullet.x >= self.x and bullet.x <= self.x + self.width and bullet.y >= self.y and bullet.y <= self.y + self.height) then
        self.health = self.health - 1
        bullet.active = false
        res = true
    end

    return res
end

function Enemy:fire(dt)
end

function Enemy:isActive()
    return self.active
end