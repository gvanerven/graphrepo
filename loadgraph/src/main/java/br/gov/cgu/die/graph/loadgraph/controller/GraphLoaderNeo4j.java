package br.gov.cgu.die.graph.loadgraph.controller;

import java.util.HashMap;
import java.util.Map;

import org.neo4j.cypher.javacompat.ExecutionEngine;
import org.neo4j.graphdb.DynamicLabel;
import org.neo4j.graphdb.DynamicRelationshipType;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.Relationship;
import org.neo4j.graphdb.ResourceIterator;
import org.neo4j.graphdb.Transaction;
import org.neo4j.graphdb.factory.GraphDatabaseFactory;
import org.neo4j.unsafe.batchinsert.BatchInserter;
import org.neo4j.unsafe.batchinsert.BatchInserters;

import br.gov.cgu.die.graph.loadgraph.model.Destination;
import br.gov.cgu.die.graph.loadgraph.model.Edge;
import br.gov.cgu.die.graph.loadgraph.model.Source;
import br.gov.cgu.die.graph.loadgraph.model.Vertex;

public class GraphLoaderNeo4j implements GraphLoaderInterface{

	@Override
	public void LoadDataInGraph(Source source,
			Destination destination,
			Map<String, Vertex> vertices, Map<String, Edge> edges) {

		Map<String, String> record;
		Map<String, Object> nodeProperties;
		Map<String, Object> edgeProperties;
		Map<String, Long> nodes;
		String efetiveLabel;
		Object propertie;
		String fieldName;
		long idNode;
		source.openSource();

		for(Vertex vertex: vertices.values()){
			createIndexConstrains(destination, vertex);
		}

		BatchInserter inserter = BatchInserters.inserter(destination.getProperties().get("pathToDatabase"));

		record = source.getSourceRecord();
		nodes = new HashMap<String, Long>();
		while(!record.isEmpty() && record.size() > 0){
			for(Vertex v: vertices.values()){
				if(!nodes.containsKey(record.get(v.getFieldKey()).toString()  + v.getLabel())){
					nodeProperties = new HashMap<String, Object>();
					for(Map<String, String> field: v.getFieldMaps().values()){
						if(field.containsKey("rename")){
							fieldName = field.get("rename");
						}else{
							fieldName = field.get("fieldName");
						}
						if(field.containsKey("type") && field.get("type").equals("int")){
							propertie = Integer.parseInt(record.get(field.get("fieldName")));
						}else if(field.containsKey("type") && field.get("type").equals("long")){
							propertie = Long.parseLong(record.get(field.get("fieldName")));
						}else if(field.containsKey("type") && field.get("type").equals("float")){
							propertie = Float.parseFloat(record.get(field.get("fieldName")));
						}else{
							propertie = record.get(field.get("fieldName"));
						}
						nodeProperties.put(fieldName, propertie);
					}
					
					if(v.getAttributes().containsKey("aliasFor")){
						efetiveLabel = v.getAttributes().get("aliasFor");
					}else{
						efetiveLabel = v.getLabel();
					}
					
					idNode = inserter.createNode(nodeProperties, DynamicLabel.label(efetiveLabel));
					nodes.put(record.get(v.getFieldKey()).toString() + v.getLabel(), idNode);
				}
			}
			
			for(Edge e: edges.values()){
				edgeProperties = new HashMap<String, Object>();
				for(Map<String, String> field: e.getFieldMaps().values()){
					if(field.containsKey("rename")){
						fieldName = field.get("rename");
					}else{
						fieldName = field.get("fieldName");
					}
					edgeProperties.put(fieldName, record.get(field.get("fieldName")));
				}
				inserter.createRelationship(nodes.get(record.get(e.getVertexSource().getFieldKey()) + e.getVertexSource().getLabel()), nodes.get(record.get(e.getVertexDestination().getFieldKey()) + e.getVertexDestination().getLabel()), DynamicRelationshipType.withName(e.getLabel()), edgeProperties.size() > 0 ? edgeProperties : null );
			}
			
			record = source.getSourceRecord();
		}
		inserter.shutdown();
	}
	
	public void createIndexConstrains(Destination destination, Vertex vertex){
		GraphDatabaseService db = new GraphDatabaseFactory().newEmbeddedDatabase( destination.getProperties().get("pathToDatabase") );
		ExecutionEngine engine = new ExecutionEngine( db );
		String createConstrain;
		String createIndex;
		
		//CREATE CONSTRAINT ON (person:Person) ASSERT person.id IS UNIQUE;
		//CREATE INDEX ON :Company(name);
		try ( Transaction tx = db.beginTx(); )
		{
			for(Map<String, String> map: vertex.getFieldMaps().values()){
				if((map.containsKey("key") && map.get("key").equals("true")) || (map.containsKey("unique") && map.get("unique").equals("true"))){
					if(map.containsKey("rename")){
						createConstrain = map.get("rename");
					}else{
						createConstrain = map.get("fieldName");						
					}
					engine.execute("CREATE CONSTRAINT ON (vertex:"+vertex.getLabel()+") ASSERT vertex."+createConstrain+" IS UNIQUE");
				}else if(map.containsKey("indexed") && map.get("indexed").equals("true")){
					if(map.containsKey("rename")){
						createIndex = map.get("rename");
					}else{
						createIndex = map.get("fieldName");						
					}
					engine.execute("CREATE INDEX ON :"+vertex.getLabel()+"("+createIndex+")");
				}
			}
		    tx.success();
		}
		
		db.shutdown();
	}

	@Override
	public void UpdateDataInGraph(Source source, Destination destination,
			Map<String, Vertex> vertices, Map<String, Edge> edges) {
		Map<String, String> record;
		Map<String, Object> nodeProperties;
		Map<String, Node> nodes;
		Object propertie;
		String fieldName;
		Node idNode;
		source.openSource();
		Relationship relationship;
		String searchField;
		Object searchValue;
		String efetiveLabel;
		int count = 0;

		for(Vertex vertex: vertices.values()){
			createIndexConstrains(destination, vertex);
		}

		GraphDatabaseService graphDb = new GraphDatabaseFactory().newEmbeddedDatabase(destination.getProperties().get("pathToDatabase"));
		
		record = source.getSourceRecord();
		nodes = new HashMap<String, Node>();
		try ( Transaction tx = graphDb.beginTx() ){
			while(!record.isEmpty() && record.size() > 0){
				count++;
				for(Vertex v: vertices.values()){
					if(!nodes.containsKey(record.get(v.getFieldKey()).toString()  + v.getLabel())){
						nodeProperties = new HashMap<String, Object>();
						searchField = v.getFieldKey();
						searchValue = "";
						for(Map<String, String> field: v.getFieldMaps().values()){
							if(field.containsKey("rename")){
								fieldName = field.get("rename");
								if(field.get("fieldName").equals(v.getFieldKey())){
									searchField = field.get("rename");
								}
							}else{
								fieldName = field.get("fieldName");
							}
							if(field.containsKey("type") && field.get("type").equals("int")){
								propertie = Integer.parseInt(record.get(field.get("fieldName")));
								if(field.get("fieldName").equals(v.getFieldKey())){ //this field is the key for the instance
									searchValue = Integer.parseInt(record.get(field.get("fieldName")));
								}
							}else if(field.containsKey("type") && field.get("type").equals("long")){
								propertie = Long.parseLong(record.get(field.get("fieldName")));
								if(field.get("fieldName").equals(v.getFieldKey())){
									searchValue = Long.parseLong(record.get(field.get("fieldName")));
								}
							}else if(field.containsKey("type") && field.get("type").equals("float")){
								propertie = Float.parseFloat(record.get(field.get("fieldName")));
							}else{
								propertie = record.get(field.get("fieldName"));
								if(field.get("fieldName").equals(v.getFieldKey())){
									searchValue = propertie;
								}								
							}
							nodeProperties.put(fieldName, propertie);
						}

						if(v.getAttributes().containsKey("aliasFor")){
							efetiveLabel = v.getAttributes().get("aliasFor");
						}else{
							efetiveLabel = v.getLabel();
						}
						
						ResourceIterator<Node> rNode = graphDb.findNodesByLabelAndProperty(DynamicLabel.label(efetiveLabel), searchField, searchValue).iterator();
						if(rNode.hasNext()){
							idNode = rNode.next();
						}else{
							idNode = graphDb.createNode();
							idNode.addLabel(DynamicLabel.label(efetiveLabel));
						}
						for(String key: nodeProperties.keySet()){
							idNode.setProperty(key, nodeProperties.get(key));
						}
						nodes.put(record.get(v.getFieldKey()).toString() + v.getLabel(), idNode);
					}
				}
				
				for(Edge e: edges.values()){
					relationship = nodes.get(record.get(e.getVertexSource().getFieldKey()) + e.getVertexSource().getLabel()).createRelationshipTo(nodes.get(record.get(e.getVertexDestination().getFieldKey()) + e.getVertexDestination().getLabel()), DynamicRelationshipType.withName(e.getLabel()));
					for(Map<String, String> field: e.getFieldMaps().values()){
						if(field.containsKey("rename")){
							fieldName = field.get("rename");
						}else{
							fieldName = field.get("fieldName");
						}
						relationship.setProperty(fieldName, record.get(field.get("fieldName")));
					}
				}
				
				if(count > 5000){
					tx.success();
					count = 0;
				}
			    record = source.getSourceRecord();
			}
			
			tx.success();
		}
		graphDb.shutdown();		
	}
	
/*	public void shutdown(GraphDatabaseService db){
		registerShutdownHook(db);
	}
	
	private static void registerShutdownHook( final GraphDatabaseService graphDb ){
	    // Registers a shutdown hook for the Neo4j instance so that it
	    // shuts down nicely when the VM exits (even if you "Ctrl-C" the
	    // running application).
	    Runtime.getRuntime().addShutdownHook( new Thread()
	    {
	        @Override
	        public void run()
	        {
	            graphDb.shutdown();
	        }
	    } );
	}*/	
}
