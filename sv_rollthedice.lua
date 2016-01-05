RTD = {}
RTD.Enabled = true --Keep this true
RTD.CooldownTime = 20 --Cooldown time in seconds
RTD.Rolls = { --Use this to add more rolls but only if you created the function for the roll beforehand
	[RTD_SpeedIncrease] = true
	[RTD_SpeedDecrease] = true
	[RTD_HealthIncrease] = true
	[RTD_HealthDecrease] = true
	[RTD_JumpIncrease] = true
	[RTD_JumpDecrease] = true
	[RTD_Drugged] = true
]

function DisplayDiceMessage( ply, message_end )
	for k, v in pairs( player.GetAll() ) do
		local RandomNumber = math.random( 1, #RTD.Rolls )
		v:ChatPrint( ply.." has rolled a "..RandomNumber.." and "..message_end )
	end
end

function RTD_SpeedIncrease( ply )
	local become_message = "became a cheetah!"
	DisplayDiceMessage( ply, become_message )
	ply:SetRunSpeed( 600 )
	ply:SetWalkSpeed( 400 )
end

function RTD_SpeedDecrease( ply )
	local become_message = "became a snail!"
	DisplayDiceMessage( ply, become_message )
	ply:SetRunSpeed( 6 )
	ply:SetWalkSpeed( 4 )
end

function RTD_HealthIncrease( ply )
	local become_message = "ate a lucky sandvich!"
	DisplayDiceMessage( ply, become_message )
	ply:SetHealth( 400 )
end

function RTD_HealthDecrease( ply )
	local become_message = "became killable by a sneeze!"
	DisplayDiceMessage( ply, become_message )
	ply:SetHealth( 1 )
end

function RTD_JumpIncrease( ply )
	local become_message = "became a bunny!"
	DisplayDiceMessage( ply, become_message )
	ply:SetJumpPower( 800 )
end

function RTD_JumpDecrease( ply )
	local become_message = "became an anvil!"
	DisplayDiceMessage( ply, become_message )
	ply:SetJumpPower( 10 )
end

function RTD_Drugged( ply )
	local become_message = "took some of that good stuff!"
	DisplayDiceMessage( ply, become_message )
	ply:SetFOV( 360, 30 )
end

function EnableRTD()
	RTD.Enabled = true
end

function DisableRTD()
	RTD.Enabled = false	
	timer.Simple( RTD.CooldownTime, EnableRTD )
end

function PickRandomRTD( ply )
	local RandomNumber = math.random( 1, #RTD.Rolls )
	local FuncToCall = RTD.Rolls[RandomNumber]
	timer.Simple( 0.1, FuncToCall )
end

hook.Add( "PlayerSay", "RollTheDiceCommandHook", function( ply, text, isTeam )
	if not IsValid( ply ) then return end
	if text = "!rtd" then
		if RTD.Enabled then
			PickRandomRTD( ply )
		else
			ply:ChatPrint( "Please wait before rolling the dice." )
		end
	end
end )
