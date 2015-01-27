package br.gov.cgu.die.graph.loadgraph.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class DatabaseTools implements SourceTools{
	private Connection conn;
	private ResultSet rs;
	private ResultSetMetaData meta;
	
	public void execConnection(String classDriver, String urlConn, String user, String pass){

		try {
			Class.forName(classDriver);
			conn = DriverManager.getConnection(urlConn, user, pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void closeConnection(){
		try {
			if(!conn.isClosed()){
				conn.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean isConnected(){
		try {
			return !conn.isClosed();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
    public void execQuery(String query){
    	rs = null;
    	Statement st;
    	
    	if(isConnected()){
    		try {
				st = conn.createStatement();
				System.out.println("Executing query: " + query);
				rs = st.executeQuery(query);
				rs.setFetchSize(200000);				
				System.out.println("SQL Array size: " + rs.getFetchSize());
				meta = rs.getMetaData();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}    		
    	}
    }

	@Override
	public void openSource(Map<String, String> properties) {
		execConnection(properties.get("driver"), properties.get("urlConnection"), properties.get("uid"), properties.get("passwd"));
		if(isConnected()){
			execQuery(properties.get("sql"));
		}
	}

	@Override
	public Map<String, String> getRecord() {
		Map<String, String> record;
		record = new HashMap<String, String>();

		try {
			if(isConnected() && !rs.isAfterLast()){
					if(rs.next()){
						for(int i = 1; i <= meta.getColumnCount(); i++){
							record.put(meta.getColumnLabel(i), rs.getObject(i).toString());
						}
					}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return record;
	}
    
}
