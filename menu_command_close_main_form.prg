user_answer = MESSAGEBOX("Ви дійсно бажаєте закрити головну форму?", 4 + 32 + 256, "ПРОЦЕС ЗАКРИВАННЯ ГОЛОВНОЇ ФОРМИ")
IF (user_answer = 6) THEN
	user_answer = MESSAGEBOX("УВАГА! Якщо ви хочете просто вийти з EXE-програми, то оберіть пункт ''Вийти з VFP''. Ви запустили Головну форму через Project Manager?", 4 + 48 + 256, "ПРОЦЕС ЗАКРИВАННЯ ГОЛОВНОЇ ФОРМИ")
	IF (user_answer = 6) THEN
		user_answer = MESSAGEBOX("Якщо ви закриєте Головну форму через EXE-файл, ви втратите дані й не зможете закрити виконавче вікно VFP. Якщо ви хочете просто вийти з EXE-програми, то оберіть пункт ''Вийти з VFP''. Ви дійсно впевнені, що закриваєте Головну форму через Project Manager?", 1 + 16 + 256, "ПРОЦЕС ЗАКРИВАННЯ ГОЛОВНОЇ ФОРМИ")
		IF (user_answer = 1) THEN
			CLOSE TABLES ALL 
			_SCREEN.ActiveForm.release() 
		ENDIF 
	ENDIF 
ENDIF
