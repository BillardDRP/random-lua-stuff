DoIncludeScript("errors.nut", this)

this.Score_T <- 0;
this.Score_CT <- 0;

function ResetScores() {
	Score_T = 0;
	Score_CT = 0;
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
