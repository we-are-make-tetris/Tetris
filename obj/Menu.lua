local Menu = Object:extend()
local main_menu = require('obj/Main_menu')
local choose_mode = require('obj/choose_mode')
local options_menu = require('obj/Options')
local Boo = require('obj/Father of menu')
local exit = require('obj/Exit')

--local OverFont = love.graphics.newFont('fonts/GameOver.otf', h/30)


function Menu:new()
	Boo()
	changeMenu('main menu')
end

function Menu:update(dt)
	if current_menu then
		current_menu:update(dt)
	end
end

function Menu:draw()
	if current_menu then
		current_menu:draw()
	end
end

function changeMenu(menuType)
	if menuType == 'main menu' then
		current_menu = main_menu()
	
	elseif menuType == 'New Game' then
		current_menu = choose_mode()
	
	elseif menuType == 'Options' then
		current_menu = options_menu()
	
	elseif menuType == 'Records' then


	elseif menuType == 'One Player' then
		gotoRoom('One Player')

	elseif menuType == 'Two Players' then
		gotoRoom('Two Players')

	elseif menuType == 'Exit' then
		current_menu = exit()
	
	elseif menuType == 'Exit Yes' then
		os.exit()
	
	elseif menuType == 'Save' then
		checkUpdates()
	end
end

return Menu