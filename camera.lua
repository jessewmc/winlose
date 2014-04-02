camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.layers = {}

function camera.set(self)
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1/self.scaleX, 1/self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end

function camera.unset(self)
	love.graphics.pop()
end

function camera.move(self, dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera.rotate(self, dr)
	self.rotation = self.rotation + dr
end

function camera.scale(self, sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX * sx
	self.scaleY = self.scaleY * sy
end

function camera.setPosition(self, x, y)
	self.x = x or self.x
	self.y = y or self.y
end

function camera.setScale(self, sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end

function camera.newLayer(self, scale, func)
	table.insert(self.layers, {draw = func, scale = scale})
	table.sort(self.layers, function(a,b) return a.scale < b.scale end)
end

function camera.draw(self)
	local bx, by = self.x, self.y
	
	for _, v in ipairs(self.layers) do
		self.x = bx * v.scale
		self.y = by * v.scale
		camera.set(camera)
		v.draw()
		camera.unset(camera)
	end
end