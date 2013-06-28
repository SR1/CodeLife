<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	//若已登录，则自动登录 
	HashMap<String, Object> userInfo;
	userInfo = (HashMap<String, Object>) session.getAttribute("userInfo");
	if(null!=userInfo)
		response.sendRedirect(BasicConfig.INDEX_PATH);

	String email = request.getParameter("email");
	String password =  request.getParameter("password");
	String cpassword =  request.getParameter("cpassword");
	if(email!=null && password!=null && cpassword!=null &&
	   !"".equals(email) && !"".equals(password) && !"".equals(cpassword) &&
	   password.equals(cpassword))
	{
		signup su = new signup();
		if(su.signUp(session,email,password))
		{
			response.sendRedirect(BasicConfig.LOGIN_PATH);
			return;
		}
		else
		{
			out.print(
						"<script>"+
							"alert(\"Oh!No!操作异常，请重试\");"+
							"history.back();"+
						"</script>"
						);
			
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>加入码农 - 码农人生</title>
		<meta name="description" content="码农人生">
		<meta name="author" content="SR1">
		<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
		<script src="js/myJs.js"></script>
		<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
		<!--[if lt IE 9]>
		<script src="//cdnjs.bootcss.com/ajax/libs/html5shiv/3.6.2/html5shiv.js"></script>
		<![endif]-->
		<style type="text/css">
			body {
				padding-top: 60px;
				padding-bottom: 40px;
				}
			.container .row {
				padding-top: 20px;
				background: #eeeeee;
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
            <form class="navbar-form pull-right" method="post" action="./login.jsp">
              <input class="span2" type="text" placeholder=" 邮箱" name="uid">
              <input class="span2" type="password" placeholder=" 密码" name="upw">
              <button type="submit" class="btn">登录</button>
            </form>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
    
    <div class="container">

      <!-- Main hero unit for a primary marketing message or call to action -->
      <div class="row">
      	<div class="span2">
      	</div>
      	<div class="span8">
      		<form method='post' class="form-horizontal">
      			<div class="control-group">
	      			<label class="control-label">注册邮箱：</label>
	      			<div class="controls">
    	  				<input type="text" name="email" placeholder="注册邮箱" />
    	  			</div>
    	  		</div>
      			<div class="control-group">
      				<label class="control-label">注册密码：</label>
	      			<div class="controls">
      					<input type="password" name="password" placeholder="注册密码" />
      				</div>
      			</div>
      			<div>
      			<div class="control-group">
      				<label class="control-label">确认密码：</label>
	      			<div class="controls">
      					<input type="password" name="cpassword" placeholder="确认密码" />
      				</div>
      			</div>
      			<div class="control-group">
      				<div class="controls">
      					<button type="submit" class="btn btn-primary">确认注册</button>
      					<a class="btn"href="<%=BasicConfig.LOGIN_PATH %>">已有帐号？</a>
      				</div>
      			</div>
      		</form>
      	</div>
      	<div class="span2">
      	</div>
      </div>
      
      <hr>
      <footer class="pull-right">
        <p>&copy; CodeLife·码农人生-2013</p>
      </footer>
    </div>	
    <script src="//cdnjs.bootcss.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	</body>
</html>