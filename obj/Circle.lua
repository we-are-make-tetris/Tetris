local gameobject = require('obj/GameObject')
local Circle = gameobject:extend()
function Circle:new(area, x, y, opts)
	Circle.super.new(area, x, y, opts)
end
function Circle:update(dt)
	-- nothing here, because circle is very stable thing so it can't just update or something kinda that.
end
function Circle:draw()
	love.graphics.setColor(self.color)
	love.graphics.circle(self.mode, self.x, self.y, self.r)
	love.graphics.setColor(default_color)
end