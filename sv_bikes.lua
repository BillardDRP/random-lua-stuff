local Bikes = {}
local Bikes.BikeModel = "models/player/eli.mdl" --temp model
local Bikes.Dir = "darkrp_bycicles/"

local WalkSpeed
local RunSpeed

if not file.Exists( Bikes.Dir ) then
	file.CreateDir( Bikes.Dir )	
end

local function IsOnBike( ply )
	local FileData = file.Read( Bikes.Dir..ply:SteamID() )
	if FileData == "true" then
		return true
	elseif FileData == "false"
		return false
	end
end

local function GetPlayerSpeeds( ply )
	WalkSpeed = ply:GetWalkSpeed()
	RunSpeed = ply:GetRunSpeed()
end

local function DrawBike( ply )
	local bike = ents.Create( "prop_physics" )	
	bike.SetModel( Bikes.BikeModel )
	while IsOnBike( ply ) do
		bike:SetPos( ply:GetPos() )
		bike:SetAngles( ply:GetAngles() )
		bike:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	end
end

local function StartBike( ply )
	file.Write( Bikes.Dir..ply:SteamID(), "true" )
	DrawBike( ply )
	ply:SetWalkSpeed( WalkSpeed * 3 )
	ply:SetRunSpeed( RunSpeed * 3 )
end

local function EndBike( ply )
	file.Write( Bikes.Dir..ply:SteamID(), "false" )
	ply:SetWalkSpeed( WalkSpeed )
	ply:SetRunSpeed( RunSpeed )
end

hook.Add( "PlayerSay", "BikeCommand", function( ply, text, isTeam )
	if not IsValid( ply ) then return end
	if text == "/bike" then
		if IsOnBike( ply ) then
			EndBike( ply )
		else
			GetPlayerSpeeds( ply )
			StartBike( ply )
		end
	end
end )
