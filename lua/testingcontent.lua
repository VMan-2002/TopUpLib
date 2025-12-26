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

	local j_infinit = SMODS.Joker {
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

	local stake_infinit = SMODS.Stake {
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

	local bl_infinit = SMODS.Blind {
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

	local bl_debuff = SMODS.Blind {
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

	local bl_notallowed = SMODS.Blind {
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
	if Partner_API then
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
	
	inject_ref(...)
end