##############################BRANCH 03########################################
#COMPANY - PERSON - COMPANY - COMPANY - PERSON - COMPANY
	
	1  SELECT 
	2    C01.company_name, 
	3    P01.name_person,
	4    C02.company_name,
	5    C03.company_name,
	6    P02.name_person,
	7    C04.company_name
	8  FROM people_partners AS PP01
	9    INNER JOIN companies AS C01 
	10     ON C01.pk_company = PP01.fk_company
	11   INNER JOIN people AS P01 
	12     ON P01.pk_person = PP01.fk_person_partner
	13   LEFT JOIN people_partners AS PP02 
	14     ON PP02.fk_person_partner = P01.pk_person
	15   LEFT JOIN companies AS C02 
	16     ON C02.pk_company = PP02.fk_company
	17   LEFT JOIN companies_partners AS CP03 
	18     ON CP03.fk_company_partner = C02.pk_company
	19   LEFT JOIN companies AS C03 
	20     ON C03.pk_company = CP03.fk_company
	21   LEFT JOIN people_partners AS PP04 
	22     ON PP04.fk_company = C03.pk_company
	23   LEFT JOIN people AS P02
	24     ON P02.pk_person = PP04.fk_person_partner    
	25   LEFT JOIN people_partners AS PP05 
	26     ON PP05.fk_person_partner = P02.pk_person
	27   LEFT JOIN companies AS C04
	28     ON C04.pk_company = PP05.fk_company
	29 WHERE C02.pk_company <> C01.pk_company 
	30   AND C02.pk_company <> C03.pk_company 
	31   AND C01.pk_company <> C03.pk_company
	32   AND C04.pk_company <> C01.pk_company
	33   AND C04.pk_company <> C02.pk_company
	34   AND C04.pk_company <> C03.pk_company
	35   AND P02.pk_person <> P01.pk_person 
	36   AND ((C01.company_name = 'COMPANY B' AND C02.company_name = 'COMPANY C') 
	37     OR (C01.company_name = 'COMPANY B' AND C03.company_name = 'COMPANY C') 
	38     OR (C01.company_name = 'COMPANY B' AND C04.company_name = 'COMPANY C'));
