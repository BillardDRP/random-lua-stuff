-- Created by Sir Francis Billard

Derma_Message( "BillardHack has been successfully loaded!", "BilllardHack", "Close" )

local hook = hook
local draw = draw
local player = player
local ents = ents
local concommand = concommand
local string = string
local table = table

local FriendsList = {}

local function FindPlayer( name )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
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

local function IsOnFriendsList( ply )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if not IsValid( ply ) then return end
	if not ply:IsPlayer() then return end
	for k, v in pairs( FriendsList ) do
		if v == ply:SteamID() then
			return true
		end
	end
end

local function AddToFriends( ply, cmd, args )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if not args[1] then return end
	if not IsValid( ply ) then return end
	if FindPlayer( args[1] ) then
		local target = FindPlayer( tostring( args[1] ) )
		if not IsOnFriendsList( target ) then
			table.insert( FriendsList, #FriendsList, target:SteamID() )
			ply:ChatPrint( target:Nick() .. " has been added to your BillardHack friends list." )
		else
			ply:ChatPrint( target:Nick() .. " is already on your BillardHack friends list." )
		end
	else
		ply:ChatPrint( "Player not found." )
	end
end

local function RemoveFromFriends( ply, cmd, args )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if not args[1] then return end
	if not IsValid( ply ) then return end
	if FindPlayer( args[1] ) then
		local target = FindPlayer( tostring( args[1] ) )
		if IsOnFriendsList( target ) then
			for k, v in pairs( FriendsList ) do
				if v == ply:SteamID() then
					table.RemoveByValue( FriendsList, ply:SteamID() )
				end
			end
			ply:ChatPrint( target:Nick() .. " has been removed from your BillardHack friends list." )
		else
			ply:ChatPrint( target:Nick() .. " is not on your BillardHack friends list." )
		end
	else
		ply:ChatPrint( "Player not found." )
	end
end

local function ListAllFriends( ply, cmd, args )
	if not IsValid( ply ) then return end
	print( "FRIENDS LIST" )
	print( "========================================" )
	for k, v in pairs( FriendsList ) do
		print( v )
	end
	print( "========================================" )
end

local function ClearFriendsList( ply, cmd, args )
	if not IsValid( ply ) then return end
	table.Empty( FriendsList )
end

local function ShouldShootAt( thing )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	return ( ( tobool( GetConVarNumber( "billardhack_bots_target_npcs" ) ) and thing:IsNPC() ) or ( thing:IsPlayer() and not IsOnFriendsList( thing ) ) )  and IsValid( thing )
end

local function GetAllTraceEntity()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	for k, v in pairs( player.GetAll() ) do
		print( v:Nick() .. " is looking at " .. tostring( v:GetEyeTrace().Entity ) )
	end
end

local function GetAllTraceTexture()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	for k, v in pairs( player.GetAll() ) do
		print( v:Nick() .. " is looking at " .. tostring( v:GetEyeTrace().HitTexture ) )
	end
end

local function GetAllTracePos()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	for k, v in pairs( player.GetAll() ) do
		print( v:Nick() .. " is looking at exactly " .. tostring( v:GetEyeTrace().HitPos ) )
	end
end

local function GetServerTick()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	print( "Current server tick is " .. tonumber( ( 1 / engine.TickInterval() ) ) )
end

local function GetPlayerTeams( ply, cmd, args )
	print( "PLAYER TEAMS" )
	print( "========================================" )
	for k, v in pairs( player.GetAll() ) do
		print( v:Nick() .. " is on team " .. team.GetName( v:Team() ) )
	end
	print( "========================================" )
end

hook.Add( "HUDPaint", "BillardHack_Crosshair", function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_crosshair" ) ) then
		local red = GetConVarNumber( "billardhack_crosshair_r" )
		local green = GetConVarNumber( "billardhack_crosshair_g" )
		local blue = GetConVarNumber( "billardhack_crosshair_b" )
		local alph = GetConVarNumber( "billardhack_crosshair_alpha" )
		local size = GetConVarNumber( "billardhack_crosshair_size" )
		local thickness = GetConVarNumber( "billardhack_crosshair_thickness" )
		draw.RoundedBox( 2, ( ScrW() / 2 ) - ( size / 2 ), ScrH() / 2, size, thickness, Color( red, green, blue, alph ) )
		draw.RoundedBox( 2, ScrW() / 2, ( ScrH() / 2 ) - ( size / 2 ), thickness, size, Color( red, green, blue, alph ) )
	end
end )

hook.Add( "PreDrawHalos", "BillardHack_Wallhack", function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_wallhack" ) ) then
		halo.Add( player.GetAll(), Color( 255, 0, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "money_printer_*" ), Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "bit_miner_*" ), Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "*_money_printer" ), Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "spawned_*" ), Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "item_*" ), Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "cityrp_*" ), Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "keypad" ), Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "weapon_*" ), Color( 255, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "m9k_*" ), Color( 255, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "prop_vehicle_*" ), Color( 255, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "vehicle_*" ), Color( 255, 255, 0 ), 0, 0, 2, true, true )
		if tobool( GetConVarNumber( "billardhack_wallhack_npcs" ) ) then
			halo.Add( ents.FindByClass( "npc_*" ), Color( 0, 0, 255 ), 0, 0, 2, true, true )
		end
	end
end )

hook.Add("Think", "BillardHack_Aimbot", function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_aimbot" ) ) then
		local ply = LocalPlayer()
		local trace = util.GetPlayerTrace( ply )
		local traceRes = util.TraceLine( trace )
		if traceRes.HitNonWorld then
			local target = traceRes.Entity
			if ShouldShootAt( target ) then
				local targethead = target:LookupBone( "ValveBiped.Bip01_Head1" )
				local targetheadpos, targetheadang = target:GetBonePosition( targethead )
				ply:SetEyeAngles( ( targetheadpos - ply:GetShootPos() ):Angle() )
			end
		end
	end
end )

hook.Add("Think", "BillardHack_Triggerbot", function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_triggerbot" ) ) then
		local ply = LocalPlayer()
		local trace = util.GetPlayerTrace( ply )
		local traceRes = util.TraceLine( trace )
		if traceRes.HitNonWorld then
			local target = traceRes.Entity
			if ShouldShootAt( target ) then
				LocalPlayer():ConCommand("+attack")
				timer.Simple( 0.05, function() LocalPlayer():ConCommand("-attack") end )
			end
		end
	end
end )

hook.Add( "CreateMove", "BillardHack_Bhop", function( ucmd )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_bhop" ) ) then
		if ucmd:KeyDown( IN_JUMP ) then
			if LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !LocalPlayer():IsOnGround() then
				ucmd:RemoveKey( IN_JUMP )
			end
		end
	end
end )

hook.Add( "HUDPaint", "BillardHack_ESP", function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_esp" ) ) then
		if tobool( GetConVarNumber( "billardhack_esp_info" ) ) then
			for k, v in pairs( player.GetAll() ) do
				if not IsValid( v ) then return end
				local pos = ( v:GetShootPos() + Vector( 0, 0, 20 ) ):ToScreen()
				local clr = team.GetColor( v:Team() )
				local outlineClr = Color( 0, 0, 0, 255 )
				draw.SimpleTextOutlined( v:Nick(), "Default", pos.x, pos.y - 45, clr, 1, 1, 1, outlineClr )
				draw.SimpleTextOutlined( "Health: "..v:Health(), "Default", pos.x, pos.y -30, clr, 1, 1, 1, outlineClr )
				draw.SimpleTextOutlined( "Armor: "..v:Armor(), "Default", pos.x, pos.y - 15, clr, 1, 1, 1, outlineClr )
				if IsValid( v:GetActiveWeapon() ) then draw.SimpleTextOutlined( v:GetActiveWeapon():GetPrintName(), "Default", pos.x, pos.y, clr, 1, 1, 1, outlineClr ) end
				if IsOnFriendsList( v ) then draw.SimpleTextOutlined( "FRIEND", "Default", pos.x, pos.y + 15, clr, 1, 1, 1, outlineClr ) end
			end
		end
		--[[ -- Unused scripts
		if tobool( GetConVarNumber( "billardhack_esp_target_npcs" ) ) then
			for k, v in pairs( ents.GetAll() ) do
				if not v:IsNPC() then return end
				local pos = ( v:GetShootPos() + Vector( 0, 0, 20 ) ):ToScreen()
				local clr = team.GetColor( v:Team() ) or Color( 0, 0, 255 )
				local outlineClr = Color( 0, 0, 0, 255 )
				draw.SimpleTextOutlined( v:Nick(), "Default", pos.x, pos.y - 45, clr, 1, 1, 1, outlineClr )
				draw.SimpleTextOutlined( "Health: "..v:Health(), "Default", pos.x, pos.y -30, clr, 1, 1, 1, outlineClr )
				if IsValid( v:GetActiveWeapon() ) then draw.SimpleTextOutlined( v:GetActiveWeapon():GetPrintName(), "Default", pos.x, pos.y, clr, 1, 1, 1, outlineClr ) end
			end
		end
		if tobool( GetConVarNumber( "billardhack_esp_boxes" ) ) then
			for k, v in pairs( player.GetAll() ) do
				local pos = ( v:GetShootPos() + Vector( 0, 0, 20 ) ):ToScreen()
				local clr = team.GetColor( v:Team() )
				draw.RoundedBox( 0, v:OBBMaxs().x, v:OBBMins(), 80, 2, clr )
			end
		end
		]]
	end
end )

hook.Add( "HUDPaint", "BillardHack_HUD", function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_hud" ) ) then
		if tobool( GetConVarNumber( "billardhack_hud_health" ) ) then
			local health = LocalPlayer():Health()
			local armor = LocalPlayer():Armor()
		end
	end
end )

hook.Add( "ShouldDrawLocalPlayer", "BillardHack_DrawSelf", function( ply )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	return tobool( GetConVarNumber( "billardhack_draw_self" ) )
end )

hook.Add( "Think", "BillardHack_PanicModeReminder", function()
	local PanicModeSpamTime = CurTime() + GetConVarNumber( "billardhack_panic_mode_spam_time" )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then
		if PanicModeSpamTime <= CurTime() then
			LocalPlayer():ChatPrint( "PANIC MODE IS ENABLED, TYPE 'BILLARDHACK_PANIC_MODE 0' IN CONSOLE TO DISABLE" )
			PanicModeSpamTime = CurTime() + GetConVarNumber( "billardhack_panic_mode_spam_time" )
		end
	end
end )

CreateClientConVar( "billardhack_panic_mode", 0, true, false )
CreateClientConVar( "billardhack_panic_mode_spam_time", 5, true, false )
CreateClientConVar( "billardhack_rage_mode", 0, true, false )
CreateClientConVar( "billardhack_crosshair", 0, true, false )
CreateClientConVar( "billardhack_crosshair_r", 255, true, false )
CreateClientConVar( "billardhack_crosshair_g", 50, true, false )
CreateClientConVar( "billardhack_crosshair_b", 50, true, false )
CreateClientConVar( "billardhack_crosshair_alpha", 200, true, false )
CreateClientConVar( "billardhack_crosshair_size", 30, true, false )
CreateClientConVar( "billardhack_crosshair_thickness", 4, true, false )
CreateClientConVar( "billardhack_wallhack", 0, true, false )
CreateClientConVar( "billardhack_wallhack_npcs", 0, true, false )
CreateClientConVar( "billardhack_aimbot", 0, true, false )
CreateClientConVar( "billardhack_triggerbot", 0, true, false )
CreateClientConVar( "billardhack_bots_target_npcs", 0, true, false )
CreateClientConVar( "billardhack_bhop", 0, true, false )
CreateClientConVar( "billardhack_esp", 0, true, false )
CreateClientConVar( "billardhack_esp_info", 0, true, false )
CreateClientConVar( "billardhack_esp_boxes", 0, true, false )
CreateClientConVar( "billardhack_hud", 0, true, false )
CreateClientConVar( "billardhack_hud_health", 0, true, false )
CreateClientConVar( "billardhack_hud_armor", 0, true, false )
CreateClientConVar( "billardhack_draw_self", 0, true, false )

concommand.Add( "billardhack_trace_entity", GetAllTraceEntity )
concommand.Add( "billardhack_trace_texture", GetAllTraceTexture )
concommand.Add( "billardhack_trace_pos", GetAllTracePos )
concommand.Add( "billardhack_friend_add", AddToFriends )
concommand.Add( "billardhack_friend_remove", RemoveFromFriends )
concommand.Add( "billardhack_friend_list", ListAllFriends )
concommand.Add( "billardhack_teams", GetPlayerTeams )
concommand.Add( "billardhack_tick", RemoveFromFriends )

-- Custom cheats section

-- Murder

local function IdentifyMurderers( ply, cmd, args )
	if not IsValid( ply ) then return end
	print( "LIST OF MURDERERS" )
	print( "========================================" )
	for k, v in pairs( ents.GetAll() ) do
		if v:GetClass() == "weapon_mu_knife" then
			print( v:GetOwner():Nick() .. " is a murderer." )
		end
	end
	print( "========================================" )
end

hook.Add( "PreDrawHalos", "BillardHack_MurderHack", function()
	if tobool( GetConVarNumber( "billardhack_murder_esp" ) ) then
		halo.Add( ents.FindByClass( "weapon_mu_knife" ), Color( 255, 0, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "weapon_mu_magnum" ), Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "mu_knife" ), Color( 255, 0, 0 ), 0, 0, 2, true, true )
		halo.Add( ents.FindByClass( "mu_loot" ), Color( 0, 255, 0 ), 0, 0, 2, true, true )
	end
end )

CreateClientConVar( "billardhack_murder_esp", 0, true, false )

concommand.Add( "billardhack_murder_list", IdentifyMurderers )
