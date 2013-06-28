<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
//	if("post".equals(request.getMethod().toLowerCase()))
	{
		String uid = (String)request.getParameter("uid");
		if(uid!=null && !"".equals(uid))
		{ 
			friendships fs = new friendships();
			boolean isDel = fs.destroy(session, uid);
			out.print(String.valueOf(isDel));
			response.sendRedirect("http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+uid);
		}	
	}
%>