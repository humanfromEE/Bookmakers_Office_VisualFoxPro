user_answer = MESSAGEBOX("�� ����� ������ ����� � VFP?", 1 + 32 + 256, "������ ������ � VFP")
IF (user_answer = 1) THEN
	CLOSE TABLES ALL
	_SCREEN.ActiveForm.release()
	CLOSE ALL
	QUIT
ENDIF
