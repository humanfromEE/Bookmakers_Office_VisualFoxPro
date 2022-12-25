CLOSE TABLES ALL 

SELECT * FROM data_base!worker_table;
INTO TABLE free_table_copy_report_salary_foundation_of_workers.dbf
USE free_table_copy_report_salary_foundation_of_workers
DO FORM form_copy_report_salary_foundation_of_workers

* Налаштування властивостей форми: заголовок, розміщення завжди зверху, ширина, висота, піктограма (у заголовку)
form_copy_report_salary_foundation_of_workers.Caption = "Копія звіту за " + TRANSFORM(DATE()) && TRANSFORM() - конвертує дату в строку, DATE() - повертає нинішню дату (у цьому випадку)
form_copy_report_salary_foundation_of_workers.AutoCenter = .T.
form_copy_report_salary_foundation_of_workers.Width = 800
form_copy_report_salary_foundation_of_workers.Height = 500
path_for_icon_form = _VFP.DefaultFilePath + "\Media Files\Form Copy Report\form_copy_report_icon.ico" && _VFP - системна змінна робочого середовища
form_copy_report_salary_foundation_of_workers.Icon = path_for_icon_form

* Вивід шапки
rows_header = 0 && Позиція рядка (висоти форми)
str_line = "" && Строка лінії
FOR i = 1 TO 112 1 && Стоврення лінії
	str_line = str_line + "="
ENDFOR
	@ rows_header, 0 SAY str_line
rows_header = rows_header + 1
	@ rows_header, 0 SAY "ФОНД ЗАРПЛАТ УСІХ ПРАЦІВНИКІВ" FONT "", 15 STYLE "B"
rows_header = rows_header + 2
	@ rows_header, 0 SAY DATE() STYLE "I"
rows_header = rows_header + 1
	@ rows_header, 0 SAY str_line
rows_header = rows_header + 1
str_space_100 = "" && Строка відступів роміром 100
str_space_20 = "" && Строка відступів роміром 20
FOR i = 1 TO 100 1 && Стоврення відступів
	str_space_100 = str_space_100 + " "
	IF (i <= 20) THEN
		str_space_20 = str_space_20 + " "
	ENDIF
ENDFOR
	@ rows_header, 0 SAY str_space_100 + "ID" + str_space_20 + "ПІП" + str_space_100 + "ЗАРПЛАТА" STYLE "B"
rows_header = rows_header + 1
	@ rows_header, 0 SAY str_line
	
* Вивід даних
rows_data = rows_header + 2 && Позиція рядка (висоти форми)
min_salary = salary_w && Мінімальна зарплата
max_salary = salary_w && Максимальна зарплата
count_workers = 0 && Кількість працівників
summ_salary = 0.0 && Сума усіх зарплат
DO WHILE (.NOT.EOF()) && Поки не настене кінець файлу (сформованого запиту)
		@ rows_data, 55 SAY id_w
		@ rows_data, 74 SAY fullname_w
		@ rows_data, 140 SAY salary_w
	rows_data  = rows_data  + 2
	* Розрахунок підсумкових параметрів
	summ_salary = summ_salary + salary_w
	count_workers = count_workers + 1
	IF (min_salary > salary_w) THEN
		min_salary = salary_w
	ENDIF
	IF (max_salary < salary_w) THEN
		max_salary = salary_w
	ENDIF
	SKIP && Лічильник записів (перехід на наступний запис)
ENDDO
avarage_salary = ROUND((summ_salary / count_workers), 2) && Середня зарплата (розрахунок підсумкових параметрів); ROUNTD() - функція округлення

* Вивід результатуючих даних
rows_result_data = rows_data + 3
	@ rows_result_data, 0 SAY "Сума усіх зарплат: "
	@ rows_result_data, 138 SAY summ_salary 
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "Кількість працівників: "
	@ rows_result_data, 138 SAY count_workers	
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "Середня зарплата: "
	@ rows_result_data, 138 SAY avarage_salary 
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "Мінімальна зарплата: "
	@ rows_result_data, 138 SAY min_salary
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "Максимальна зарплата: "
	@ rows_result_data, 138 SAY max_salary

* Етап закриття
FOR i = -3 TO -1 1
	WAIT WINDOW "Для закриття натисніть певну кількість раз: " + STR(ABS(i), 1, 0)
ENDFOR
_SCREEN.ActiveForm.release()
CLOSE TABLES ALL
