local function findplayer( name )
	name = string.lower( name )
	for k,v in pairs( player.GetAll() ) do
		if string.lower( v:SteamID() ) == name then
			return v
		end
		if string.lower( v:UniqueID() ) == name then
			return v
		end
		local nick = string.lower( v:Nick()  )
		if string.find( nick, name ) then
			return v
		end
		if v.SteamName then
			local sname = string.lower( v:SteamName() )
			if string.find( sname, name ) then
				return v
			end
		end
	end
end

local function CmdCheck( ply, args )
	if not IsValid( ply ) then
		return false
	end
	if not args[1] then
		return false
	end
end

local function GetCmdValue( args, argnum, default )
	argnum = tonumber( argnum )
	if not args[argnum] then
		return default
	else
		return args[argnum]
	end
end

local function MakeEnt( Class, Model )
	local ent = ents.Create( Class )
	ent:SetModel( Mode )
	ent:Spawn()
	ent:Activate()
	ent:Wake()
	return ent
end

concommand.Add( "troll_trainfuck", function( ply, cmd, args )
	
end )
