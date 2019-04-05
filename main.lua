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

	timer = Timer()
	input = Input()
	input:bind('return', 'click')
	input:bind('down', 'down')
	input:bind('up', 'up')
	input:bind('left', 'left')
	input:bind('right', 'right')
	input:bind('escape', 'esc')
	input:bind('space', 'space')


	timer:after(0.01, function() gotoRoom('Menu') end)
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
	elseif room == 'New game' then currentRoom = Game() end
end