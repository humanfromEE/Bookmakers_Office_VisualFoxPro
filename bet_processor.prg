* � ������ �� ����� �� ���������, �� �� ����� ���������� ����� ����� � ����� �������
* =====================================================================================
* =====================================================================================

CLOSE TABLES ALL

SELECT Event_table.id_re_e, Bet_table.id_re_b,;
  Departament_table.id_d, Event_table.id_e, Worker_table.id_w, Bet_table.id_b,;
  Event_table.all_options_e, Event_table.desired_options_e,;
  Bet_table.summ_b, Departament_table.capital_d;
 FROM ;
     data_base!departament_table ;
    INNER JOIN data_base!worker_table ;
   ON  Departament_table.id_d = Worker_table.id_d_w ;
    INNER JOIN data_base!bet_table ;
   ON  Worker_table.id_w = Bet_table.id_w_b ;
    INNER JOIN data_base!event_table ;
   ON  Event_table.id_e = Bet_table.id_e_b;
 WHERE  Bet_table.process_status_b = .T.;
 INTO TABLE free_table_bet_processor.dbf
 USE free_table_bet_processor

DO WHILE (.NOT.EOF()) && ���� �� ������� ����� �����
	id_event_now = id_e
	id_bet_now = id_b
	id_worker_now = id_w
	id_departament_now = id_d
	summ_bet_now = summ_b
	capital_departament_now = capital_d
	UPDATE data_base!worker_table SET update_data_w = .F. WHERE id_w = id_worker_now
	UPDATE data_base!bet_table SET process_status_b = .F. WHERE id_b = id_bet_now
	
	IF (id_re_b = id_re_e) THEN && � ������ �� �� � ����������� �������� ���� �������
		coeficient_bet = ROUND(100 / ROUND(desired_op / all_option * 100, 2), 2)
		summ_bet_now = summ_bet_now * coeficient_bet
	ELSE
		summ_bet_now = 0
	ENDIF
	
	IF (summ_bet_now >= 1000) THEN && �������� �� ��������� ������� ����� ����
		UPDATE data_base!bet_table SET summ_b = 1000 WHERE id_b = id_bet_now
	ELSE
		UPDATE data_base!bet_table SET summ_b = summ_bet_now WHERE id_b = id_bet_now
	ENDIF
	
	IF (id_re_b = id_re_e) THEN && � ������ �� �� � ����������� ������� �����
		IF ( (capital_departament_now - summ_bet_now) < 1000) THEN && �������� �� ��������� ������� �����
			UPDATE data_base!departament_table SET capital_d = 1000 WHERE id_d = id_departament_now 
		ELSE
			capital_departament_now = capital_departament_now - summ_bet_now
			UPDATE data_base!departament_table SET capital_d = capital_departament_now  WHERE id_d = id_departament_now 
		ENDIF
	ELSE
		capital_departament_now = capital_departament_now + summ_bet_now
		UPDATE data_base!departament_table SET capital_d = capital_departament_now  WHERE id_d = id_departament_now
	ENDIF
	
	SKIP && ˳������� ������ (������� �� ��������� �����)
ENDDO

CLOSE TABLES ALL

