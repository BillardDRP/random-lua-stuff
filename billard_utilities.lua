BillardUtilities = {}

BillardUtilities.SavePlayerData = function( ply, directory, data )
	if not file.Exists( directory ) then
		file.CreateDir( directory )
	end
	local PlyID = ply:SteamID()
	file.Write( directory..PlyID, data )
end

BillardUtilities.LoadPlayerData = function( ply, directory )
	if not file.Exists( directory..PlyID ) then
		return
	end
	local data = file.Read( directory..PlyID, "DATA" )
	return data
end

BillardUtilities.CreateChatCommand = function( command, name, callback )
	hook.Add( "PlayerSay", name, function( ply, text, isTeam )
		if not IsValid( ply ) then return end
		if text == command then
			callback( ply, text, isTeam )	
		end
	end )
end
