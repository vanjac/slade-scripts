-- Add a COMPLVL lump to the archive.

function Execute(archive)
	local complvl = UI.PromptString(
		"COMPLVL", "Options: vanilla, boom, mbf, mbf21", "boom"
	)
	if complvl ~= "" then
		local entry = archive:CreateEntry("COMPLVL", 0)
		entry:ImportData(complvl)
	end
end
