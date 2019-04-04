local GameField = Object:extend()

function GameField:makePassive(t)
	for i=1, 4 do
		grid[t[i][2]][t[i][1]]=1
	end
end

local types = {
	'left_zed', 'right_zed', 'T', 'cube', 'left_ugol', 'right_ugol', 'palka'
}
local figures = {
	left_zed = {
		{{2,1}, {2,2}, {1,2}, {1,3}}, -- Up
		{{1,1}, {2,1}, {2,2}, {3,2}} -- Left
	},
	right_zed = {
		{{1,1}, {1,2}, {2,2}, {2,3}}, -- Up
		{{1,2}, {2,2}, {2,1}, {3,1}} -- Left
	},
	T = {
		{{2,1},{1,2},{2,3},{2,2}},  --left
		{{1,2},{2,1},{3,2},{2,2}}, --down
		{{2,1},{2,2},{2,3},{3,2}}, --right
		{{1,1},{2,1},{3,1},{2,2}} --up
	},
	cube = {
		{{1,1},{1,2},{2,1},{2,2}}
	},
	left_ugol = {
		{{1,2},{2,2},{3,2},{3,1}},
		{{2,1},{2,2},{2,3},{3,3}},
		{{1,3},{1,2},{2,2},{3,2}},
		{{1,1},{2,1},{2,2},{2,3}}
	},
	right_ugol = {
		{{3,3},{1,2},{2,2},{3,2}},
		{{1,3},{2,1},{2,2},{2,3}},
		{{1,1},{1,2},{2,2},{3,2}},
		{{3,1},{2,1},{2,2},{2,3}}
	},
	palka = {
		{{2,4},{2,3},{2,2},{2,1}},
		{{1,3},{2,3},{3,3},{4,3}}
	}
}
--[[
4   0
3 0 0 0 0 
2   
1   0  
  1 2 3 4
]]--
function GameField:newFigure()
	typef = types[love.math.random(1,#types)]
	pos = love.math.random(1,#figures[typef])
	active_brick = copy(figures[typef][pos])
	active_brick.pos = pos
	active_brick.type = typef
	timer:every(speed, function()
		stop = false
		temp = copy(active_brick)
		for i=1, 4 do
			if temp[i][2]+1 <= height and grid[temp[i][2]+1][temp[i][1]] == 0 then
				temp[i][2] = temp[i][2]+1
			else
				stop = true
				break
			end
		end
		if stop == false then
			active_brick = copy(temp)
		else
			GameField:makePassive(active_brick)
			timer:after(speed,GameField:newFigure())
			return false
		end

	end)
end

function GameField:new()
	edge = Field.w/width
	grid = {}
	emptyline = {}
	for i=1, width do table.insert(emptyline,0) end 
	for i=1, height do
		table.insert(grid,{})
		for j=1, width do
			table.insert(grid[i],0)
		end
	end
	GameField:newFigure()
end


speed = 0.5         


function copy(obj)
  	if type(obj) ~= 'table' then return obj end
  	local res = {}
  	for k, v in pairs(obj) do res[copy(k)] = copy(v) end
  	return res
end


function GameField:MoveActive()
	if input:down('left', 0.1, 0.1) then
		temp = copy(active_brick)
		stop = false
		for i=1,4 do
			if temp[i][1]-1 <= 0 or grid[temp[i][2]][temp[i][1]-1] == 1 then
				stop = true
				break
			end
			temp[i][1] = temp[i][1] - 1
		end
		if stop == false then active_brick = copy(temp) end
	end
	if input:down('right', 0.1, 0.1) then
		temp = copy(active_brick)
		stop = false
		for i=1,4 do
			if temp[i][1]+1 > width or grid[temp[i][2]][temp[i][1]+1] == 1 then
				stop = true
				break
			end
			temp[i][1] = temp[i][1] + 1
		end
		if stop == false then active_brick = copy(temp) end
	end
	if input:down('down', 0.08, 0.08) then
		temp = copy(active_brick)
		stop = false
		for i=1,4 do
			if temp[i][2]+1 > height or grid[temp[i][2]+1][temp[i][1]] == 1 then
				stop = true
				break
			end
			temp[i][2] = temp[i][2] + 1
		end
		if stop == false then active_brick = copy(temp) end
	end
	if input:down('up', 0.3, 0.3) then
		temp = copy(active_brick)
		for i=1, 4 do
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
		stop = false
		for i=1, 4 do
			coor = temp[i]
			if coor[1] < 1 or coor[1] > width or coor[2] > height or grid[coor[2]][coor[1]] == 1 then
				stop = true
				break
			end
		end
		if stop == false then active_brick = copy(temp) end
	end 
	if input:pressed('space') then
		temp = copy(active_brick)
		stop = false
		while stop == false do
			for i=1,4 do
				if temp[i][2]+1 > height or grid[temp[i][2]+1][temp[i][1]] == 1 then
					stop = true
					break
				end
				temp[i][2] = temp[i][2] + 1
			end
			if stop == false then active_brick = copy(temp) end
		end
		GameField:makePassive(active_brick)
	end
end
function GameField:Clear()
	for i=1, height do
		full = true
		for j=1, width do
			if grid[i][j] == 0 then
				full = false
				break
			end
		end
		if full == true then
			local list = {0,0,0,0,0,0,0,0,0,0}
			table.remove(grid, i+1)
			table.insert(grid, 1, list)
		end
	end
end
function GameField:drawPassive()
	for i=1, width do
		for j=1, height do
			if grid[j][i] == 1 then
				love.graphics.rectangle('fill' ,First_x + edge*(i-1), Field.y + edge*(j-1), edge, edge)
			end
		end
	end
end
function GameField:drawActive()
	for i=1, 4 do
		love.graphics.rectangle('fill' ,First_x + edge*(active_brick[i][1]-1), Field.y + edge*(active_brick[i][2]-1), edge, edge)
	end
end


function GameField:update(dt)
	GameField:MoveActive()
	GameField:Clear()
end

function GameField:draw()
	GameField:drawActive()
	GameField:drawPassive()
end

return GameField