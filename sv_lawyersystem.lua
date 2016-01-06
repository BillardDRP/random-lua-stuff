local LawyerSystem = {}
local LawyerSystem.DataDirectory = "darkrp_lawyer_system/"
local LawyerSystem.HirePriceMin = 600
local LawyerSystem.HirePriceMax = 1800
local LawyerSystem.FirstNames = {
	["John"] = true
	["Humphrey"] = true
	["William"] = true
	["Robert"] = true
	["Harris"] = true
	["Franklin"] = true
}
local LawyerSystem.MiddleNames = {
	["J."] = true
	["L."] = true
	["R."] = true
	["T."] = true
	["F."] = true
}
local LawyerSystem.LastNames = {
	["Jones"] = true
	["Roberts"] = true
	["Humphreys"] = true
	["Truman"] = true
	["Potter"] = true
}

local function SavePlayerData( ply, directory, data )
	if not file.Exists( directory ) then
		file.CreateDir( directory )
	end
	local PlayerSteamID = ply:SteamID()
	if not file.Exists( directory..PlayerSteamID ) then
		return
	end
	file.Write( directory..PlayerSteamID..".txt", data )
end

local function LoadPlayerData( ply, directory )
	if not file.Exists( directory ) then
		return
	end
	local PlayerSteamID = ply:SteamID()
	if not file.Exists( directory..PlayerSteamID ) then
		return
	end
	local data = file.Read( directory..PlayerSteamID..".txt", "DATA" )
	return data
end

local LawyerSystem.GetLawyerName = function()
	local FirstName = math.random( 1, #LawyerSystem.FirstNames )
	local MiddleName = math.random( 1, #LawyerSystem.MiddleNames )
	local LastName = math.random( 1, #LawyerSystem.LastNames )
	local LawyerName = tostring( FirstName.." "..MiddleName.." "..LastName )
	return LawyerName
end

local LawyerSystem.HasLawyer = function( ply )
	if LoadPlayerData( ply, LawyerSystem.DataDirectory ) == "true" then
		return true
	elseif LoadPlayerData( ply, LawyerSystem.DataDirectory ) == "false" then
		return false
	end
end

hook.Add( "PlayerSay", "LawyerSystemHireCommand", function( ply, text, isTeam )
	if text == "/hirelawyer" then
		local LawyerPrice = math.random( LawyerSystem.HirePriceMin, LawyerSystem.HirePriceMax )
		if ply:canAfford( LawyerPrice ) then
			ply:addMoney( LawyerPrice * -1 )
			local LawyerName = LawyerSystem.GetName
			ply:ChatPrint( LawyerName.." has been hired as your lawyer!" )
			SavePlayerData( ply, LawyerSystem.DataDirectory, "true" )
		else
			ply:ChatPrint( "You cannot afford a lawyer!" )
		end
	end
end )

hook.Add( "PlayerSay", "LawyerSystemWelfareCommand", function( ply, text, isTeam )
	if text == "/requestwelfare" then
		if LawyerSystem.HasLawyer( ply ) then
			
		else
			ply:ChatPrint( "You do not have a lawyer!" )	
		end
	end
end )

hook.Add( "PlayerSay", "LawyerSystemMedicalCommand", function( ply, text, isTeam )
	if text == "/requestmedical" then
		
	end
end )
