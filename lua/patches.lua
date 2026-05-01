local tul_cardarea_emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	tul_cardarea_emplace_ref(self, card, ...)
	if G.jokers then
		eval_card(card, {topuplib_card_emplace = true})
	end
end

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

tul_play_sound_ref = play_sound
function play_sound(name, pitch, vol, ...)
	if name == "balance" then
		pitch = pitch or 1
		vol = vol or 1
		play_sound('gong', 0.94*1.5*pitch, 0.2*vol, ...)
		play_sound('tarot1', 1.5*pitch, vol, ...)
		return play_sound('gong', 0.94*pitch, 0.3*vol, ...)
	end
	return tul_play_sound_ref(name, pitch, vol, ...)
end