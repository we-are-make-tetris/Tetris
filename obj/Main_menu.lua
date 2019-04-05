local Main_menu = Object:extend()
self.Game = require('obj/Game')

self.white = {1, 1, 1}

self.List = {}
self.Listh = h/2
self.Listy = h/3
self.interval = 0

self.scale = 2

self.TetrisFont = love.graphics.newFont('fonts/logo.ttf', h/10)
self.MenuFont = love.graphics.newFont('fonts/logo.ttf', h/30)
self.ScaleFont = love.graphics.newFont('fonts/logo.ttf', MenuFont:getAscent()*scale)

function Main_menu:add(name)
	interval = Listh / #List

	for i=1, #List do
		List[i].y = Listy + (i-1) * interval
		List[i].big_y = List[i].y - (ScaleFont:getAscent()-MenuFont:getAscent())/2
	end

	table.insert(List, {
		text = love.graphics.newText(MenuFont, name),
		room = name,
		y = Listy + #List*interval,
	})
	List[#List].x = (w-List[#List].text:getWidth())/2
	List[#List].big_x = (w-List[#List].text:getWidth()*scale)/2
	
	List[#List].big_y = List[#List].y - (ScaleFont:getAscent()-MenuFont:getAscent())/2

	List[#List].font = List[#List].text:getHeight()*scale
end


self.logo = {
	Logo = love.graphics.newText(TetrisFont, 'LOL Tetris from II LOL'),
	y = h/5
}
self.logo.x = (w - logo.Logo:getWidth())/2

self.focus = 1

function Main_menu:new()
	
end

function Main_menu:update(dt)
	List[focus].text:setFont(MenuFont)
	if input:pressed('click') then
		changeMenu(List[focus].room)
	end

	if input:down('down', 0.1) then
		focus = focus + 1
		if focus > #List then focus = 1 end
	end

	if input:down('up', 0.1) then
		focus = focus - 1
		if focus < 1 then focus = #List end
	end
	List[focus].text:setFont(ScaleFont)
end

function Main_menu:draw()
	love.graphics.setBackgroundColor(0.5, 0.2, 0.8)
	love.graphics.draw(logo.Logo, logo.x, logo.y) 
	love.graphics.setColor((white))
	for i=1, #List do
		if i ~= focus then love.graphics.draw(List[i].text, List[i].x, List[i].y)
		else love.graphics.draw(List[i].text, List[i].big_x, List[i].big_y) end
	end
	
end

return Main_menu	