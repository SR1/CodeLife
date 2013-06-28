<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.roslab.web.logicm.*"%>
<%
	session.setAttribute("userInfo", null);
	session.setAttribute("hasSuperPower", null);
	response.sendRedirect(BasicConfig.INDEX_PATH);
%>