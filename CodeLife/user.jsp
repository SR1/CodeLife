<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.roslab.web.logicm.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	//检测是否登录
	HashMap<String, Object> userInfo = null;
	userInfo = (HashMap<String, Object>) session.getAttribute("userInfo");
	if(null==userInfo)
	{
		response.sendRedirect(BasicConfig.LOGIN_PATH);
		return;
	}
	//检测uid是否存在，不存在则跳转至个人主页login.jsp
	String uid = request.getParameter("uid");
	if(null==uid)
	{
		uid = (String)userInfo.get("uid");
	}
	users us = new users();
	HashMap<String,Object> othersInfo = us.show(uid);
	if(null==othersInfo)
	{
		response.sendRedirect(BasicConfig.INDEX_PATH);
		return;
	}
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><%=othersInfo.get("username") %> - 码农人生</title>
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
						<div class="icon" style="background-image:url('<%=(String)othersInfo.get("pic") %>');"></div>
						<h4><%=(String)othersInfo.get("username") %></h4>
						<% if(friendships.isFollowed((String)userInfo.get("uid"),uid))
							{
								if(!uid.equals((String)userInfo.get("uid")))
								{
						%>
						<a class="btn btn-small btn btn-info" >
							已关注</a>
						<a class="btn btn-small btn-danger" 
							href="http://192.168.67.186/S2011150210/CodeLife/api/friendships/destroy.jsp?uid=<%=uid %>">
							取消关注</a>
						<%
								} 
							}else
							{
						%>
						<a class="btn btn-small btn-primary" 
							href="http://192.168.67.186/S2011150210/CodeLife/api/friendships/create.jsp?uid=<%=uid %>">
							关注</a>
						<a class="btn btn-small btn-info" 
							href="http://192.168.67.186/S2011150210/CodeLife/api/friendships/create.jsp?uid=<%=uid %>&Secret=1">
							悄悄关注</a>
						<% } %>
					</div>
				</div>
				<div class="row">
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
						<p><%=(String)othersInfo.get("signature") %></p>
						<h5>个人简介</h5>
						<p><%=(String)othersInfo.get("info") %></p>
					</div>
				</div>
			</div>
		    <!--CenterPart
			================================================== -->
			<div class="span6 centerColor" >
				<div>
					<h4><%=(String)othersInfo.get("username") %>的动态：</h4>
				</div>
				<hr/>
				<div id="contentt">
					<script>
						user_timeline('<%=(String)othersInfo.get("uid")%>');
					</script>
				</div>
			</div>
		    <!--RightPart
			================================================== -->
			<div class="span2 well">
				<h4>Ta的关注</h4>
				<%
					friendships fs = new friendships();
					ArrayList<HashMap<String, Object>> friends = fs.friends((String)othersInfo.get("uid"));
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
				<h4>Ta的粉丝</h4>
				<%
					ArrayList<HashMap<String, Object>> follows = fs.followers((String)othersInfo.get("uid"));
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
	<!-- Modal -->
	<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" onClick="repostModalClose()">×</button>
			<h4 id="myModalLabel">转发动态</h4>
		</div>
		<div class="modal-body" id="modal">
			<input type="hidden" id="repo_mid" value="" />
			<pre id="repo_source"></pre>
		</div>
		<div class="modal-footer">
			<button class="btn" onClick="repostModalClose()" >关闭</button>
			<button class="btn btn-primary" onClick="statuses_repost(repo_mid.value, repo_content.value)" >转发</button>
		</div>
	</div>
	<script src="js/bootstrap.min.js"></script>
	</body>
</html>