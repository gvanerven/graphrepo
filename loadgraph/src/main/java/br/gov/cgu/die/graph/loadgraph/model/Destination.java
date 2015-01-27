package br.gov.cgu.die.graph.loadgraph.model;

import java.util.Map;

public class Destination {
	private String id;
	private DestinationType type;
	private Map<String, String> properties;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public DestinationType getType() {
		return type;
	}
	public void setType(DestinationType type) {
		this.type = type;
	}
	public Map<String, String> getProperties() {
		return properties;
	}
	public void setProperties(Map<String, String> properties) {
		this.properties = properties;
	}
	
}
