-- BAM!
-- Billard Admin Mod
-- At least it is not ULX
-- This is more of a FUN mod
-- Not so much an ADMIN mod

-- Helper functions

local function FindPlayer( name )
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

local function CmdInit( Ply, Args, NumArgsToCheck, NeedAdmin )
	if not NeedAdmin then
		NeedAdmin = true
	end
	if not IsValid( Ply ) then
		return false
	end
	if NeedAdmin and not Ply:IsAdmin() then
		return false
	end
	if NumArgsToCheck then
		for i = 1, NumArgsToCheck do
			if not Args[1] then
				return false
			end
		end
	end
end

-- Actual commands

concommand.Add( "badmin_trainfuck", function( ply, cmd, args )
	local function TrainFuck( Ply )
		Ply:ChatPrint( "You have been fucked by a train!" )
		timer.Simple( 1, function() Ply:Kill() end ) -- Kill him in a second
		local pos = Ply:GetPos()
		local train = ents.Create( "prop_physics" )
		if not IsValid( train ) then return end
		train:SetModel( "models/props_trainstation/train001.mdl" )
		train:SetPos( pos )
		train:Spawn()
		train:EmitSound( "ambient/alarms/train_horn2.wav" )
		timer.Simple( 6, function() train:Remove() end ) -- Remove the train in 6 seconds
	end
	if not CmdInit( ply, args, 1, true ) then return end
	local Text = tostring( args[1] )
	if FindPlayer( Text ) then
		local Victim = FindPlayer( Text )
		TrainFuck( Victim )
	elseif Text == "*" then
		for k, v in pairs( player.GetAll() ) do
			TrainFuck( v )
		end
	end
end )
