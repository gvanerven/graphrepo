package br.gov.cgu.die.graph.loadgraph.model;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import br.gov.cgu.die.graph.loadgraph.controller.GraphLoaderInterface;
import br.gov.cgu.die.graph.loadgraph.controller.GraphLoaderNeo4j;
import br.gov.cgu.die.graph.loadgraph.controller.GraphLoaderRDFFILE;

public class Job {
	
	private String description;
	private Source source;
	private Destination destination;
	private Map<String, Vertex> vertices;
	private Map<String, Edge> edges;
	private GraphLoaderInterface gl;

	
	public Map<String, Vertex> getVertices() {
		return vertices;
	}

	public Map<String, Edge> getEdges() {
		return edges;
	}

	public Destination getDestination() {
		return destination;
	}
	
	public String getDescription() {
		return description;
	}

	public Source getSource() {
		return source;
	}
	
	public void loadSchema(String path){
		File fXmlFile = new File(path);
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();

		try {
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			description = doc.getElementsByTagName("job")
					.item(0).getAttributes()
					.item(0).toString()
					.replace("\"", "")
					.split("=")[1];
			loadSource(doc);
			loadDestination(doc);
			loadVertices(doc);
			loadEdges(doc);
		} catch (SAXException | IOException | ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	
	
	public String[] formatAttribute(String attributeInput){
		String[] attribute = attributeInput.split("=");
		
		attribute[0] = attribute[0].trim();
		attribute[1] = attribute[1].trim();
		
		if(attribute[0].charAt(0) == '"'){
			attribute[0] = attribute[0].substring(1);
		}
		if(attribute[1].charAt(0) == '"'){
			attribute[1] = attribute[1].substring(1);
		}			


		if(attribute[0].charAt(attribute[0].length()-1) == '"'){
			attribute[0] = attribute[0].substring(0, (attribute[0].length()-1));
		}
		if(attribute[1].charAt(attribute[1].length()-1) == '"'){
			attribute[1] = attribute[1].substring(0, (attribute[1].length()-1));
		}
		
		return attribute;
	}
	private void loadSource(Document doc){
		NodeList elSource;
		elSource = doc.getElementsByTagName("source");
		Map<String, String> attributes;
		Node auxNode;
		String attribute[];
		
		source = new Source();
		attributes = new HashMap<String, String>();
		
		for(int j = 0; j < elSource.item(0).getAttributes().getLength(); j++){
			auxNode = elSource.item(0).getAttributes().item(j);

			attribute = formatAttribute(auxNode.toString());
			
			if(attribute[0].toLowerCase().equals("id")){
				source.setId(attribute[1]);
			}else if(attribute[0].toLowerCase().equals("type")){
				switch(attribute[1].toUpperCase()){
					case "SQL": 
						source.setType(SourceType.SQL);
						attributes.put("sql", elSource.item(0).getTextContent().trim());
					break;
					case "FILETABLE": source.setType(SourceType.FILETABLE);
						source.setType(SourceType.FILETABLE);
						attributes.put("pathToFile", elSource.item(0).getTextContent().trim());
					break;
					default: source.setType(SourceType.INVALID);
				}
			}else {
				attributes.put(attribute[0], attribute[1]);
			}
		}
		source.setProperties(attributes);
		
	}
	
	private void loadDestination(Document doc){
		NodeList elDestination;
		elDestination = doc.getElementsByTagName("destination");
		Map<String, String> attributes;
		Node auxNode;
		String attribute[];
		
		destination = new Destination();
		
		attributes = new HashMap<String, String>();
		for(int j = 0; j < elDestination.item(0).getAttributes().getLength(); j++){
			auxNode = elDestination.item(0).getAttributes().item(j);
			attribute = formatAttribute(auxNode.toString());
			//attribute = auxNode.toString().replace("\"", "").split("=");
			if(attribute[0].toLowerCase().equals("id")){
				destination.setId(attribute[1]);
			}else if(attribute[0].toLowerCase().equals("type")){
				switch(attribute[1].toUpperCase()){
					case "NEO4J": 
						destination.setType(DestinationType.NEO4J);
						attributes.put("pathToDatabase", elDestination.item(0).getTextContent().trim());
					break;
					case "RDFFILE": 
						destination.setType(DestinationType.RDFFILE);
						attributes.put("pathToFile", elDestination.item(0).getTextContent().trim());
					break;
					default: destination.setType(DestinationType.INVALID);
				}
			}else {
				attributes.put(attribute[0], attribute[1]);
			}
		}
			
			destination.setProperties(attributes);
	}
	
	private void loadVertices(Document doc){
		Vertex vertex;
		NodeList elVertices;
		NodeList elMaps;
		Map<String, String> attributes;
		Map<String, Map<String,String>> mapFields;
		Node auxNode;
		String attribute[];
		String fieldName;
		Map<String, String> mapAux;
		boolean keyField;
		
		elVertices = doc.getElementsByTagName("vertex");
		vertices = new HashMap<String, Vertex>();
				
		for(int i = 0; i < elVertices.getLength(); i++){
			vertex = new Vertex();
			attributes = new HashMap<String, String>();
			mapFields = new HashMap<String, Map<String,String>>();
			fieldName = "";
			
			for(int j = 0; j < elVertices.item(i).getAttributes().getLength(); j++){
				auxNode = elVertices.item(i).getAttributes().item(j);
				attribute = formatAttribute(auxNode.toString());
				//attribute = auxNode.toString().replace("\"", "").split("=");
				if(attribute[0].toLowerCase().equals("label")){
					vertex.setLabel(attribute[1]);
				}else {
					attributes.put(attribute[0], attribute[1]);
				}
				
			}
			
			if(elVertices.item(i).hasChildNodes()){
				elMaps = elVertices.item(i).getChildNodes();
				for(int j = 0; j < elMaps.getLength(); j++){
					keyField = false;
					if(elMaps.item(j).getNodeName() == "map"){
						mapAux = new HashMap<String, String>();
						for(int k = 0; k < elMaps.item(j).getAttributes().getLength(); k++){
							auxNode = elMaps.item(j).getAttributes().item(k);
							attribute = formatAttribute(auxNode.toString());
							//attribute = auxNode.toString().replace("\"", "").split("=");
							if(attribute[0].equals("fieldName")){
								fieldName = attribute[1];
							}else if(attribute[0].equals("key")){
								keyField = true;
							}
							mapAux.put(attribute[0], attribute[1]);
						}
						if(keyField){
							vertex.setFieldKey(fieldName);
						}
						mapFields.put(fieldName, mapAux);
					}
				}
			}
			vertex.setAttributes(attributes);
			vertex.setFieldMaps(mapFields);
			vertices.put(vertex.getLabel(), vertex);
			
		}		
	}
	
	private void loadEdges(Document doc){
		Edge edge;
		NodeList elEdges;
		NodeList elMaps;
		Map<String, String> attributes;
		Map<String, Map<String,String>> mapFields;
		Node auxNode;
		String attribute[];
		String fieldName;
		Map<String, String> mapAux;
		
		elEdges = doc.getElementsByTagName("edge");
		edges = new HashMap<String, Edge>();
				
		for(int i = 0; i < elEdges.getLength(); i++){
			edge = new Edge();
			attributes = new HashMap<String, String>();
			mapFields = new HashMap<String, Map<String,String>>();
			fieldName = "";
			
			for(int j = 0; j < elEdges.item(i).getAttributes().getLength(); j++){
				auxNode = elEdges.item(i).getAttributes().item(j);
				attribute = formatAttribute(auxNode.toString());
				//attribute = auxNode.toString().replace("\"", "").split("=");
				if(attribute[0].toLowerCase().equals("label")){
					edge.setLabel(attribute[1]);
				}else if(attribute[0].equals("id")){
					edge.setId(attribute[1]);
				}else if(attribute[0].equals("vertexSrc")){
					edge.setVertexSource(vertices.get(attribute[1]));
				}else if(attribute[0].equals("vertexDst")){
					edge.setVertexDestination(vertices.get(attribute[1]));
				}else {
					attributes.put(attribute[0], attribute[1]);
				}
				
			}
			
			if(elEdges.item(i).hasChildNodes()){
				elMaps = elEdges.item(i).getChildNodes();
				for(int j = 0; j < elMaps.getLength(); j++){
					if(elMaps.item(j).getNodeName() == "map"){
						mapAux = new HashMap<String, String>();
						for(int k = 0; k < elMaps.item(j).getAttributes().getLength(); k++){
							auxNode = elMaps.item(j).getAttributes().item(k);
							attribute = auxNode.toString().replace("\"", "").split("=");
							if(attribute[0].equals("fieldName")){
								fieldName = attribute[1];
							}
							mapAux.put(attribute[0], attribute[1]);
						}
						mapFields.put(fieldName, mapAux);
					}
				}
			}
			edge.setAttributes(attributes);
			edge.setFieldMaps(mapFields);
			edges.put(edge.getId(), edge);
		}		
	}
	
	public void startLoader(){
		List<Source> sources;
		String[] path;
		String pathToDir;
		File directory;
		File[] filesToLoad;
		String matchName;
		String slash;
				
		sources = new ArrayList<Source>();
		if(!source.getType().equals(SourceType.FILETABLE)){
			sources.add(source);
		}else{
			if(source.getProperties().containsKey("multiFiles") && Boolean.parseBoolean(source.getProperties().get("multiFiles"))){
				if(System.getProperty("os.name").toLowerCase().indexOf("win") >= 0){
					path = source.getProperties().get("pathToFile").split("\\\\");
					slash = "\\";
				}else{
					path = source.getProperties().get("pathToFile").split("/");
					slash = "/";
				}
				matchName = path[path.length - 1];
				pathToDir = path[0];				
				for(int i = 1; i < path.length - 1; i++){
					pathToDir = pathToDir + slash + path[i];
				}
				directory = new File(pathToDir);
				if(directory.isDirectory()){
					filesToLoad = directory.listFiles(new FilenameFilter() {
					    public boolean accept(File dir, String name) {
					    	return name.toLowerCase().matches(matchName);
					    }
					});
					for(File f: filesToLoad){
						Source s = new Source();
						s.setId(source.getId());
						s.setType(source.getType());
						s.setProperties(new HashMap<String, String>(source.getProperties()));
						s.getProperties().put("pathToFile", f.getAbsolutePath());
						sources.add(s);
					}
				}else{
					System.out.println("Error getting directory: " + pathToDir);
				}
			}else{
				sources.add(source);
			}
		}
		for(int i = 0; i<sources.size(); i++){
			System.out.print("Load source " + (i+1) + " of " + sources.size() + " ");
			if(sources.get(i).getType().equals(SourceType.FILETABLE)){
				System.out.println(sources.get(i).getProperties().get("pathToFile"));
			}
			if(destination.getType().equals(DestinationType.NEO4J)){
				gl = new GraphLoaderNeo4j();
				if(destination.getProperties().get("method").equals("insert")){
					gl.LoadDataInGraph(sources.get(i), destination, vertices, edges);
				}else if(destination.getProperties().get("method").equals("update")){
					gl.UpdateDataInGraph(sources.get(i), destination, vertices, edges);
				}
			}else if(destination.getType().equals(DestinationType.RDFFILE)){
				gl = new GraphLoaderRDFFILE();
				gl.LoadDataInGraph(sources.get(i), destination, vertices, edges);
			}
		}
	}
}
