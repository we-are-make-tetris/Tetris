local Options = require('obj/Father of menu'):extend()

function Options:new()
	Options:add('switcher', {
		{'Fullscreen :', {'on', 'off', 'boff', 'no', 'yes'}, w/10, h/2, h/30},
		{'Control :', {'ho', 'oh', 'lol'}, w/10, h/2 + h/20, h/30}
	})
end

function Options:update(dt)
	Options:handling()	
end

function Options:draw()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
	Options:drawList()
end

return Options