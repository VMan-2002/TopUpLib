--0: Background
--2: [TopUpLib] Universe Background
--100: self.I.NODE
--200: self.I.MOVEABLE
--300: G.SPLASH_LOGO
--400: UI Boxes without parent (not v.attention_text)
--500: Card Areas without parent
--600: Cards without parent
--700: UI Boxes without parent (v.attention_text)
--800: G.SPLASH_FRONT
--900: Tutorial Overlay
--985: [ElementCatlatro] World End Anim
--1000: Overlay Menu
--1100: Debug Tools
--1200: self.I.ALERT (this?)
--1300: Object Being Dragged
--1400: Focused Card not in hand (what?)
--1500: self.I.POPUP (what?)
--1600: Achievement Notification
--1700: Screenwipe

topuplib.globalDrawSteps = {
}

topuplib.globalDrawStepHandler = {
	steporder = {
		{"bg", 0},
		{"node", 100},
		{"moveable", 200},
		{"splashlogo", 300},
		{"uiboxs", 400},
		{"cardareas", 500},
		{"cards", 600},
		{"uiboxs_attention", 700},
		{"splashfront", 800},
		{"tutorial", 900},
		{"overlaymenu", 1000},
		{"debugtools", 1100},
		{"alert", 1200},
		{"draggednode", 1300},
		{"focusedcardnotinhand", 1400},
		{"popup", 1500},
		{"achievement", 1600},
		{"screenwipe", 1700}
	},
	steps = {},
	orderCheck = function()
		for k,v in pairs(topuplib.globalDrawStepHandler.steps) do
			table.sort(v, function(a, b)
				if a.order == b.order then
					return a.key < b.key
				end
				return a.order > b.order
			end)
		end
	end,
	INITIALRUN = 20,
	INITIALRUN_CHECKS = {},
	RUN_NUM = 0,
	run = function(n)
		topuplib.globalDrawStepHandler.INITIALRUN = topuplib.globalDrawStepHandler.INITIALRUN - 1
		if topuplib.globalDrawStepHandler.INITIALRUN == 0 then
			if topuplib.countKeys(topuplib.globalDrawStepHandler.INITIALRUN_CHECKS) ~= #topuplib.globalDrawStepHandler.steporder then
				local a = {}
				for k,v in ipairs(topuplib.globalDrawStepHandler.steporder) do
					if not topuplib.globalDrawStepHandler.INITIALRUN_CHECKS[v[1]] then
						table.insert(a, v[1])
					end
				end
				print("[topuplib.globalDrawStepHandler.run] The following global draw steps failed to be injected: "..table.concat(a, ", "))
				print("[topuplib.globalDrawStepHandler.run] Global Draw Steps may fail to work entirely.")
			else 
				print("[topuplib.globalDrawStepHandler.run] All Global Draw Steps injections appear to be working.")
			end
			topuplib.globalDrawStepHandler.run = topuplib.globalDrawStepHandler.run_a
		end
		topuplib.globalDrawStepHandler.INITIALRUN_CHECKS[n] = true
	end,
	run_a = function(n)
		if topuplib.globalDrawStepHandler.RUN_NUM ~= 17 or n ~= topuplib.globalDrawStepHandler.steporder[topuplib.globalDrawStepHandler.RUN_NUM + 1][1] then
			return
		end
		topuplib.globalDrawStepHandler.RUN_NUM = topuplib.globalDrawStepHandler.RUN_NUM + 1
		print("Draw step "..n)
		for k,v in ipairs(topuplib.globalDrawStepHandler.steps[n]) do
			love.graphics.push()
			v.func()
			love.graphics.pop()
		end
		return true
	end,
}

for k,v in pairs(topuplib.globalDrawStepHandler.steporder) do
	topuplib.globalDrawStepHandler.steps[v[1]] = {}
end

topuplib.globalDrawStep = function(d)
	assert(d.key, "[topuplib.globalDrawStep] Missing key!")
	d.key = SMODS.current_mod.prefix .. "_" .. d.key
	assert(d.order, "[topuplib.globalDrawStep] "..d.key.." missing order!")
	assert(d.func, "[topuplib.globalDrawStep] "..d.key.." missing func!")
	local a = 1
	while topuplib.globalDrawStepHandler.steporder[a][2] > d.order do
		a = a + 1
	end
	table.insert(topuplib.globalDrawStepHandler.steps[topuplib.globalDrawStepHandler.steporder[a][1]], d)
	topuplib.globalDrawSteps[d.key] = d
end

--this doesnt show up? what's going wrong?
topuplib.globalDrawStep({
	key = "test",
	order = 1650,
	func = function()
		love.graphics.print("Hello World!")
	end
})