--Emplace calc
local tul_cardarea_emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	tul_cardarea_emplace_ref(self, card, ...)
	if G.jokers then
		eval_card(card, {topuplib_card_emplace = true})
	end
end

--Debuff joker except
tul_debuff_ref = Blind.drawn_to_hand
function Blind:drawn_to_hand(...)
	local a = tul_debuff_ref(self, ...)
	for k,card in pairs(G.jokers.cards) do
		if G.GAME.modifiers.topuplib_debuff_joker_except and not topuplib.getValueIndex(G.GAME.modifiers.topuplib_debuff_joker_except, card.config.center.key) then
			SMODS.debuff_card(card, true, "topuplib_debuff_joker_except")
		end
	end
	return a
end

--Play sound
tul_play_sound_ref = play_sound
local talisman_fallbacks = next(SMODS.find_mod("Talisman")) and {
	talisman_echip = "xchips",
	talisman_eechip = "xchips",
	talisman_eeechip = "xchips",
	talisman_emult = "multhit2",
	talisman_eemult = "multhit2",
	talisman_eeemult = "multhit2"
	--dont add talisman_xchip
} or nil
function play_sound(name, pitch, vol, ...)
	if name == "balance" then
		pitch = pitch or 1
		vol = vol or 1
		play_sound('gong', 0.94*1.5*pitch, 0.2*vol, ...)
		play_sound('tarot1', 1.5*pitch, vol, ...)
		return play_sound('gong', 0.94*pitch, 0.3*vol, ...)
	elseif talisman_fallbacks ~= nil and talisman_fallbacks[name] and not SMODS.Sounds[name] then
		return play_sound(talisman_fallbacks[name], pitch, vol, ...)
	end
	return tul_play_sound_ref(name, pitch, vol, ...)
end

--Get rid of the eyesore
local config = SMODS.Mods.TopUpLib.config
local fuck = G.FUNCS.go_to_twitter
G.FUNCS.go_to_twitter = function(e)
	if config.stopcallingittwitter then
		fuck(e)
	else
		love.system.openURL("https://bsky.app/profile/playbalatro.com")
	end
end
local menu_ref = create_UIBox_main_menu_buttons
function create_UIBox_main_menu_buttons(...)
	local r = menu_ref(...)
	if not config.stopcallingittwitter then
		local b = r.nodes[2].nodes[1].nodes[2] 
		b.config.colour = G.C.WHITE
		local bsky = Sprite(0,0,0.6,0.6,G.ASSET_ATLAS["topuplib_bsky"], {x=0, y=0})
		bsky.states.drag.can = false
		b.nodes[1].config.object = bsky
	end
	return r
end

--Start run init
local start_run_ref = Game.start_run
function Game.start_run(...)
	local ret = {start_run_ref(...)}
	if not G.GAME.topuplib_init then
		topuplib.start_run_init()
	end
	return unpack(ret)
end

--Custom tab injects
local create_tabs_ref = create_tabs
function create_tabs(args)
	for k,v in pairs(topuplib.modOrder) do
		if v.topuplib_tabsModify then
			v.topuplib_tabsModify(args, topuplib.createTabsMeaning)
		end
	end
	topuplib.createTabsMeaning = nil
	return create_tabs_ref(args)
end

local runinfo_ref = G.UIDEF.run_info
function G.UIDEF.run_info(...)
	topuplib.createTabsMeaning = "run_info"
	return runinfo_ref(...)
end

local runsetup_ref = G.UIDEF.run_setup
function G.UIDEF.run_setup(...)
	topuplib.createTabsMeaning = "run_setup"
	return runsetup_ref(...)
end

local usagetabs_ref = G.UIDEF.usage_tabs
function G.UIDEF.usage_tabs(...)
	topuplib.createTabsMeaning = "usage_tabs"
	return usagetabs_ref(...)
end