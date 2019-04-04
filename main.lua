object = require('lib/classic/classic')
Timer = require('lib/hump/timer')
Input = require('lib/boipushy/Input')
Room = require('obj/Room')

currentRoom = nil
DIFFICULTY = 3

default_color = {1, 1, 1}

function love.load()
	timer = Timer()
	input = Input()



	input:bind('return', 'click')
	input:bind('down', 'down')
	input:bind('up', 'up')
	input:bind('left', 'down')
	input:bind('right', 'up')
	input:bind('escape', 'esc')
end
function love.update(dt)
	timer:update(dt)
	if currentRoom then
		currentRoom:update(dt)
	end
end
function love.draw()
	love.graphics.setBackgroundColor(0.5, 0.2, 0.8)
	if currentRoom then
		currentRoom:draw()
	end
end
function gotoRoom(room_type, ...)
	if room_type == 'game' then
		currentRoom = Game(...)
	end
	if room_type == 'menu' then
		currentRoom = Menu(...)
	end
end