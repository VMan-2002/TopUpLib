topuplib.pixellated_rect = function(l, t, w, h)
	local r, b = l+w, t+h
	return {l+(w*0.5), t+(h*0.5), l, b, r, b, r, t, l, t, l, b}
end