local GameObject = object:extend()

function GameObject:new(area, x, y, opts)
	local opts = opts or {}
	if opts then
		for k,v in pairs(opts) do self.k = v end
	end
	self.x, self.y = x, y
	self.area = area
end
