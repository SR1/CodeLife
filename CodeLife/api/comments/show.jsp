<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String mid = (String)request.getParameter("mid");
		if(mid!=null && !"".equals(mid))
		{
			comments cm = new comments();
			ArrayList<HashMap<String, Object>> commentss = cm.show(mid);
			StringBuffer json = new StringBuffer();
			json.append("{\"comments\":[ ");
			for(int i=0;i<commentss.size();i++)
			{
				HashMap<String, Object> comment = commentss.get(i);
				json.append("{ ");
				for(Map.Entry entry : comment.entrySet())
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