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

* ������������ ������������ �����: ���������, ��������� ������ ������, ������, ������, ��������� (� ���������)
form_tickets_processed_bets.Caption = "�������� ��������� �� " + TRANSFORM(DATE()) && TRANSFORM() - �������� ���� � ������, DATE() - ������� ������ ���� (� ����� �������)
form_tickets_processed_bets.AutoCenter = .T.
form_tickets_processed_bets.Width = 500
form_tickets_processed_bets.Height = 250
path_for_icon_form = _VFP.DefaultFilePath + "\Media Files\Form Tickets Processed Bets\form_tickets_processed_bets_icon.ico" && _VFP - �������� ����� �������� ����������
form_tickets_processed_bets.Icon = path_for_icon_form

* ����
str_line = ""
FOR i = 1 TO 68 1
	str_line = str_line + "="
ENDFOR


check_void_file = .T. && ��� ������ ����������� ��� ��������� ����
DO WHILE (.NOT.EOF()) && ���� �� ������� ����� ����� (������������ ������)
	check_void_file = .F.
	
	rows_data = 0
	column_data = 0
	
	@ rows_data, column_data SAY "ID ������ - ������ֲ� � " + STR(id_b, 10, 0) FONT "", 15 STYLE "B"
	rows_data = rows_data + 3
	@ rows_data, 0 SAY str_line 
	rows_data = rows_data + 2
	column_data = column_data + 20
	@ rows_data, column_data SAY "ID ����������: " + STR(id_w, 10, 0)
	rows_data = rows_data + 1
	@ rows_data, column_data SAY "ϲ� ����������: " + fullname_w
	rows_data = rows_data + 1
	@ rows_data, column_data SAY "��� ID: " + STR(id_c, 10, 0)
	rows_data = rows_data + 1
	coeficient = ROUND(100 / ROUND(desired_op / all_option * 100, 2), 2)
	@ rows_data, column_data SAY "���������� ������: " + STR(coeficient, 10, 2)
	IF (summ_b > 0) THEN
		rows_data = rows_data + 1
		@ rows_data, column_data SAY "��������� ���� ������: " + STR(ROUND(summ_b / coeficient, 2), 10, 2)
	ENDIF
	rows_data = rows_data + 1
	IF (summ_b != 0) THEN
		@ rows_data, column_data SAY "���� ������: ������" 
	ELSE
		@ rows_data, column_data SAY "���� ������: �� ������" 
	ENDIF
	rows_data = rows_data + 2
	@ rows_data, 0 SAY str_line
	rows_data = rows_data + 2
	column_data = column_data + 15
	@ rows_data, column_data SAY "��� ������: " + STR(summ_b, 10, 2) FONT "", 10 STYLE "U"
	WAIT WINDOW "�������� ��� �����������"
	CLEAR
	SKIP && ˳������� ������ (������� �� ��������� �����)
ENDDO


* ���� ��������
IF (check_void_file) THEN
	@ 7, 20 SAY "����� ����ί ������ֲ�!" FONT "", 15 STYLE "B"
	WAIT WINDOW "����� ����ί ������ֲ�! �����Ͳ��� ENTER"
ENDIF

_SCREEN.ActiveForm.release()
CLOSE TABLES ALL
