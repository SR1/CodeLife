<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	//检测是否登录，未登录则跳转至登录界面
	HashMap<String, Object> userInfo;
	userInfo = (HashMap<String, Object>) session.getAttribute("userInfo");
	if(null==userInfo)
		response.sendRedirect(BasicConfig.LOGIN_PATH);

	String oldPassword = request.getParameter("oldPassword");
	String newPassword = request.getParameter("newPassword");
	String cpassword = request.getParameter("cpassword");
	
	if( oldPassword!=null && newPassword!=null && cpassword!=null &&
		!"".equals(oldPassword) && !"".equals(newPassword) &&
		!"".equals(cpassword) && newPassword.equals(cpassword))
	{
		String uid = (String)userInfo.get("uid");
		String sql = "UPDATE `b_users` SET `password` = PASSWORD(?) WHERE `id` = ? AND `password` = PASSWORD(?);";
		DBConnect conn = new DBConnect();
		PreparedStatement stat = conn.getPreparedStatement(sql);
		stat.setString(1,newPassword);
		stat.setString(2,uid);
		stat.setString(3,oldPassword);
		int resultCode = stat.executeUpdate();
		if(resultCode!=0)
		{
			users us = new users();
			session.setAttribute("userInfo",null);
			response.sendRedirect(BasicConfig.LOGIN_PATH);
			return;
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>修改资料 - 码农人生</title>
		<meta name="description" content="码农人生">
		<meta name="author" content="SR1">
		<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
		<link rel="stylesheet" type="text/css" media="screen" href="css/messenger.css">
		<link rel="stylesheet" type="text/css" media="screen" href="css/messenger-theme-future.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/messenger.min.js"></script>
		<script src="js/codelife.js"></script>
		<style type="text/css">
			body {
				background-color:#fafafa;
				//background-image: url(./img/mbg.jpg);
				padding-top: 60px;
				padding-bottom: 40px;
				}
			.centerColor{
				//background-color: #FFFFFF;
			}
			.icon{
				border-style: solid;
				border-width: 1px;
				float: left;
				margin: 10px;
				overflow: hidden;
				width: 60px;
				height: 60px;
				background-size: 60px 60px;
				background-color: #fff;
				-webkit-border-radius: 3px;
				-moz-border-radius: 3px;
				border-radius: 3px;
				background-color: transparent;
			}
			.smallicon{
				border-style: solid;
				border-width: 1px;
				float: left;
				margin: 10px;
				overflow: hidden;
				width: 30px;
				height: 30px;
				background-size: 30px 30px;
				background-color: #fff;
				-webkit-border-radius: 3px;
				-moz-border-radius: 3px;
				border-radius: 3px;
				background-color: transparent;
			}
			.vertical{
				height: 4em;
				line-height: 4em;
				overflow: hidden;
			}
			.leftpart{
				background-color: #333333;
			}
    	</style>
	</head>
	<body>
	<!-- Navbar
	================================================== -->
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="./">CodeLife·码农人生</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="">
                <a href="./">我的首页</a>
              </li>
              <li>
                <a href="./public.jsp">随便看看</a>
              </li>
              <li class="active">
                <a href="./user.jsp">用户资料</a>
              </li>
			<%
				Boolean hasSuperPower = (Boolean)session.getAttribute("hasSuperPower");
				if(hasSuperPower!=null && hasSuperPower)
				{
			%>
              <li>
                <a href="./SuperMan.jsp">抓虫记</a>
              </li>
			<%
				}
			%>
            </ul>
            <ul class="nav pull-right">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=(String)userInfo.get("username") %>的帐号 <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="./change.jsp">修改个人资料</a></li>
                  <li><a href="">修改帐号密码</a></li>
                  <li class="divider"></li>
                  <li><a href="./logout.jsp">注销登录</a></li>
                </ul>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    
    <!--MainBody
	================================================== -->
	<div class="container">
      	<div class="span8 offset2">
      		<form method='post' class="form-horizontal">
      			<div class="control-group">
	      			<label class="control-label">原密码：</label>
	      			<div class="controls">
	    	  			<input type="text" name="oldPassword">
	    	  		</div>
    	  		</div>
    	  		<div class="control-group">
      				<label class="control-label">新密码：</label>
	      			<div class="controls">
      					<input type="password" name="newPassword">
      				</div>
      			</div>
      			<div class="control-group">
      				<label class="control-label">确认密码：</label>
	      			<div class="controls">
      					<input type="password" name="cpassword">
      				</div>
      			</div>
      			<div class="control-group">
	      			<div class="controls">
      					<button type="submit" class="btn btn-danger">确认更改</button>
      					<a class="btn" href="<%=BasicConfig.INDEX_PATH %>">放弃更改</a>
      				</div>
      			</div>
      		</form>
      	</div>
		<hr>
		<footer class="pull-right">
			<p>&copy; CodeLife·码农人生-2013</p>
		</footer>
	</div>
	<script src="js/bootstrap.min.js"></script>
	</body>
</html>