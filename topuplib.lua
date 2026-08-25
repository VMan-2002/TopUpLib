--	so uhhh yeah
--	this is library!

topuplib = topuplib or {}
local topuplib = topuplib
topuplib.tforms = { --DEPRECATED
	-- Scoring
	mult = "{C:mult}",
	xmult = "{X:mult,C:white}",
	chips = "{C:chips}",
	xchips = "{X:chips,C:white}",
	money = "{C:money}",
	xmoney = "{X:money,C:white}",
	
	--Suits
	clubs = "{C:clubs}",
	hearts = "{C:hearts}",
	spades  = "{C:spades}",
	diamonds = "{C:diamonds}",
	
	--Items
	tarot = "{C:tarot}",
	planet = "{C:planet}",
	spectral = "{C:spectral}",
	
	--Modifiers
	edition = "{C:edition}",
	dark_edition = "{C:dark_edition}",
	
	--Other
	r = "{}",
	vman = "{C:vmanlol}",
	chance = "{C:green}",
	small = "{C:inactive,s:0.7}",
	attention = "{C:attention}",
	inactive = "{C:inactive}"
}
topuplib.pixellated_rect_options = {}
topuplib.font_options = {}
topuplib.debug_item_keys = {
	"j_luchador",
	"j_chicot",
	"j_credit_card",
	"j_pareidolia",
	"j_shortcut",
	"j_erosion",
	"j_blueprint",
	"j_invisible",
	"j_topuplib_infinit",
	"c_lovers",
	"c_hanged_man",
	"c_death",
	"c_cryptid",
	"v_antimatter",
	"v_money_tree",
	"v_paint_brush",
	"bl_topuplib_infinit", --todo: Ctrl+3 on blinds in debug essentials doesnt spawn the blind?
	"bl_topuplib_debuff",
	"bl_topuplib_notallowed"
}
topuplib.configpage = 1
do --Debugging
	--`true` if the DebugPlus mod is installed and enabled
	topuplib.debug = SMODS.Mods.DebugPlus and not SMODS.Mods.DebugPlus.disabled
	--Print details about an object's keys and values
	topuplib.inspect = function(name, value)
		if not value then
			value = name
			name = "var"
		end
		topuplib.inspectedvalue = value
		local t = type(value)
		if t == "table" then
			local r = {}
			local keys = {}
			for k, v in pairs(value) do
				r[#r + 1] = tostring(k)..": "..type(v).." "..tostring(v)
				keys[#keys + 1] = tostring(k)
			end
			print(name .. ": " .. tostring(value) .. ", table with length " .. #value .. " and " .. #r.." keys")
			print("inspect: {" .. table.concat(r, ", ") .. "}")
			print("keys: {" .. table.concat(keys, ", ") .. "}")
		else
			print(name .. ": " .. tostring(value) .. " of type " .. t)
		end
	end
	--Find a substring inside an object's keys and string values (includes metatable properties)
	topuplib.findIn = function(obj, key, path, tables)
		path = path or ""
		tables = tables or {}
		if type(obj) == "table" then
			for k,v in pairs(obj) do
				if string.find(k, key) then
					print("Found in "..path..k)
				end
				if type(v) == "string" then
					if string.find(v, key) then
						print("Found in string value of "..path..k..": "..v)
					end
				else
					if (type(v) == "table" or getmetatable(v)) and not tables[k] then
						tables[k] = v
						pcall(topuplib.findIn, v, key, k .. "." .. path, tables)
					end
				end
			end
		end
		if getmetatable(obj) then
			pcall(topuplib.findIn, getmetatable(obj), key, path, tables)
		elseif obj == nil or type(obj) ~= "table" then
			print("cannot search this")
		end
	end
	topuplib.printverts = function(verts)
		local i = 1
		print("print verts")
		while i + 1 ~= #verts do
			print("("..tostring(verts[i])..","..tostring(verts[i+1])..")")
			i = i + 2
		end
	end
	topuplib.addDebugCollectionItem = function(...)
		for k,v in ipairs({...}) do
			table.insert(topuplib.debug_item_keys, v)
		end
	end
	--Override this function if your shit dont work
	topuplib.debug_item_key_get = function(name)
		if not name then return end
		if string.sub(name, 1, 3) == "bl_" then
			return G.P_BLINDS[name]
		end
		return G.P_CENTERS[name]
	end
	--Discard savegame if it is broken
	topuplib.newRunFix = function()
		success = pcall(function()
			local svcheck = get_compressed(G.SETTINGS.profile..'/'..'save.jkr')
			if svcheck ~= nil then svcheck = STR_UNPACK(svcheck) end
		end)
		if success then
			print("Savegame is OK - No fix needed")
			return
		end
		print("Savegame INVALID - Overriding broken savegame")
		G.FUNCS.start_setup_run()
	end
end
do -- Misc
	--Returns false, can be used to avoid creating new function objects
	topuplib.returnFalse = function() return false end
	--Returns true, can be used to avoid creating new function objects
	topuplib.returnTrue = function() return true end
	--Texts that can be added in object descriptions
	topuplib.txwip = "{C:chips,s:0.7}(wip){}"
	topuplib.txnyi = "{C:chips,s:0.7}(nyi){}"
	topuplib.txbug = "{C:chips,s:0.7}(known bugs){}"
	--Returns the same as one input value
	topuplib.same = function(value) return value end
	--Override this function in your custom shapes
	topuplib.pixellated_rect = topuplib.returnFalse
	--Add an option to topuplib config for your mod's UI element shape
	topuplib.addPixellatedRectOption = function(label, id, mod)
		mod = mod and SMODS.Mods[mod] or SMODS.current_mod
		if mod.id ~= SMODS.Mods.TopUpLib.id then
			label = label .. " (" .. mod.name .. ")"
		end
		table.insert(topuplib.pixellated_rect_options, {label = label, id = id, mod = mod.id})
	end
	--Add an option to topuplib config for your mod's font
	topuplib.addFontOption = function(label, id, mod)
		mod = mod and SMODS.Mods[mod] or SMODS.current_mod
		if mod.id ~= SMODS.Mods.TopUpLib.id then
			label = label .. " (" .. mod.name .. ")"
		end
		table.insert(topuplib.font_options, {label = label, id = id, mod = mod.id})
	end
	--Add a function to G.FUNCS with a unique name, and returns that name
	topuplib.addUniqueFunc = function(func)
		local i, n = 0
		while true do
			n = "ufunc_" .. tostring(i)
			if not G.FUNCS[n] then
				G.FUNCS[n] = func
				return n
			elseif G.FUNCS[n] == func then
				return n
			end
			i = i + 1
		end
	end
	--Copies a table's keys and values
	topuplib.tableShallowCopy = function(tbl)
		local result = {}
		for k,v in pairs(tbl) do
			result[k] = v
		end
		return result
	end
	--Gets a mod's folder name. Result starts and ends with "/".
	--Technical mods (Lovely, Balatro) may return nil.
	topuplib.modFolderName = function(name)
		local modlol = (name and SMODS.Mods[name] or SMODS.current_mod).path
		if not modlol then return nil end
		local i = #modlol
		while i ~= 0 do
			i = i - 1
			if string.sub(modlol, i, i) == "/" then
				local modfolder = string.sub(modlol, i, nil)
				return modfolder
			end
		end
	end
	--Checks for discovered custom non-gameobject.
	topuplib.isDiscovered = function(set, key)
		local d = G.PROFILES[G.SETTINGS.profile].topuplib_discovered
		return d and d[set] and d[set][key]
	end
	--Mark a custom non-gameobject as discovered.
	--Todo: add option to save profile.
	topuplib.markDiscovered = function(set, key)
		local d = G.PROFILES[G.SETTINGS.profile].topuplib_discovered or {}
		if not d[set] then d[set] = {} end
		d[set][key] = true
		G.PROFILES[G.SETTINGS.profile].topuplib_discovered = d
	end
	--Gets index of a value in a table
	topuplib.getValueIndex = function(tbl, val, fallback)
		for k,v in pairs(tbl) do
			if v == val then return k end
		end
		return fallback
	end
	--Gets first key matching the filter
	topuplib.getFirstFilteredIndex = function(tbl, filter)
		local r = {}
		for k,v in pairs(tbl) do
			if filter(v,k) then
				return k,v
			end
		end
	end
	--Count entries in a table
	topuplib.countKeys = function(tbl)
		local r = 0
		for k,v in pairs(tbl) do
			r = r + 1
		end
		return r
	end
	--Return a table with keys and values passing the filter
	topuplib.filter = function(tbl, filter)
		local r = {}
		for k,v in pairs(tbl) do
			if filter(v,k) then
				r[k] = v
			end
		end
		return r
	end
	--Convert a table into one with continuous integer keys
	topuplib.continuous = function(tbl)
		local r = {}
		for k,v in pairs(tbl) do
			r[#r + 1] = v
		end
		return r
	end
	--Return continuous keys for matching values in the table
	topuplib.filterContinuous = function(tbl, filter)
		local r = {}
		for k,v in pairs(tbl) do
			if filter(v,k) then
				r[#r + 1] = v
			end
		end
		return r
	end
	--Returns true if the given mod exists and is not disabled
	topuplib.modEnabled = function(name)
		local mod = SMODS.find_mod(name)
		return next(mod) and not mod[1].disabled
	end
	--Function called when detail level is changed. Override this for custom behaviour.
	topuplib.detail_changed = function(new_detail_level, old_detail_level) end
	-- Function called when a run is started (not using the continue menu.)
	topuplib.start_run_init = function() end
end
do --Files
	--Return a filepath relative to a mod
	topuplib.filePath = function(path, mod)
		return (mod or SMODS.current_mod).path .. path
	end
	--Load a png image file as a Love2D Image
	topuplib.loadGraphic = function(path, extra, mod)
		local path = "assets/gfx/"..path..".png"
		local file = SMODS.NFS.read('data', topuplib.filePath(path, mod))
		if not file then error("[topuplib.loadGraphic] Failed to load the file at "..path.." from mod "..(SMODS.current_mod or mod).id) end
		local gfx = love.graphics.newImage(file, nil)
		if not extra then return gfx end
		for k,v in pairs(extra) do
			if type(v) ~= "table" then v = {v} end
			if k == "filter" then gfx:setFilter(unpack(v))
			elseif k == "mipmapFilter" then gfx:setMipmapFilter(unpack(v))
			elseif k == "wrap" then gfx:Wrap(unpack(v))
			else print("[topuplib.loadGraphic] Unrecognized parameter name \""..k.."\".") end
		end
		return gfx
	end
end
do -- Text
	--cooler text format func.
	--Used more like basegame text formatting
	local asub_pat = "%{_A[^%}]+%}"
	local psub_pat = "%#[^S]?SUB"
	topuplib.asub = function(d)
		local t = type(d)
		--print("Asub call with "..t)
		if t == "string" then
			return string.gsub(d, asub_pat, function(match)
				--print("Asub match: "..match)
				local c = string.find(match, ":", 5)
				local atype = string.sub(match, 5, c and (c-1) or -2)
				local srcstring = G.localization.topuplib.asub[atype] or "{C:"..atype.."}#SUB{}"
				local psub_s, psub_e = string.find(srcstring, psub_pat)
				if not psub_s then return srcstring end
				local aval = c and string.sub(match, c+1, -2) or G.localization.topuplib.asub_defaults[atype]
				local subtype = string.sub(match, psub_s, psub_e)
				--[[if subtype == "#PSUB" then
					local valn = tonumber(aval)
					if (valn and valn > 0) then
						aval = G.localization.topuplib.positive_sign .. aval
					end
				end]]
				return string.sub(srcstring, 1, psub_s - 1) .. aval .. string.sub(srcstring, psub_e + 1)
			end)
		end
		if t == "table" then
			for k,v in pairs(d) do
				d[k] = topuplib.asub(v)
			end
			return d
		end
		return d
	end
	topuplib.simpleLocVars = function(properties)
		local prop_vars = ""
		for k,v in ipairs(properties) do
			prop_vars = prop_vars .. "c.ability.extra." .. v .. ","
		end
		return assert(loadstring([[
			return function(a,b,c) if not c.ability.extra then return end return {vars = {]]..prop_vars..[[}} end
		]]), "[topuplib.simpleLocVars] Failed to generate function")()
	end
	--Gets localized key of an object of any type
	topuplib.nameFromKey = function(key, fallback)
		for _,grp in pairs(G.localization.descriptions) do
			if grp[key] then
				return grp[key].name
			end
		end
		return fallback or key
	end
	topuplib.localizeDesc = function(grp, key)
		return G.localization.descriptions[grp][key]
	end
	--Patch this function to modify localization dynamically
	topuplib.localizeHook = function(args, loc_target, misc_cat) end
	--Parses modified localization from the previous function. You may need to patch this if you have custom data that's not supported
	topuplib.localizeModifiedParse = function(r)
		if r.name then
			r.name_parsed = loc_parse_string(r.name)
		end
		if r.text then
			r.text_parsed = {}
			for k,v in pairs(r.text) do
				r.text_parsed[k] = loc_parse_string(v)
			end
		end
		return r
	end
	--Returns named table in localization file
	topuplib.localize = function(tbl, name)
		return name and G.localization[tbl][name] or G.localization[tbl or "topuplib"]
	end
end
do -- Object spawning
	--Create and open a booster pack
	topuplib.openBooster = function(key, extra)
		--Note: Opening a booster while a booster is open does weird shit
		local card = Card(
			G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
			G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2,
			G.CARD_W*1.27,
			G.CARD_H*1.27,
			G.P_CARDS.empty,
			G.P_CENTERS[key],
			{bypass_discovery_center = true, bypass_discovery_ui = true}
		)
		card.cost = 0
		if extra then
			for k, v in pairs(extra) do card[k] = v end
		end
		G.FUNCS.use_card({config = {ref_table = card}})
		card:start_materialize()
	end
	--Give a tag
	topuplib.giveTag = function(key)
		G.E_MANAGER:add_event(Event({
			func = (function()
				add_tag(Tag(key))
				play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
				play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
			   return true
		   end)
		}))
	end
end
do -- Cards
	topuplib.quickGive = function(d)
		if type(d) == "string" then
			d = {key = d}
		end
		d.set = d.set or G.P_CENTERS[d.key].set
		SMODS.add_card(d)
	end
	topuplib.ranksFromHand = function(hand)
		--Returns a table where each key (a rank) is either nil or an array of cards
		local result = {}
		--valatroingout.inspect(hand)
		--valatroingout._v_jermahand = hand
		local t
		for k,v in pairs(hand) do
			t = result[v.base.value] or {}
			t[k] = v
			result[v.base.value] = t
		end
		--valatroingout._v_jermahand = result
		return result
	end
	topuplib.createFallbackPoolItem = function(_type, _pool)
		--Override this function to define custom behaviour.
		--Return true to allow the game to generate a default placeholder item.
		return true
	end
	topuplib.cardAreaHasRoom = function(cardarea, amount)
		cardarea = cardarea or G.jokers
		return #G.jokers.cards < G.jokers.config.card_limit + (amount or 1)
	end
	topuplib.allIsSameSuit = function(cards, suit)
		
	end
	--If the card instance is in the collection menu, returns the row number
	topuplib.viewedFromCollection = function(card)
		if not (G.your_collection and card.area) then return end
		for k,v in pairs(G.your_collection) do
			if v == card.area then return k end
		end
	end
	--Gets the stats used for the ranking on the collection
	topuplib.statsRanking = function(tbl, key, set)
		local used_cards = {}
		for k, v in pairs(tbl) do
			if G.P_CENTERS[k] and G.P_CENTERS[k].set == set and G.P_CENTERS[k].discovered then
				used_cards[#used_cards + 1] = {count = v.count, key = k}
				--if v.count > max_amt then max_amt = v.count end
			end
		end
		table.sort(used_cards, function (a, b) return a.count > b.count end )
		local rc = math.huge
		local rck
		for k,v in ipairs(used_cards) do
			if v.count < rc then
				rc = v.count
				rck = k
			end
			if v.key == key then
				local tc = rck
				while used_cards[tc].count ~= rc do
					tc = tc + 1
				end
				return rck, #used_cards, tc - rck
			end
		end
	end
	--Checks the `discovery_unlock` table in the center def
	--`set`: The set to check unlock count for (if nil, checks everything, if table, checks all in table)
	--`centers`: Additional center keys to count
	--`accumilate`: If `set` is a table, this is the function to use when adding counts from different sets (if nil, addition). `math.min` or `math.max` are good to use here
	--`count`: The amount of items needed to be discovered
	topuplib.discoveryUnlock = function(self, args)
		if args.type == "discover_amount" then
			local ds = self.discovery_unlock
			local c
			assert(ds, "[topuplib.discoveryUnlock] No discovery_unlock table found in "..self.key)
			if type(ds.set) == "table" then
				local sc
				for k,v in pairs(ds) do
					sc = G.DISCOVER_TALLIES[v:lower() .. "s"].tally
					if not c then
						c = sc
					elseif ds.accumilate then
						c = ds.accumilate(c, sc)
					else
						c = c + sc
					end
				end
			elseif ds.set then
				c = G.DISCOVER_TALLIES[ds.set and (ds.set:lower() .. "s") or "total"].tally
			else
				c = 0
			end
			if ds.centers then
				local center_c = 0
				for k,v in pairs(ds.centers) do
					if G.P_CENTERS[v].discovered then
						center_c = center_c + 1
					end
				end
				c = ds.accumilate and (ds.accumilate(c, center_c)) or (c + center_c)
			end
			return c >= ds.count
		end
	end
	--SMODS should have `Card.is_rank`, but until then...
	topuplib.isRank = function(card, rank)
		if SMODS.has_no_rank(card) then
			return false
		end
		if CARDMERGE and CARDMERGE.HasRank(card, SMODS.Ranks[rank].id) then
			return true
		end
		return card:get_id() == SMODS.Ranks[rank].id
	end
	topuplib.isRanks = function(card, ranks)
		if SMODS.has_no_rank(card) then
			return false
		end
		for k,v in ipairs(ranks) do
			if topuplib.isRank(card, v) then return true end
		end
		return false
	end
end
do -- Internal use
	-- Don't mess with these functions unless you know what you're doing
	topuplib.draw_pixellated_rect_textured = function(self, _type, _parallax, _emboss, _progress)
		if not self.pixellated_rect then
			self:draw_pixellated_rect(_type, _parallax, _emboss, _progress)
		end
		love.graphics.setColor(G.C.WHITE)
		love.graphics.draw(self.pixellated_rect_textured_mesh)
	end
	topuplib.pixellated_rect_uv = function(self, verts, w, h)
		if not self.config.pixellated_rect_texture then return end
		local result = {}
		local i = 1
		while i < #verts do
			result[#result+1] = {verts[i], verts[i+1], verts[i] / w, verts[i+1] / h}
			i = i + 2
		end
		local mesh = love.graphics.newMesh(result, "fan", "static")
		mesh:setTexture(self.config.pixellated_rect_texture)
		return mesh
	end
	--Deprecated
	--Adds predefined formatting to a single string
	topuplib.formatString = function(text, f)
		print("[TopUpLib] Use of deprecated topuplib.formatString !!")
		return topuplib.tforms[f]..text
	end
	--Deprecated
	--Adds predefined formatting and joins strings
	topuplib.formatText = function(arr)
		print("[TopUpLib] Use of deprecated topuplib.formatText !!")
		local result = ""
		for k,v in pairs(arr) do
			result = result .. topuplib.formatString(v[1] or "", v[2] or "r")
		end
		return result
	end
	--Deprecated
	--Fallback for to_number from talisman
	topuplib.num = function(...)
		print("[TopUpLib] Use of deprecated topuplib.num !!")
		return to_number and to_number(...) or topuplib.same(...)
	end
	--Deprecated
	--Fallback for to_big from talisman
	topuplib.big = function(...)
		print("[TopUpLib] Use of deprecated topuplib.big !!")
		return to_big and to_big(...) or topuplib.same(...)
	end
end

--[[local veryfunny = create_UIBox_generic_options
function create_UIBox_generic_options(arg, ...)
	local r = veryfunny(arg, ...)
	if arg.back_func == "exit_mods" and SMODS.full_restart and SMODS.full_restart ~= 0 then
		local lol = r.nodes[1].nodes[1].nodes[2]
		if lol then
			lol.nodes[1].nodes[1].text = lol.nodes[1].nodes[1].text .. " and restart game"
		end
	end
	return r
end]]
local mod = SMODS.current_mod
local config = mod.config
topuplib.preventcrash = config.crashpatches == 1
topuplib.debugdescription = config.debugdescription == 1
topuplib.detail = config.detail or 3

SMODS.Atlas{
	key = "common",
	px = 71,
	py = 95,
	path = "common.png"
}
SMODS.Atlas{
	key = "bsky",
	px = 66,
	py = 66,
	path = "dontbestupid.png"
}

mod.ui_config = {
	colour = HEX("1A2635"), -- Color of the mod menu BG
	author_colour = G.C.CHIPS, -- Color of the text displaying the mod authors
	bg_colour = HEX("1A2635DD"), -- Color of the area behind the mod menu.
	back_colour = G.C.BLUE, -- Color of the "Back" button
	tab_button_colour = G.C.BLUE, -- Color of the tab buttons
	collection_back_colour = G.C.BLUE -- Color of the "Back" button in the collections menu. Defaults to `back_colour` if not provided.
}

topuplib.addPixellatedRectOption("Default")
topuplib.addPixellatedRectOption("Rectangle", "lua/shapes/rect")
topuplib.addPixellatedRectOption("Rounded Rectangle", "lua/shapes/roundrect")
topuplib.addPixellatedRectOption("Circle", "lua/shapes/circle")
topuplib.addPixellatedRectOption("Cat Emoji", "lua/shapes/cat")

topuplib.addFontOption("Default (m6x11)")
topuplib.addFontOption("Oswald", "lua/fonts/oswald")
topuplib.addFontOption("Terrance Big", "lua/fonts/terrancebig")
topuplib.addFontOption("Comic Sans MS", "lua/fonts/comic")

--[[local function setFont(lol)
	G.FONTS[1] = lol
	G.FONTS[1].FONT = love.graphics.newFont( lol.file, lol.render_scale)
end
setFont({file = "Mods/topuplib/assets/fonts/Oswald-Medium.ttf", render_scale = G.TILESIZE*10, TEXT_HEIGHT_SCALE = 0.83, TEXT_OFFSET = {x=10,y=-20}, FONTSCALE = 0.1, squish = 1, DESCSCALE = 1})]]

if config.pixellated_rect and (config.pixellated_rect ~= "?none") then
	print("Load pixellated rect: ", pcall(SMODS.load_file(config.pixellated_rect..".lua", config.pixellated_rect_mod)))
end

if config.font and (config.font ~= "?none") then
	print("Load font: ", pcall(SMODS.load_file(config.font..".lua", config.font_mod)))
	local p = topuplib.font_replacement
	if p then
		p.FONT = love.graphics.newFont( "Mods" .. topuplib.modFolderName(config.font_mod or mod.id) .. "assets/fonts/" .. p.file, p.render_scale)
		if p.antialias then
			p.FONT:setFilter("linear", "linear")
		end
		for k,v in pairs(G.LANGUAGES) do
			if v.font == G.FONTS[1] then
				v.font = p
			end
		end
		G.FONTS[1] = p
	end
end

mod.extra_tabs = function() return {
	{
		label = "Customization",
		tab_definition_function = function()
			local pixellated_rect_names = {}
			local pixellated_rect_select = 1
			for k,v in pairs(topuplib.pixellated_rect_options) do
				pixellated_rect_names[k] = v.label
				if v.id == config.pixellated_rect then
					pixellated_rect_select = k
				end
			end
			
			local font_names = {}
			local font_select = 1
			for k,v in pairs(topuplib.font_options) do
				font_names[k] = v.label
				if v.id == config.font then
					font_select = k
				end
			end
			return {n = G.UIT.ROOT, config = {
				colour = mod.ui_config.colour,
			}, nodes = {
				create_option_cycle({
					label = topuplib.localize().uishape_title,
					options = pixellated_rect_names,
					info = {topuplib.localize().uishape_desc .. " " .. topuplib.localize().game_will_restart},
					current_option = pixellated_rect_select,
					colour = G.C.BLUE,
					w = 9,
					opt_callback = topuplib.addUniqueFunc(function(arg)
						local o = topuplib.pixellated_rect_options[arg.cycle_config.current_option]
						config.pixellated_rect = o.id or "?none"
						config.pixellated_rect_mod = (o.id and (o.mod ~= "TopUpLib")) and o.mod or nil
						SMODS.full_restart = math.huge
					end)
				}),
				create_option_cycle({
					label = "Font",
					options = font_names,
					info = {"Change the game's font. Only standard font, not RU/JP/CN/KO. Game will restart."},
					current_option = font_select,
					colour = G.C.BLUE,
					w = 9,
					opt_callback = topuplib.addUniqueFunc(function(arg)
						local o = topuplib.font_options[arg.cycle_config.current_option]
						config.font = o.id or "?none"
						config.font_mod = (o.id and (o.mod ~= "TopUpLib")) and o.mod or nil
						SMODS.full_restart = math.huge
					end)
				}),
				create_option_cycle({
					label = topuplib.localize().detail_title,
					options = {topuplib.localize().detail_low, topuplib.localize().detail_medium, topuplib.localize().detail_high, topuplib.localize().detail_veryhigh},
					info = {topuplib.localize().detail_desc},
					current_option = topuplib.detail,
					colour = G.C.BLUE,
					w = 9,
					opt_callback = topuplib.addUniqueFunc(function(arg)
						local old = config.detail
						config.detail = arg.cycle_config.current_option
						topuplib.detail = config.detail
						topuplib.detail_changed(config.detail, old)
					end)
				})
			}}
		end
	},
	{
		label = "Debug",
		tab_definition_function = function()
			return {n = G.UIT.ROOT, config = {
				colour = mod.ui_config.colour,
			}, nodes = {
				create_option_cycle({
					label = "Crash Prevention Patches",
					options = {"Yes", "No"},
					info = {"Hacky patches to prevent some crashes, but prone to causing bugs."},
					current_option = config.crashpatches,
					colour = G.C.BLUE,
					w = 9,
					opt_callback = topuplib.addUniqueFunc(function(arg)
						config.crashpatches = arg.cycle_config.current_option
						topuplib.preventcrash = config.crashpatches == 1
					end)
				}),
				create_option_cycle({
					label = "Debug Descriptions (UNIMPLEMENTED)",
					options = {"Yes", "No"},
					info = {"Show internal data on items. WIP, can crash on some types. Requires DebugPlus enabled."},
					current_option = config.debugdescription or 2,
					colour = G.C.BLUE,
					w = 9,
					opt_callback = topuplib.addUniqueFunc(function(arg)
						config.debugdescription = arg.cycle_config.current_option
						topuplib.debugdescription = config.debugdescription == 1
					end)
				}),
				create_option_cycle({
					label = "Commands",
					options = {"Fix \"Play\" button crash", "Reset Entropy tutorial"},
					info = {"You only need to use this if something is broken."},
					current_option = 1,
					colour = G.C.BLUE,
					w = 9,
					opt_callback = topuplib.addUniqueFunc(function(arg)
						topuplib.debugfixcommand = arg.cycle_config.current_option
					end)
				}),
				UIBox_button({button = 'topuplib_debug_fix_command', label = {"It's about time."}, minw = 7, focus_args = {snap_to = true}})
				
			}}
		end
	},
	{
		label = "Extra",
		tab_definition_function = function()
			return {n = G.UIT.ROOT, config = {
				colour = mod.ui_config.colour,
			}, nodes = {
				create_option_cycle({
					label = "Enable Updater",
					options = {"Yes", "Only Requirements", "No"},
					info = {"Enable updater: Checks for mod updates/requirements on startup."},
					current_option = config.updater,
					colour = G.C.BLUE,
					w = 9,
					opt_callback = topuplib.addUniqueFunc(function(arg)
						config.updater = arg.cycle_config.current_option
					end)
				}),
				create_toggle({
					label = "Enable if you are a repulsive \"Twitter\" user",
					ref_table = config,
					ref_value = 'stopcallingittwitter',
				})
			}}
		end
	}
} end
SMODS.current_mod.custom_collection_tabs = function()
	return { UIBox_button {
		button = 'your_collection_topuplib_music', label = {topuplib.localize('topuplib', "collection_menus").music}, minw = 5, id = 'your_collection_topuplib_music'
	}}
end

G.FUNCS.topuplib_debug_fix_command = function()
	if topuplib.debugfixcommand == 1 or not topuplib.debugfixcommand then
		topuplib.newRunFix()
	elseif topuplib.debugfixcommand == 2 and G.FUNCS.entropy_tutorial_controller then
		G.F_SKIP_TUTORIAL = nil
		G.SETTINGS.entropy_tutorial_complete = nil
		G.SETTINGS.entropy_tutorial_progress = nil
		G.FUNCS.entropy_tutorial_controller()
		play_sound("multhit1")
	end
end

if topuplib.debug and false then --todo: is this a good idea
	SMODS.current_mod.optional_features = {
		quantum_enhancements = true,
		retrigger_joker = true,
		post_trigger = true,
		cardareas = {deck = true, discard = true}
	}
end

local rq = {
	V("1.0.0~BETA-1920a") > V(SMODS.version) and "auto2x",
	"after_init",
	"global_drawsteps",
	"texteffects",
	"updater",
	"patches",
	"registrymenu",
	"card_anim",
	"universe",
	"universe_bg",
	(topuplib.debug or Cryptid) and "testingcontent"
}

for i, v in ipairs(rq) do
	if v then
		local a = assert(SMODS.load_file("lua/"..v..".lua"))()
		if type(a) == "function" then
			a(topuplib)
		end
	end
end