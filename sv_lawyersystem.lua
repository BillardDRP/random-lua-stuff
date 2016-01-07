local LawyerSystem = {}
local LawyerSystem.DataDirectory = "darkrp_lawyer_system/"
local LawyerSystem.Lang = "EN"
local LawyerSystem.Message = {}
local Lang = {}
local Lang["EN"] = {}
local Lang.["EN"].NoLawyer = "You do not have a lawyer!"
local Lang.["EN"].HasBeenHired = " has been hired as your lawyer!"
local Lang.["EN"].CannotAfford = "You cannot afford a lawyer!"
local Lang.["EN"].Welfare1 = "You have received "
local Lang.["EN"].Welfare2 = " dollars in a welfare check from your lawyer!"
local Lang.["EN"].NoWelfare = "Your lawyer failed to get you a welfare check!"
local Lang.["EN"].Medical = "Your lawyer has payed your medical bills!"
local Lang.["EN"].NoMedical = "Your lawyer failed at paying your medical bills!"
local LawyerSystem.HirePriceMin = 600
local LawyerSystem.HirePriceMax = 1800
local LawyerSystem.MedicalChance = 10
local LawyerSystem.WelfareChance = 5
local LawyerSystem.WelfareAmountLower = 2
local LawyerSystem.WelfareAmountHigher = 18
local LawyerSystem.FirstNames = {
	["John"] = true
	["Humphrey"] = true
	["William"] = true
	["Robert"] = true
	["Harry"] = true
	["Franklin"] = true
	["Ronald"] = true
	["Ivan"] = true
	["Vladimir"] = true
	["Arnold"] = true
	["Dwayne"] = true
	["Glenn"] = true
}
local LawyerSystem.MiddleNames = {
	["J."] = true
	["L."] = true
	["R."] = true
	["T."] = true
	["F."] = true
	["S."] = true
	["K."] = true
	["\"The Rock\""] = true
}
local LawyerSystem.LastNames = {
	["Jones"] = true
	["Roberts"] = true
	["Humphreys"] = true
	["Truman"] = true
	["Potter"] = true
	["McDonald"] = true
	["Kalishnakov"] = true
	["Reagan"] = true
	["Johnson"] = true
	["Miyashiro"] = true
}

local function SavePlayerData( ply, directory, data )
	if not file.Exists( directory ) then
		file.CreateDir( directory )
	end
	local PlayerSteamID = ply:SteamID()
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

local LawyerSystem.GivePlayerWelfare = function( ply )
	local RandomNumber = math.random( 1, 100 )
	local WelfareAmount = math.random( LawyerSystem.WelfareAmountLower, LawyerSystem.WelfareAmountHigher )
	if LawyerSystem.WelfareChance >= RandomNumber then
		ply:addMoney( WelfareAmount )
		ply:ChatPrint( LawyerSystem.Message.Welfare1..WelfareAmount..LawyerSystem.Message.Welfare2 )
	else
		ply:ChatPrint( LawyerSystem.Message.NoWelfare )
	end
end

local LawyerSystem.GivePlayerMedical = function( ply )
	if ply:Health() = ply:GetMaxHealth() then return end
	local RandomNumber = math.random( 1, 100 )
	if LawyerSystem.MedicalChance >= RandomNumber then
		ply:SetHealth( ply:GetMaxHealth() )
		ply:ChatPrint( LawyerSystem.Message.Medical )
	else
		ply:ChatPrint( LawyerSystem.Message.NoMedical )
	end
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
			ply:ChatPrint( LawyerName..LawyerSystem.Message.HasBeenHired )
			SavePlayerData( ply, LawyerSystem.DataDirectory, "true" )
		else
			ply:ChatPrint( LawyerSystem.Message.CannotAfford )
		end
	end
end )



hook.Add( "PlayerSay", "LawyerSystemWelfareCommand", function( ply, text, isTeam )
	if text == "/requestwelfare" then
		if LawyerSystem.HasLawyer( ply ) then
			LawyerSystem.GivePlayerWelfare( ply )
		else
			ply:ChatPrint( LawyerSystem.Message.NoLawyer )	
		end
	end
end )

hook.Add( "PlayerSay", "LawyerSystemMedicalCommand", function( ply, text, isTeam )
	if text == "/requestmedical" then
		if LawyerSystem.HasLawyer( ply ) then
			LawyerSystem.GivePlayerMedical( ply )
		else
			ply:ChatPrint( LawyerSystem.Message.NoLawyer )
		end
	end
end )
