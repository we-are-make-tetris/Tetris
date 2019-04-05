local Main_menu = require('obj/Father of menu'):extend()

function Main_menu:new()
	list = {{'New Game', 'New Game'}, {'Options', 'Options'}, {'Records', 'Records'}, {'Exit', 'Exit'}}
	for i=1, #list do
		table.insert(list[i], w/10) --x
		table.insert(list[i], h/2 + (i-1)*(h/20)) --y
		table.insert(list[i], h/30)      --font
	end
	Main_menu:add(list)

	TetrisFont = love.graphics.newFont('fonts/logo.ttf', h/10)
	logo = {
		Logo = love.graphics.newText(TetrisFont, 'LOL Tetris from II LOL'),
		y = h/5
	}
	logo.x = (w - logo.Logo:getWidth())/2
end

function Main_menu:update(dt)
	Main_menu:handling()
end

function Main_menu:drawLogo()
	love.graphics.draw(logo.Logo, logo.x, logo.y)
end

function Main_menu:draw()
	love.graphics.setBackgroundColor(0.5, 0.2, 0.8)
	Main_menu:drawLogo()
	Main_menu:drawList()
end	

return Main_menu	