local LawyerSystem = {}
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

local LawyerSystem.GetLawyerName = function()
	local FirstName = math.random( 1, #LawyerSystem.FirstNames )
	local MiddleName = math.random( 1, #LawyerSystem.MiddleNames )
	local LastName = math.random( 1, #LawyerSystem.LastNames )
	local LawyerName = tostring( FirstName.." "..MiddleName.." "..LastName )
	return LawyerName
end

hook.Add( "PlayerSay", "LawyerSystemHireCommand", function( ply, text, isTeam )
	if text == "/hirelawyer" then
		local LawyerPrice = math.random( LawyerSystem.HirePriceMin, LawyerSystem.HirePriceMax )
		if ply:canAfford( LawyerPrice ) then
			ply:addMoney( LawyerPrice * -1 )
			local LawyerName = LawyerSystem.GetName
		else
			ply:ChatPrint( "You cannot afford a lawyer!" )
		end
	end
end )

hook.Add( "PlayerSay", "LawyerSystemWelfareCommand", function( ply, text, isTeam )
	if text == "/requestwelfare" then
		
	end
end )

hook.Add( "PlayerSay", "LawyerSystemMedicalCommand", function( ply, text, isTeam )
	if text == "/requestmedical" then
		
	end
end )
