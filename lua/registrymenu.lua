topuplib.registryMenuName = topuplib.debug and "Registry Browser" or "Soundtrack"

local c_set
local c_mod

topuplib.registryMenuAddEntry = function(tbl, dat)
	if type(tbl) ~= "table" then
		c_set = tbl
		return
	end
	if dat.no_collection then return end
	local loc = topuplib.localize("descriptions", "TopUpLib_Music")[dat.key]
	local c = loc and G.P_CENTERS[loc.center] or G.P_CENTERS.j_joker
	dat.mod = dat.mod or c_mod
	table.insert(tbl, {
		unlocked = true,
		set = c_set,
		name = dat.key,
		key = dat.key,
		discovered = true,
		unlocked = true,
		atlas = loc and loc.atlas or dat.collection_atlas or c.atlas or c.set or "Joker",
		pos = loc and loc.pos or dat.collection_pos or c.pos or {x=0,y=0},
		soul_pos = loc and loc.soul_pos or dat.collection_soul_pos or c.soul_pos,
		mod = dat.mod,
		original_mod = dat.original_mod or dat.mod,
		_order = loc and loc.order or dat.collection_order or math.huge,
		pixel_size = loc and loc.pixel_size or dat.collection_pixel_size or c.pixel_size,
		config = {}
	})
end

G.FUNCS.your_collection_topuplib_music = function(e)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu{
    definition = create_UIBox_your_collection_topuplib_music(),
  }
end

create_UIBox_your_collection_topuplib_music = function()
	local collect = {}
	topuplib.registryMenuAddEntry("TopUpLib_Music")
	c_mod = nil
	for k = 1,5 do
		topuplib.registryMenuAddEntry(collect, {
			from = "Balatro",
			key = "music"..k
		})
	end
	for k,v in pairs(SMODS.Sounds) do
		if type(v.select_music_track) == "function" then
			topuplib.registryMenuAddEntry(collect, {
				from = "Mod",
				key = k,
				no_collection = v.no_collection,
				mod = v.mod,
				original_mod = v.original_mod,
				collection_atlas = v.collection_atlas,
				collection_pos = v.collection_pos,
				collection_soul_pos = v.collection_soul_pos,
				collection_order = v.collection_order,
				collection_pixel_size = v.collection_pixel_size,
			})
		end
	end
	for _, mod in pairs(SMODS.Mods) do
		if type(mod.topuplib_music_addition) == "function" then
			c_mod = mod
			mod.topuplib_music_addition(collect)
		end
	end
	table.sort(collect, function(a, b)
		if b.mod then
			if not a.mod then return true end
			if b.mod ~= a.mod then return b.mod.id > a.mod.id end
		elseif a.mod then
			return false
		end
		return a._order < b._order
	end)
    return SMODS.card_collection_UIBox(collect, {5,5}, {
        snap_back = true,
        h_mod = 1.03,
        hide_single_page = true,
        collapse_single_page = true,
		back_func = "your_collection_other_gameobjects"
    })
end