# Graphrepo - Repository to graph tools
## Loadgraph

The loadgraph is a program to load CSV files or SQL queries into graph databases using the concept of Job. The job is described into XML and transformed in vertices and edges. For now, the loadgraph are only working with Neo4j and a rough implementation to generate RDF files.

>Use the following command to load the graph:

`java -jar loadgraph.jar job.xml`

>A example of XML File is shown below and other can be found in examplesTest diretory too.

```
<?xml version='1.0' encoding='utf-8'?>
<job description="Job Test">
	<destination id="graphProcurements" type = "NEO4J" method="update">/database/neo4j</destination>
			
	<source id="Procurements" 
			type = "SQL"
			driver = "com.mysql.jdbc.Driver" 
			urlConnection = "jdbc:mysql://localhost:3306/procurements"
			database = "procurements"
			uid = "root"
			passwd = "password">
			SELECT fk_company, fk_company_partner, '19/12/2014' as load_date 
			FROM procurements.companies_partners;
			</source>

	<vertex label="CompanyPartner" aliasFor="Company">
		<map fieldName="fk_company" rename="idCompany" key="true" type="int"/>
	</vertex>

	<vertex label="Company">
		<map fieldName="fk_company_partner" rename="idCompany" key="true" type="int"/>
	</vertex>	

	<edge id="CompanyPartner" vertexSrc="CompanyPartner" label="HAS_PART" vertexDst="Company">
		<map fieldName="load_date" type="string"/>
	</edge>
	
</job>
```

If the insert option in destination tag is used, the program will not check if the vertex exists, but will be faster. This mode are better to load lists with unique vertices.

##License

Loadgraph is licensed under the Apache License, Version 2.0.
