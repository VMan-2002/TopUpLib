--Atlas
SMODS.Atlas {
	key = "testingcontent",
	px = 71,
	py = 95,
	path = "testingcontent.png"
}
SMODS.Atlas {
	key = "testingcontent_sleeves",
	px = 73,
	py = 94,
	path = "testingcontent_sleeves.png"
}
SMODS.Atlas {
	key = "testingcontent_partner",
	px = 46,
	py = 58,
	path = "testingcontent_partner.png"
}
SMODS.Atlas {
	key = "testingcontent_stake",
	px = 29,
	py = 29,
	path = "testingcontent_stake.png"
}
SMODS.Atlas {
	key = "testingcontent_blind",
	px = 34,
	py = 34,
	path = "testingcontent_blind.png",
	atlas_table = "ANIMATION_ATLAS",
	frames = 21
}

--Collection lol
if topuplib.debug then
	local collection_ref = create_UIBox_your_collection
	function create_UIBox_your_collection(...)
		local ret = collection_ref(...)
		G_tmp_lol = ret
		table.insert(ret.nodes[1].nodes[1].nodes[1].nodes[2].nodes,
			UIBox_button({button = 'your_collection_topuplib_debug', label = {G.localization.topuplib.debug_centers}, minw = 5, id = 'your_collection_topuplib_debug'}))
		return ret
	end

	G.FUNCS.your_collection_topuplib_debug = function(e)
		G.SETTINGS.paused = true
		G.FUNCS.overlay_menu{
			definition = create_UIBox_your_collection_topuplib_debug(),
		}
		G.FUNCS.your_collection_topuplib_debug_page({cycle_config = {current_option = 1}})
	end
	function create_UIBox_your_collection_topuplib_debug()
		local deck_tables = {}

		G.your_collection = {}
		for j = 1, 3 do
			G.your_collection[j] = CardArea(
				G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
				7*G.CARD_W,
				0.95*G.CARD_H, 
				{card_limit = 7, type = 'title', highlight_limit = 0, collection = true}
			)
			table.insert(deck_tables, 
				{n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true},
				nodes={{n=G.UIT.O, config={object = G.your_collection[j]}}}
			})
		end

		local joker_options = {}
		for i = 1, math.ceil(#topuplib.debug_item_keys/(7*#G.your_collection)) do
			table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#topuplib.debug_item_keys/(7*#G.your_collection))))
		end
		
		local t = create_UIBox_generic_options({ back_func = 'your_collection', contents = {
			{n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
			{n=G.UIT.R, config={align = "cm"}, nodes={
				create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_topuplib_debug_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
			}}
		}})
		return t
	end
	G.FUNCS.your_collection_topuplib_debug_page = function(args)
		if not args or not args.cycle_config then return end
		for j = 1, #G.your_collection do
			for i = #G.your_collection[j].cards,1, -1 do
				local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
				c:remove()
				c = nil
			end
		end
		for i = 1, 7 do
			for j = 1, #G.your_collection do
				local key = topuplib.debug_item_keys[i+(j-1)*7 + (7*#G.your_collection*(args.cycle_config.current_option - 1))]
				if not key then break end
				local center = topuplib.debug_item_key_get(key)
				local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
				card.bypass_discovery_center = true
				G.your_collection[j]:emplace(card)
			end
		end
	end
end

--Items
local inject_ref = SMODS.injectItems
function SMODS.injectItems(...)
	local b_infinit = SMODS.Back {
		key = "topuplib_infinit",
		atlas = "topuplib_testingcontent",
		pos = {x=0,y=0},
		config = {
			joker_slot = 9e8, consumable_slot = 9e8, hands = 990, discards = 990, dollars = 9e5
		},
		unlocked = true
	}

	local lol = 1e300
	local j_infinit, stake_infinit, bl_infinit, bl_debuff, bl_notallowed

	if topuplib.debug then
		j_infinit = SMODS.Joker {
			key = "topuplib_infinit",
			loc_vars = function()
				return {vars = {lol}}
			end,
			atlas = "topuplib_testingcontent",
			pos = {x=1,y=0},
			calculate = function(_, _, context)
				if context.joker_main then
					return {mult = lol, chips = lol}
				end
			end,
			unlocked = true,
			discovered = true,
			in_pool = topuplib.returnFalse
		}

		stake_infinit = SMODS.Stake {
			key = "topuplib_infinit",
			atlas = "topuplib_testingcontent_stake",
			pos = {x=0,y=0},
			unlocked = true,
			applied_stakes = {},
			modifiers = function()
				G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 9e8
				G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + 9e5
				G.GAME.starting_params.hands = G.GAME.starting_params.hands + 990
				G.GAME.starting_params.discards = G.GAME.starting_params.discards + 990
				G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots + 9e8
			end
		}

		bl_infinit = SMODS.Blind {
			key = "topuplib_infinit",
			atlas = "topuplib_testingcontent_blind",
			pos = {x=0,y=0},
			unlocked = true,
			discovered = true,
			in_pool = topuplib.returnFalse,
			boss = {min = -99, max = 1e4},
			mult = 1e280,
			boss_colour = HEX("8766FF")
		}

		bl_debuff = SMODS.Blind {
			key = "topuplib_debuff",
			atlas = "topuplib_testingcontent_blind",
			pos = {x=0,y=1},
			unlocked = true,
			discovered = true,
			in_pool = topuplib.returnFalse,
			boss = {min = -99, max = 1e4},
			mult = 1,
			boss_colour = HEX("FF2C2B"),
			recalc_debuff = function(self, card)
				if self.debuffCategory == 1 then
					return true
				elseif self.debuffCategory == 2 then
					return card.area == G.hand
				elseif self.debuffCategory == 3 then
					if card.area ~= G.hand then	return false end
					for k,v in ipairs(G.hand.cards) do
						if v == card and k - 0.7 < #G.hand.cards * 0.5 then return true end
					end
				elseif self.debuffCategory == 4 then
					return card.area == G.hand and card.area.cards[1] == card
				elseif self.debuffCategory == 5 then
					return card.config.center.set == "Joker"
				elseif self.debuffCategory == 6 then
					return card.area == G.jokers and card.area.cards[1] == card
				end
				return false
			end,
			debuffCategory = 1
		}

		local bclick = Blind.click
		function Blind.click(self, ...) 
			if self.name == "bl_topuplib_debuff" then
				bl_debuff.debuffCategory = bl_debuff.debuffCategory + 1
				local cat = {
					"Now debuffing ALL CARDS",
					"Now debuffing CARDS IN HAND",
					"Now debuffing LEFT HALF OF HAND",
					"Now debuffing LEFTMOST CARD IN HAND",
					"Now debuffing JOKERS",
					"Now debuffing LEFTMOST JOKER"
					--other debuff categories
				}
				if bl_debuff.debuffCategory > #cat then
					bl_debuff.debuffCategory = 1
				end
				print(cat[bl_debuff.debuffCategory])
				
				for k,v in pairs({
					G.hand,
					G.jokers
					--other types of debuffables
				}) do
					if v then
						for _,v2 in pairs(v.cards) do
							SMODS.recalc_debuff(v2)
						end
					end
				end
			end
			bclick(self, ...)
		end

		bl_notallowed = SMODS.Blind {
			key = "topuplib_notallowed",
			atlas = "topuplib_testingcontent_blind",
			pos = {x=0,y=2},
			unlocked = true,
			discovered = true,
			in_pool = topuplib.returnFalse,
			boss = {min = -99, max = 1e4},
			mult = 1,
			boss_colour = HEX("FD0092"),
			debuff = {
				h_size_le = -1e9
			}
		}
	end

	local sleeve_infinit
	if CardSleeves then
		sleeve_infinit = CardSleeves.Sleeve {
			key = "topuplib_infinit",
			atlas = "topuplib_testingcontent_sleeves",
			pos = {x=0,y=0},
			config = {
				joker_slot = 9e8, consumable_slot = 9e8, hands = 990, discards = 990, dollars = 9e5
			},
			unlocked = true
		}
	end
	
	local partner_infinit
	if Partner_API and topuplib.debug then
		partner_infinit = Partner_API.Partner {
			key = "topuplib_infinit",
			atlas = "topuplib_testingcontent_partner",
			pos = {x=0,y=0},
			config = {
				hands = 990, discards = 990
			},
			calculate_begin = function(self, card)
				if G.jokers then G.jokers.config.card_limit = G.jokers.config.card_limit + 9e8 end
				if G.consumeables then G.consumeables.config.card_limit = G.consumeables.config.card_limit + 9e8 end
				if G.GAME and G.GAME.dollars then G.GAME.dollars = G.GAME.dollars + 9e5 end
			end,
			unlocked = true,
			discovered = true
		}
		partner_infinit_mult = Partner_API.Partner {
			key = "topuplib_infinit_mult",
			atlas = "topuplib_testingcontent_partner",
			pos = {x=1,y=0},
			calculate = function(_, _, context)
				if context.joker_main then
					return {mult = lol, chips = lol}
				end
			end,
			unlocked = true,
			discovered = true
		}
	end
	
	for k,v in pairs({b_infinit, j_infinit, sleeve_infinit, stake_infinit, bl_infinit, bl_debuff, bl_notallowed, partner_infinit, partner_inifinit_mult}) do
		if v then
			--Since this content is registered outside of the initial mod loading
			--(bc otherwise we can't reference CardSleeves)
			--we manually make sure the origin mod is correctly set
			v.mod = SMODS.Mods.TopUpLib
			v.original_mod = SMODS.Mods.TopUpLib
		end
	end
	
	do --Add other mod's things to Debug Essentials
		local existadds = {
			"j_cry_Double Scale", --what?
			"j_cry_maximized",
			"j_cry_kidnap",
			"j_cry_oldcandy",
			"j_cry_panopticon",
			"j_cry_sync_catalyst",
			"j_cry_maze",
			"j_cry_altgoogol",
			"j_cry_error",
			"j_cry_fractal",
			"j_cry_tropical_smoothie",
			"j_cry_oil_lamp",
			"j_cry_digitalhallucinations",
			"j_cry_demicolon",
			"j_cry_scalae",
			"j_cry_effarcire",
			"j_cry_tenebris",
			"j_cry_crustulum"
		}
		for k,v in pairs(existadds) do
			if SMODS.Centers[v] then
				table.insert(topuplib.debug_item_keys, v)
			end
		end
	end
	
	inject_ref(...)
end