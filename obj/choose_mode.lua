local chooseMode = require('obj/Main_menu'):extend()

function chooseMode:new()
	list = {{'One Player', 'One Player'}, {'Two Players', 'Two Players'}, {'Back', 'main menu'}}
	for i=1, #list do
		table.insert(list[i], w/10) --x
		table.insert(list[i], h/2 + (i-1)*(h/20)) --y
		table.insert(list[i], h/30)      --font
	end
	chooseMode:add(list)
end

function chooseMode:update(dt)
	chooseMode:handling()
end

function chooseMode:draw()
	love.graphics.setBackgroundColor(0.5, 0.2, 0.8)
	--Main_menu:drawLogo()
	chooseMode:drawList()
end

return chooseMode	