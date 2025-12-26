if SMODS.current_mod.config.updater == 3 then return end

print("TopUpLib updater check")

--Detect mod list changes
local modList = {}
for k,v in pairs(SMODS.Mods) do
	modList[#modList + 1] = v.id .. "%" .. v.version
end
table.sort(modList)

local toCheck = {}
local needs = {}
local shouldCheck = SMODS.current_mod.config.nextUpdateCheck <= os.time()
if SMODS.current_mod.config.lastModList ~= modList then
	print("Mod list changes found")
	SMODS.current_mod.config.lastModList = modList
	SMODS.save_mod_config(SMODS.current_mod)
	shouldCheck = true
end

G.FUNCS.topuplib_update_link = function(o, ...)
	objT = {o, ...}
	--TODO: surely there MUST be a better way than this pile of absolute what?
	for k,v in pairs(o.UIBox.definition.nodes[1].nodes[1].nodes[1].nodes) do
		table.insert(objT, v)
		if v.tul_update_id and v.nodes[1].nodes[1].config.button_UIE == o then
			love.system.openURL("https://github.com/" .. toCheck[v.tul_update_id].githubPath)
		end
	end
end

do
	local function addCheck(m, d)
		local need = needs[d.id] or {}
		need[m] = d.type or "required"
		needs[d.id] = need
		local v = toCheck[d.id]
		if v and (v.id == d.id) then
			if V(d.version) <= V(v.version) then
				toCheck[k] = d
			end
			return
		end
		toCheck[d.id] = d
	end
	
	local function modTitle(m)
		return SMODS.Mods[m] and (SMODS.Mods[m].name .. " ("..m..")") or m
	end
	
	local unsupport = {}
	for k,v in pairs(SMODS.Mods) do
		local foldername = topuplib.modFolderName(k)
		
		if foldername and love.filesystem.exists("Mods" .. foldername .. "topuplib_meta.json") then
			print("Mod "..k.." update check")
			local succ, d = pcall(function() return JSON.decode(love.filesystem.read("Mods"..foldername.."topuplib_meta.json")) end)
			if not succ then error("Failed to read topuplib_meta.json for mod "..k..": "..d) end
			if d.githubPath then
				print("mod github path: " .. d.githubPath)
			end
			if d.relations then
				print("mod relations", d.relations)
				for k2,v2 in pairs(d.relations) do
					if not SMODS.Mods[v2.id] then
						shouldCheck = true
						addCheck(k, v2)
					end
				end
			end
		else
			unsupport[#unsupport + 1] = k
		end
	end
	print("TUL check lol")
	print(#unsupport)
	if #unsupport ~= 0 then
		print("Unsupported mods: "..table.concat(unsupport, ", "))
	end
	print(toCheck)
	print(needs)
	if next(toCheck) then
		local textline = function(n, scale)
			return {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
				{n=G.UIT.T, config={text = n, scale = (4/7) * (scale or 1), colour = G.C.UI.TEXT_LIGHT, shadow = true}},
			}}
		end
		local lines = {textline("TopUpLib update checker", 2/3)}
		table.insert(lines, next(needs) and textline("Requirements needed!" or "Updates needed!"))
		for k,v in pairs(toCheck) do
			local btn = UIBox_button({button = 'topuplib_update_link', label = {modTitle(v.id).." at "..v.githubPath}, minw = 7, focus_args = {snap_to = true}})
			btn.tul_update_id = v.id
			table.insert(lines, btn)
			for k2,v2 in pairs(needs[v.id]) do
				table.insert(lines, textline(v2.." by "..modTitle(k2), 0.5))
			end
		end

		local UIBox_topuplib_update = function()
			local t = create_UIBox_generic_options({ contents = lines })
			return t
		end
		
		local mainmenu_ref = G.main_menu
		function G.main_menu(...)
			mainmenu_ref(...)
			
			G.FUNCS.overlay_menu{
				definition = UIBox_topuplib_update()
			}
		end
	else
		print("No update check")
	end
end