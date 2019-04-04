local Room = object:extend()
local Area = require('obj/Area')

function Room:new(bg, opts)
	self.bg = bg
	local opts = opts or {}
	if opts then
		for k,v in pairs(opts) do self.k = v end
	end
	self.areaNum = 1
	if self.bg then love.graphics.setBackgroundColor(self.bg) end
end

function Room:update(dt)
	if self.areas then
		for _,area in pairs(self.areas) do
			area:update(dt)
		end
	end
end

function Room:draw()
	if self.areas then
		for _,area in pairs(self.areas) do
			area:draw()
		end
	end
end

function Room:addArea(name, area)
	name = name or areaNum
	if self.areas then table.insert(self.areas, name, area) 
	else self.areas = {name = area} end
	areaNum = areaNum + 1
end
function Room:deleteArea(name)
	name = name or areaNum - 1
	table.remove(self.areas, name) 
end

return Room