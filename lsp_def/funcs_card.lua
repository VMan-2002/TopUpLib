---@meta

---funcs_card

---@param cards table A table of cards to perform on, such as G.hand.highlighted
---@param func function A function to call on each card, as func(card, i)
---@param cond function|bool A condition for which cards should be affected. As a bool, checks if card is highlighted. As a function, calls the function as cond(card, i)
--- Runs a tarot-like effect where given cards flip, run a function on each card, then flip back.
function topuplib.tarotEffect(cards, func, cond) end