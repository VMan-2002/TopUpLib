local circle = {}
do
	local div = math.pi / 48
	for i = 0, 96 do
		circle[#circle + 1] = math.sin(i * div)
		circle[#circle + 1] = math.cos(i * div)
	end
end

topuplib.pixellated_rect = function(l, t, w, h)
	w, h = w*0.5, h*0.5
	local mx, my = l+w, t+h
	local verts = {mx,my}
	local isx = false
	for k,v in pairs(circle) do
		isx = not isx
		verts[k] = (circle[k] * (isx and w or h)) + (isx and mx or my) 
	end
	return verts
end