function givePlayerItem(ply, itemclass) {
	local plyPos = ply.EyePosition();
	SendToConsole("ent_create " + itemclass + " Temp_WeaponPickupForPlayer");
	local plyWep = Entities.FindByTarget(null, itemclass);
	plyWep.SetOrigin(plyPos);
}

function setPlayerHealth(ply, newHealth, setMaxHealth) {
	ply.SetHealth(newHealth);
	if (setMaxHealth) {
		ply.SetMaxHealth(newHealth);
	}
}

