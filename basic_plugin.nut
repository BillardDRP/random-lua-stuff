function givePlayerItem(ply, itemclass) {
	local plyPos = ply.EyePosition();
	SendToConsole("ent_create " + itemclass + " Temp_WeaponPickupForPlayer");
	local plyWep = Entities.FindByTarget(null, itemclass);
	plyWep.SetOrigin(plyPos);
}
