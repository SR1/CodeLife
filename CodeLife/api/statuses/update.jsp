<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String content = (String)request.getParameter("content");
		if(content!=null && !"".equals(content))
		{
			statuses st = new statuses();
			boolean isUpdate = st.update(session, Tools.htmlEncode(content));
			out.print(String.valueOf(isUpdate));
		}	
	} 
%>
