<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String cid = (String)request.getParameter("cid");
		if(cid!=null && !"".equals(cid))
		{
			comments cm = new comments();
			boolean isDel = cm.destroy(session, cid);
			out.print(String.valueOf(isDel));
		}	
	}
%>