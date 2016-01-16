-- Inspired by smeghack
-- Created by Sir Francis Billard

Derma_Message( "BillardHack has been successfully loaded!", "BilllardHack", "Close" )

local function GetAllTraceEntity()
	for k, v in pairs( player.GetAll() ) do
	print( v:Nick() .. " is looking at " .. tostring( v:GetEyeTrace().Entity ) )
	end
end

local function GetAllTraceTexture()
	for k, v in pairs( player.GetAll() ) do
	print( v:Nick() .. " is looking at " .. tostring( v:GetEyeTrace().HitTexture ) )
	end
end

local function GetAllTracePos()
	for k, v in pairs( player.GetAll() ) do
		print( v:Nick() .. " is looking at exactly " .. tostring( v:GetEyeTrace().HitPos ) )
	end
end

hook.Add( "HUDPaint", "BillardHack_Crosshair", function()
	if tobool( GetConVarNumber( "billardhack_crosshair" ) ) then
		local red = GetConVarNumber( "billardhack_crosshair_r" )
		local green = GetConVarNumber( "billardhack_crosshair_g" )
		local blue = GetConVarNumber( "billardhack_crosshair_b" )
		local alph = GetConVarNumber( "billardhack_crosshair_alpha" )
		draw.RoundedBox( 2, ScrW(), ScrH(), 30, 2, Color( red, green, blue, alph ) )
		draw.RoundedBox( 2, ScrW(), ScrH(), 2, 30, Color( red, green, blue, alph ) )
	end
end )

hook.Add( "PreDrawHalos", "BillardHack_Wallhack", function()
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
	end
end )

CreateClientConVar( "billardhack_crosshair", 0, true, false )
CreateClientConVar( "billardhack_crosshair_r", 255, true, false )
CreateClientConVar( "billardhack_crosshair_g", 50, true, false )
CreateClientConVar( "billardhack_crosshair_b", 50, true, false )
CreateClientConVar( "billardhack_crosshair_alpha", 200, true, false )
CreateClientConVar( "billardhack_crosshair_size", 30, true, false )
CreateClientConVar( "billardhack_crosshair_thickness", 4, true, false )

CreateClientConVar( "billardhack_wallhack", 0, true, false )

CreateClientConVar( "billardhack_esp", 0, true, false )
CreateClientConVar( "billardhack_esp_info", 0, true, false )
CreateClientConVar( "billardhack_esp_boxes", 0, true, false )

local function BillardHackESP()
	if tobool( GetConVarNumber( "billardhack_esp" ) ) then
		if tobool( GetConVarNumber( "billardhack_esp_info" ) ) then
			for k, v in pairs( player.GetAll() ) do
				local pos = ( v:GetShootPos() + Vector( 0, 0, 20 ) ):ToScreen()
				local clr = team.GetColor( v:Team() )
				local outlineClr = Color( 0, 0, 0, 255 )
				draw.SimpleTextOutlined( v:Nick(), "Default", pos.x, pos.y - 45, clr, 1, 1, 1, outlineClr )
				draw.SimpleTextOutlined( "Health: "..v:Health(), "Default", pos.x, pos.y -30, clr, 1, 1, 1, outlineClr )
				draw.SimpleTextOutlined( "Armor: "..v:Armor(), "Default", pos.x, pos.y - 15, clr, 1, 1, 1, outlineClr )
				if v:GetActiveWeapon():IsValid() then draw.SimpleTextOutlined( v:GetActiveWeapon():GetPrintName(), "Default", pos.x, pos.y, clr, 1, 1, 1, outlineClr ) end
			end
		end
		--[[if tobool( GetConVarNumber( "billardhack_esp_boxes" ) ) then
			for k, v in pairs( player.GetAll() ) do
				local pos = ( v:GetShootPos() + Vector( 0, 0, 20 ) ):ToScreen()
				local clr = team.GetColor( v:Team() )
				draw.RoundedBox( 0, v:OBBMaxs().x, v:OBBMins(), 80, 2, clr )
			end
		end]]
	end
end

hook.Add( "HUDPaint", "BillardHackESP", BillardHackESP )

concommand.Add( "billardhack_trace_entity", GetAllTraceEntity )
concommand.Add( "billardhack_trace_texture", GetAllTraceTexture )
concommand.Add( "billardhack_trace_pos", GetAllTracePos )
