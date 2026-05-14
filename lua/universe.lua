local start_run_ref = Game.start_run
function Game:start_run(args, ...)
	local r = start_run_ref(self, args, ...)
	print("Start run")
	print(G.GAME.topuplib_universe)
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			delay = 0,
			timer = 'REAL',
			func = function()
				if not G.GAME.topuplib_universe then
					G.GAME.topuplib_universe = {vars = {}}
					topuplib.universe.travel(G.GAME.modifiers.topuplib_starting_universe or "balatro")
				else
					topuplib.universes[G.GAME.topuplib_universe.current].init()
				end
				return true
			end
		}))
end

topuplib.universes = {
	balatro = {init = topuplib.returnFalse}
}

topuplib.universe = {
	--Travel to a universe, optionally with a transition
	travel = function(name, transition)
		assert(topuplib.universes[name], "[topuplib.universe.travel] The target universe \""..name.."\" is not defined!")
		if not transition then
			local from = topuplib.universes[G.GAME.topuplib_universe.current]
			if from and from.leave then
				from.leave()
			end
			G.GAME.topuplib_universe.current = name
			G.GAME.topuplib_universe.vars[name] = G.GAME.topuplib_universe.vars[name] or {}
			topuplib.universe.vars = {}
			topuplib.universes[name].init()
			if topuplib.universes[name].arrive then
				topuplib.universes[name].arrive()
			end
		end
	end,
	universes = {}
}

local wipeoff_ref = G.FUNCS.wipe_off
G.FUNCS.wipe_off = function(...)
	if topuplib.universe.background then
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0,
			no_delete = true,
			timer = 'REAL',
			func = function()
				topuplib.universe.background = nil
				return true
			end
		}))
	end
	wipeoff_ref(...)
end

local gcp_hook = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)
	if G.GAME.topuplib_universe then --what
		local gcp_new = topuplib.universes[G.GAME.topuplib_universe.current].get_current_pool_args
		if gcp_new then
			_type, _rarity, _legendary, _append = gcp_new(_type, _rarity, _legendary, _append)
		end
	end
	return gcp_hook(_type, _rarity, _legendary, _append)
end