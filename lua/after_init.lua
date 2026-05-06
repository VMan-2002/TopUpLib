topuplib.afterInits = {}
topuplib.afterInit = function(func)
	table.insert(topuplib.afterInits, {func, SMODS.current_mod})
end
--agh
--[[topuplib.runAfterInits = function(mod)
	if not (mod.can_load and topuplib.afterInits[mod.id]) then return end
	local current_mod_prev = SMODS.current_mod
	for k,v in ipairs(topuplib.afterInits[mod.id]) do
		SMODS.current_mod = v[2]
		v[1]()
	end
	SMODS.current_mod = current_mod_prev
	topuplib.afterInits[mod.id] = nil
end]]

local get_optional_features_ref = SMODS.get_optional_features
function SMODS.get_optional_features()
	local was = SMODS.current_mod
	for k,v in ipairs(topuplib.afterInits) do
		SMODS.current_mod = v[2]
		v[1]()
	end
	SMODS.current_mod = was
	get_optional_features_ref()
end