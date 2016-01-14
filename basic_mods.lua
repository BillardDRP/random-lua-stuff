-- Inspired by boolit :)

basic_mods = {} -- Global

basic_mods["create"] = function( ply, cmd, args ) -- Built to be console command
	local thing = ""
	local model = ""
	if not IsValid( ply ) then
		return
	end
	if not args[1] then
		thing = "sent_ball"
	else
		thing = tostring( args[1] )
	end
	if not args[2] then
		model = "models/error.mdl"
	else
		model = tostring( args[2] )
	end
	local ent = ents.Create( thing )
	ent:SetModel( model )
	ent:Spawn()
	ent:Activate() -- Make sure it has physics
end

basic_mods["burn"] = function( ply, cmd, args )
	if not IsValid( ply ) then
		return
	end
	local length = 1
	if not args[1] then
		length = 5
	else
		length = tonumber( args[1] )
	end
	local tr = ply:GetEyeTrace()
	if not IsValid( tr.Entity ) then
		return
	end
	tr.Entity:Ignite( length, 16 ) -- Burn that sucker
end

basic_mods["freeze"] = function( ply, cmd, args )
	if not IsValid( ply ) then
		return
	end
	local length = 1
	if not args[1] then
		length = 5
	else
		length = tonumber( args[1] )
	end
	local tr = ply:GetEyeTrace()
	if not IsValid( tr.Entity ) then
		return
	end
	if not tr.Entity:IsPlayer() then
		return
	end
	tr.Entity:Freeze( true )
	timer.Simple( length, function()
		tr.Entity:Freeze( false )
	end )
end

concommand.Add( "basic_create", basic_mods.create )
concommand.Add( "basic_burn", basic_mods.burn )
concommand.Add( "basic_freeze", basic_mods.freeze )
