local Boo = Object:extend()

function Boo:add(list)
	List = {}
	for _, obj in pairs(list) do
		name, roomname, x, y, font = obj[1], obj[2], obj[3], obj[4], obj[5]
		interval = Listh / #list
		MenuFont = love.graphics.newFont('fonts/logo.ttf', font)
		ScaleFont = love.graphics.newFont('fonts/logo.ttf', font*scale)
		table.insert(List, {
			text = love.graphics.newText(MenuFont, name),
			scaletext = love.graphics.newText(ScaleFont, name),
			room = roomname,
			y = y,
			x = x,
			font = font
		})
		List[#List].big_x = x - (List[#List].scaletext:getWidth()-List[#List].text:getWidth())/2
		
		List[#List].big_y = y - (List[#List].scaletext:getHeight()-List[#List].text:getHeight())/2

	end
end
--У вас титаник, незаконная музыка и...(пауза) Поворот!
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

function Boo:new()
	white = {1, 1, 1}

	Listh = h/2
	Listy = h/3
	interval = 0

	scale = 1.5

	focus = 1
end

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

function Boo:handling()
	if input:pressed('click') then changeMenu(List[focus].room) end
	if input:down('down', 0.1, 0.2) or input:down('left', 0.1, 0.2) then
		focus = focus + 1
		if focus > #List then focus = 1 end
	end

	if input:down('up', 0.1, 0.2) or input:down('right', 0.1, 0.2) then
		focus = focus - 1
		if focus < 1 then focus = #List end
	end
end

function Boo:drawList()
	love.graphics.setColor((white))
	for i=1, #List do
		if i ~= focus then love.graphics.draw(List[i].text, List[i].x, List[i].y)
		else love.graphics.draw(List[i].scaletext, List[i].big_x, List[i].big_y) end
	end
end

return Boo