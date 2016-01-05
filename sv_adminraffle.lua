AdminRaffle = {}
AdminRaffle.DefaultChance = 5 --Chance out of one hundred, can be overridden using console
AdminRaffle.DefaultAmount = 800 --Money earned upon win, can be overridden using console

concommand.Add( "darkrp_adminraffle_start", function( ply, cmd, args )
	if not ply:IsAdmin() then return end
	for k, v in pairs( player.GetAll ) do
		v:ChatPrint( "The server admins have started a raffle!" )
	end
	local RaffleChance = args[2] or AdminRaffle.DefaultChance
	local RaffleMoney = args[1] or AdminRaffle.DefaultAmount
end )
