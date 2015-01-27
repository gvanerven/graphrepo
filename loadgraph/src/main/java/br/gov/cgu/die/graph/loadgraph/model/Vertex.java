package br.gov.cgu.die.graph.loadgraph.model;

import java.util.Map;

public class Vertex {
	private String fieldKey;
	private String label;
	private Map<String, String> attributes;
	private Map<String, Map<String,String>> fieldMaps;

	public String getFieldKey() {
		return fieldKey;
	}
	public void setFieldKey(String fieldKey) {
		this.fieldKey = fieldKey;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
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
