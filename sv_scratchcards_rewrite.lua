--Rewriting the scratchcards module to make it slightly less shitty.

ScratchCards = {}
ScratchCards.Enabled = true
ScratchCards.Debug = true
ScratchCards.Price = 1000
ScratchCards.PrizeMin = 5000
ScratchCards.PrizeMax = 500000
ScratchCards.Chance = 20
ScratchCards.ChanceOutOf = 100
ScratchCards.DefaultGetData = 0 --What to get from ScratchCards.Get if the PData doesn't exist
ScratchCards.Set = function(ply, amt)
	if ScratchCards.Debug and not IsValid(ply) then print("[ERROR] Function ScratchCards.Set got invalid player!") return end
	if ScratchCards.Debug and not IsPlayer(ply) then print("[ERROR] Function ScratchCards.Set got a non-player entity!") return end
	if ScratchCards.Debug and not type(amt) == "number" then print("[ERROR] Function ScratchCards.Set got a non-number value!") return end
	ply:SetPData("scratchcards_amount", tonumber(amt))
end
ScratchCards.Get = function(ply)
	if ScratchCards.Debug and not IsValid(ply) then print("[ERROR] Function ScratchCards.Get got invalid player!") return end
	if ScratchCards.Debug and not IsPlayer(ply) then print("[ERROR] Function ScratchCards.Get got a non-player entity!") return end
	return tonumber(ply:GetPData("scratchcards_amount"), tonumber(ScratchCards.DefaultGetData))
end
GetScratchCardsAddonTable = function()
	return ScratchCards
end
hook.Add("PlayerSay", "ScratchCards_BuyCommand", function(ply, text, isTeam)
	if string.sub(text, 1, 15) = "!buyscratchcard" then
		if ply:canAfford(ScratchCards.Price) then
			
		end
	end
end)
hook.Add("PlayerSay", "ScratchCards_ScratchCommand", function(ply, text, isTeam)
	if string.sub(text, 1, 12) = "!scratchcard" then
		if tonumber(ScratchCards.Get(ply)) > 0 then
			if math.random(1, ScratchCards.ChaceOutOf)
				
			else
				
			end
		else
			ply:ChatPrint("You do not have any scratch cards! You can buy some using !buyscratchcard.")
		end
	end
end)
