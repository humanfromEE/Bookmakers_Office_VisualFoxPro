user_answer = MESSAGEBOX("�� ����� ������ ������������� ������� �����?", 1 + 32 + 256, "������ ����������� ������ί �����")
IF (user_answer = 1) THEN
	CLOSE TABLES ALL
	_SCREEN.ActiveForm.release()
	DO FORM main
ENDIF
