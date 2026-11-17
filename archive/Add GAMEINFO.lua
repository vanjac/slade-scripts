-- Add ZDoom GAMEINFO lump with the currently selected IWAD and a list of all
-- other currently open archives.

return function(archive)
	local iwad = Archives.BaseResource().filename:match("([^/\\]*)$")
	local gameinfo = 'IWAD="' .. iwad .. '"'
	local firstPwad = true
	for _, other in ipairs(Archives.All()) do
		if other.filename ~= archive.filename then
			gameinfo = gameinfo .. (firstPwad and '\nLOAD="' or ',"')
			gameinfo = gameinfo .. other.filename .. '"'
			firstPwad = false
		end
	end

	local entry = archive:EntryAtPath("GAMEINFO")
	if not entry then
		entry = archive:CreateEntry("GAMEINFO", 0)
	end
	entry:ImportData(gameinfo)
end
