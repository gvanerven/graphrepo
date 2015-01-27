package br.gov.cgu.die.graph.loadgraph;

import java.io.File;
import java.util.List;

import org.neo4j.cypher.javacompat.ExecutionEngine;
import org.neo4j.graphdb.DynamicLabel;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.ResourceIterator;
import org.neo4j.graphdb.Transaction;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;
import org.neo4j.graphdb.schema.IndexDefinition;

import br.gov.cgu.die.graph.loadgraph.controller.GraphLoaderNeo4j;
import br.gov.cgu.die.graph.loadgraph.model.DatabaseTools;
import br.gov.cgu.die.graph.loadgraph.model.DestinationType;
import br.gov.cgu.die.graph.loadgraph.model.FiletableTools;
import br.gov.cgu.die.graph.loadgraph.model.Job;
import br.gov.cgu.die.graph.loadgraph.model.SourceType;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

/**
 * Unit test for simple App.
 */
public class AppTest 
    extends TestCase
{
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public AppTest( String testName )
    {
        super( testName );
    }

    
    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite( AppTest.class );
    }

    /**
     * Rigourous Test :-)
     */
    public void testApp()
    {
        assertTrue( true );
    }
    
    public void testConn(){    	
    	DatabaseTools dbt = new DatabaseTools();
    	dbt.execConnection("com.mysql.jdbc.Driver", "jdbc:mysql://localhost:3306/", "root", "password");
    	assertEquals(true, dbt.isConnected());
    	dbt.closeConnection();    	
    }
    
    public void testQuery(){ //remember to start the database   	
    	DatabaseTools dbt = new DatabaseTools();
    	dbt.execConnection("com.mysql.jdbc.Driver", "jdbc:mysql://localhost:3306/procurements", "root", "password");
    	dbt.execQuery("SELECT pk_person FROM people;");
   		assertEquals("1", dbt.getRecord().get("pk_person"));
   		dbt.closeConnection();
    }
    
    public void testOpenFiletable(){    	
    	FiletableTools flt = new FiletableTools();
    	flt.openFile("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\agency.csv", ';', '"', true, null);
    	assertEquals(true, flt.isOpen());
    	flt.closeFile();
    }    
    
    public void testHeaderFiletable(){
    	List<String> header;
    	FiletableTools flt = new FiletableTools();
    	flt.openFile("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\agency.csv", ';', '"',true, null);
    	header = flt.getHeader();
    	assertEquals(3, header.size());
    	assertEquals("id", header.get(0));
    	assertEquals("ministryID", header.get(1));
    	assertEquals("agencyName", header.get(2));
    	flt.closeFile();
    }
    
    public void testReadLineFiletable(){
    	List<String> fields;
    	FiletableTools flt = new FiletableTools();
    	flt.openFile("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\agency.csv", ';', '"', true, null);
    	fields = flt.getLineInArrayFields();
    	assertEquals(3, fields.size());
    	assertEquals("1", fields.get(0));
    	assertEquals("1", fields.get(1));
    	assertEquals("AGENCY A", fields.get(2));    	
    	flt.closeFile();
    }
    
    public void testReadLineFiletableWithoutQuota(){
    	List<String> fields;
    	FiletableTools flt = new FiletableTools();
    	flt.openFile("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\agency2.csv", ';', '"', true, null);
    	fields = flt.getLineInArrayFields();
    	assertEquals(3, fields.size());
    	assertEquals("1", fields.get(0));
    	assertEquals("1", fields.get(1));
    	assertEquals("AGENCY A", fields.get(2));    	
    	flt.closeFile();
    }
    
    public void testReadLineFiletableQuotaInside(){
    	List<String> fields;
    	FiletableTools flt = new FiletableTools();
    	flt.openFile("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\agency3.csv", ';', '"', true, null);
    	fields = flt.getLineInArrayFields();
    	assertEquals(3, fields.size());
    	assertEquals("1", fields.get(0));
    	assertEquals("1", fields.get(1));
    	assertEquals("AGENCY \" A", fields.get(2));    	
    	flt.closeFile();
    }    
    
    public void testReadLineFiletableDelimiterInside(){
    	List<String> fields;
    	FiletableTools flt = new FiletableTools();
    	flt.openFile("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\agency4.csv", ';', '"', true, null);
    	fields = flt.getLineInArrayFields();
    	assertEquals(3, fields.size());
    	assertEquals("1", fields.get(0));
    	assertEquals("1", fields.get(1));
    	assertEquals("AGENCY; A", fields.get(2));    	
    	flt.closeFile();
    }

    public void testLoadSourceJob(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("Procurements", job.getSource().getId());
    }

    public void testGetJobDescription(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("Job Test", job.getDescription());
    }
    
    public void testGetSourceJobType(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals(SourceType.SQL, job.getSource().getType());
    }

    public void testGetSourceJobNumAtt(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals(6, job.getSource().getProperties().size());
    }
    
    public void testGetSourceJobDatabase(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("procurements", job.getSource().getProperties().get("database"));
    }
    
    public void testGetDestinationJobId(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("graphProcurements", job.getDestination().getId());
    }
    
    public void testGetDestinationJobType(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals(DestinationType.NEO4J, job.getDestination().getType());
    }

    public void testGetDestinationJobNumAtt(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals(2, job.getDestination().getProperties().size());
    }
    
    public void testGetDestinationJobAttPath(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("c:\\database\\neo4j", job.getDestination().getProperties().get("pathToDatabase"));
    }
    
    public void testGetVertexMapPersonJob(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("name", job.getVertices().get("Person").getFieldMaps().get("name_person").get("rename"));
    }
    
    public void testGetVertexMapCompanyJob(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("true", job.getVertices().get("Company").getFieldMaps().get("pk_company").get("key"));
    }

    public void testGetEdgeMapJob(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("HAS_PART", job.getEdges().get("PersonCompany").getLabel());
    }
    
    public void testGetEdgeMapVertSrcJob(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("Person", job.getEdges().get("PersonCompany").getVertexSource().getLabel());
    }
    
    public void testGetEdgeMapVertDstJob(){
    	Job job = new Job();
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	assertEquals("Company", job.getEdges().get("PersonCompany").getVertexDestination().getLabel());
    }
    
    public void testNeo4jIndexCpf(){
    	boolean found = false;
    	GraphLoaderNeo4j gl = new GraphLoaderNeo4j();
    	Job job = new Job();
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	gl.createIndexConstrains(job.getDestination(), job.getVertices().get("Person"));

		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
		try ( Transaction tx = db.beginTx(); )
		{
			for(IndexDefinition index: db.schema().getIndexes()){
				if(index.getLabel().toString().equals(job.getVertices().get("Person").getLabel())){
					for(String s: index.getPropertyKeys()){
						if(s.equals("cpf")){
							found = true;
						}
					}
				}
			}
		    tx.success();
		}
		db.shutdown();
		assertEquals(true, found);
    	
    }
    
    public void testNeo4jIndexName(){
    	boolean found = false;
    	GraphLoaderNeo4j gl = new GraphLoaderNeo4j();
    	Job job = new Job();
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	gl.createIndexConstrains(job.getDestination(), job.getVertices().get("Person"));

		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
		try ( Transaction tx = db.beginTx(); )
		{
			for(IndexDefinition index: db.schema().getIndexes()){
				if(index.getLabel().toString().equals(job.getVertices().get("Person").getLabel())){
					for(String s: index.getPropertyKeys()){
						if(s.equals("name")){
							found = true;
						}
					}
				}
			}
		    tx.success();
		}
		db.shutdown();
		assertEquals(true, found);
    	
    }

    public void testNeo4jIndexCnpj(){
    	boolean found = false;
    	GraphLoaderNeo4j gl = new GraphLoaderNeo4j();
    	Job job = new Job();
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	gl.createIndexConstrains(job.getDestination(), job.getVertices().get("Company"));

		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
		try ( Transaction tx = db.beginTx(); )
		{
			for(IndexDefinition index: db.schema().getIndexes()){
				if(index.getLabel().toString().equals(job.getVertices().get("Company").getLabel())){
					for(String s: index.getPropertyKeys()){
						if(s.equals("cnpj")){
							found = true;
						}
					}
				}
			}
		    tx.success();
		}
		db.shutdown();
		assertEquals(true, found);
    	
    }
    
    public void testNeo4jCpfNode(){
    	boolean found = false;
    	Job job = new Job();
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraph.xml");
    	job.startLoader();

		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
		try ( Transaction tx = db.beginTx(); )
		{
			Node person;
			Label label = DynamicLabel.label("Person");
			ResourceIterator<Node> persons = db.findNodesByLabelAndProperty( label, "cpf", 1 ).iterator();
			if(persons.hasNext()){
				person = persons.next();
				if(person.getProperty("name").equals("PEOPLE A")){
					found = true;
				}
			}
		    tx.success();
		}
		db.shutdown();
		assertEquals(true, found);
    	
    }
    
    public void testNeo4jCpfNodeFromFile(){
    	boolean found = false;
    	Job job = new Job();
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraphcsv.xml");
    	job.startLoader();

		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
		try ( Transaction tx = db.beginTx(); )
		{
			Node person;
			Label label = DynamicLabel.label("Person");
			ResourceIterator<Node> persons = db.findNodesByLabelAndProperty( label, "cpf", 31 ).iterator();
			if(persons.hasNext()){
				person = persons.next();
				if(person.getProperty("name").equals("PEOPLE CA")){
					found = true;
				}
			}
		    tx.success();
		}
		db.shutdown();
		assertEquals(true, found);
    	
    }    

    public void testNeo4jProcurementNodeInsert(){
  	boolean found = false;
  	Job job = new Job();
  	ExecutionEngine engine;
  	GraphDatabaseService db;
  	
  	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraphprocinsert.xml");

  	db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
  	
  	engine = new ExecutionEngine(db);

  	try ( Transaction tx = db.beginTx(); )
	{
  		engine.execute( "match (n:Procurements) delete n" );
	    tx.success();
	}
	
  	db.shutdown();
  	
  	job.startLoader();
  	
  	db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );

	try ( Transaction tx = db.beginTx(); )
	{
		Node person;
		Label label = DynamicLabel.label("Procurement");
		ResourceIterator<Node> persons = db.findNodesByLabelAndProperty( label, "pk_procurement", 1 ).iterator();
		if(persons.hasNext()){
			person = persons.next();
			if(person.getProperty("publication_date").equals("2014-01-24")){
				found = true;
			}
		}
	    tx.success();
	}
	db.shutdown();
	assertEquals(true, found);
  	
  }
    
    public void testNeo4jProcurementNode(){
    	boolean found = false;
    	Job job = new Job();
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraphproc.xml");
    	job.startLoader();

		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
		try ( Transaction tx = db.beginTx(); )
		{
			Node person;
			Label label = DynamicLabel.label("Procurement");
			ResourceIterator<Node> persons = db.findNodesByLabelAndProperty( label, "pk_procurement", 1 ).iterator();
			if(persons.hasNext()){
				person = persons.next();
				if(person.getProperty("publication_date").equals("2014-01-24")){
					found = true;
				}
			}
		    tx.success();
		}
		db.shutdown();
		assertEquals(true, found);
    	
    }
    
    public void testRDFCreateFile(){
    	Job job = new Job();
    	File check;
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraphrdf.xml");
    	job.startLoader();
    	
    	check = new File("c:\\database\\procuremets_rdf.rdf");

		assertEquals(true, check.exists());
		assertEquals(true, check.getUsableSpace() > 0);
    	
    }
    
    public void testMultiFiles(){
    	Job job = new Job();
    	boolean found = false;
    	
    	job.loadSchema("C:\\Users\\gvanerven\\Dropbox\\Arquivos\\eclipse\\git\\localgraph\\loadgraph\\jobgraphcsvMulti.xml");
    	job.startLoader();
    	
		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( job.getDestination().getProperties().get("pathToDatabase") );
		try ( Transaction tx = db.beginTx(); )
		{
			Node person;
			Label label = DynamicLabel.label("Agency");
			ResourceIterator<Node> persons = db.findNodesByLabelAndProperty( label, "cod_agency", 1 ).iterator();
			if(persons.hasNext()){
				person = persons.next();
				if(person.getProperty("agency_name").equals("AGENCY A")){
					found = true;
				}
			}
		    tx.success();
		}
		db.shutdown();
		assertEquals(true, found);
    	
    }
        
}
