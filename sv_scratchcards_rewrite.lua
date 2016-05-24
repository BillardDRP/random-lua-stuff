--Rewriting the scratchcards module to make it slightly less shitty.

ScratchCards = {}
ScratchCards.Error = {}
ScratchCards.Error.InvalidPlayer = "[ERROR] Function ScratchCards.Set got invalid player!"
ScratchCards.Debug = true
ScratchCards.Price = 1000
ScratchCards.PrizeMin = 5000
ScratchCards.PrizeMax = 500000
ScratchCards.Chance = 20
ScratchCards.ChanceOutOf = 100
ScratchCards.DefaultGetData = 0 --What to get from ScratchCards.Get if the PData doesn't exist
ScratchCards.Set = function(ply, amt)
	if ScratchCards.Debug and not IsValid(ply) then print(ScratchCards.Error.InvalidPlayer) return end
	if ScratchCards.Debug and not IsPlayer(ply) then print("[ERROR] Function ScratchCards.Set got a non-player entity!") return end
	ply:SetPData("scratchcards_amount", amt)
end
