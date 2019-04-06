local Options = require('obj/Father of menu'):extend()

function Options:new()
	Options:add()
	Options:addSwitcher({
		{'Fullscreen :', {'No', 'Yes'}, w/10, h/2, h/30},
		
		--{'Control :', {'ho', 'oh', 'lol'}, w/10, h/2 + h/20, h/30}
	})
	Options:addLink({ 
		{'Save', 'Save', w/10, h/2 + (h/20)*3, h/30},
		{'Back', 'main menu', w/10, h/2 + (h/20) * 4, h/30} })
end

function Options:update(dt)
	Options:handling()	
end

function Options:draw()
	love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
	Options:drawList()
end

function checkUpdates()
	for i=1, #List do
		if List[i].type == 'switcher' then
			
			if List[i].sign == 'Fullscreen :' then
				if List[i].choose_list[List[i].focus].sign == 'Yes' then
					fullscreen = true
				else
					fullscreen = false
				end
				love.window.setFullscreen(fullscreen)
			end
		end
	end
end

return Options