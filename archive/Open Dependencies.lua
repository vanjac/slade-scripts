-- Find the _DEPINFO lump created by "Add Dependencies", and open all listed
-- archives.

function Execute(archive)
	local depEntry = archive:EntryAtPath("_DEPINFO")
	if depEntry then
		for path in string.gmatch(depEntry.data:AsString(), '[^\n]+') do
			Archives.OpenFile(path)
		end
	end
	App.ShowArchive(archive)
end
