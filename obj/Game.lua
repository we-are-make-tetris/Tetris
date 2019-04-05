local Game = Object:extend()
local game_field = require('obj/gameField')
local game_field1= require('obj/gameField') 

width = 11
height = 24

function Game:new()
	GameField1 = game_field('right', Second_x, Field.y, Field.w, Field.h, width, height)
	GameField2 = game_field1('left', First_x, Field.y, Field.w, Field.h, width, height)
end

function Game:update(dt)
	GameField1:update(dt)
	GameField2:update(dt)
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

	GameField1:draw()
	GameField2:draw()

	--love.graphics.draw(nextText, 150, 675)
end

return Game