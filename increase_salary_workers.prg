* � ������ �� ����� �� ���������, �� �� ����� ���������� ����� ����� � ����� �������
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
 WHERE  Event_table.id_re_e = Bet_table.id_re_b; && ���������� ������ � ���� ����� ���� ����������
   AND  Bet_table.process_status_b = ( .F. ); && ��䳿 ��������
   AND Worker_table.update_data_w = (.F.); && ��������� ����� ���������� ������� ���� ������������, ��� �� ���� �� ���� ���������� ��������
 GROUP BY Worker_table.fullname_w, Worker_table.id_w, Worker_table.salary_w;
 HAVING  ( count_wins) >= ( 3 );
 ORDER BY count_wins DESC;
 INTO TABLE free_table_increase_salary_workers.dbf
 USE free_table_increase_salary_workers
 
* ���� ��� ��������� �������
type_one = 0.1
type_two = 0.2
type_three = 0.15
type_fourth = 0.17
type_five = 0.09

DO WHILE (.NOT.EOF()) && ���� �� ������� ����� �����
	id_now = id_w && ���������� ID ��� ���� �����
	UPDATE data_base!worker_table SET update_data_w = .T. WHERE id_w = id_now && ���� ������� �������, ��� �������� ���������� ���������� ��� ������ ����������
	* ���� ������� (����) ��������
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
	UPDATE data_base!worker_table SET salary_w = ROUND(salary_now, 2) WHERE id_w = id_now && ���� ���������
	SKIP && ˳������� ������ (������� �� ��������� �����)
ENDDO

CLOSE TABLES ALL
