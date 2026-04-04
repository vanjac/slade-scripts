-- Add a _DEPINFO lump with a list of all other currently open archives.
-- Use the "Open Dependencies" script to restore this state later.

function Execute(archive)
	local depends = ""
	for _, other in ipairs(Archives.All()) do
		if other ~= archive then
			depends = depends .. other.filename .. "\n"
		end
	end
	local entry = archive:CreateEntry("_DEPINFO", 0)
	entry:ImportData(depends)
end
