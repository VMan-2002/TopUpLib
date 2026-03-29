topuplib.cardAnimations = {}
local recentchange = true

local updateref = Game.update
function Game.update(...)
	if recentchange then
		recentchange = false
		topuplib.cardAnimationsActive = {}
		topuplib.cardAnimationTargets = {}
		for k,v in pairs(G.I.CARD) do
			local center = v.config.center
			if center and center.topuplib_anim then
				topuplib.cardAnimationsActive[center.topuplib_anim.rate] = true
				topuplib.cardAnimationTargets[#topuplib.cardAnimationTargets + 1] = v
			end
		end
	end
	local a = updateref(...)
	local dt = love.timer.getDelta()
	for av,_ in pairs(topuplib.cardAnimationsActive) do
		local tc = topuplib.cardAnimations[av]
		tc[2] = tc[2] + dt
		if tc[2] >= tc[1] then
			tc[2] = tc[2] - tc[1]
			for key,anm in pairs(tc[3]) do
				local center = G.P_CENTERS[key]
				anm.frameNum = anm.frameNum + 1
				if anm.frameNum == anm.frameCount then
					anm.frameNum = 0
				end
				anm.runFunc(center, anm)
				for k,v in pairs(topuplib.cardAnimationTargets) do
					if v.config.center_key == key then
						v:topuplib_update_anim(center, anm)
					end
				end
			end
		end
	end
	return a
end

topuplib.cardAnimation_framebased = function(self, anm)
	local frame = anm.frames[anm.frameNum]
	self.pos.x = frame.x or self.pos.x
	self.pos.y = frame.y or self.pos.y
	self.soul_pos.x = frame.soulx or self.pos.soulx
	self.soul_pos.y = frame.souly or self.pos.souly
end

topuplib.cardAnimation_varbased = function(self, anm)
	if anm.vars.x then self.pos.x = anm.frameNum end
	if anm.vars.y then self.pos.y = anm.frameNum end
	if anm.vars.soulx then self.soul_pos.x = anm.frameNum end
	if anm.vars.souly then self.soul_pos.y = anm.frameNum end
end

local injectref = SMODS.injectItems
function SMODS.injectItems(...)
	injectref(...)
	for k,v in pairs(G.P_CENTERS) do
		local anm = v.topuplib_anim
		if anm then
			assert((anm.frames or anm.func or (anm.vars and anm.frameCount)) and anm.rate, "A card animation is wrongly defined, or TopUpLib needs an update!")
			topuplib.cardAnimations[anm.rate] = topuplib.cardAnimations[anm.rate] or {1 / anm.rate, 0, {}}
			topuplib.cardAnimations[anm.rate][3][k] = anm
			if anm.frames then
				anm.frameCount = #anm.frames
			end
			if not anm.frameNum or anm.frameNum > anm.frameCount then
				anm.frameNum = 1
			end
			if anm.func then
				anm.runFunc = anm.func
			elseif anm.frames then
				anm.runFunc = topuplib.cardAnimation_framebased
			elseif anm.vars then
				anm.runFunc = topuplib.cardAnimation_varbased
			end
		end
	end
end

function Card:topuplib_update_anim(center, anm)
	if self.children.floating_sprite then
		self.children.floating_sprite:set_sprite_pos(center.soul_pos)
	end
end

local card_remove_ref = Card.remove
function Card:remove(...)
	recentchange = true
	return card_remove_ref(self, ...)
end

local card_set_base_ref = Card.set_base
function Card:set_base(...)
	recentchange = true
	return card_set_base_ref(self, ...)
end

local card_set_ability_ref = Card.set_ability
function Card:set_ability(...)
	recentchange = true
	return card_set_ability_ref(self, ...)
end