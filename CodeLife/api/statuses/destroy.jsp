<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String mid = (String)request.getParameter("mid");
		if(mid!=null &&!"".equals(mid))
		{
			statuses st = new statuses();
			boolean isDel = st.destroy(session, mid);
			out.print(String.valueOf(isDel));
		}	
	}
%>
 
