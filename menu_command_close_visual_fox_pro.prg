user_answer = MESSAGEBOX("Ви дійсно бажаєте вийти з VFP?", 1 + 32 + 256, "ПРОЦЕС ВИХОДУ З VFP")
IF (user_answer = 1) THEN
	CLOSE TABLES ALL
	_SCREEN.ActiveForm.release()
	CLOSE ALL
	QUIT
ENDIF
