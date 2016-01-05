--Too Much Information
--Clientside lua script by Sir Francis Billard

hook.Add( "PlayerHurt", "TMI_PlayerHurt", function( victim, attacker, healthRemaining, damageTaken )
	if attacker:IsPlayer() then
		Print( victim:Nick() .. " took " .. damageTaken .. " damage from " .. attacker:Nick() .. " and has " .. healthRemaining .. " health left." )
	else
		Print( victim:Nick() .. " took " .. damageTaken .. " damage from " .. attacker .. " and has " .. healthRemaining .. " health left." )
	end
end )

hook.Add( "OnPlayerChat", "TMI_OnPlayerChat", function( ply, text, teamChat, isDead )
	print( ply:Nick() .. " sent message:\n" .. text .. "\n" )
	if teamChat then
		print( "The message was in team chat" )
	end
	if isDead then
		print( "The message was sent while dead" )
	end
end )

hook.Add( "PlayerNoClip", "TMI_PlayerNoClip", function( ply, desiredState )
	if ( desiredState ) then
		print( ply:Name() .. " wants to enter noclip." )
	else
		print( ply:Name() .. " wants to leave noclip." )
	end
end )
