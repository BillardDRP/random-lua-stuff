// Source file for custom functions

this.gameIsOnPC		<- true; // True by default

function SetGameIsOnPC(OnPC) {
	gameIsOnPC = OnPC;
}

function GameIsOnPC() {
	return gameIsOnPC;
}

function RunConsoleCommand(cmd) {
	EntFire("SquirrelHooks_CommandCenter", cmd);
}
