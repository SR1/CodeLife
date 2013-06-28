<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String mid = (String)request.getParameter("mid");
		String comm = (String)request.getParameter("comment");
		if(mid!=null && comm!=null && !"".equals(mid) && !"".equals(comm))
		{
			comments cm = new comments();
			ArrayList<HashMap<String, Object>> commentss = cm.create(session,mid,Tools.htmlEncode(comm));
			out.print("{\"comments\":[");
			if(commentss!=null)
			{
				for(int i=0;i<commentss.size();i++)
				{
					HashMap<String, Object> commen = commentss.get(i);
					String cid = (String)commen.get("cid");
					String comment = (String)commen.get("comment");
					String commenter = (String)commen.get("commenter");
					String commentTime = (String)commen.get("commentTime");
					out.print("{");
					out.print("\"cid\":");
					out.print("\""+cid+"\"");
					out.print(",\"comment\":");
					out.print("\""+comment+"\"");
					out.print(",\"commenter\":");
					out.print("\""+commenter+"\"");
					out.print(",\"commentTime\":");
					out.print("\""+commentTime+"\"");
					if(i<commentss.size()-1)
						out.print("},");
					else
						out.print("}");
				}
			}
			out.print("]}");
		}
	}
%>