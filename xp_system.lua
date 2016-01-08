local XP = {}
local XP.Reward = {}
local XP.Penalty = {}
local XP.Directory = "billard_xp_system/"
local XP.PrestigeDirectory
local XP.Reward.KillPlayer = 60
local XP.Reward.KillNPC = 10
local XP.Penalty.Death = 0 --No penalty for dying


local XP.SavePlayerData = function( ply, directory, data )
	if not file.Exists( directory ) then
		file.CreateDir( directory )
	end
	local PlyID = ply:SteamID()
	file.Write( directory..PlyID, data )
end

local XP.LoadPlayerData = function( ply, directory )
	if not file.Exists( directory..PlyID ) then
		return
	end
	local data = file.Read( directory..PlyID, "DATA" )
	return data
end
