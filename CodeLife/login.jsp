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
	
	String uid = (String)request.getParameter("uid");
	String upw = (String)request.getParameter("upw");
	
	if(uid!=null && upw!=null && !"".equals(uid) && !"".equals(upw))
	{
		boolean isSuc = false;
		login lg = new login();
		isSuc = lg.verify(session, uid, upw);
		if(isSuc)
		{
			Cookie cookie_uid = new Cookie("uid",(String)((HashMap<String, Object>)session.getAttribute("userInfo")).get("uid"));
			response.addCookie(cookie_uid);
			response.sendRedirect(BasicConfig.INDEX_PATH);
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>登录 - 码农人生</title>
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
			.bgcolor {
				background-color: #eeeeee;
				padding: 20px;
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
      <div class="hero-unit">
        <h1>你好！码农！</h1>
        <p>春天，你种下一行行代码；秋天，你收获一堆堆Bug。为何你孜孜不倦的码间耕耘，只因你对它爱的深沉？加入我们吧~！码农人生社区现已正式开放注册！</p>
        <p><a href="./signup.jsp" class="btn btn-primary btn-large">加入码农 &raquo;</a></p>
      </div>

      <!-- Example row of columns -->
      <div class="row">
        <div class="span5 well">
          <h2>开放</h2>
          <p>在这里，你可以跟志同道合的朋友讨论感兴趣的技术，甚至仅仅是八卦吹水。码农人生欢迎任何对计算机感兴趣人加入！</p>
        </div>
        <div class="span6 well">
          <h2>平等</h2>
          <p>大神小白一视同仁，只要你的想法足够新颖独特，能巧妙的解决问题，你就是大神！</p>
       </div>
       </div>
       <div class="row">
        <div class="span5 well">
          <h2>协作</h2>
          <p>码农人生希望通过提供一个团队协作交流工具，让团队能够更便捷有效的相互沟通写作，创造更多优秀的应用。</p>
       </div>
        <div class="span6 well">
          <h2>分享</h2>
          <p>分享你的Idea，你的Wonderful Code，让更多的人得以站在巨人的肩膀上。分享正是互联网精神的精髓。</p>
        </div>
      </div>

      <hr>

      <footer class="pull-right">
        <p>&copy; CodeLife·码农人生-2013</p>
      </footer>

    </div> <!-- /container -->
	
	
	
	
    <script src="//cdnjs.bootcss.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	</body>
</html>