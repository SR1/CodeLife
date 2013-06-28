<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
//	if("post".equals(request.getMethod().toLowerCase()))
	{ 
		String uid = "2";//(String)request.getParameter("uid");
		if(uid!=null && !"".equals(uid))
		{
			StringBuffer json = new StringBuffer();
			users us = new users();
			HashMap<String, Object> userInfo = us.show(uid);
			json.append("{\"userInfo\":[ ");
			if(userInfo!=null)
			{
				json.append("{ ");
				for(Map.Entry entry : userInfo.entrySet())
				{
					String key = (String)entry.getKey();
					String value = (String)entry.getValue();
					json.append("\""+key+"\":");
					json.append("\""+value+"\",");
				}
				json.delete(json.length()-1,json.length());
				json.append("},");
			}
			json.delete(json.length()-1,json.length());
			json.append("]}");
			out.print(json.toString());
		}	
	}
%>