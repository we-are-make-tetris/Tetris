local Boo = Object:extend()

function Boo:add(typef, list)
	if typef == 'link' then Boo:addLink(list)
	elseif typef == 'switcher' then Boo:addSwitcher(list) end
end

function Boo:addLink(list)
	List = {}
	for _, obj in pairs(list) do
		name, roomname, x, y, font = obj[1], obj[2], obj[3], obj[4], obj[5]
		
		MenuFont = love.graphics.newFont('fonts/logo.ttf', font)
		ScaleFont = love.graphics.newFont('fonts/logo.ttf', font*scale)
		TetrisFont = love.graphics.newFont('fonts/logo.ttf', h/10)
		table.insert(List, {
			text = love.graphics.newText(MenuFont, name),
			scaletext = love.graphics.newText(ScaleFont, name),
			room = roomname,
			type = 'link',
			y = y,
			x = x,
			font = font
		})
		List[#List].big_x = x - (List[#List].scaletext:getWidth()-List[#List].text:getWidth())/2
		
		List[#List].big_y = y - (List[#List].scaletext:getHeight()-List[#List].text:getHeight())/2

	end
end

function Boo:addSwitcher(list)
	List = {}
	for _, obj in pairs(list) do
		name, choose_list, x, y, font = obj[1], obj[2], obj[3], obj[4], obj[5]
		MenuFont = love.graphics.newFont('fonts/logo.ttf', font)
		ScaleFont = love.graphics.newFont('fonts/logo.ttf', font*scale)
		TetrisFont = love.graphics.newFont('fonts/logo.ttf', h/10)
		table.insert(List, {
			text = love.graphics.newText(MenuFont, name),
			choose_list = {},
			type = 'switcher',
			focus = 1,
			y = y,
			x = x,
			font = font
		})
		for i=1, #choose_list do
			table.insert(List.choose_list, {choose_list[i], love.graphics.newText(ScaleFont, List.choose_list[i])})
		end

		List[#List].big_x = x - (List[#List].scaletext:getWidth()-List[#List].text:getWidth())/2
		
		List[#List].big_y = y - (List[#List].scaletext:getHeight()-List[#List].text:getHeight())/2

	end
end

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
	if input:pressed('esc') then changeMenu('main menu') end
	
	if input:down('down', 0.1, 0.2) then
		focus = focus + 1
	elseif input:down('up', 0.1, 0.2) then
		focus = focus - 1
	end

	if focus > #List then focus = 1
	elseif focus < 1 then focus = #List end

	if List[focus].type == 'link' then
		if input:pressed('click') then changeMenu(List[focus].room) end
	elseif List[focus].type == 'switcher' then
		if input:pressed('right') then
			List[focus].focus = List[focus].focus + 1
			if List[focus].focus > #List[List[focus].focus].choose_list then List[focus].focus = 1 end
		elseif input:pressed('left') then
			List[focus].focus = List[focus].focus - 1
			if List[focus].focus < 1 then List[focus].focus = #List[List[focus].focus] end
		end

	end
end

function Boo:drawLogo(Logo)
	love.graphics.draw(Logo, (w - Logo:getWidth())/2, h/5)
end

function Boo:drawList()
	love.graphics.setColor((white))
	for i=1, #List do
		if i ~= focus then love.graphics.draw(List[i].text, List[i].x, List[i].y)
		else love.graphics.draw(List[i].scaletext, List[i].big_x, List[i].big_y) end
	end
end

function Boo:drawSwitcher()
	for i=1, #List[focus].choose_list do
		if i ~= List[focus].focus then love.graphics.draw(List[i].text, List[i].x, List[i].y)
		else love.graphics.draw(List[i].choose_list[List[i].focus].scaletext, List[i].big_x, List[i].big_y) end
	end
end

return Boo