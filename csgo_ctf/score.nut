DoIncludeScript("errors.nut", this)

this.Score_T <- 0;
this.Score_CT <- 0;

function ResetScores() {
	Score_T = 0;
	Score_CT = 0;
}

function ShowScores() {
	ScriptPrintMessageChatAll("The current score is:");
	ScriptPrintMessageChatAll("T: " + Score_T + " CT: " + Score_CT);
}

function GetScore(team) {
	if (team == "T") {
		return Score_T;
	} else if (team == "CT") {
		return Score_CT;
	} else {
		ThrowError("GetScore expected valid team, got null team ID!");
	}
}

function IncrementScore(team, amount) {
	if not (amount == 0) {
		if (team == "T") {
			Score_T = Score_T + amount;
		} else if (team == "CT") {
			Score_CT = Score_CT + amount;
		} else {
			ThrowError("IncrementScore expected valid team, got null team ID!");
		}
	} else {
		ThrowError("IncrementScore expected non-zero value, got null value!")
	}
}
