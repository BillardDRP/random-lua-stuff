PlayerData = {}
PlayerData.SaveData = function( ply, directory, data )
	if not file.Exists( directory ) then
		file.CreateDir( directory )
	end
	local PlyID = ply:SteamID()
	file.Write( directory..PlyID, data )
end
PlayerData.LoadData = function( ply, directory )
	if not file.Exists( directory..PlyID ) then
		return
	end
	local data = file.Read( directory..PlyID, "DATA" )
	return dat
end
