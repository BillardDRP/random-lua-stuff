RTD = {}
RTD.CooldownTime = 20 --Cooldown time in seconds
RTD.Rolls = { --Use this to add more rolls but only if you crated the function beforehand
	[RTD_SpeedIncrease] = true
	[RTD_SpeedDecrease] = true
	[RTD_HealthIncrease] = true
	[RTD_HealthDecrease] = true
	[RTD_JumpIncrease] = true
	[RTD_JumpDecrease] = true
	[RTD_Drugged] = true
]

function RTD_SpeedIncrease( ply )
	local become_message = "became a cheetah!"
end

function RTD_SpeedDecrease( ply )
	local become_message = "became a snail!"
end

function RTD_HealthIncrease( ply )
	local become_message = "took some morphine!"
end

function RTD_HealthDecrease( ply )
	local become_message = "caught ebola!"
end

function RTD_JumpIncrease( ply )
	local become_message = "became a bunny!"
end

function RTD_JumpDecrease( ply )
	local become_message = "became an anvil!"
end

function RTD_JumpDecrease( ply )
	local become_message = "took some of that good stuff!"
end
