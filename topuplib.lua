--	so uhhh yeah
--	this is library!

topuplib = topuplib or {}
local topuplib = topuplib
topuplib.tforms = {
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
			print(name .. ": " .. tostring(value) .. ", table with length " .. #value .. " and " .. tostring(r).." keys")
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
	--Fallback for to_number from talisman
	topuplib.num = to_number or topuplib.same
	--Fallback for to_big from talisman
	topuplib.big = to_big or topuplib.same
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
		local modfolder = string.sub(modlol, string.find(modlol, "/"), nil)
		return modfolder
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
	--Gets localized key of an object of any type
	topuplib.nameFromKey = function(key, fallback)
		for _,grp in pairs(G.localization.descriptions) do
			if grp[key] then
				return grp[key].name
			end
		end
		return fallback or key
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
		return topuplib.tforms[f]..text
	end
	--Deprecated
	--Adds predefined formatting and joins strings
	topuplib.formatText = function(arr)
		local result = ""
		for k,v in pairs(arr) do
			result = result .. topuplib.formatString(v[1] or "", v[2] or "r")
		end
		return result
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

mod.config_tab = function()
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
			label = "UI Element Shape",
			options = pixellated_rect_names,
			info = {"The shape of UI element boxes (pixellated_rect). Game will restart."},
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
		create_option_cycle({
			label = "Crash Prevention Patches",
			options = {"Yes", "No"},
			info = {"Hacky patches to prevent crashes, but prone to causing bugs."},
			current_option = config.updater,
			colour = G.C.BLUE,
			w = 9,
			opt_callback = topuplib.addUniqueFunc(function(arg)
				config.crashpatches = arg.cycle_config.current_option
				topuplib.preventcrash = config.crashpatches == 1
			end)
		})
	}}
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
	"updater",
	"patches",
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