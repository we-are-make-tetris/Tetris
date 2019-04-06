local Options = require('obj/Father of menu'):extend()

function Options:new()
	
end

function Options:update(dt)
	
end
function Options:draw()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
	Options:drawLogo(Logo)
end

return Options