##############################BRANCH 07########################################
#COMPANY - COMPANY - COMPANY - PERSON - COMPANY
	
	1  SELECT 
	2    C01.company_name, 
	3    C02.company_name,
	4    C03.company_name,
	5    P01.name_person,
	6    C04.company_name
	7  FROM companies_partners AS CP01
	8    INNER JOIN companies AS C01 
	9      ON C01.pk_company = CP01.fk_company_partner
	10   INNER JOIN companies AS C02 
	11     ON C02.pk_company = CP01.fk_company    
	12   LEFT JOIN companies_partners AS CP02 
	13     ON CP02.fk_company_partner = C02.pk_company
	14   LEFT JOIN companies AS C03 
	15     ON C03.pk_company = CP02.fk_company
	16   LEFT JOIN people_partners AS PP03
	17     ON PP03.fk_company = C03.pk_company
	18   LEFT JOIN people AS P01
	19     ON P01.pk_person = PP03.fk_person_partner
	20   LEFT JOIN people_partners AS PP04 
	21     ON PP04.fk_person_partner = P01.pk_person
	22   LEFT JOIN companies AS C04 
	23     ON C04.pk_company = PP04.fk_company
	24 WHERE C02.pk_company <> C01.pk_company 
	25   AND C02.pk_company <> C03.pk_company 
	26   AND C01.pk_company <> C03.pk_company
	27   AND C04.pk_company <> C01.pk_company
	28   AND C04.pk_company <> C02.pk_company
	29   AND C04.pk_company <> C03.pk_company
	30   AND ((C01.company_name = 'COMPANY B' AND C02.company_name = 'COMPANY C') 
	31     OR (C01.company_name = 'COMPANY B' AND C03.company_name = 'COMPANY C') 
	32     OR (C01.company_name = 'COMPANY B' AND C04.company_name = 'COMPANY C'));
