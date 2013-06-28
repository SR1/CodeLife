<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
//	if("post".equals(request.getMethod().toLowerCase()))
	{
		String lastMid = request.getParameter("lastMid");
		ArrayList<HashMap<String, Object>> messages = null;

		statuses st = new statuses();
		if(lastMid!=null && !"".equals(lastMid))
		{ 
			messages = st.friends_timeline(session, lastMid);
		}
		else
		{
			messages = st.friends_timeline(session);
		}
		StringBuffer json = new StringBuffer();
		json.append("{\"friends_timeline\":[ ");
		for(int i=0;i<messages.size();i++)
		{
			HashMap<String, Object> message = messages.get(i);
			json.append("{ ");
			for(Map.Entry entry : message.entrySet())
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
%>