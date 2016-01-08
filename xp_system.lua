local XP = {}
local XP.Reward = {}
local XP.Penalty = {}
local XP.Directory = "billard_xp_system/xp/"
local XP.PrestigeDirectory = "billard_xp_system/prestige/"
local XP.Reward.KillPlayer = 60
local XP.Reward.KillNPC = 10
local XP.Penalty.Death = 0 --No penalty for dying


local XP.SetPlayerXP = function( ply, xp )
	if not IsValid( ply ) then return end
	local PlyID = ply:SteamID()
	if not file.Exists( XP.Directory ) then
		file.CreateDir( XP.Directory )
	end
	file.Write( XP.Directory, xp )
end

local XP.GetPlayerXP = function( ply )
	if not IsValid( ply ) then return end
	local PlyID = ply:SteamID()
	if not file.Exists( XP.Directory..PlyID ) then
		return
	end
	local data = file.Read( XP.Directory..PlyID, "DATA" )
	return data
end

local XP.SetPlayerLevel = function( ply, level )
	if not IsValid( ply ) then return end
	local PlyID = ply:SteamID()
	if not file.Exists( XP.Directory ) then
		file.CreateDir( XP.Directory )
	end
	file.Write( XP.Directory, level )
end

local XP.GetPlayerLevel = function( ply )
	if not IsValid( ply ) then return end
	local PlyID = ply:SteamID()
	if not file.Exists( XP.Directory..PlyID ) then
		return
	end
	local data = file.Read( XP.Directory..PlyID, "DATA" )
	return data
end

hook.Add( "OnNPCKilled", "XP_System_Kill_NPC", function( npc, attacker, inflictor )
	if not IsValid( npc ) then return end
	if not IsValid( attacker ) then return end
	if not attacker:IsPlayer() then return end
	local PlyNewXP = XP.GetPlayerXP( attacker ) + XP.Reward.KillNPC
	XP.SetPlayerLevel( attacker, PlyNewXP )
end )
