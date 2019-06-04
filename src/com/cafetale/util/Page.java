package com.cafetale.util;

public class Page {
	public static String getCurrentPage(String page){
		int slashCounter = page.indexOf("/");
		String pg = page.substring(slashCounter);
		for(int i=0; i<2; i++){
			pg = pg.substring(pg.indexOf("/", slashCounter+1));
		}
		return pg;
	}
}
