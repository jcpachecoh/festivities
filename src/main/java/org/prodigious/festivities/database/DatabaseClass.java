package org.prodigious.festivities.database;

import java.util.HashMap;
import java.util.Map;

import org.prodigious.festivities.model.Festivity;

public class DatabaseClass {
	private static Map<Long,Festivity> festivities=new HashMap<>();
	
	public static Map<Long,Festivity> getFestivities(){
		return festivities;
	}
}
