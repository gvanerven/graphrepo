package br.gov.cgu.die.graph.loadgraph.model;

import java.util.Map;

public class Edge {
	private String id;
	private Vertex VertexSource;
	private Vertex VertexDestination;
	private Map<String, String> attributes;
	private Map<String, Map<String,String>> fieldMaps;
	private String label;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public Vertex getVertexSource() {
		return VertexSource;
	}
	public void setVertexSource(Vertex vertexSource) {
		VertexSource = vertexSource;
	}
	public Vertex getVertexDestination() {
		return VertexDestination;
	}
	public void setVertexDestination(Vertex vertexDestination) {
		VertexDestination = vertexDestination;
	}
	public Map<String, String> getAttributes() {
		return attributes;
	}
	public void setAttributes(Map<String, String> attributes) {
		this.attributes = attributes;
	}
	public Map<String, Map<String,String>> getFieldMaps() {
		return fieldMaps;
	}
	public void setFieldMaps(Map<String, Map<String,String>> fieldMaps) {
		this.fieldMaps = fieldMaps;
	}
}
