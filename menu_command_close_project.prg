user_answer = MESSAGEBOX("�� ����� ������ ������� ����� ������?", 4 + 32 + 256, "������ ���������� ������ �������")
IF (user_answer = 6) THEN
	user_answer = MESSAGEBOX("�����! ���� �� ������ ������ ����� � EXE-��������, �� ������ ����� ''����� � VFP''. �� ����� ����������� � Project Manager?", 4 + 48 + 256, "������ ���������� ������ �������")
	IF (user_answer = 6) THEN
		user_answer = MESSAGEBOX("���� �� ������� ������ ����� EXE-����, �� �������� ���� � �� ������� ������� ��������� ���� VFP.  ���� �� ������ ������ ����� � EXE-��������, �� ������ ����� ''����� � VFP''. �� ����� ��������, �� ��������� ������ ����� Project Manager?", 1 + 16 + 256, "������ ���������� ������ �������")
		IF (user_answer = 1) THEN
			CLOSE TABLES ALL 
			_SCREEN.ActiveForm.release()
			CLOSE ALL
		ENDIF
	ENDIF 
ENDIF