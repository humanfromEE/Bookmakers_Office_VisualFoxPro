CLOSE TABLES ALL 

SELECT Bet_table.*, client_table.*, worker_table.*, event_table.*;
 FROM ;
     data_base!client_table ;
    INNER JOIN data_base!bet_table ;
   ON  Client_table.id_c = Bet_table.id_c_b ;
    INNER JOIN data_base!event_table ;
   ON  Event_table.id_e = Bet_table.id_e_b ;
    INNER JOIN data_base!worker_table ;
   ON  Worker_table.id_w = Bet_table.id_w_b;
 WHERE  Bet_table.process_status_b = ( .F. );
 ORDER BY Bet_table.id_b;
INTO TABLE free_table_tickets_processed_bets.dbf
USE free_table_tickets_processed_bets
DO FORM form_tickets_processed_bets

* Налаштування властивостей форми: заголовок, розміщення завжди зверху, ширина, висота, піктограма (у заголовку)
form_tickets_processed_bets.Caption = "Перегляд квитанцій за " + TRANSFORM(DATE()) && TRANSFORM() - конвертує дату в строку, DATE() - повертає нинішню дату (у цьому випадку)
form_tickets_processed_bets.AutoCenter = .T.
form_tickets_processed_bets.Width = 500
form_tickets_processed_bets.Height = 250
path_for_icon_form = _VFP.DefaultFilePath + "\Media Files\Form Tickets Processed Bets\form_tickets_processed_bets_icon.ico" && _VFP - системна змінна робочого середовища
form_tickets_processed_bets.Icon = path_for_icon_form

* Вивід
str_line = ""
FOR i = 1 TO 68 1
	str_line = str_line + "="
ENDFOR


check_void_file = .T. && Для виводу повідомлення при відсутності подій
DO WHILE (.NOT.EOF()) && Поки не настене кінець файлу (сформованого запиту)
	check_void_file = .F.
	
	rows_data = 0
	column_data = 0
	
	@ rows_data, column_data SAY "ID СТАВКИ - КВИТАНЦІЯ № " + STR(id_b, 10, 0) FONT "", 15 STYLE "B"
	rows_data = rows_data + 3
	@ rows_data, 0 SAY str_line 
	rows_data = rows_data + 2
	column_data = column_data + 20
	@ rows_data, column_data SAY "ID працівника: " + STR(id_w, 10, 0)
	rows_data = rows_data + 1
	@ rows_data, column_data SAY "ПІП працівника: " + fullname_w
	rows_data = rows_data + 1
	@ rows_data, column_data SAY "Ваш ID: " + STR(id_c, 10, 0)
	rows_data = rows_data + 1
	coeficient = ROUND(100 / ROUND(desired_op / all_option * 100, 2), 2)
	@ rows_data, column_data SAY "Коефіціент ставки: " + STR(coeficient, 10, 2)
	IF (summ_b > 0) THEN
		rows_data = rows_data + 1
		@ rows_data, column_data SAY "Пачаткова сума ставки: " + STR(ROUND(summ_b / coeficient, 2), 10, 2)
	ENDIF
	rows_data = rows_data + 1
	IF (summ_b != 0) THEN
		@ rows_data, column_data SAY "Ваша ставка: зайшла" 
	ELSE
		@ rows_data, column_data SAY "Ваша ставка: не зайшла" 
	ENDIF
	rows_data = rows_data + 2
	@ rows_data, 0 SAY str_line
	rows_data = rows_data + 2
	column_data = column_data + 15
	@ rows_data, column_data SAY "ВАШ ВИГРАШ: " + STR(summ_b, 10, 2) FONT "", 10 STYLE "U"
	WAIT WINDOW "Натисніть для продовження"
	CLEAR
	SKIP && Лічильник записів (перехід на наступний запис)
ENDDO


* Етап закриття
IF (check_void_file) THEN
	@ 7, 20 SAY "НЕМАЄ ЖОДНОЇ КВИТАНЦІЇ!" FONT "", 15 STYLE "B"
	WAIT WINDOW "НЕМАЄ ЖОДНОЇ КВИТАНЦІЇ! НАТИСНІСТЬ ENTER"
ENDIF

_SCREEN.ActiveForm.release()
CLOSE TABLES ALL
