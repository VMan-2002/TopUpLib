local circle = {}
local index = {1,3,5,7,7,9,11,13,13,15,17,19,19,21,23,1,1}
do
	local div = math.pi / 6
	for i = 0, 12 do
		circle[#circle + 1] = math.sin((i-3) * div)
		circle[#circle + 1] = math.cos((i-3) * div)
	end
end

topuplib.pixellated_rect = function(l, t, w, h, res)
	res = res*6
	local r, b = l+w-res, t+h-res
	l, t = l+res, t+res
	local corner = {l, b, r, b, r, t, l, t, l, b}
	local verts = {l+(w*0.5), t+(h*0.5)}
	for k,v in pairs(index) do
		local corner_n = (math.floor((k-1) * 0.25) * 2)
		verts[#verts+1] = (circle[v]*res) + corner[corner_n + 1]
		verts[#verts+1] = (circle[v + 1]*res) + corner[corner_n + 2]
	end
	return verts
end