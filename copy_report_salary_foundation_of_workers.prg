CLOSE TABLES ALL 

SELECT * FROM data_base!worker_table;
INTO TABLE free_table_copy_report_salary_foundation_of_workers.dbf
USE free_table_copy_report_salary_foundation_of_workers
DO FORM form_copy_report_salary_foundation_of_workers

* ������������ ������������ �����: ���������, ��������� ������ ������, ������, ������, ��������� (� ���������)
form_copy_report_salary_foundation_of_workers.Caption = "���� ���� �� " + TRANSFORM(DATE()) && TRANSFORM() - �������� ���� � ������, DATE() - ������� ������ ���� (� ����� �������)
form_copy_report_salary_foundation_of_workers.AutoCenter = .T.
form_copy_report_salary_foundation_of_workers.Width = 800
form_copy_report_salary_foundation_of_workers.Height = 500
path_for_icon_form = _VFP.DefaultFilePath + "\Media Files\Form Copy Report\form_copy_report_icon.ico" && _VFP - �������� ����� �������� ����������
form_copy_report_salary_foundation_of_workers.Icon = path_for_icon_form

* ���� �����
rows_header = 0 && ������� ����� (������ �����)
str_line = "" && ������ ��
FOR i = 1 TO 112 1 && ��������� ��
	str_line = str_line + "="
ENDFOR
	@ rows_header, 0 SAY str_line
rows_header = rows_header + 1
	@ rows_header, 0 SAY "���� ������� �Ѳ� ���ֲ���ʲ�" FONT "", 15 STYLE "B"
rows_header = rows_header + 2
	@ rows_header, 0 SAY DATE() STYLE "I"
rows_header = rows_header + 1
	@ rows_header, 0 SAY str_line
rows_header = rows_header + 1
str_space_100 = "" && ������ ������� ������ 100
str_space_20 = "" && ������ ������� ������ 20
FOR i = 1 TO 100 1 && ��������� �������
	str_space_100 = str_space_100 + " "
	IF (i <= 20) THEN
		str_space_20 = str_space_20 + " "
	ENDIF
ENDFOR
	@ rows_header, 0 SAY str_space_100 + "ID" + str_space_20 + "ϲ�" + str_space_100 + "��������" STYLE "B"
rows_header = rows_header + 1
	@ rows_header, 0 SAY str_line
	
* ���� �����
rows_data = rows_header + 2 && ������� ����� (������ �����)
min_salary = salary_w && ̳������� ��������
max_salary = salary_w && ����������� ��������
count_workers = 0 && ʳ������ ����������
summ_salary = 0.0 && ���� ��� �������
DO WHILE (.NOT.EOF()) && ���� �� ������� ����� ����� (������������ ������)
		@ rows_data, 55 SAY id_w
		@ rows_data, 74 SAY fullname_w
		@ rows_data, 140 SAY salary_w
	rows_data  = rows_data  + 2
	* ���������� ���������� ���������
	summ_salary = summ_salary + salary_w
	count_workers = count_workers + 1
	IF (min_salary > salary_w) THEN
		min_salary = salary_w
	ENDIF
	IF (max_salary < salary_w) THEN
		max_salary = salary_w
	ENDIF
	SKIP && ˳������� ������ (������� �� ��������� �����)
ENDDO
avarage_salary = ROUND((summ_salary / count_workers), 2) && ������� �������� (���������� ���������� ���������); ROUNTD() - ������� ����������

* ���� �������������� �����
rows_result_data = rows_data + 3
	@ rows_result_data, 0 SAY "���� ��� �������: "
	@ rows_result_data, 138 SAY summ_salary 
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "ʳ������ ����������: "
	@ rows_result_data, 138 SAY count_workers	
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "������� ��������: "
	@ rows_result_data, 138 SAY avarage_salary 
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "̳������� ��������: "
	@ rows_result_data, 138 SAY min_salary
	rows_result_data = rows_result_data + 1
	@ rows_result_data, 0 SAY "����������� ��������: "
	@ rows_result_data, 138 SAY max_salary

* ���� ��������
FOR i = -3 TO -1 1
	WAIT WINDOW "��� �������� �������� ����� ������� ���: " + STR(ABS(i), 1, 0)
ENDFOR
_SCREEN.ActiveForm.release()
CLOSE TABLES ALL
