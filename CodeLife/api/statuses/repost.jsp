<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	if("post".equals(request.getMethod().toLowerCase()))
	{
		String mid = (String)request.getParameter("mid");
		String content = (String)request.getParameter("content");
		if(content!=null && mid!=null && !"".equals(content) &&!"".equals(mid))
		{
			statuses st = new statuses();
			boolean isRepost = st.repost(session, mid, Tools.htmlEncode(content));
			out.print(String.valueOf(isRepost));
		}	
	} 
%>

