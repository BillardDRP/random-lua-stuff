ScriptCraft = {}
ScriptCraft.Limit = {}
ScriptCraft.Limit.Weapons = 2
ScriptCraft.Limit.Entities = 2
ScriptCraft.Limit.Scripts = 2
ScriptCraft.BlockedFunctions = {
	[":SetHealth"] = true
	[":SetMaxHealth"] = true
	[":Kill"] = true
	["net."] = true
	[":IsAdmin"]
}

if not file.Exists( "scriptcraft_scripts" ) then
	file.CreateDir( "scriptcraft_scripts" )
end

concommand.Add( "scriptcraft_loadscript", function( ply, cmd, args )
	if not args[1] then return end
	local PlayerScript = tostring( args[1] )
	local PlayerSteamID = ply:SteamID()
	if not file.Exists( "scriptcraft_scripts/"..PlayerSteamID.."/"..PlayerScript ) then return end
	for k, v in pairs( ScriptCraft.BlockedFunctions ) do
		if string.find( PlayerScriptContent, v ) then
			ply:ChatPrint( "Your script contains illegal commands!" )
			return
		end
	end
end )
