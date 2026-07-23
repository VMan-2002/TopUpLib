--Downward shift, intended for subscript
SMODS.DynaTextEffect {
    key = "sub",
    func = function (self, index, letter)
		letter.offset.y = -35
    end
}

--Upward shift, intended for subscript
SMODS.DynaTextEffect {
    key = "super",
    func = function (self, index, letter)
		letter.offset.y = 20
    end
}

--Shake
SMODS.DynaTextEffect {
    key = "shake",
    func = function (self, index, letter)
        letter.offset.x = -10 + (math.random() * 20)
        letter.offset.y = -10 + (math.random() * 20)
    end
}

--Twitch
SMODS.DynaTextEffect {
    key = "twitch",
    func = function (self, index, letter)
		if (not letter._twitch) then
			letter._twitch = {false, math.random() * 2.2}
			return
		end
		letter._twitch[2] = letter._twitch[2] - love.timer.getDelta()
		if (letter._twitch[2] <= 0) then
			letter._twitch[1] = not letter._twitch[1]
			letter._twitch[2] = letter._twitch[1] and 0.06 or (1 + (math.random() * 1))
			if letter._twitch[1] then
				letter.offset.x = -18 + (math.random() * 36)
				letter.offset.y = -18 + (math.random() * 36)
			else
				letter.offset.x = 0
				letter.offset.y = 0
			end
		end
    end
}

--Pop
SMODS.DynaTextEffect {
    key = "pop",
    func = function (self, index, letter)
		local s = math.sin((G.TIMERS.REAL * 5) - (index * 0.5))
		letter.offset.x = (s * 15) * (-1 + ((index / self.string:len()) * 2))
		letter.offset.y = (1 - s) * 30
		letter.scale = 1.1 - (s * 0.2)
    end
}