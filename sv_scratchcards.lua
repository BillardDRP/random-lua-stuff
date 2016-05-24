--UPDATE: This script uses an old and tedious way of storing data in files. There will be a rewrite with database usage soon!

local ScratchCards = {}
local ScratchCards.Win = {}
local ScratchCards.CardPrice = 600
local ScratchCards.Win.AmountHigher = 4800 --Highest amount of money you get if you win
local ScratchCards.Win.AmountLower = 1200 --Lowest amount of money you get if you win
local ScratchCards.Win.Chance = 5 -- Percent chance out of 100

--All created/written/read files are relative to GarrysMod/garrysmod/data if you want to change them

if not file.Exists( "darkrp_scratch_cards" ) then
	file.CreateDir( "darkrp_scratch_cards" )
end

local function GivePlayerScratchCardLoot( ply )
	local CardNumber = math.random( 1, 100 )
	if ScratchCards.Win.Chance <= CardNumber then
		local WinAmount = math.random( ScratchCards.Win.AmountLower, ScratchCards.Win.AmountHigher )
		ply:addMoney( WinAmount )
		ply:ChatPrint( "You have won "..WinAmount.." dollars!" )
	else
		ply:ChatPrint( "I guess it just isn't your lucky day." )
	end
end

hook.Add( "PlayerSay", "ScratchCardsBuyCardHook", function( ply, text, teamChat )
 	if not IsValid( ply ) then return end
 	if text == "/buyscratchcard" then
 		if ply:canAfford( ScratchCards.CardPrice ) then
 			local PlayerSteamID = tostring( ply:SteamID() )
 			if file.Exists( "darkrp_scratch_cards/"..PlayerSteamID..".txt" ) then
 				local PlayerScratchCards = file.Read( PlayerSteamID..".txt" )
 				local PlayerNewScratchCards = tonumber( PlayerScratchCards ) + 1
 				file.Write( "darkrp_scratch_cards/"..PlayerSteamID..".txt", PlayerNewScratchCards )
 				ply:addMoney( ScratchCards.CardPrice * -1 )
 			else
 				file.Write( "darkrp_scratch_cards/"..PlayerSteamID..".txt", 1 ) --Give them one scratch card
 			end
 		else
 			ply:ChatPrint( "You cannot afford this item!" )
 		end
 	end
end )

hook.Add( "PlayerSay", "ScratchCardsUseCardHook", function( ply, text, teamChat )
 	if not IsValid( ply ) then return end
 	if text == "/scratch" then
 		local PlayerSteamID = tostring( ply:SteamID() )
 		if file.Exists( "darkrp_scratch_cards/"..PlayerSteamID..".txt" ) then
 			local PlayerScratchCards = file.Read( PlayerSteamID..".txt" )
 			if PlayerScratchCards < 1 then
 				ply:ChatPrint( "You do not have any scratch cards!" )
 				return
 			end
 			local PlayerNewScratchCards = tonumber( PlayerScratchCards ) - 1
 			file.Write( "darkrp_scratch_cards/"..PlayerSteamID..".txt", PlayerNewScratchCards )
 			GivePlayerScratchCardLoot( ply )
 		else
 			ply:ChatPrint( "You do not have any scratch cards!" )
 		end
 	end
end )
