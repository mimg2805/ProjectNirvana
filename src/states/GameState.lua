GameState = Class{__includes = BaseState}

function GameState:init()
    ship = Ship:init()

    moveLeftBtn = Button:new()
    moveLeftBtn:setSize(SMALL_BUTTON_WIDTH, BUTTON_HEIGHT)
    moveLeftBtn:setPosition(40, WINDOW_HEIGHT - 60)
    moveLeftBtn:setColor(COLOR_GREEN)
    moveLeftBtn:setText("<-", COLOR_BLACK)

    moveRightBtn = Button:new()
    moveRightBtn:setSize(SMALL_BUTTON_WIDTH, BUTTON_HEIGHT)
    moveRightBtn:setPosition(90, WINDOW_HEIGHT - 60)
    moveRightBtn:setColor(COLOR_GREEN)
    moveRightBtn:setText("->", COLOR_BLACK)

    fireBtn = Button:new()
    fireBtn:setSize(100, 50)
    fireBtn:setPosition(WINDOW_WIDTH_HALF + 60, WINDOW_HEIGHT - 60)
    fireBtn:setColor(COLOR_RED)
    fireBtn:setText("FIRE", COLOR_BLACK)

    stars = {}
    for s = 1, WINDOW_HEIGHT do
        table.insert(stars, Star:new(nil, s))
    end
    starSpawnTime = STAR_SPAWN_DELAY
    
    bullets = {}
    shipCanFire = true

    enemies = {}
    enemyLimit = 1
    enemySpawnTime = 0 --ENEMY_SPAWN_DELAY

    explosions = {}

    fireBtn.exec = function()
        if (shipCanFire) then
            ship:fire(bullets)
            shipCanFire = false
        end
    end
end

function GameState:update(dt)
    ship:update(dt)

    self:removeInactiveStars()
    self:removeInactiveBullets()
    self:removeInactiveEnemies()
    self:removeInactiveExplosions()

    self:spawnStars(dt)
    self:spawnEnemies(dt)

    self:updateStars(dt)
    self:updateEnemies(dt)
    self:updateBullets(dt)
    self:updateExplosions(dt)

    -- Only fire once per click
    if (not fireBtn:isClicked()) then
        shipCanFire = true
    end

    --Move ship left
    moveLeftBtn.exec = function()
        ship:move(dt, 'left')
    end

    --Move ship right
    moveRightBtn.exec = function()
        ship:move(dt, 'right')
    end
    
    -- Multitouch (Button Manager?)
    local touches = t.getTouches()
    local touch = #touches > 0
    if touch then
        for ti = 0, #touches do
            if touches[ti] ~= nil then
                local touchX, touchY = t.getPosition(touches[ti])
                touchX = touchX / scaleX
                touchY = touchY / scaleY
                
                -- Check each button
                moveLeftBtn:checkClick(touchX, touchY)
                moveRightBtn:checkClick(touchX, touchY)
                fireBtn:checkClick(touchX, touchY)
            end
        end
    end
end

function GameState:draw()
    ship:draw()

    for e, enemy in ipairs(enemies) do
        enemy:draw()
    end
    
    for b, bullet in ipairs(bullets) do
        bullet:draw()
    end
    
    for s, star in ipairs(stars) do
        star:draw()
    end

    for e, explosion in ipairs(explosions) do
        explosion:draw()
    end

    moveLeftBtn:draw()
    moveRightBtn:draw()
    fireBtn:draw()
end

function GameState:touchpressed(id, x, y, dx, dy, pressure)
    --moveLeftBtn:touchpressed(id, x, y, dx, dy, pressure)
    --moveRightBtn:touchpressed(id, x, y, dx, dy, pressure)
    --fireBtn:touchpressed(id, x, y, dx, dy, pressure)
end

function GameState:touchreleased(id, x, y, dx, dy, pressure) end

function GameState:spawnStars(dt)
    --starSpawnTime = starSpawnTime + dt
    --if (starSpawnTime >= STAR_SPAWN_DELAY) then
        table.insert(stars, Star:new())
        --starSpawnTime = 0
    --end
end

function GameState:spawnEnemies(dt)
    if (#enemies < enemyLimit) then
        enemySpawnTime = enemySpawnTime + dt
        if (enemySpawnTime >= ENEMY_SPAWN_DELAY) then
            --newEnemy = Enemy:new()
            table.insert(enemies, Enemy:new())
            enemySpawnTime = 0
        end
    end
end

function GameState:updateStars(dt)
    for s, star in ipairs(stars) do
        star:update(dt)
    end
end

function GameState:updateEnemies(dt)
    for e, enemy in ipairs(enemies) do
        enemy:update(dt)
        for b, bullet in ipairs(bullets) do
            if enemy:checkBullet(bullet) then
                table.insert(explosions, Explosion:new(bullet.x, bullet.y, enemy.color))
            end
        end
    end
end

function GameState:updateBullets(dt)
    for b, bullet in ipairs(bullets) do
        bullet:update(dt)
    end
end

function GameState:updateExplosions(dt)
    for e, explosion in ipairs(explosions) do
        explosion:update(dt)
    end
end

function GameState:removeInactiveStars()
    for s = #stars, 1, -1 do
        if not stars[s]:isActive() then
            table.remove(stars, s)
        end
    end
end

function GameState:removeInactiveBullets()
    for b = #bullets, 1, -1 do
        if not bullets[b]:isActive() then
            table.remove(bullets, b)
        end
    end
end

function GameState:removeInactiveEnemies()
    for e = #enemies, 1, -1 do
        if not enemies[e]:isActive() then
            table.remove(enemies, e)
        end
    end
end

function GameState:removeInactiveExplosions()
    for x = #explosions, 1, -1 do
        if not explosions[x]:isActive() then
            table.remove(explosions, x)
        end
    end
end