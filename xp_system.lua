local XP = {}
local XP.Reward = {}
local XP.Penalty = {}
local XP.Directory = "billard_xp_system/xp/" --Where player XP amounts will be saved in "garrysmod/data/"
local XP.PrestigeDirectory = "billard_xp_system/prestige/" --Where player prestige amounts will be saved in "garrysmod/data/"
local XP.TimerTime = 300 --Five minutes
local XP.TimerEnabled = true --Whetherpeople get XP over time
local XP.Reward.KillPlayer = 60 --XP reward for killing a player
local XP.Reward.KillNPC = 10 --XP reward for killing an NPC
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

local XP.GiveOnTimer = function()
	timer.Simple( XP.TimerTime, function()
		for k, v in pairs( player.GetAll() ) do
			if IsValid( v ) then
				local PlyNewXP = XP.GetPlayerXP + 10
				XP.SetPlayerXP( v, PlyNewXP )
				if XP.TimerEnabled then
					XP.GiveOnTimer()
				end
			end
		end
	end )
end

hook.Add( "OnNPCKilled", "XP_System_Kill_NPC", function( npc, attacker, inflictor )
	if not IsValid( npc ) then return end
	if not IsValid( attacker ) then return end
	if not attacker:IsPlayer() then return end
	local PlyNewXP = XP.GetPlayerXP( attacker ) + XP.Reward.KillNPC
	XP.SetPlayerLevel( attacker, PlyNewXP )
end )

hook.Add( "PlayerHurt", "XP_System_Kill_Player", function( victim, attacker, healthRemaining, damageTaken )
	if not IsValid( victim ) then return end
	if not IsValid( attacker ) then return end
	if not victim:IsPlayer() then return end
	if not attacker:IsPlayer() then return end
	if not victim:Alive() then
		local PlyNewXP = XP.GetPlayerXP( attacker ) + XP.Reward.KillPlayer
		XP.SetPlayerLevel( attacker, PlyNewXP )
	end
end )
