package br.gov.cgu.die.graph.loadgraph;

import br.gov.cgu.die.graph.loadgraph.model.Job;


/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
    	if(args.length != 1){
    		throw new IllegalArgumentException("Usage: loadgaph file.xml");
    	}
    	Job job = new Job();
    	job.loadSchema(args[0]);
    	job.startLoader();

    }
}
