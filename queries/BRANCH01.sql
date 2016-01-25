##############################BRANCH 01########################################
#EMPRESA - PESSOA - EMPRESA - PESSOA - EMPRESA - PESSOA - EMPRESA
	
	1  SELECT
	2    C01.nome_empresa, 
	3    P01.nome_pessoa,
	4    C02.nome_empresa,
	5    P02.nome_pessoa,
	6    C03.nome_empresa,
	7    P03.nome_pessoa,
	8    C04.nome_empresa
	9  FROM PessoasSocios AS PP01
	10   INNER JOIN Empresas AS C01 --Inicio das 12 juncoes.
	11     ON C01.pk_empresa = PP01.fk_empresa
	12   INNER JOIN Pessoas AS P01 
	13     ON P01.pk_pessoas = PP01.fk_pessoa_socio
	14   LEFT JOIN PessoasSocios AS PP02 
	15     ON PP02.fk_pessoa_socio = P01.pk_pessoa
	16   LEFT JOIN Empresas AS C02 
	17     ON C02.pk_empresa = PP02.fk_empresa
	18   LEFT JOIN PessoasSocios AS PP03 
	19     ON PP03.fk_empresa = C02.pk_empresa
	20   LEFT JOIN Pessoas AS P02 
	21     ON P02.pk_pessoa = PP03.fk_pessoa_socio
	22   LEFT JOIN PessoasSocios AS PP04 
	23     ON PP04.fk_pessoa_socio = P02.pk_pessoa
	24   LEFT JOIN Empresas AS C03 
	25     ON C03.pk_empresa = PP04.fk_empresa
	26   LEFT JOIN PessoasSocios AS PP05 
	27     ON PP05.fk_empresa = C03.pk_empresa
	28   LEFT JOIN Pessoas AS P03 
	29     ON P03.pk_pessoas = PP05.fk_pessoa_socio
	30   LEFT JOIN PessoasSocios AS PP06 
	31     ON PP06.fk_pessoa_socio = P03.pk_pessoa
	32   LEFT JOIN Empresas AS C04 
	33     ON C04.pk_empresa = PP06.fk_empresa --Fim das 12 juncoes
	34 WHERE C02.pk_empresa <> C01.pk_empresa
	35   AND C02.pk_empresa <> C03.pk_empresa
	36   AND C01.pk_empresa <> C03.pk_empresa
	37   AND C04.pk_empresa <> C01.pk_empresa
	38   AND C04.pk_empresa <> C02.pk_empresa
	39   AND C04.pk_empresa <> C03.pk_empresa
	40   AND P02.pk_pessoa <> P01.pk_pessoa
	41   AND P03.pk_pessoa <> P01.pk_pessoa 
	42   AND P03.pk_pessoa <> P02.pk_pessoa
	43   AND ((C01.nome_empresa = 'EMPRESA B' AND C02.nome_empresa = 'EMPRESA C') 
	44   OR (C01.nome_empresa = 'EMPRESA B' AND C03.nome_empresa = 'EMPRESA C') 
	45   OR (C01.nome_empresa = 'EMPRESA B' AND C04.nome_empresa = 'EMPRESA C'));
