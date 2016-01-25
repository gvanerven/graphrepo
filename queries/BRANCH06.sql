##############################BRANCH 06########################################
#COMPANY - COMPANY - PERSON - COMPANY - COMPANY
	
	1  SELECT 
	2    C01.company_name, 
	3    C02.company_name,
	4    P01.name_person,
	5    C03.company_name,
	6    C04.company_name
	7  FROM companies_partners AS CP01
	8    INNER JOIN companies AS C01 
	9      ON C01.pk_company = CP01.fk_company_partner
	10   LEFT JOIN companies AS C02 
	11     ON C02.pk_company = CP01.fk_company    
	12   LEFT JOIN people_partners AS PP02 
	13     ON PP02.fk_company = C02.pk_company
	14   INNER JOIN people AS P01
	15     ON P01.pk_person = PP02.fk_person_partner
	16   LEFT JOIN people_partners AS PP03 
	17     ON PP03.fk_person_partner = P01.pk_person
	18   LEFT JOIN companies AS C03 
	19     ON C03.pk_company = PP03.fk_company
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
