AddCSLuaFile()

local draw = draw
local hook = hook
local LocalPlayer = LocalPlayer
local ScrW = ScrW
local ScrH = ScrH
local Color = Color

local function GetAmmo( ply )
   local weap = ply:GetActiveWeapon()
   if not weap or not ply:Alive() then return -1 end

   local ammo_inv = weap:Ammo1() or 0
   local ammo_clip = weap:Clip1() or 0
   local ammo_max = weap.Primary.ClipSize or 0

   return ammo_clip, ammo_max, ammo_inv
end

hook.Add( "HUDPaint", "G3XRP_HUD", function()
	local lp = LocalPlayer()
	local wep = LocalPlayer():GetActiveWeapon()
	local clip1, max1, ammo1 = GetAmmo( LocalPlayer() )
	local health = LocalPlayer():Health()
	local armor = LocalPlayer():Armor()
	-- Layer 1
	draw.RoundedBox( 4, ScrW() / 1.1, ScrH() / 1.13, ScrW() / 12, ScrH() / 10.8, Color( 60, 0, 80, 255 ) )
	draw.RoundedBox( 4, ScrW() / 96, ScrH() / 1.43, ScrW() / 3.84, ScrH() / 3.6, Color( 60, 0, 80, 255 ) )
	-- Layer 2
	draw.DrawText( lp:Nick(), "Arial24", ScrW() / 48, ScrH() / 1.39, Color( 255, 255, 255, 255 ) )
	draw.DrawText( DarkRP.getPhrase( "job", lp:getDarkRPVar( "job" ) or "" ), "Arial24", ScrW() / 48, ScrH() / 1.29, Color( 255, 255, 255, 255 ) )
	draw.DrawText( DarkRP.getPhrase( "wallet", DarkRP.formatMoney( LocalPlayer():getDarkRPVar( "money" ) ), "" ), "Arial24", ScrW() / 48, ScrH() / 1.19, Color( 255, 255, 255, 255 ) )
	draw.DrawText( DarkRP.getPhrase( "salary", DarkRP.formatMoney( lp:getDarkRPVar( "salary" ) ), "" ), "Arial24", ScrW() / 5.05, ScrH() / 1.39, Color( 255, 255, 255, 255 ) )
	draw.DrawText( clip1 or 0, "Arial24", ScrW()/1.09, ScrH() / 1.11, Color( 60, 0, 80, 255 ) )
	draw.DrawText( ammo1 or 0, "Arial24", ScrW() / 1.09, ScrH() / 1.06, Color( 60, 0, 80, 255 ) )
	if health > 0 then
		draw.RoundedBox( 4, ScrW() / 48, ScrH() / 1.11, ( ScrW()/4.17 * health ) / 100, ScrH() / 18, Color( 255, 0, 0, 255 ) )
	end
	-- Layer 3
	if armor > 0 then
		draw.RoundedBox( 4, ScrW() / 48, ScrH()/1.06, ( ScrW()/4.17 * armor ) / 100, ScrH() / 54, Color( 0, 0, 255, 255 ) )
	end
end )

local Hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "G3XRP_HUD_HIDE_DEFAULT", function( name )
	if ( Hide[name] ) then
		return false
	end
end )
