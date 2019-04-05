Object = require('lib/classic/classic')
Timer = require('lib/hump/timer')
Input = require('lib/boipushy/Input')

currentRoom = nil
DIFFICULTY = 3

w = love.graphics.getWidth()
h = love.graphics.getHeight()

Menu = require('obj/Menu')
Game = require('obj/Game')

function love.load()
	gotoRoom('Menu')
	timer = Timer()
	input = Input()
	input:bind('return', 'click')
	input:bind('down', 'down')
	input:bind('up', 'up')
	input:bind('left', 'left')
	input:bind('right', 'right')
	input:bind('escape', 'esc')
	input:bind('space', 'space')
<<<<<<< HEAD
=======
	input:bind('a', 'a')
	input:bind('w', 'w')
	input:bind('s', 's')
	input:bind('d', 'd')

	timer:after(0.01, function() gotoRoom('Menu') end)
>>>>>>> 09a9f91cddb8aafc46858ef77021da60f3ae76c7
end

function love.update(dt)
	timer:update(dt)
	if currentRoom then
		currentRoom:update(dt)
	end
end

function love.draw()
	if currentRoom then
		currentRoom:draw()	
	end
end
function gotoRoom(room)
	if room == 'Menu' then currentRoom = Menu()
	elseif room == 'One Player' then currentRoom = Game() end
end