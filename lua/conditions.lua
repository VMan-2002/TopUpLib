topuplib.conditions = topuplib.conditions or {}

--If there are cards in your hand
topuplib.conditions.handNotEmpty = function()
	return G.hand or next(G.hand.cards)
end

--If you have jokers
topuplib.conditions.jokersNotEmpty = function()
	return G.jokers or next(G.jokers.cards)
end