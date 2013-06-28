package com.roslab.web.logicm;

public class Tools {
	
	public static String htmlEncode(String txt)
	{
		txt = txt.replaceAll("\n","<br/>");
		txt = txt.replaceAll("&","&amp;");
		txt = txt.replaceAll("\"","&quot;");
		txt = txt.replaceAll("'","&#39;");
		txt = txt.replaceAll("<","&lt;");
		txt = txt.replaceAll(">","&gt;");
		txt = txt.replaceAll(" ","&nbsp;"); 
		return txt; 
	}
}
