--	so uhhh yeah
--	this is free memory savings

SMODS.Atlas{
	key = "blind_chips",
	px = 34,
	py = 34,
	atlas_table = "ANIMATION_ATLAS",
	frames = 9,
	firstframes = 12,
	raw_key = true,
	path = "blindchips.png",
	reanimatedblind_path = "blindchips_sh.png",
	reanimatedblind_shine = "blind_shine.png"
}

local set_sprite_pos_ref = AnimatedSprite.set_sprite_pos
function AnimatedSprite:set_sprite_pos(...)
	local r = set_sprite_pos_ref(self, ...)
	if not self.current_animation then return r end
	self.current_animation.firstframes = self.atlas.firstframes or 0
	self.current_animation.frames = (self.current_animation.frames or 0) + self.current_animation.firstframes
	return r
end