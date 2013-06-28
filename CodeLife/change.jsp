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

	String Username = request.getParameter("Username");
	String OneWord = request.getParameter("OneWord");
	String personInfo = request.getParameter("personInfo");
	String userIMGLink = request.getParameter("userIMGLink");
	
	if( Username!=null && OneWord!=null && personInfo!=null && userIMGLink !=null &&
		!"".equals(Username) && !"".equals(OneWord) &&
		!"".equals(personInfo) && !"".equals(userIMGLink) )
	{
		String uid = (String)userInfo.get("uid");
		String sql = "UPDATE `b_usersInfo` SET `nickname` = ? , `sign` = ? , `info`= ? , `pic` = ? WHERE `uid` = ? ;";
		DBConnect conn = new DBConnect();
		PreparedStatement stat = conn.getPreparedStatement(sql);
		stat.setString(1,Username);
		stat.setString(2,OneWord);
		stat.setString(3,personInfo);
		stat.setString(4,userIMGLink);
		stat.setString(5,uid);
		int resultCode = stat.executeUpdate();
		if(resultCode!=0)
		{
			users us = new users();
			session.setAttribute("userInfo",us.show(uid));
			response.sendRedirect(BasicConfig.USERS_PATH);
			return;
		}
	}
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>修改密码 - 码农人生</title>
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
                  <li><a href="./reset.jsp">修改帐号密码</a></li>
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
		<div class="row">
		    <!--LeftPart
			================================================== -->
			<div class="span3 well">
				<div class="row">
					<div class="span3">
						<div class="icon" style="background-image:url('<%=(String)userInfo.get("pic") %>');"></div>
						<h4><%=(String)userInfo.get("username") %></h4>
					</div>
				</div>
				<div class="row">
					<%
						users us = new users();
						HashMap<String,Object> othersInfo = us.show((String)userInfo.get("uid"));
					%>
					<div class="span1 text-center " >
							粉丝<br/>
							<%=(String)othersInfo.get("follower") %>
					</div>
					<div class="span1 text-center" >
							关注<br/>
							<%=(String)othersInfo.get("folloed") %>
					</div>
					<div class="span1 text-center" >
							微博<br/>
							<%=(String)othersInfo.get("message") %>
					</div>
				</div>
				<div class="row">
					<div class="span3">
						<h5>个性签名</h5>
						<p><%=(String)userInfo.get("signature") %></p>
						<h5>个人简介</h5>
						<p><%=(String)userInfo.get("info") %></p>
					</div>
				</div>
			</div>
		    <!--CenterPart
			================================================== -->
			<div class="span6 centerColor" >
				<div>
					<h4>更新<%=(String)othersInfo.get("username") %>的资料：</h4>
				</div>
				<hr/>
				<div id="contentt">
					<form method="post">
						<a onClick="changeIMG()">点击更换头像</a><br/>
						<img id="userIMG" onClick="changeIMG()" class="img-polaroid" style="width: 140px; height: 140px; margin-bottom:20px;" src="<%=(String)userInfo.get("pic") %>" />
						<input type="hidden" id="userIMGLink" name="userIMGLink" value="<%=(String)userInfo.get("pic") %>">
							<div class="control-group">
								<label class="control-label" for="inputUsername">用户昵称：</label>
								<div class="controls">
									<input type="text"  name="Username" id="inputUsername" value="<%=(String)userInfo.get("username") %>" placeholder="用户昵称" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputOneWord">签名档：</label>
								<div class="controls">
									<input class="span4" type="text"  value="<%=(String)userInfo.get("signature") %>" name="OneWord" id="inputOneWord" placeholder="一句话介绍">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">个人简介：</label>
								<div class="controls">
									<textarea class="span4" rows="3" name="personInfo" placeholder="几百年后出图发现，你闷骚的样子依然清晰可见？"><%=(String)userInfo.get("info") %></textarea>
								</div>
							</div>
							<button class="btn btn-primary">保存更改</button>
							<a class="btn" href="<%=BasicConfig.USERS_PATH %>" >放弃修改</a>
						</form>
					</div>
			</div>
		    <!--RightPart
			================================================== -->
			<div class="span2 well">
				<h4>我的好友列表</h4>
				<h5>我的关注</h5>
				<%
					friendships fs = new friendships();
					ArrayList<HashMap<String, Object>> friends = fs.friends((String)userInfo.get("uid"));
					for(int i=0;i<friends.size();i++)
					{
						String nickname = (String)friends.get(i).get("username");
						String pic = (String)friends.get(i).get("pic");
						String link = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+(String)friends.get(i).get("uid");;
				%>
				<div class="vertical">
					<a href="<%=link %>">
					<div class="smallicon" style="background-image:url('<%=pic %>');" ></div>
					<span><%=nickname %></span></a>
				</div>
				<%
					}
				%>
				<h5>我的悄悄关注</h5>
				<%
					ArrayList<HashMap<String, Object>> secret_friends = fs.secret_friends(session);
					for(int i=0;i<secret_friends.size();i++)
					{
						String nickname = (String)secret_friends.get(i).get("username");
						String pic = (String)secret_friends.get(i).get("pic");
						String link = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+(String)secret_friends.get(i).get("uid");;
				%>
				<div class="vertical">
					<a href="<%=link %>">
					<div class="smallicon" style="background-image:url('<%=pic %>');" ></div>
					<span><%=nickname %></span></a>
				</div>
				<%
					}
				%>
				<h5>我的粉丝</h5>
				<%
					ArrayList<HashMap<String, Object>> follows = fs.followers((String)userInfo.get("uid"));
					for(int i=0;i<follows.size();i++)
					{
						String nickname = (String)follows.get(i).get("username");
						String pic = (String)follows.get(i).get("pic");
						String link = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+(String)follows.get(i).get("uid");
				%>
				<div class="vertical">
					<a href="<%=link %>">
					<div class="smallicon" style="background-image:url('<%=pic %>');" ></div>
					<span><%=nickname %></span></a>
				</div>
				
				<%
					}
				%>
			</div>
		</div>
		<hr>
		<footer class="pull-right">
			<p>&copy; CodeLife·码农人生-2013</p>
		</footer>
	</div>
	<script src="js/bootstrap.min.js"></script>
	</body>
</html>