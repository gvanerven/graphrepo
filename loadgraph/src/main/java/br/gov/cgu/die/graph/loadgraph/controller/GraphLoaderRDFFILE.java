package br.gov.cgu.die.graph.loadgraph.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

import org.apache.log4j.PropertyConfigurator;

import com.hp.hpl.jena.datatypes.RDFDatatype;
import com.hp.hpl.jena.datatypes.TypeMapper;
import com.hp.hpl.jena.rdf.model.Literal;
import com.hp.hpl.jena.rdf.model.Model;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.rdf.model.Property;
import com.hp.hpl.jena.rdf.model.Resource;

import br.gov.cgu.die.graph.loadgraph.model.Destination;
import br.gov.cgu.die.graph.loadgraph.model.Edge;
import br.gov.cgu.die.graph.loadgraph.model.Source;
import br.gov.cgu.die.graph.loadgraph.model.Vertex;

public class GraphLoaderRDFFILE implements GraphLoaderInterface{

	@Override
	public void LoadDataInGraph(Source source, Destination destination,
			Map<String, Vertex> vertices, Map<String, Edge> edges) {

		Map<String, String> record;
		Resource auxNode;
		Resource subject;
		Property predicate;
		Resource object;
		Object propertie;
		String fieldName;
		RDFDatatype type;
		Property propRDF;
		source.openSource();
		Model model;
		TypeMapper tm;
		String pathToFile;
		String fileFormat;
		FileOutputStream out;
		Literal auxLiteral;

		PropertyConfigurator.configure(destination.getProperties().get("logFile"));
		tm = new TypeMapper();
		record = source.getSourceRecord();
		model = ModelFactory.createDefaultModel();
		while(record.size() > 0){
			for(Vertex v: vertices.values()){
				auxNode = model.createResource(v.getAttributes().get("uriBase") + record.get(v.getFieldKey()));
				for(Map<String, String> field: v.getFieldMaps().values()){
					if(!field.containsKey("key") || (field.containsKey("key") && field.get("key").equals("false"))){
						if(field.containsKey("rename")){
							fieldName = field.get("rename");
						}else{
							fieldName = field.get("fieldName");
						}
						type = tm.getSafeTypeByName("http://www.w3.org/TR/xmlschema11-2/#" + field.get("type"));
						propertie = record.get(field.get("fieldName"));
						auxLiteral = model.createTypedLiteral(propertie.toString(), type);
						propRDF = model.getProperty(field.get("basePredicate"), fieldName);
						auxNode.addLiteral(propRDF, auxLiteral);
						//auxNode.addProperty(propRDF, propertie, type);
					}
				}
			}
			
			for(Edge e: edges.values()){
				subject = model.getResource(e.getVertexSource().getAttributes().get("uriBase") + record.get(e.getVertexSource().getFieldKey()));
				object = model.getResource(e.getVertexDestination().getAttributes().get("uriBase") + record.get(e.getVertexDestination().getFieldKey()));
				predicate = model.getProperty(e.getAttributes().get("basePredicate") + e.getLabel());
				subject.addProperty(predicate, object);
			}
			
			record = source.getSourceRecord();
		}
		
		pathToFile = destination.getProperties().get("pathToFile");
		fileFormat = destination.getProperties().get("format");
		if(fileFormat == null || fileFormat.equals("")){
			fileFormat = "N-TRIPLES";
		}
		
		try {
			out = new FileOutputStream(pathToFile);
			model.write(out, fileFormat);
			//model.write(out);
			out.close();
			model.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void UpdateDataInGraph(Source source, Destination destination,
			Map<String, Vertex> vertices, Map<String, Edge> edges) {
		LoadDataInGraph(source, destination, vertices, edges);
		
	}

}
