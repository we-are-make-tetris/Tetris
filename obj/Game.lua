local Game = Object:extend()
--local game_field1= require('obj/gameField') 


local OverFont = love.graphics.newFont('fonts/GameOver.otf', h/20)
local ComboFont = love.graphics.newFont('fonts/logo.ttf', h/10)
local nextFont = love.graphics.newFont('fonts/logo.ttf', h/30)

game_over_splash_screen = {
	bg_color = {0, 0, 0, 0},
	censore = {false, {0, 0, 0, 1}},
	text = love.graphics.newText(OverFont, 'Вас Морально Унизили'),
	text_draw = false,
	game_over = false
}

types = {
	'left_zed', 'right_zed', 'T', 'cube', 'left_ugol', 'right_ugol', 'palka'
}
figures = {
	left_zed = {
		{{2,1},{2,2},{1,2},{1,3}}, -- Up
		{{1,1},{2,1},{2,2},{3,2}} -- Left
	},
	right_zed = {
		{{1,1},{1,2},{2,2},{2,3}}, -- Up
		{{2,1},{1,2},{3,1},{2,2}} -- Left
	},
	T = {
		{{2,1},{1,2},{2,2},{2,3}},  --left
		{{2,1},{1,2},{3,2},{2,2}}, --down
		{{2,1},{2,2},{3,2},{2,3}}, --right
		{{1,1},{2,1},{3,1},{2,2}} --up
	},
	cube = {
		{{1,1},{1,2},{2,1},{2,2}}
	},
	left_ugol = {
		{{3,1},{1,2},{2,2},{3,2}},
		{{2,1},{2,2},{2,3},{3,3}},
		{{2,2},{1,2},{3,2},{1,3}},
		{{1,1},{2,1},{2,2},{2,3}}
	},
	right_ugol = {
		{{1,2},{2,2},{3,2},{3,3}},
		{{2,1},{1,3},{2,2},{2,3}},
		{{1,1},{1,2},{2,2},{3,2}},
		{{3,1},{2,1},{2,2},{2,3}}
	},
	palka = {
		{{2,1},{2,3},{2,2},{2,4}},
		{{1,3},{2,3},{3,3},{4,3}}
	}
}

NEXT_TEXT = love.graphics.newText(nextFont, 'Next')

COLORS = {
	{1, 1, 1, 1},
	{0, 0, 0, 1},
	{1, 0, 0, 1},
	{0, 1, 0, 1},
	{0, 0, 1, 1},
	{1, 1, 0, 1},
	{1, 0.4, 0.05, 1},
	{1, 0.5, 1, 1}
}

width = 11
height = 24

function Game:new(player_count)
	local game_field = require('obj/gameField')
	game_over_splash_screen = {
		bg_color = {0, 0, 0, 0},
		censore = {false, {0, 0, 0, 1}},
		text = love.graphics.newText(OverFont, 'Вас Морально Унизили'),
		text_draw = false,
		game_over = false
	}
	if player_count == 1 then
		GameField1 = game_field('right', Second_x, Field.y, Field.w, Field.h, width, height)
	elseif player_count == 2 then
		GameField1 = game_field('left', First_x, Field.y, Field.w, Field.h, width, height)
		GameField2 = game_field('right', Second_x, Field.y, Field.w, Field.h, width, height)
	end
end

function Game:update(dt)
	GameField1:update(dt)
	if GameField2 then GameField2:update(dt) end
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
	if GameField2 then GameField2:draw() end

	--love.graphics.draw(nextText, 150, 675)
end

return Game