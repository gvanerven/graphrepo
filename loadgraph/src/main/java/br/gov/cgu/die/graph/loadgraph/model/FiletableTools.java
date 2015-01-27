package br.gov.cgu.die.graph.loadgraph.model;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FiletableTools implements SourceTools{
	
	private BufferedReader fileBr;
	private char delimiter;
	private List<String> header;
	private char textSurroundedChar;
	
	public void openFile(String filePath, char dlmt, char textSurroundedChar, boolean hasHeader, String userHeader){
		delimiter = dlmt;
		header = null;
		this.textSurroundedChar = textSurroundedChar;
		try {
			fileBr = new BufferedReader(new FileReader(filePath), 102400000);
			if(hasHeader){
				header = Arrays.asList(fileBr.readLine().split(String.valueOf(delimiter)));
			}else if(userHeader != null && !userHeader.equals("")){
				header = Arrays.asList(userHeader.split(String.valueOf(delimiter)));
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void closeFile(){
		if(fileBr != null){
			try {
				fileBr.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public List<String> getLineInArrayFields(){
		String line;
		String field;
		List<String> fieldsList = new ArrayList<String>();
		boolean startField = true;
		boolean textField = false;
		
		field = "";
		try {
			
			if((line = fileBr.readLine()) != null){			
				for(int i = 0; i < line.length(); i++){
					if(startField){
						startField = false;
						textField = false;
						if(line.charAt(i) == textSurroundedChar){
							textField = true;
						}
						field = "";
					}
					 
					if(line.charAt(i) == delimiter && (!textField || (i > 0 && line.charAt(i-1) == textSurroundedChar))){
						if(textField){
							if(i > 0 && line.charAt(i-1) == textSurroundedChar){
								field = field.substring(1, field.length() - 1);
							}
						}
						fieldsList.add(field);
						startField = true;
					}else{
						field = field + line.charAt(i);
					}
	
				}
				if(textField){
					if(line.charAt(line.length()-1) == textSurroundedChar){
						field = field.substring(1, field.length() - 1);
					}
				}
				fieldsList.add(field);
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fieldsList;
	}

	public List<String> getHeader() {
		return header;
	}
	
	public boolean isOpen(){
		if(fileBr != null){
			return true;
		}
		return false;
	}

	@Override
	public void openSource(Map<String, String> properties) {
		char delimiter;
		char textSurroundedChar;
		boolean header = false;
		String userHeader = null;
		
		if(properties.containsKey("header")){
			header = Boolean.parseBoolean(properties.get("header"));
		}
		
		if(properties.containsKey("userHeader")){
			userHeader = properties.get("userHeader");
		}
		
		if(properties.get("delimiter").equals("\t")){
			delimiter = '\t';
		}else if(properties.get("delimiter").equals("\"")){
			delimiter = '\"';
		}else if(properties.get("delimiter").equals("'\"'")){
			delimiter = '\"';
		}else if(properties.get("delimiter").equals("\'")){
			delimiter = '\'';
		}else{
			delimiter = properties.get("delimiter").charAt(0);
		}
		
		if(properties.get("textSurroundedChar").equals("\t")){
			textSurroundedChar = '\t';
		}else if(properties.get("textSurroundedChar").equals("'\"'")){
			textSurroundedChar = '\"';
		}else if(properties.get("textSurroundedChar").equals("\"")){
			textSurroundedChar = '\"';
		}else if(properties.get("textSurroundedChar").equals("\'")){
			textSurroundedChar = '\'';
		}else{
			textSurroundedChar = properties.get("textSurroundedChar").charAt(0);
		}
		
		openFile(properties.get("pathToFile"), delimiter, textSurroundedChar, header, userHeader);
	}

	@Override
	public Map<String, String> getRecord() {
		Map<String, String> record;
		List<String> list;
		
		record = new HashMap<String, String>();
				
		list = getLineInArrayFields();
		if(list.size() > 0){
			if(header == null){
				for(int i = 0; i < list.size(); i++){
					record.put(String.valueOf(i), list.get(i));
				}
			}else{
				for(int i = 0; i < list.size(); i++){
					record.put(header.get(i), list.get(i));
				}
			}
		}		
		return record;
	}
	
}
