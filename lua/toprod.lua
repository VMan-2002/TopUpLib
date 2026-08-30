local a = pcall(function() SMODS.Atlas({
	key = "toprod",
	path = "toprod.png",
	px = 71,
	py = 95,
}) end)

local i = function()
	FishAndChips.Rod {
		key = "toprod",
		atlas = a and "toprod" or "fac_rods",
		pos = { x = 0, y = a and 0 or 1 },
		unlocked = true,
		discovered = true,
		config = {
			fishing = {
				bar_size = 9,
				catch_gain = 9,
				toprod = true
			}
		},
		loc_txt = {
			name = "Top Rod",
			text = {"{C:attention}Guaranteed","catch","Start with","extra {C:fac_sand_dollars,f:fac_sand_dollars}${C:fac_sand_dollars}999{}"}
		},
		ppu_coder = { "VMan_2002" },
		prefix_config = {atlas = a}
	}
end

local start_run_ref = topuplib.start_run_init
function topuplib.start_run_init(...)
	local ret = {start_run_ref(...)}
	if (FishAndChips.get_rod().config.fishing.toprod) then
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			func = function()
				G.GAME.fac_sand_dollars = G.GAME.fac_sand_dollars + 999
				return true
			end
		}))
	end
	return unpack(ret)
end

topuplib.afterInit(i)