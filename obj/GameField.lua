local GameField = object:extend()
function GameField:new()
	-- body
end
function GameField:update(dt)

end
function GameField:draw()
	love.graphics.rectangle('line', 50, 50, 350, 600)
end
return GameField