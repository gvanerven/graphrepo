##############################BRANCH 04########################################
#COMPANY - PERSON - COMPANY - COMPANY - COMPANY
	
	1  SELECT 
	2    C01.company_name, 
	3    P01.name_person,
	4    C02.company_name,
	5    C03.company_name,
	6    C04.company_name
	7  FROM people_partners AS PP01
	8    INNER JOIN companies AS C01 
	9      ON C01.pk_company = PP01.fk_company
	10   INNER JOIN people AS P01 
	11     ON P01.pk_person = PP01.fk_person_partner
	12   LEFT JOIN people_partners AS PP02 
	13     ON PP02.fk_person_partner = P01.pk_person
	14   LEFT JOIN companies AS C02 
	15     ON C02.pk_company = PP02.fk_company
	16   LEFT JOIN companies_partners AS CP03 
	17     ON CP03.fk_company_partner = C02.pk_company
	18   LEFT JOIN companies AS C03 
	19     ON C03.pk_company = CP03.fk_company
	20   LEFT JOIN companies_partners AS CP04 
	21     ON CP04.fk_company_partner = C03.pk_company
	22   LEFT JOIN companies AS C04
	23     ON C04.pk_company = CP04.fk_company
	24 WHERE C02.pk_company <> C01.pk_company 
	25   AND C02.pk_company <> C03.pk_company 
	26   AND C01.pk_company <> C03.pk_company
	27   AND C04.pk_company <> C01.pk_company
	28   AND C04.pk_company <> C02.pk_company
	29   AND C04.pk_company <> C03.pk_company
	30   AND ((C01.company_name = 'COMPANY B' AND C02.company_name = 'COMPANY C') 
	31     OR (C01.company_name = 'COMPANY B' AND C03.company_name = 'COMPANY C') 
	32     OR (C01.company_name = 'COMPANY B' AND C04.company_name = 'COMPANY C'));
