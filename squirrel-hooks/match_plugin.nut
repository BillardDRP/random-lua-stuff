// Example plugin that gives ESEA-like matches

this.WarmupEndDelay		<- 40; // Extra time added to default warmup time

function OnMapLoad() {
	RunConsoleCommand("warmup_pausetimer 1");
	ScriptPrintMessageCenterAll("GAME WILL START IN " + WarmupEndDelay + " SECONDS");
	RunConsoleCommandWithDelay("warmup_pausetimer 0", WarmupEndDelay)
}

function OnNewRound() {
	
}
