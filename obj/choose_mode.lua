Main_menu = require('obj/Main_menu')
local chooseMode = Main_menu:extend()

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

return chooseMode	