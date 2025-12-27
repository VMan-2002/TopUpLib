local tul_cardarea_emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
	tul_cardarea_emplace_ref(self, card, ...)
	if G.jokers then
		eval_card(card, {topuplib_card_emplace = true})
	end
end