local Options = Object:extend()
local font = love.graphics.newFont('src/fonts/sfont.ttf')
local diffPos = {
	{x = 100, y = 188},
	{x = 125, y = 188},
	{x = 150, y = 188},
	{x = 175, y = 188},
	{x = 200, y = 188},
	{x = 225, y = 188},
	{x = 250, y = 188},
	{x = 275, y = 188},
	{x = 300, y = 188},
	{x = 325, y = 188},
	{x = 350, y = 188}
}
local polzun = {
	w = 4,
	h = 24,
	x = diffPos[DIFFICULTY].x,
	y = diffPos[DIFFICULTY].y,	
}
function Options:new()

end
function Options:update(dt)
	if input:pressed('esc') then
		changeMenu('mainMenu')
	end
	if input:pressed('up') then
		DIFFICULTY = math.min(DIFFICULTY + 1, 11)
		polzun.x, polzun.y = diffPos[DIFFICULTY].x, diffPos[DIFFICULTY].y
	end
	if input:pressed('down') then
		DIFFICULTY = math.max(DIFFICULTY - 1, 1)
		polzun.x, polzun.y = diffPos[DIFFICULTY].x, diffPos[DIFFICULTY].y
	end
end
function Options:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.setFont(font, 30)
	love.graphics.print('Press  Esc  to back')
	love.graphics.setFont(font, 60)
	love.graphics.print('Difficulty:', 100, 150)
	love.graphics.print(tostring(DIFFICULTY), 150, 150)
	love.graphics.setColor(1, 1, 1)	
	love.graphics.rectangle('fill', 100, 200, 250, 2)

	love.graphics.rectangle('fill', 100-1, 190, 3, 22)
	love.graphics.rectangle('fill', 225-1, 190, 3, 22)
	love.graphics.rectangle('fill', 350-1, 190, 3, 22)
	for _,v in pairs(diffPos) do
		love.graphics.rectangle('fill', v.x, v.y + 7, 1, 10)
	end

	love.graphics.rectangle('fill', polzun.x-2, polzun.y, 4, 24)

end

return Options