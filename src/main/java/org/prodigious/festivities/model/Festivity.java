package org.prodigious.festivities.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Festivity {
	
	private long id;
	private String name;
	private String place;
	private String start;
	private String end;
	
	
	public Festivity() {
		
	}

	public Festivity(long id, String name, String place, String start, String end) {
		super();
		this.id = id;
		this.name = name;
		this.place = place;
		this.start = start;
		this.end = end;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getPlace() {
		return place;
	}
	
	public void setPlace(String place) {
		this.place = place;
	}
	public String getStart() {
		return start;
	}
	
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	
	public void setEnd(String end) {
		this.end = end;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	
	
}
