if SERVER then
	SWEP.Weight				= 5			-- Decides whether we should switch from/to this
	SWEP.AutoSwitchTo		= true		-- Auto switch to if we pick it up
	SWEP.AutoSwitchFrom		= true		-- Auto switch from if you pick up a better weapon
end

if CLIENT then
	SWEP.PrintName			= "Scripted Weapon"		-- 'Nice' Weapon name (Shown on HUD)	
	SWEP.Slot				= 0						-- Slot in the weapon selection menu
	SWEP.SlotPos			= 10					-- Position in the slot
	SWEP.DrawAmmo			= true					-- Should draw the default HL2 ammo counter
	SWEP.DrawCrosshair		= true 					-- Should draw the default crosshair
	SWEP.DrawWeaponInfoBox	= true					-- Should draw the weapon info box
	SWEP.BounceWeaponIcon   = true					-- Should the weapon icon bounce?
	SWEP.SwayScale			= 1.0					-- The scale of the viewmodel sway
	SWEP.BobScale			= 1.0					-- The scale of the viewmodel bob
	SWEP.RenderGroup 		= RENDERGROUP_OPAQUE
	SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/swep" )
	SWEP.SpeechBubbleLid	= surface.GetTextureID( "gui/speech_lid" )
end

SWEP.Author			= "Sir Francis Billard"
SWEP.Contact		= "Steam"
SWEP.Purpose		= "Stupid stuff"
SWEP.Instructions	= "Do stupid things"

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pistol.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"

SWEP.Spawnable			= false
SWEP.AdminOnly			= false

SWEP.Primary.ClipSize		= 8					-- Size of a clip
SWEP.Primary.DefaultClip	= 32				-- Default number of bullets in a clip
SWEP.Primary.Automatic		= false				-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "Pistol"

SWEP.Secondary.ClipSize		= 8					-- Size of a clip
SWEP.Secondary.DefaultClip	= 32				-- Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "Pistol"

function SWEP:Initialize()

	self:SetHoldType( "pistol" )

end

function SWEP:Precache()
end

local function SetContains( set, key )
	return set[key]
end

local DoorClasses = {
	["func_door"] = true
	["func_door_rotating"] = true
	["prop_door"] = true
	["prop_door_rotating"] = true
}

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self.Weapon:EmitSound("Weapon_AR2.Single")
	self:ShootBullet( 150, 1, 0.01 )
	self:TakePrimaryAmmo( 1 )
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	local tr = self.Owner:GetEyeTrace()
	if SetContains( DoorClasses, tr.Entity:GetClass() ) then
		tr.Entity:Fire( "unlock" )
		tr.Entity:Fire( "open" )
	end
end

function SWEP:SecondaryAttack()
	if ( !self:CanSecondaryAttack() ) then return end
	self.Weapon:EmitSound("Weapon_Shotgun.Single")
	self:ShootBullet( 150, 9, 0.2 )
	self:TakeSecondaryAmmo( 1 )
	self.Owner:ViewPunch( Angle( -10, 0, 0 ) )
	local tr = self.Owner:GetEyeTrace()
	if SetContains( DoorClasses, tr.Entity:GetClass() ) then
		tr.Entity:Fire( "unlock" )
		tr.Entity:Fire( "open" )
	end
end

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD )
	local tr = self.Owner:GetEyeTrace()
	if IsValid( tr.Entity ) then
		tr.Entity:Ignite()
	end
end

function SWEP:Think()
end

function SWEP:Holster( wep )
	return true
end

function SWEP:Deploy()
	return true
end
