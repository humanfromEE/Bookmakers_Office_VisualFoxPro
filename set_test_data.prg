* ??? ?????????? ?????????? ?????
* ==========================================================================================
* ==========================================================================================

CLOSE TABLES ALL

* RAND() - ???????? ??????? ????? ? ????????? [0; 1]

UPDATE data_base!worker_table SET update_data_w = .T. WHERE update_data_w = .F.
UPDATE data_base!bet_table SET process_status_b = .T. WHERE process_status_b = .F.
UPDATE data_base!worker_table SET salary_w = RAND()*(501 - 155) + 155 WHERE update_data_w = .T. && ĳ?????? ??????? [155; 500]
UPDATE data_base!bet_table SET summ_b = RAND()*(31 - 25) + 25 WHERE process_status_b = .T. && ĳ?????? ??????? [20; 30]
UPDATE data_base!departament_table SET capital_d = RAND()*(5556 - 3000) + 3000 WHERE BETWEEN(id_d, 1, 9999) && ĳ?????? ??????? [3000; 5555]


CLOSE TABLES ALL