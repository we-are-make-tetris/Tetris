local Exit = require('obj/Father of menu'):extend()

local WarningFont = love.graphics.newFont('fonts/GameOver.otf', h/8)
local WarningText = love.graphics.newText(WarningFont, 'Are you sure')

function Exit:new()
	Exit:add('link', {{'Yes', 'Exit Yes', w/2.6 - w/30, h/2, h/10}, {'No', 'main menu', w/2 + w/30, h/2, h/10}})
end

function Exit:update(dt)
	Exit:handling()
end

function Exit:drawWarning()
	x, y = (w-WarningText:getWidth())/2, h/4
	love.graphics.draw(WarningText, x, y)
end

function Exit:draw()
	Exit:drawWarning()
	Exit:drawList()
end

return Exit