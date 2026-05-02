-- Add ZDoom GAMEINFO lump with the currently selected IWAD and a list of all
-- other currently open archives.

function Execute(archive)
	local iwad = Archives.BaseResource().filename:match("([^/\\]*)$")
	local gameinfo = 'IWAD="' .. iwad .. '"'
	local firstPwad = true
	for _, other in ipairs(Archives.All()) do
		if other ~= archive then
			gameinfo = gameinfo .. (firstPwad and '\nLOAD="' or ',"')
			gameinfo = gameinfo .. other.filename .. '"'
			firstPwad = false
		end
	end
	
	local entry = archive:CreateEntry("GAMEINFO", 0)
	entry:ImportData(gameinfo)
end
