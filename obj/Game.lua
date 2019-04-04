local Game = Object:extend()
local game_field = require('obj/gameField') 

width = 10
height = 24

function Game:new()
	GameField = game_field()
end

function Game:update(dt)
	GameField:update(dt)
end


Field = {
	y = h/10, -- 1/10 от верхнего края
	w = w/2 - w/5,
	h = (w/2 - w/5)/width*height
}
if Field.h + h/10 > h then
	Field.h = h - h/5
	Field.w = Field.h/height*width
end
First_x = w/20
Second_x = First_x + w/2 

function Game:draw()
	love.graphics.setBackgroundColor(0.6, 0.8, 0)

	GameField:draw()

	love.graphics.rectangle('line', First_x, Field.y, Field.w, Field.h) 
	love.graphics.rectangle('line', Second_x, Field.y, Field.w, Field.h)
	--love.graphics.draw(nextText, 150, 675)
end

return Game