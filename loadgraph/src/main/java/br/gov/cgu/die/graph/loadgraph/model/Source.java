package br.gov.cgu.die.graph.loadgraph.model;

import java.util.Map;

public class Source {
	private String id;
	private SourceType type;
	private Map<String, String> properties;
	private SourceTools srcTools;

	public Source(){
		srcTools = null;
	}
	
	public Map<String, String> getProperties() {
		return properties;
	}
	public void setProperties(Map<String, String> properties) {
		this.properties = properties;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public SourceType getType() {
		return type;
	}
	public void setType(SourceType type) {
		this.type = type;
	}

	public void openSource(){
		if(srcTools == null){
			if(SourceType.SQL.equals(type)){
				srcTools = new DatabaseTools();
				srcTools.openSource(properties);
			}else if(SourceType.FILETABLE.equals(type)){
				srcTools = new FiletableTools();
				srcTools.openSource(properties);
			}
		}
	}
	
	public Map<String, String> getSourceRecord(){
		if(srcTools != null){
			return srcTools.getRecord();
		}
		return null;
	}
}
