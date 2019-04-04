local Area = object:extend()

function Area:new(x, y)
	self.x, self.y = x, y
	self.gameObjects = {}

end

function Area:update(dt)
  	for i = #self.gameObjects, 1, -1 do
  		local GO = self.gameObjects[i]
  		GO:update(dt)
  		if GO.dead then table.remove(self.gameObjects, i) end
  	end
end

function Area:draw()
	for _,go in pairs(self.gameObjects) do
		go:draw
	end
end

function Area:addGameObject(typ, area, x, y, opts, name)
	self.gameObjects[name] = typ(area, x, y, opts)
end

return Area