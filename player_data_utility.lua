PlayerData = {}
PlayerData.SaveData = function( ply, directory, data )
	if not file.Exists( directory ) then
	file.CreateDir( directory )
	end
end
