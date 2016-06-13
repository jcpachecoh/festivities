package org.prodigious.festivities.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.prodigious.festivities.database.DatabaseClass;
import org.prodigious.festivities.model.Festivity;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class FestivityService {
	
	private Map<Long,Festivity> festivities=DatabaseClass.getFestivities();
	
	public FestivityService(){
		   List<Festivity> list=new ArrayList<>();
		   long id=0;
		  // Creating some objects of Festivity while initializing  
		   try {

				File fXmlFile = new File("C:/festivities.xml");
				DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
				Document doc = dBuilder.parse(fXmlFile);
						
				//optional, but recommended
				//read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
				doc.getDocumentElement().normalize();

				
						
				NodeList nList = doc.getElementsByTagName("festivity");
						
				System.out.println("----------------------------");

				for (int temp = 0; temp < nList.getLength(); temp++) {

					Node nNode = nList.item(temp);
							
					
							
					if (nNode.getNodeType() == Node.ELEMENT_NODE) {

						Element eElement = (Element) nNode;

						
						Festivity fest=new Festivity( id, eElement.getElementsByTagName("name").item(0).getTextContent(), eElement.getElementsByTagName("place").item(0).getTextContent(),eElement.getElementsByTagName("start").item(0).getTextContent(),eElement.getElementsByTagName("end").item(0).getTextContent());
						 //list.add(fest);
						 festivities.put(id, fest);
					}
					id++;
				}
			    } catch (Exception e) {
				e.printStackTrace();
			    }
	
	}
	public List<Festivity> getallFestivities(){
		return new ArrayList<Festivity>(festivities.values());
	}
	
	public Festivity getFestivity(long id){
		return festivities.get(id);
	}
	public Festivity addFestivity(Festivity fest){
		fest.setId(festivities.size()+1);
		festivities.put(fest.getId(), fest);
		return fest;
		
	}
	
	public Festivity updateFestivity(Festivity fest){
		if(fest.getId()<=0){
			return null;
		}
		festivities.put(fest.getId(), fest);
		return fest;
	}
	
	public Festivity removeFestivity(long id){
		return festivities.remove(id);
	}
	
	
	
}
