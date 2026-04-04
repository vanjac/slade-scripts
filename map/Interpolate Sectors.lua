-- With multiple sectors selected, interpolate properties between the first
-- sector and last sector, in order. Use to create stairs, light gradients, etc.

function Execute(map)
	local sel = App.MapEditor():SelectedSectors()
	local len = #sel
	if len < 2 then
		UI.MessageBox("Interpolate Sectors", "Not enough sectors selected")
		return
	end
	local a = sel[1]
	local b = sel[len]

	local propsInput = UI.PromptString(
		"Interpolate Sectors",
		len.." sectors ("..(len - 1).." steps)"..
		"\nFloor step: "..((b.heightFloor - a.heightFloor) / (len - 1))..
		"\nCeiling step: "..((b.heightCeiling - a.heightCeiling) / (len - 1))..
		"\n\nProperties to interpolate:",
		"heightfloor heightceiling lightlevel"
	)
	if propsInput == "" then
		return
	end
	local properties = {}
	for str in string.gmatch(propsInput, "%S+") do
		table.insert(properties, str)
	end

	local aVals = {}
	local bVals = {}
	for p, prop in ipairs(properties) do
		aVals[p] = a:IntProperty(prop)
		bVals[p] = b:IntProperty(prop)
	end

	for s, sector in ipairs(sel) do
		local aFactor = (len - s) / (len - 1)
		local bFactor = (s - 1) / (len - 1)
		for p, prop in ipairs(properties) do
			sector:SetIntProperty(prop, aVals[p] * aFactor + bVals[p] * bFactor)
		end
	end
end
