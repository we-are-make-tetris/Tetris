local Room = require('obj/Room')

local Menu = Room:extend()

function Menu:new(color)
	Menu.super.new(color)
end

function Menu:update(dt)
	Menu.super.update(dt)
end

function Menu:draw()
	Menu.super.draw()
end