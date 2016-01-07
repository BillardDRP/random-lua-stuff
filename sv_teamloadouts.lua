local function SetContains(set, key)
    return set[key] ~= nil
end

local TeamLoadouts = {
	["Gun Dealer"] = { "weapon_crowbar", "weapon_pistol", "lockpick" }
	["Mayor"] = { "stunstick", "weapon_pistol" }
	["Gangster"] = { "weapon_mac102", "weapon_deagle2" }
}

hook.Add( "PlayerSpawn", "TeamLoadoutsMainHook" function( player )
	local PlayerTeamName = team.GetName( player:Team() )
	if SetContains( TeamLoadouts, PlayerTeamName ) then
		for k, v in pairs( TeamLoadouts[PlayerTeamName] ) do
			player:Give( v )
			print( "You have been given a "..v:GetPrintName() )
		end
	end
end )
