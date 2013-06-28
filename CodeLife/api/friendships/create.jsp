<%@page import="com.roslab.web.logicm.*"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
//	if("post".equals(request.getMethod().toLowerCase()))
	{
		String uid = (String)request.getParameter("uid");
		String Secret = (String)request.getParameter("Secret");
		if(uid!=null && !"".equals(uid))
		{
			if(Secret!=null && !"".equals(Secret))
			{
				Secret = "1";
			}
			else
			{
				Secret = "0";
			}
			friendships fs = new friendships();
			boolean isFollowed = fs.create(session, uid, Secret);
			response.sendRedirect("http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+uid);
		}	
	}
%>