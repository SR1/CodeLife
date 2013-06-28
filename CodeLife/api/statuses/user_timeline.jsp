<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String uid = request.getParameter("uid");
		String lastMid = request.getParameter("lastMid");
		if(uid!=null && !"".equals(uid))
		{
			statuses st = new statuses();
			ArrayList<HashMap<String, Object>> messages = null;
			if(lastMid!=null && !"".equals(lastMid))
			{
				messages = st.user_timeline(uid,lastMid);
			}
			else
			{
				messages = st.user_timeline(uid);
			}
			StringBuffer json = new StringBuffer();
			json.append("{\"user_timeline\":[ ");
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
	}
%>