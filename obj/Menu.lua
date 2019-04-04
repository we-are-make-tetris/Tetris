local Menu = Object:extend()
local Main_menu = require('obj/Main_menu')
local optionMenu= require('obj/Options')
local startGame = require('obj/Game')

local OverFont = love.graphics.newFont('fonts/GameOver.otf', h/30)


function Menu:new()
	changeMenu('mainMenu')
	Main_menu:add('New game')
	Main_menu:add('Options')
	Main_menu:add('Records')
	Main_menu:add('Exit')
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
	if menuType == 'mainMenu' then
		current_menu = Main_menu()
	elseif menuType == 'Options' then
		current_menu = optionMenu
	elseif menuType == 'Records' then

	elseif menuType == 'Exit' then
		os.exit()
	end
end

return Menu