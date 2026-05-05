topuplib.universe.bgobj = Moveable:extend()
local UniverseBackground = topuplib.universe.bgobj

function UniverseBackground:init(anm)
	Moveable.init(self, 0, 0, 90, 90)
	self.states.drag.can = false
	self.animobjects = anm.objects or {}
	self.timer = 0
	self.vars = {}
	self.events = anm.events or {}
	self.animupdate = anm.update or topuplib.returnFalse
end

--Initial scale XY are multiplied by 0.01
function UniverseBackground:addAnimObject(obj)
	obj.x = obj.x or 0
	obj.vx = obj.vx or 0
	obj.y = obj.y or 0
	obj.vy = obj.vy or 0
	obj.r = obj.r or 0
	obj.vr = obj.vr or 0
	obj.sx = (obj.sx or 1) * 0.01
	obj.vsx = obj.vsx or 0
	obj.sy = (obj.sy and obj.sy * 0.01) or obj.sx
	obj.vsy = obj.vsy or 0
	obj.kx = obj.kx or 0
	obj.vkx = obj.vkx or 0
	obj.ky = obj.ky or 0
	obj.vky = obj.vky or 0
	obj.blend = obj.blend or "alpha"
	obj.col = obj.col or {1,1,1,1}
	obj.vcol = obj.vcol or {0,0,0,0}
	self.animobjects[#self.animobjects + 1] = obj
	return obj
end

function UniverseBackground:removeAnimObject(obj)
	return table.remove(self.animobjects, topuplib.getValueIndex(self.animobjects, obj))
end

function UniverseBackground:draw()
	local dt = love.timer.getDelta()
	self.timer = self.timer + dt
	if next(self.events) and self.events[1][1] <= self.timer then
		self.events[1][2](self)
		table.remove(self.events, 1)
		if topuplib.debug then print("Anim event play, "..tostring(#self.events).." left") end
	end
	
	prep_draw(self, 1)
	local shdold = love.graphics.getShader()
	local bmold = love.graphics.getBlendMode()
	self:animupdate(dt)
	if self.bgshader then
		love.graphics.setShader(self.bgshader)
		love.graphics.clear(1,1,1,1)
	elseif self.bgcol then
		love.graphics.clear(self.bgcol)
	end
	for k,v in pairs(self.animobjects) do
		v.x = v.x + (v.vx * dt)
		v.y = v.y + (v.vy * dt)
		v.r = v.r + (v.vr * dt)
		v.sx = v.sx + (v.vsx * dt)
		v.sy = v.sy + (v.vsy * dt)
		v.kx = v.kx + (v.vkx * dt)
		v.ky = v.ky + (v.vky * dt)
		v.col[1] = v.col[1] + (v.vcol[1] * dt)
		v.col[2] = v.col[2] + (v.vcol[2] * dt)
		v.col[3] = v.col[3] + (v.vcol[3] * dt)
		v.col[4] = v.col[4] + (v.vcol[4] * dt)
		love.graphics.setColor(v.col)
		love.graphics.setBlendMode(v.blend)
		love.graphics.setShader(v.shader)
		love.graphics.draw(v[1], v.x, v.y, v.r, v.sx, v.sy, v.ox, v.oy, v.kx, v.ky)
	end
	love.graphics.pop()
	love.graphics.setColor(1,1,1,1)
	love.graphics.setBlendMode(bmold)
	love.graphics.setShader(shdold)
end