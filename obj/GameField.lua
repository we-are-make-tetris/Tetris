local GameField = Object:extend()
local OverFont = love.graphics.newFont('fonts/GameOver.otf', h/30)
local ComboFont = love.graphics.newFont('fonts/logo.ttf', h/10)

-- это надо перенести в класс Game
game_over_splash_screen = {
	bg_color = {0, 0, 0, 0},
	text = love.graphics.newText(OverFont, 'Вы Морально Унижены'),
	text_draw = false,
	game_over = false
}


score = 0

local game_over = false
local in_game = true



types = {
	'left_zed', 'right_zed', 'T', 'cube', 'left_ugol', 'right_ugol', 'palka'
}
figures = {
	left_zed = {
		{{2,1},{2,2},{1,2},{1,3}}, -- Up
		{{1,1},{2,1},{2,2},{3,2}} -- Left
	},
	right_zed = {
		{{1,1},{1,2},{2,2},{2,3}}, -- Up
		{{2,1},{1,2},{3,1},{2,2}} -- Left
	},
	T = {
		{{2,1},{1,2},{2,2},{2,3}},  --left
		{{2,1},{1,2},{3,2},{2,2}}, --down
		{{2,1},{2,2},{3,2},{2,3}}, --right
		{{1,1},{2,1},{3,1},{2,2}} --up
	},
	cube = {
		{{1,1},{1,2},{2,1},{2,2}}
	},
	left_ugol = {
		{{3,1},{1,2},{2,2},{3,2}},
		{{2,1},{2,2},{2,3},{3,3}},
		{{2,2},{1,2},{3,2},{1,3}},
		{{1,1},{2,1},{2,2},{2,3}}
	},
	right_ugol = {
		{{1,2},{2,2},{3,2},{3,3}},
		{{2,1},{1,3},{2,2},{2,3}},
		{{1,1},{1,2},{2,2},{3,2}},
		{{3,1},{2,1},{2,2},{2,3}}
	},
	palka = {
		{{2,1},{2,3},{2,2},{2,4}},
		{{1,3},{2,3},{3,3},{4,3}}
	}
}
-- это надо перенести в класс Game

function GameField:new(player_side, x, y, w, h, width, height)
	self.player_side = player_side
	self.x, self.y, self.w, self.h = x, y, w, h -- Координаты поля, ширина и высота игрового поля
	self.width, self.height = width, height -- Количество кубиков в рядах и столбцах соответственоо

	self.edge = self.w / self.width -- длина стороны квадрата(кубика)
	self.score = 0

	self.speed = 0.3

	self.fall = 'space'
	
	if self.player_side == 'left' then
		self.left, self.right, self.rotate, self.increase = 'a', 'd', 'w', 's'
	end
	if self.player_side == 'right' then
		self.left, self.right, self.rotate, self.increase = 'left', 'right', 'up', 'down'
	end

	local grid = {}
	for i = 1, self.height do
		table.insert(grid, {})
		for j = 1, self.width do
			table.insert(grid[i], 0)
		end
	end
	self.grid = grid
	self:newFigure()
end

function GameField:draw()
	love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
	self:drawPassive()
	self:drawActive()

end

-- "омертвляет фигуру", делает пассивной.
function GameField:makePassive(t)
	t.is_active = false
	for i=1, 4 do
		self.grid[t[i][2]][t[i][1]]=1
	end
	self:Clear(t)
end


function GameField:newFigure()
	local typef = types[love.math.random(1, #types)]
	typef = 'palka'
	local pos = love.math.random(1, #figures[typef])

	self.active_brick = copy(figures[typef][pos])
	self.active_brick.pos = pos
	self.active_brick.type = typef
	self.active_brick.is_active = true

	game_over_check(self, self.active_brick)

	if not game_over_splash_screen.game_over then
		if game_over_splash_screen.game_over then return false end
		timer:every(self.speed, function ()
			stop = false
			temp = copy(self.active_brick)
			for i = 1, 4 do
				if temp[i][2] + 1 <= height and self.grid[temp[i][2] + 1][temp[i][1]] == 0 then
					temp[i][2] = temp[i][2] + 1
				else
					stop = true
					break
				end
			end

			if stop then
				self.active_brick.is_active = self:makePassive(self.active_brick)
				self:newFigure()
				return false
			else
				self.active_brick = copy(temp)
			end
		end)
	end
end

function GameField:makePassive(ab)
	for i = 1, 4 do
		self.grid[ab[i][2]][ab[i][1]] = 1
	end
	self:clear(ab)
	return false
end

function GameField:clear(ab)
	for i = ab[1][2], ab[4][2] do
		full = true
		for j = 1, width do
			if self.grid[i][j] == 0 then
				full = false
			end
		end
		local list = {}
		for k = 1, width do table.insert(list, 0) end
		if full then
			table.remove(self.grid, i)
			table.insert(self.grid, 1, list)
			self.score = self.score + 10
		end
	end
end

function GameField:moveActive()
	if input:down(self.left, 0.1, 0.1) then
		local temp = copy(self.active_brick)
		local stop = false
		for i = 1, 4 do
			if temp[i][1] - 1 <= 0 or self.grid[temp[i][2]][temp[i][1] - 1] ==1 or not temp.is_active then
				stop = true
				break
			end
			temp[i][1] = temp[i][1] - 1
		end
		if not stop then self.active_brick = copy(temp) end
	end

	if input:down(self.right, 0.1, 0.1) then
		local temp = copy(self.active_brick)
		local stop = false
		for i = 1, 4 do
			if temp[i][1] + 1 > self.width or self.grid[temp[i][2]][temp[i][1] + 1] == 1 or not temp.is_active then
				stop = true
				break
			end
			temp[i][1] = temp[i][1] + 1
		end
		if not stop then self.active_brick = copy(temp) end
	end


	if input:down(self.increase, 0.05, 0.05) then
		local temp = copy(self.active_brick)
		local stop = false
		for i = 1, 4 do
			if temp[i][2] + 1 > self.height or self.grid[temp[i][2] + 1][temp[i][1]] == 1 or not temp.is_active then
				stop = true
				break
			end
			temp[i][2] = temp[i][2] + 1
		end

		if not stop then self.active_brick = copy(temp)
		--elseif temp.is_active then self.active_brick.is_active = self:makePassive(self.active_brick)
		--else self:newFigure() end
		end
	end


	if input:down(self.rotate, 0.3, 0.3) then
		local temp = copy(self.active_brick)
		for i = 1, 4 do
			temp[i][1] = temp[i][1] - figures[temp.type][temp.pos][i][1]
			temp[i][2] = temp[i][2] - figures[temp.type][temp.pos][i][2]
		end
		temp.pos = temp.pos + 1
		if temp.pos > #figures[temp.type] then
			temp.pos = 1
		end
		for i=1, 4 do
			temp[i][1] = temp[i][1] + figures[temp.type][temp.pos][i][1]
			temp[i][2] = temp[i][2] + figures[temp.type][temp.pos][i][2]
		end
		local stop = false

		for i = 1, 4 do
			local coor = temp[i]
			if coor[2] > self.height or self.grid[coor[2]][coor[1]] == 1 then
				stop = true
				break
			end

			if coor[1] < 1 then
				local dif = 1 - coor[1]
				for i = 1, 4 do
					temp[i][1] = temp[i][1] + dif
				end
				break
			elseif coor[1] > self.width then
				local dif = coor[1] - self.width
				for i = 1, 4 do
					temp[i][1] = temp[i][1] - dif
				end
			end
		end
		if not stop then self.active_brick = copy(temp) end
	end

	if input:pressed(self.fall) then
		local temp = copy(self.active_brick)
		local stop = false
		while not stop do
			for i = 1, 4 do
				if temp[i][2] + 1 > self.height or self.grid[temp[i][2]+1][temp[i][1]] == 1 then
					stop = true
					break
				end
				temp[i][2] = temp[i][2] + 1
			end
			if not stop then self.active_brick = copy(temp) end
		end
		--self.active_brick.is_active = self:makePassive(self.active_brick)
	end

end



function GameField:drawPassive()
	for i=1, self.width do
		for j=1, self.height do
			if self.grid[j][i] == 1 then
				love.graphics.rectangle('fill' ,self.x + self.edge*(i-1), self.y + self.edge*(j-1), self.edge-1, self.edge-1)
			end
		end
	end
end
function GameField:drawActive()
	if self.active_brick.is_active then
		for i=1, 4 do
			love.graphics.rectangle('fill' ,self.x + self.edge*(self.active_brick[i][1]-1), self.y + self.edge*(self.active_brick[i][2]-1), self.edge-1, self.edge-1)
		end
	end
end

function GameField:update(dt)
	if not game_over_splash_screen.game_over then
		self:moveActive() 
	end
end



function game_over_check(field, ab)
	for i = 1, 4 do
		if field.grid[ab[i][2]][ab[i][1]] ~= 0 then game_over_splash_screen.game_over = true end
	end
end

function copy(obj)
  	if type(obj) ~= 'table' then return obj end
  	local res = {}
  	for k, v in pairs(obj) do res[copy(k)] = copy(v) end
  	return res
end

return GameField