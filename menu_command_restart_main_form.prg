user_answer = MESSAGEBOX("Ви дійсно бажаєте перезапустити головну форму?", 1 + 32 + 256, "ПРОЦЕС ПЕРЕЗАПУСКУ ГОЛОВНОЇ ФОРМИ")
IF (user_answer = 1) THEN
	CLOSE TABLES ALL
	_SCREEN.ActiveForm.release()
	DO FORM main
ENDIF
