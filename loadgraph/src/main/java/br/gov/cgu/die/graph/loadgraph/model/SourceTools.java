package br.gov.cgu.die.graph.loadgraph.model;

import java.util.Map;

public interface SourceTools {
	
	public void openSource(Map<String, String> properties);
	
	public Map<String, String> getRecord();
}
