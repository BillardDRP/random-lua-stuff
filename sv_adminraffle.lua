AdminRaffle = {}
AdminRaffle.DefaultChance = 5 --Chance out of one hundred, can be overridden using console
AdminRaffle.DefaultAmount = 800 --Money earned upon win, can be overridden using console

concommand.Add( "darkrp_adminraffle_start", function( ply, cmd, args )
	if not ply:IsAdmin() then return end
	for k, v in pairs( player.GetAll() ) do
		v:ChatPrint( "The server admins have started a raffle!" )
	end
	local RaffleChance = tonumber( args[2] ) or AdminRaffle.DefaultChance
	local RaffleMoney = tonumber( args[1] ) or AdminRaffle.DefaultAmount
	for k, v in pairs( player.GetAll() )
		local RandomNumber = math.random( 1, 100 )
		if RaffleChance > RandomNumber then
			local LuckyMoney = DarkRP.createMoneyBag( v:GetShootPos(), RaffleMoney )
			LuckyMoney:Spawn()
			v:ChatPrint( "You have won "..RaffleMoney.."!" )
		else
			v:ChatPrint( "I guess it just isn't your lucky day." )
		end
	end
end )
