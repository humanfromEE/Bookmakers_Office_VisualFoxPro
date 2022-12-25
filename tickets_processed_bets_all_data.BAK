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
INTO TABLE free_table_tickets_processed_bets_all_data.dbf
USE free_table_tickets_processed_bets_all_data
DO FORM form_tickets_processed_bets_all_data

* Налаштування властивостей форми: заголовок, розміщення завжди зверху, ширина, висота, піктограма (у заголовку)
form_tickets_processed_bets_all_data.Caption = "Перегляд усіх квитанцій за " + TRANSFORM(DATE()) && TRANSFORM() - конвертує дату в строку, DATE() - повертає нинішню дату (у цьому випадку)
form_tickets_processed_bets_all_data.AlwaysOnTop = .T.
form_tickets_processed_bets_all_data.Width = 1250
form_tickets_processed_bets_all_data.Height = 800
path_for_icon_form = _VFP.DefaultFilePath + "\Media Files\Form Tickets Processed Bets\form_tickets_processed_bets_icon.ico" && _VFP - системна змінна робочого середовища
form_tickets_processed_bets_all_data.Icon = path_for_icon_form



* Вивід шапки
str_header_space = ""
FOR i = 1 TO 15 1
	str_header_space = str_header_space + " "
ENDFOR
str_line_header = ""
FOR i = 1 TO 175 1
	str_line_header = str_line_header + "="
ENDFOR

rows_header = 0
str_header = "ID ставки" + str_header_space + "ID працівника" + str_header_space + "ПІП працівника" + str_header_space + str_header_space + str_header_space  + "Ваш ID" + str_header_space + "Результат ставки" + str_header_space + "Коефіціент ставки" + str_header_space + "Виграш" + str_header_space + "Початова сума"
	@ rows_header, 0 SAY str_header FONT "", 9 STYLE "B"
rows_header = rows_header + 1
	@ rows_header, 0 SAY str_line_header



* Вивід даних
str_line_data = ""
FOR i = 1 TO 245 1
	str_line_data = str_line_data + "*"	
ENDFOR
check_void_file = .T. && Для виводу повідомлення при відсутності подій
rows_data = rows_header + 1
	@ rows_data, 0 SAY str_line_data
rows_data = rows_data + 1

DO WHILE (.NOT.EOF()) && Поки не настене кінець файлу (сформованого запиту)
	check_void_file = .F.
	columns_data = 0
		@ rows_data, columns_data SAY STR(id_b, GetLengthNumber(id_b), 0)
	columns_data = columns_data + 24
		@ rows_data, columns_data SAY STR(id_w, GetLengthNumber(id_w), 0)
	columns_data = columns_data + 28
		@ rows_data, columns_data SAY fullname_w
	columns_data = columns_data + 55
		@ rows_data, columns_data SAY STR(id_c, GetLengthNumber(id_c), 0)
	columns_data = columns_data + 20
	IF (summ_b != 0) THEN
		@ rows_data, columns_data SAY "зайшла" 
	ELSE
		@ rows_data, columns_data SAY "не зайшла" 
	ENDIF
	coeficient = ROUND(100 / ROUND(desired_op / all_option * 100, 2), 2)
	columns_data = columns_data + 28
		@ rows_data, columns_data SAY coeficient 
	columns_data = columns_data + 39
		@ rows_data, columns_data SAY STR(ROUND(summ_b, 2), GetLengthNumber(INT(summ_b)) + 3, 2)
	columns_data = columns_data + 21
	IF (summ_b != 0) THEN
		@ rows_data, columns_data SAY STR(ROUND(summ_b / coeficient, 2), GetLengthNumber(INT(summ_b / coeficient)) + 3, 2)
	ELSE
		@ rows_data, columns_data SAY "Дані недоступні"
	ENDIF
	rows_data = rows_data + 1
		@ rows_data, 0 SAY str_line_data
	rows_data = rows_data + 1
	SKIP && Лічильник записів (перехід на наступний запис)
ENDDO


* Етап закриття
IF (check_void_file) THEN
	@ 7, 20 SAY "НЕМАЄ ЖОДНОЇ КВИТАНЦІЇ!" FONT "", 15 STYLE "B"
ENDIF

FOR i = -3 TO -1 1
	WAIT WINDOW "Закриття через кількість натисків: " + STR(ABS(i), 1, 0)
ENDFOR

_SCREEN.ActiveForm.release()
CLOSE TABLES ALL

* Функція повернення довжини цілого числа: (534) - return 3; (-534) - return 4
FUNCTION GetLengthNumber
LPARAMETERS value_number
	length_number = 0
	number_10_power = 0
	ABS_value_number = ABS(value_number)
	DO WHILE (.T.)
		number_10_power = number_10_power + 1
		length_number = length_number + 1
		IF (ABS_value_number < (10 ^ number_10_power) ) THEN
			EXIT
		ENDIF
	ENDDO
	IF (value_number < 0) THEN && Перевірка чи число від'ємна
		length_number = length_number + 1
	ENDIF
	RETURN length_number
ENDFUNC
