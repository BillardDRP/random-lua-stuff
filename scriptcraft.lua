local ScriptCraft = {}
local ScriptCraft.Limit = {}
local ScriptCraft.Limit.Weapons = 2
local ScriptCraft.Limit.Entities = 2
local ScriptCraft.Limit.Scripts = 2
local ScriptCraft.BlockedFunctions = {
	[1] = ":Ignite("
	[2] = ":Kill("
	[3] = ":SetArmor("
	[4] = ":SetHealth("
	[5] = ":IsAdmin("
	[6] = "net."
	[7] = "RunConsoleCommand("
	[8] = ":ConCommand("
}

if not file.Exists( "scriptcraft_scripts" ) then
	file.CreateDir( "scriptcraft_scripts" )
end

concommand.Add( "scriptcraft_loadscript", function( ply, cmd, args )
	if not args[1] then return end
	local PlayerScript = tostring( args[1] )
	local PlayerSteamID = ply:SteamID()
	if not file.Exists( "scriptcraft_scripts/"..PlayerSteamID.."/"..PlayerScript..".lua" ) then
		file.CreateDir( "scriptcraft_scripts/"..PlayerSteamID.."/" )
		file.Write( "scriptcraft_scripts/"..PlayerSteamID.."/"..PlayerScript..".lua", PlayerScript )
	end
	for k, v in pairs( ScriptCraft.BlockedFunctions ) do
		if string.find( PlayerScriptContent, v ) then
			ply:ChatPrint( "Your script contains illegal commands!" )
			return
		end
	end
	BroadcastLua( PlayerScript )
end )
