<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String uid = "2";//(String)request.getParameter("uid");
		if(uid!=null && !"".equals(uid))
		{ 
			friendships fs = new friendships();
			ArrayList<HashMap<String, Object>> followers = fs.followers(uid);
			StringBuffer json = new StringBuffer();
			json.append("{\"followers\":[ ");
			for(int i=0;i<followers.size();i++)
			{
				HashMap<String, Object> follower = followers.get(i);
				json.append("{ ");
				for(Map.Entry entry : follower.entrySet())
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
			out.print("]}");
		}	
	}
%>
