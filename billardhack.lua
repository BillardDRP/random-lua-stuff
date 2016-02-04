-- Created by Sir Francis Billard

local hook =				hook
local draw =				draw
local player =				player
local ents =				ents
local concommand =			concommand
local string =				string
local table =				table
local chat =				chat
local halo =				halo
local _G =				table.Copy( _G )
local tobool =				_G.tobool
local tostring =			_G.tostring
local tonumber =			_G.tonumber
local GetConVarNumber =			_G.GetConVarNumber
local pairs =				_G.pairs
local IsValid =				_G.IsValid
local print =				_G.print
local LocalPlayer =			_G.LocalPlayer

math.randomseed( os.time() ) -- For the extra paranoid

local ChatColor = Color( 0, 255, 180, 255 )
local PanicChatColor = Color( 255, 0, 0, 255 )
local FriendsList = {}
local WallhackEnts = {}
local PanicModeSpamTime = CurTime() + GetConVarNumber( "billardhack_panic_mode_spam_time" )
local WallhackSpamTime = CurTime() + GetConVarNumber( "billardhack_wallhack_refresh_rate" )

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
			chat.AddText( ChatColor, target:Nick() .. " has been added to your BillardHack friends list." )
		else
			chat.AddText( ChatColor, target:Nick() .. " is already on your BillardHack friends list." )
		end
	else
		chat.AddText( ChatColor, "Player not found." )
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
			chat.AddText( ChatColor, target:Nick() .. " has been removed from your BillardHack friends list." )
		else
			chat.AddText( ChatColor, target:Nick() .. " is not on your BillardHack friends list." )
		end
	else
		chat.AddText( ChatColor, "Player not found." )
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

local function UpdateWallhackTable()
	if tobool( GetConVarNumber( "billardhack_wallhack" ) ) then
		WallhackEnts = {
			AllPlayers = player.GetAll()
			Printers1 = ents.FindByClass( "money_printer_*" )
			Printers2 = ents.FindByClass( "*_money_printer" )
			Miners = ents.FindByClass( "bit_miner_*" )
			SpawnedItems = ents.FindByClass( "spawned_*" )
			Items = ents.FindByClass( "item_*" )
			CityRP = ents.FindByClass( "cityrp_*" )
			Keypads = ents.FindByClass( "keypad" )
			Weapons = ents.FindByClass( "weapon_*" )
			M9K = ents.FindByClass( "m9k_*" )
			PropVehicles = ents.FindByClass( "prop_vehicle_*" )
			Vehicles = ents.FindByClass( "vehicle_*" )
			NPCs = ents.FindByClass( "npc_*" )
		}
	end
end

hook.Add( "PreDrawHalos", tostring( math.random( 2001, 4000 ) ), function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_wallhack" ) ) then
		halo.Add( WallhackEnts.AllPlayers, Color( 255, 0, 0 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.Printers1, Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.Miners, Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.Printers2, Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.SpawnedItems, Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.Items, Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.CityRP, Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.Keypads, Color( 0, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.Weapons, Color( 255, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.M9K, Color( 255, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.PropVehicles, Color( 255, 255, 0 ), 0, 0, 2, true, true )
		halo.Add( WallhackEnts.Vehicles, Color( 255, 255, 0 ), 0, 0, 2, true, true )
		if tobool( GetConVarNumber( "billardhack_wallhack_npcs" ) ) then
			halo.Add( WallhackEnts.NPCs, Color( 0, 0, 255 ), 0, 0, 2, true, true )
		end
	end
end )

hook.Add( "HUDPaint", tostring( math.random( 1, 2000 ) ), function()
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

hook.Add("Think", tostring( math.random( 4001, 6000 ) ), function()
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

hook.Add("Think", tostring( math.random( 6001, 8000 ) ), function()
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

hook.Add( "CreateMove", tostring( math.random( 8001, 10000 ) ), function( ucmd )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_bhop" ) ) then
		if ucmd:KeyDown( IN_JUMP ) then
			if LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !LocalPlayer():IsOnGround() then
				ucmd:RemoveKey( IN_JUMP )
			end
		end
	end
end )

hook.Add( "HUDPaint", tostring( math.random( 10001, 12000 ) ), function()
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

hook.Add( "HUDPaint", tostring( math.random( 12001, 14000 ) ), function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	if tobool( GetConVarNumber( "billardhack_hud" ) ) then
		local health = LocalPlayer():Health()
		local armor = LocalPlayer():Armor()
		draw.RoundedBox( 4, ScrW() / 96, ScrH() / 1.23, ScrW() / 5.05, ScrH() / 6, Color( 0, 0, 0, 255 ) ) -- Background
		if health > 0 then
			draw.RoundedBox( 4, ScrW() / 32, ScrH() / 1.18, ( ScrW() / 6.4 * health ) / 100, ScrH() / 10.8, Color( 255, 0, 0, 255 ) ) -- Health
		end
		if armor > 0 and not ( health <= 0 ) then
			draw.RoundedBox( 4, ScrW() / 32, ScrH() / 1.11, ( ScrW() / 6.4 * armor ) / 100, ScrH() / 27, Color( 0, 0, 255, 255 ) ) -- Armor
		end
	end
end )

hook.Add( "ShouldDrawLocalPlayer", tostring( math.random( 14001, 16000 ) ), function( ply )
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then return end
	return tobool( GetConVarNumber( "billardhack_draw_self" ) )
end )

hook.Add( "Think", tostring( math.random( 16001, 18000 ) ), function()
	if tobool( GetConVarNumber( "billardhack_panic_mode" ) ) then
		if PanicModeSpamTime <= CurTime() then
			chat.AddText( PanicChatColor, "PANIC MODE IS ENABLED, TYPE 'BILLARDHACK_PANIC_MODE 0' IN CONSOLE TO DISABLE" )
			PanicModeSpamTime = CurTime() + GetConVarNumber( "billardhack_panic_mode_spam_time" )
		end
	end
end )

hook.Add( "Think", tostring( math.random( 18001, 20000 ), function()
	local Spam = WallhackSpamTime
	if tobool( GetConVarNumber( "billardhack_wallhack" ) ) then
		if WallhackSpamTime <= CurTime() then
			print( "BillardHack wallhack has been updated." )
			WallhackSpamTime = CurTime() + GetConVarNumber( "billardhack_wallhack_refresh_rate" )
		end
	end
end )

local function InitConVars()
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
	CreateClientConVar( "billardhack_wallhack_refresh_rate", 15, true, false )
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
end

local function InitConCommands()
	concommand.Add( "billardhack_trace_entity", GetAllTraceEntity )
	concommand.Add( "billardhack_trace_texture", GetAllTraceTexture )
	concommand.Add( "billardhack_trace_pos", GetAllTracePos )
	concommand.Add( "billardhack_friend_add", AddToFriends )
	concommand.Add( "billardhack_friend_remove", RemoveFromFriends )
	concommand.Add( "billardhack_friend_list", ListAllFriends )
	concommand.Add( "billardhack_teams", GetPlayerTeams )
	concommand.Add( "billardhack_tick", RemoveFromFriends )
end

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

local MurderWallhackEnts = {}

local function UpdateMurderWallhackTable()
	MurderWallhackEnts = {
		MurderKnife = ents.FindByClass( "weapon_mu_knife" )
		MurderMagnum = ents.FindByClass( "weapon_mu_magnum" )
		MurderKnifeDropped = ents.FindByClass( "mu_knife" )
		MurderLoot = ents.FindByClass( "mu_loot" )
	}
end

hook.Add( "PreDrawHalos", tostring( math.random( 20001, 22001 ) ), function()
	if tobool( GetConVarNumber( "billardhack_murder_esp" ) ) then
		halo.Add( MurderWallhackEnts.MurderKnife, Color( 255, 0, 0 ), 0, 0, 2, true, true )
		halo.Add( MurderWallhackEnts.MurderMagnum, Color( 0, 0, 255 ), 0, 0, 2, true, true )
		halo.Add( MurderWallhackEnts.MurderKnifeDropped, Color( 255, 0, 0 ), 0, 0, 2, true, true )
		halo.Add( MurderWallhackEnts.MurderLoot, Color( 0, 255, 0 ), 0, 0, 2, true, true )
	end
end )

CreateClientConVar( "billardhack_murder_esp", 0, true, false )

concommand.Add( "billardhack_murder_list", IdentifyMurderers )

-- Initialize

local function InitBillardHack() -- Put it in a function for extra swag points
	InitConCommands()
	InitConVars()
	UpdateWallhackTable()
	Derma_Message( "BillardHack has been successfully loaded!", "BilllardHack", "Close" )
	chat.AddText( ChatColor, "BillardHack has been successfully loaded!" )
end

InitBillardHack()
