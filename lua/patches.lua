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