Button = Class{}

function Button:new()
    local btn = setmetatable({}, self)
    
    btn.width = BUTTON_WIDTH
    btn.height = BUTTON_HEIGHT
    btn.x = MENU_BUTTON_X
    btn.rx = 5
    btn.ry = 5
    
	return btn
end

function Button:setPosition(x, y)
    self.x = x or 0
    self.y = y or 0
end

function Button:setSize(width, height)
    self.width = width or BUTTON_WIDTH
    self.height = height or BUTTON_HEIGHT
end

function Button:setText(text, color)
    self.text = g.newText(g.getFont(), {color, text})
    local textWidth = self.text:getWidth()
    local textHeight = self.text:getHeight()
    self.textX = self.x + (self.width / 2) - (textWidth / 2)
    self.textY = self.y + (self.height / 2) - (textHeight / 2)
end

function Button:setColor(color)
    self.color = color or COLOR_WHITE
end

function Button:draw()
    g.setColor(self.color)
    g.rectangle("fill", self.x, self.y, self.width, self.height, self.rx, self.ry)
    g.setColor(COLOR_WHITE)
    if self.text ~= nil then
        g.draw(self.text, self.textX, self.textY)
    end

    if self:isClicked() then
        g.setColor(COLOR_WHITE)
        g.rectangle("line", self.x, self.y, self.width, self.height, self.rx, self.ry)
    end
end

function Button:exec()
end

function Button:isClicked()
    local touches = t.getTouches()
    local touch = #touches > 0
    local touchX, touchY
    if touch then
        touchX, touchY = t.getPosition(touches[#touches])
        touchX = touchX / scaleX
        touchY = touchY / scaleY
    end
    return touch and (touchX > self.x and touchX < self.x + self.width) and (touchY > self.y and touchY < self.y + self.height)
end

function Button:checkClick(touchX, touchY)
    if touchX == nil and touchY == nil then
	    if self:isClicked() then
	        self:exec()
	    end
	elseif (touchX > self.x and touchX < self.x + self.width) and (touchY > self.y and touchY < self.y + self.height) then
        self:exec()
    end
end

--[[
function Button:touchpressed(id, x, y, dx, dy, pressure)
    print(id)
    x = x * scaleX
    y = y * scaleY
    if (x > self.x and x < self.x + self.width) and (y > self.y and y < self.y + self.height) then
        g.setColor(COLOR_WHITE)
        g.rectangle("line", self.x, self.y, self.width, self.height, self.rx, self.ry)
        self:exec()
    end
end

function Button:touchreleased(id, x, y, dx, dy, pressure) end
]]--