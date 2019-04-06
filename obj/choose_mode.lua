local chooseMode = require('obj/Main_menu'):extend()

function chooseMode:new()
	list = {{'One Player', 'One Player'}, {'Two Players', 'Two Players'}, {'Back', 'main menu'}}
	for i=1, #list do
		table.insert(list[i], w/10) --x
		table.insert(list[i], h/2 + (i-1)*(h/20)) --y
		table.insert(list[i], h/30)      --font
	end
	list[3][4] = list[3][4] + h/20
	chooseMode:add(list)

	Logo = love.graphics.newText(TetrisFont, 'Choose mode')
end

function chooseMode:update(dt)
	chooseMode:handling()
end

function chooseMode:drawLogo()
	love.graphics.draw(Logo, (w - Logo:getWidth())/2, h/5)
end

function chooseMode:draw()
	love.graphics.setBackgroundColor(0.5, 0.2, 0.8)
	chooseMode:drawLogo()
	chooseMode:drawList()
end

return chooseMode	