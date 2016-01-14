-- Inspired by boolit :)

basic_mods = {} -- Global

local function CheckPly( ply )
	if not IsValid( ply ) then
		return false
	end
	if not ply:IsAdmin() then
		return false
	end
	return true
end

basic_mods["create"] = function( ply, cmd, args ) -- Built to be console command
	if not CheckPly( ply ) then return end
	local thing = ""
	local model = ""
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
	if not CheckPly( ply ) then return end
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
	local old = tr.Entity:GetColor() -- Save the old color
	tr.Entity:Ignite( length, 16 ) -- Burn that sucker
	tr.Entity:SetColor( Color( 0, 0, 0 ) ) -- Make it black
	timer.Simple( length, function()
		tr.Entity:Extinguish()
		tr.Entity:SetColor( old ) -- Give it the old color
	end )
end

basic_mods["freeze"] = function( ply, cmd, args )
	if not CheckPly( ply ) then return end
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
	local old = tr.Entity:GetColor() -- Save the old color
	tr.Entity:Freeze( true )
	tr.Entity:SetColor( 0, 0, 255 ) -- Make them blue
	timer.Simple( length, function()
		tr.Entity:Freeze( false )
		tr.Entity:SetColor( old ) -- Give them their old color
	end )
end

basic_mods["model"] = function( ply, cmd, args )
	if not CheckPly( ply ) then return end
	local model = ""
	if not args[1] then
		model = "models/error.mdl"
	else
		model = tostring( args[1] )
	end
	local tr = ply:GetEyeTrace()
	if not IsValid( tr.Entity ) then
		return
	end
	tr.Entity:SetModel( model )
end

-- Console commands
local concommand = concommand -- I think this makes it go faster
concommand.Add( "basic_create", basic_mods.create )
concommand.Add( "basic_burn", basic_mods.burn )
concommand.Add( "basic_freeze", basic_mods.freeze )
concommand.Add( "basic_model", basic_mods.model )
