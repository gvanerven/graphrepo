package br.gov.cgu.die.graph.loadgraph.controller;

import java.util.Map;

import br.gov.cgu.die.graph.loadgraph.model.Destination;
import br.gov.cgu.die.graph.loadgraph.model.Edge;
import br.gov.cgu.die.graph.loadgraph.model.Source;
import br.gov.cgu.die.graph.loadgraph.model.Vertex;

public interface GraphLoaderInterface {

	public void LoadDataInGraph(Source source,
			Destination destination,
			Map<String, Vertex> vertices,
			Map<String, Edge> edges);
	
	public void UpdateDataInGraph(Source source,
			Destination destination,
			Map<String, Vertex> vertices,
			Map<String, Edge> edges);
	
}
