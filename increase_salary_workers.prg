* Я зробив це через цю програмку, бо не можна оновлювати кілька даних з різних таблиць
* =====================================================================================
* =====================================================================================

CLOSE TABLES ALL

SELECT Worker_table.fullname_w,;
  COUNT(Bet_table.id_b) AS count_wins,;
  Worker_table.id_w,;
  Worker_table.salary_w;
 FROM ;
     data_base!worker_table ;
    INNER JOIN data_base!bet_table ;
   ON  Worker_table.id_w = Bet_table.id_w_b ;
    INNER JOIN data_base!event_table ;
   ON  Event_table.id_e = Bet_table.id_e_b;
 WHERE  Event_table.id_re_e = Bet_table.id_re_b; && Результати ставки й подій мають бути однаковими
   AND  Bet_table.process_status_b = ( .F. ); && Події завершині
   AND Worker_table.update_data_w = (.F.); && Оновлення даних працівника повинне бути неправидивим, щоб не йшло по колу начислення зарпалти
 GROUP BY Worker_table.fullname_w, Worker_table.id_w, Worker_table.salary_w;
 HAVING  ( count_wins) >= ( 3 );
 ORDER BY count_wins DESC;
 INTO TABLE free_table_increase_salary_workers.dbf
 USE free_table_increase_salary_workers
 
* Типи для збільшення зарплат
type_one = 0.1
type_two = 0.2
type_three = 0.15
type_fourth = 0.17
type_five = 0.09

DO WHILE (.NOT.EOF()) && Поки не настане кінець файлу
	id_now = id_w && Збереження ID для зміни даних
	UPDATE data_base!worker_table SET update_data_w = .T. WHERE id_w = id_now && Зміна статусу обробки, щоб уникнути повторного врахування при недіянні працівника
	* Типи збілення (зміни) зарплати
	type_now = 0
	DO CASE
		CASE count_wins = 3
			type_now = type_one
		CASE count_wins = 5
			type_now = type_two
		CASE count_wins = 10
			type_now = type_three
		CASE count_wins = 20
			type_now = type_fourtn
		CASE count_wins = 50
			type_now = type_five
	ENDCASE
	salary_now = salary_w + salary_w * type_now
	UPDATE data_base!worker_table SET salary_w = ROUND(salary_now, 2) WHERE id_w = id_now && Зміна зарпалати
	SKIP && Лічильник записів (перехід на наступний запис)
ENDDO

CLOSE TABLES ALL
