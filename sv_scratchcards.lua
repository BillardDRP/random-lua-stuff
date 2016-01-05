ScratchCards = {}
ScratchCards.Win = {}
ScratchCards.CardPrice = -600 --Must be negative or will add money upon purchase
ScratchCards.Win.AmountHigher = 4800 --Highest amount of money you get if you win
ScratchCards.Win.AmountLower = 1200 --Lowest amount of money you get if you win
ScratchCards.Win.Chance = 5 -- Percent chance out of 100


hook.Add( "PlayerSay", "ScratchCardsBuyCardHook", function( ply, text, teamChat )
 	if !IsValid( ply ) then return end
 	if text == "/buyscratchcard" or text == "/buycard" then
 		local PlayerSteamID = tostring(ply:SteamID())
 		if file.Exists( "darkrp_scratch_cards/"..PlayerSteamID..".lua" ) then
 			local PlayerScratchCards = file.Read( PlayerSteamID..".lua" )
 			local PlayerNewScratchCards = PlayerScratchCards + 1
 			
 		else
 			file.
 		end
 	end
end )
