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
	local timeStarted = tonumber ( os.clock() )
	if not code then return end
	local newcode = tostring( code )
	for k, v in pairs( olivescript.keywords ) do
		string.gsub( tostring( code ), tostring( k ), tostring( v ) )
	end
	print( "Compiled Olivescript into Lua in " .. tonumber( os.clock() ) - timeStarted  .. " seconds." )
end

local olivescript.decompile = function( code )
	local timeStarted = tonumber ( os.clock() )
	if not code then return end
	local newcode = tostring( code )
	for k, v in pairs( olivescript.keywords ) do
		string.gsub( tostring( code ), tostring( v ), tostring( k ) )
	end
	print( "Compiled Lua into Olivescript in " .. tonumber( os.clock() ) - timeStarted  .. " seconds." )
end
