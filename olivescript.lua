local olivescript = {
	version = "0.1",
	description = "OliveScript is a stupid little language that does stupid little things.",
	author = "Sir Francis Billard",
}

local olivescript.keywords = {
	["?"] = " if ",
	["->"] = " then ",
	["&8"] = " while ",
	["-->"] = " do ",
	["-|"] = " ( ",
	["|-"] = " ) ",
	["++"] = " and ",
	["^^"] = " or ",
	[".f"] = " function ",
	[".l"] = " local ",
}

local olivescript.compile = function( code )
	local timeStarted = tonumber ( os.time() )
	if not code then return end
	local newcode = tostring( code )
	for k, v in pairs( olivescript.keywords ) do
		string.gsub( code, k, v )
	end
	local timeEnded = tonumber( os.time() )
	local timeTaken = tonumber( os.difftime( timeStarted, timeEnded ) )
	print( "Compiled Olivescript into Lua in " .. timeTaken .. " seconds." )
end

local olivescript.decompile = function( code )
	local timeStarted = tonumber ( os.time() )
	if not code then return end
	local newcode = tostring( code )
	for k, v in pairs( olivescript.keywords ) do
		string.gsub( code, v, k )
	end
	local timeEnded = tonumber( os.time() )
	local timeTaken = tonumber( os.difftime( timeStarted, timeEnded ) )
	print( "Compiled Lua into Olivescript in " .. timeTaken .. " seconds." )
end
