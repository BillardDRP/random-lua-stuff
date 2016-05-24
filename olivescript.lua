local olivescript = {
	version = "0.1",
	description = "OliveScript is a stupid little language that does stupid little things.",
	author = "Sir Francis Billard",
	garrysmod = {
		enabled = true,
		admin = true,
	},
}

local olivescript.keywords = {
	["?"] = " if ",
	["->"] = " then ",
	["&8"] = " while ",
	["-->"] = " do ",
	["-|"] = "( ",
	["|-"] = " ) ",
	["++"] = " and ",
	["^^"] = " or ",
	[".f"] = " function ",
	[".l"] = " local ",
}

local olivescript.compile = function( code )
	local timeStarted = tonumber ( os.clock() )
	if not code then return end
	local newcode = tostring( code )
	for k, v in pairs( olivescript.keywords ) do
		newcode = string.gsub( tostring( code ), tostring( k ), tostring( v ) )
	end
	print( tostring( newcode ) )
	print( "Compiled Olivescript into Lua in " .. tonumber( os.clock() ) - timeStarted  .. " seconds." )
	return newcode
end

local olivescript.decompile = function( code )
	local timeStarted = tonumber ( os.clock() )
	if not code then return end
	local newcode = tostring( code )
	for k, v in pairs( olivescript.keywords ) do
		newcode = string.gsub( tostring( code ), tostring( v ), tostring( k ) )
	end
	print( tostring( newcode ) )
	print( "Compiled Lua into Olivescript in " .. tonumber( os.clock() ) - timeStarted  .. " seconds." )
	return newcode
end

if olivescript.garrysmod.enabled then
	concommand.Add( "olivescript_compile", function( ply, cmd, args, argsStr )
		if not IsValid( ply ) then return end
		if olivescript.garrysmod.admin and not ply:IsAdmin() then return end
		local code = olivescript.compile( tostring( argsStr ) )
		RunString( code )
	end )
end
