DoIncludeScript("errors.nut", this)
DoIncludeScript("score.nut", this)

function TeamCaptured(team) {
	if ((team == "T") or (team == "CT")) {
		IncrementScore(team, 1)
	} else {
		ThrowError("TeamCaptured expected valid team, got null team ID!")
	}
}
