	##############################BRANCH 08########################################
	#COMPANY - COMPANY - COMPANY - COMPANY
	
	1  SELECT 
	2    C01.company_name, 
	3    C02.company_name,
	4    C03.company_name,
	5    C04.company_name
	6  FROM companies_partners AS CP01
	7    INNER JOIN companies AS C01 
	8      ON C01.pk_company = CP01.fk_company_partner
	9    INNER JOIN companies AS C02 
	10     ON C02.pk_company = CP01.fk_company    
	11   LEFT JOIN companies_partners AS CP02 
	12     ON CP02.fk_company_partner = C02.pk_company
	13   LEFT JOIN companies AS C03 
	14     ON C03.pk_company = CP02.fk_company
	15   LEFT JOIN companies_partners AS CP03
	16     ON CP03.fk_company_partner = C03.pk_company
	17   LEFT JOIN companies AS C04 
	18     ON C04.pk_company = CP03.fk_company
	19 WHERE C02.pk_company <> C01.pk_company 
	20   AND C02.pk_company <> C03.pk_company 
	21   AND C01.pk_company <> C03.pk_company
	22   AND C04.pk_company <> C01.pk_company
	23   AND C04.pk_company <> C02.pk_company
	24   AND C04.pk_company <> C03.pk_company
	25   AND ((C01.company_name = 'COMPANY B' AND C02.company_name = 'COMPANY C') 
	26     OR (C01.company_name = 'COMPANY B' AND C03.company_name = 'COMPANY C') 
	27     OR (C01.company_name = 'COMPANY B' AND C04.company_name = 'COMPANY C'));
