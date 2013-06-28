var API_ROOT_PATH = "http://192.168.67.186/S2011150210/CodeLife/api/";
var xmlhttp;

var WARNING_UPDATE_SUCCESS = "发表成功~！" 
var WARNING_UPDATE_FAILE = "发表动态失败！请稍后重试。"
var WARNING_DELETE_SUCCESS = "成功删除该动态~！" 
var WARNING_DELETE_FAILE = "删除动态失败！请稍后重试。"
var WARNING_REPOST_SUCCESS = "转发动态成功~！" 
var WARNING_REPOST_FAILE = "转发动态失败！请稍后重试。"
var WARNING_COMMENT_SUCCESS = "评论动态成功~！"
var WARNING_COMMENT_FAILE = "评论动态失败！请稍后重试。"
var WARNING_DEL_COMMENT_SUCCESS = "删除评论成功~！"
var WARNING_DEL_COMMENT_FAILE = "删除评论失败！请稍后重试。"

var ALERT_STATE_SUCCESS = 'success'
var ALERT_STATE_ERROR = 'error'

function changeIMG()
{
	document.getElementById("userIMG").src="";
	var link = "http://192.168.67.186/S2011150210/CodeLife/img/userface/b";
	var num = Math.random()*21;
	link += Math.round(num);
	link += ".jpg";
	document.getElementById("userIMGLink").value=link;
	document.getElementById("userIMG").src=link;
}

function public_timeline()
{
	buildAjax(API_ROOT_PATH+"statuses/public_timeline.jsp", "", function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var friends = JSON.parse(xmlhttp.responseText);
						document.getElementById("content").innerHTML = "";
						friends = friends["public_timeline"];
						var message;
						
						var my_uid = document.cookie.split("; ")[0];
						my_uid = my_uid.split("=")[1];
						console.log(my_uid);

						for(var i=0;i<friends.length;i++)
						{
							var msg =  friends[i];
							var text = document.createElement("p");
							text.innerHTML = msg["content"];
							
							var content = document.createElement("p");
							content.appendChild(text);
							
							var link = document.createElement("a");
							link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["uid"];
							link.innerHTML = msg["nickname"];
							
							var create_time = document.createElement("span");
							create_time.innerHTML = "   " + msg["create_at"];
							
							var makeSmall = document.createElement("small");
							makeSmall.appendChild(link);
							makeSmall.appendChild(create_time);
							
							var comment = document.createElement("a");
							$(comment).addClass("pull-right");
							comment.innerHTML = "评论";
							var brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(comment);
							makeSmall.appendChild(brace);
							
							var repo = document.createElement("a");
							$(repo).addClass("pull-right");
							if(msg["re_mid"]!="0")
							{
								$(repo).click(show_repost_modal(
									msg['re_mid'],
									"@"+msg['re_nickname']+":"+msg['re_content'],
									"//@"+msg['nickname']+":"+msg['content']));
							}
							else
							{
								$(repo).click(show_repost_modal(
									msg['mid'],
									"@"+msg['nickname']+":"+msg['content'],""));
							}
							repo.innerHTML = "转发";
							makeSmall.appendChild(repo);
							brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(brace);
							
							if(msg["uid"]==my_uid || window.hasSuperPower == true)
							{
								var del = document.createElement("a");
								$(del).addClass("pull-right");
								$(del).click(prepare_destroy(msg['mid'], document.getElementById("repo_content")));
								del.innerHTML = "删除";
								del.marginLeft = "10";
								del.marginRight = "10"
								makeSmall.appendChild(del);
							}
						
							var message = document.createElement("blockquote");
							message.appendChild(content);
							message.appendChild(makeSmall);
							
							var divide = document.createElement("hr");
							
							if(msg["re_mid"]!="0")
							{
								var br = document.createElement("br");
								message.appendChild(br);
								
								var re_text = document.createElement("pre");
								re_text.innerHTML = msg["re_content"];
								
								var re_content = document.createElement("p");
								re_content.appendChild(re_text);
							
								var re_link = document.createElement("a");
								re_link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["re_uid"];
								re_link.innerHTML = msg["re_nickname"];
							
								var re_makeSmall = document.createElement("small");
								re_makeSmall.appendChild(re_link);
								re_makeSmall.innerHTML += "   " + msg["re_create_at"];
							
								var re_message = document.createElement("blockquote");
								re_message.appendChild(re_content);
								re_message.appendChild(re_makeSmall);
								
								message.appendChild(re_message);
							}
							
							$(comment).click(prepare_comment(message,msg['mid']));
							
							document.getElementById("content").appendChild(message);
							document.getElementById("content").appendChild(divide);
						}
						$("#content").append('<div id="addMore" class="accordion" ><p class="text-center"><a onclick="load_more_public_timeline('+friends[friends.length-1]['mid']+')">加载更多</a></p></div>');
					}
				});
}

function friends_timeline()
{
	buildAjax(API_ROOT_PATH+"statuses/friends_timeline.jsp", "", function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var friends = JSON.parse(xmlhttp.responseText);
						document.getElementById("content").innerHTML = "";
						friends = friends["friends_timeline"];
						var message;
						
						var my_uid = document.cookie.split("; ")[0];
						my_uid = my_uid.split("=")[1];
						console.log(my_uid);

						for(var i=0;i<friends.length;i++)
						{
							var msg =  friends[i];
							var text = document.createElement("p");
							text.innerHTML = msg["content"];
							
							var content = document.createElement("p");
							content.appendChild(text);
							
							var link = document.createElement("a");
							link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["uid"];
							link.innerHTML = msg["nickname"];
							
							var create_time = document.createElement("span");
							create_time.innerHTML = "   " + msg["create_at"];
							
							var makeSmall = document.createElement("small");
							makeSmall.appendChild(link);
							makeSmall.appendChild(create_time);
							
							var comment = document.createElement("a");
							$(comment).addClass("pull-right");
							comment.innerHTML = "评论";
							var brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(comment);
							makeSmall.appendChild(brace);
							
							var repo = document.createElement("a");
							$(repo).addClass("pull-right");
							if(msg["re_mid"]!="0")
							{
								$(repo).click(show_repost_modal(
									msg['re_mid'],
									"@"+msg['re_nickname']+":"+msg['re_content'],
									"//@"+msg['nickname']+":"+msg['content']));
							}
							else
							{
								$(repo).click(show_repost_modal(
									msg['mid'],
									"@"+msg['nickname']+":"+msg['content'],""));
							}
							repo.innerHTML = "转发";
							makeSmall.appendChild(repo);
							brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(brace);
							
							if(msg["uid"]==my_uid)
							{
								var del = document.createElement("a");
								$(del).addClass("pull-right");
								$(del).click(prepare_destroy(msg['mid'], document.getElementById("repo_content")));
								del.innerHTML = "删除";
								del.marginLeft = "10";
								del.marginRight = "10"
								makeSmall.appendChild(del);
							}
						
							var message = document.createElement("blockquote");
							message.appendChild(content);
							message.appendChild(makeSmall);
							
							var divide = document.createElement("hr");
							
							if(msg["re_mid"]!="0")
							{
								var br = document.createElement("br");
								message.appendChild(br);
								
								var re_text = document.createElement("pre");
								re_text.innerHTML = msg["re_content"];
								
								var re_content = document.createElement("p");
								re_content.appendChild(re_text);
							
								var re_link = document.createElement("a");
								re_link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["re_uid"];
								re_link.innerHTML = msg["re_nickname"];
							
								var re_makeSmall = document.createElement("small");
								re_makeSmall.appendChild(re_link);
								re_makeSmall.innerHTML += "   " + msg["re_create_at"];
							
								var re_message = document.createElement("blockquote");
								re_message.appendChild(re_content);
								re_message.appendChild(re_makeSmall);
								
								message.appendChild(re_message);
							}
							
							$(comment).click(prepare_comment(message,msg['mid']));
							
							document.getElementById("content").appendChild(message);
							document.getElementById("content").appendChild(divide);
						}
						$("#content").append('<div id="addMore" class="accordion" ><p class="text-center"><a onclick="load_more_friends_timeline('+friends[friends.length-1]['mid']+')">加载更多</a></p></div>');
					}
				});
}

function user_timeline(uid)
{
	var data = "uid="+uid;
	buildAjax(API_ROOT_PATH+"statuses/user_timeline.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var friends = JSON.parse(xmlhttp.responseText);
						document.getElementById("contentt").innerHTML = "";
						friends = friends["user_timeline"];
						var message;

						var my_uid = document.cookie.split("; ")[0];
						my_uid = my_uid.split("=")[1];
						console.log(my_uid);

						for(var i=0;i<friends.length;i++)
						{
							var msg =  friends[i];
							var text = document.createElement("p");
							text.innerHTML = msg["content"];
							
							var content = document.createElement("p");
							content.appendChild(text);
							
							var link = document.createElement("a");
							link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["uid"];
							link.innerHTML = msg["nickname"];
							
							var create_time = document.createElement("span");
							create_time.innerHTML = "   " + msg["create_at"];
							
							var makeSmall = document.createElement("small");
							makeSmall.appendChild(link);
							makeSmall.appendChild(create_time);
							
							var comment = document.createElement("a");
							$(comment).addClass("pull-right");
							comment.innerHTML = "评论";
							var brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(comment);
							makeSmall.appendChild(brace);
							
							var repo = document.createElement("a");
							$(repo).addClass("pull-right");
							if(msg["re_mid"]!="0")
							{
								$(repo).click(show_repost_modal(
									msg['re_mid'],
									"@"+msg['re_nickname']+":"+msg['re_content'],
									"//@"+msg['nickname']+":"+msg['content']));
							}
							else
							{
								$(repo).click(show_repost_modal(
									msg['mid'],
									"@"+msg['nickname']+":"+msg['content'],""));
							}
							repo.innerHTML = "转发";
							makeSmall.appendChild(repo);
							brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(brace);
							
							if(msg["uid"]==my_uid)
							{
								var del = document.createElement("a");
								$(del).addClass("pull-right");
								$(del).click(prepare_destroy(msg['mid'], document.getElementById("repo_content")));
								del.innerHTML = "删除";
								del.marginLeft = "10";
								del.marginRight = "10"
								makeSmall.appendChild(del);
							}
						
							var message = document.createElement("blockquote");
							message.appendChild(content);
							message.appendChild(makeSmall);
							
							var divide = document.createElement("hr");
							
							if(msg["re_mid"]!="0")
							{
								var br = document.createElement("br");
								message.appendChild(br);
								
								var re_text = document.createElement("pre");
								re_text.innerHTML = msg["re_content"];
								
								var re_content = document.createElement("p");
								re_content.appendChild(re_text);
							
								var re_link = document.createElement("a");
								re_link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["re_uid"];
								re_link.innerHTML = msg["re_nickname"];
							
								var re_makeSmall = document.createElement("small");
								re_makeSmall.appendChild(re_link);
								re_makeSmall.innerHTML += "   " + msg["re_create_at"];
							
								var re_message = document.createElement("blockquote");
								re_message.appendChild(re_content);
								re_message.appendChild(re_makeSmall);
								
								message.appendChild(re_message);
							}
							
							$(comment).click(prepare_comment(message,msg['mid']));
							
							document.getElementById("contentt").appendChild(message);
							document.getElementById("contentt").appendChild(divide);
						}
						$("#contentt").append('<div id="addMore" class="accordion" ><p class="text-center"><a onclick="load_more_user_timeline('+uid+","+friends[friends.length-1]['mid']+')">加载更多</a></p></div>');
					}
				});
}

function load_more_public_timeline(lastMid)
{
	var data = "lastMid="+lastMid;
	buildAjax(API_ROOT_PATH+"statuses/public_timeline.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var friends = JSON.parse(xmlhttp.responseText);
						friends = friends["public_timeline"];
						var message;
						
						$('#addMore').remove();
						
						if(friends.length==0)
						{
							showMessage("你已经浏览完所有动态啦~",ALERT_STATE_SUCCESS);
							return;
						}
						
						var my_uid = document.cookie.split("; ")[0];
						my_uid = my_uid.split("=")[1];
						console.log(my_uid);

						for(var i=0;i<friends.length;i++)
						{
							var msg =  friends[i];
							var text = document.createElement("p");
							text.innerHTML = msg["content"];
							
							var content = document.createElement("p");
							content.appendChild(text);
							
							var link = document.createElement("a");
							link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["uid"];
							link.innerHTML = msg["nickname"];
							
							var create_time = document.createElement("span");
							create_time.innerHTML = "   " + msg["create_at"];
							
							var makeSmall = document.createElement("small");
							makeSmall.appendChild(link);
							makeSmall.appendChild(create_time);
							
							var comment = document.createElement("a");
							$(comment).addClass("pull-right");
							comment.innerHTML = "评论";
							var brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(comment);
							makeSmall.appendChild(brace);
							
							var repo = document.createElement("a");
							$(repo).addClass("pull-right");
							if(msg["re_mid"]!="0")
							{
								$(repo).click(show_repost_modal(
									msg['re_mid'],
									"@"+msg['re_nickname']+":"+msg['re_content'],
									"//@"+msg['nickname']+":"+msg['content']));
							}
							else
							{
								$(repo).click(show_repost_modal(
									msg['mid'],
									"@"+msg['nickname']+":"+msg['content'],""));
							}
							repo.innerHTML = "转发";
							makeSmall.appendChild(repo);
							brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(brace);
							
							if(msg["uid"]==my_uid || window.hasSuperPower==true )
							{
								var del = document.createElement("a");
								$(del).addClass("pull-right");
								$(del).click(prepare_destroy(msg['mid'], document.getElementById("repo_content")));
								del.innerHTML = "删除";
								del.marginLeft = "10";
								del.marginRight = "10"
								makeSmall.appendChild(del);
							}
						
							var message = document.createElement("blockquote");
							message.appendChild(content);
							message.appendChild(makeSmall);
							
							var divide = document.createElement("hr");
							
							if(msg["re_mid"]!="0")
							{
								var br = document.createElement("br");
								message.appendChild(br);
								message.appendChild(br);
								
								var re_text = document.createElement("pre");
								re_text.innerHTML = msg["re_content"];
								
								var re_content = document.createElement("p");
								re_content.appendChild(re_text);
							
								var re_link = document.createElement("a");
								re_link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["re_uid"];
								re_link.innerHTML = msg["re_nickname"];
							
								var re_makeSmall = document.createElement("small");
								re_makeSmall.appendChild(re_link);
								re_makeSmall.innerHTML += "   " + msg["re_create_at"];
							
								var re_message = document.createElement("blockquote");
								re_message.appendChild(re_content);
								re_message.appendChild(re_makeSmall);
								
								message.appendChild(re_message);
							}
							
							$(comment).click(prepare_comment(message,msg['mid']));
							
							document.getElementById("content").appendChild(message);
							document.getElementById("content").appendChild(divide);
						}
						$("#content").append('<div id="addMore" class="accordion" ><p class="text-center"><a onclick="load_more_public_timeline('+friends[friends.length-1]['mid']+')">加载更多</a></p></div>');
					}
				});
}

function load_more_friends_timeline(lastMid)
{
	var data = "lastMid="+lastMid;
	buildAjax(API_ROOT_PATH+"statuses/friends_timeline.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var friends = JSON.parse(xmlhttp.responseText);
						friends = friends["friends_timeline"];
						var message;
						
						$('#addMore').remove();
						
						if(friends.length==0)
						{
							showMessage("你已经浏览完所有动态啦~",ALERT_STATE_SUCCESS);
							return;
						}
						
						var my_uid = document.cookie.split("; ")[0];
						my_uid = my_uid.split("=")[1];
						console.log(my_uid);

						for(var i=0;i<friends.length;i++)
						{
							var msg =  friends[i];
							var text = document.createElement("p");
							text.innerHTML = msg["content"];
							
							var content = document.createElement("p");
							content.appendChild(text);
							
							var link = document.createElement("a");
							link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["uid"];
							link.innerHTML = msg["nickname"];
							
							var create_time = document.createElement("span");
							create_time.innerHTML = "   " + msg["create_at"];
							
							var makeSmall = document.createElement("small");
							makeSmall.appendChild(link);
							makeSmall.appendChild(create_time);
							
							var comment = document.createElement("a");
							$(comment).addClass("pull-right");
							comment.innerHTML = "评论";
							var brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(comment);
							makeSmall.appendChild(brace);
							
							var repo = document.createElement("a");
							$(repo).addClass("pull-right");
							if(msg["re_mid"]!="0")
							{
								$(repo).click(show_repost_modal(
									msg['re_mid'],
									"@"+msg['re_nickname']+":"+msg['re_content'],
									"//@"+msg['nickname']+":"+msg['content']));
							}
							else
							{
								$(repo).click(show_repost_modal(
									msg['mid'],
									"@"+msg['nickname']+":"+msg['content'],""));
							}
							repo.innerHTML = "转发";
							makeSmall.appendChild(repo);
							brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(brace);
							
							if(msg["uid"]==my_uid)
							{
								var del = document.createElement("a");
								$(del).addClass("pull-right");
								$(del).click(prepare_destroy(msg['mid'], document.getElementById("repo_content")));
								del.innerHTML = "删除";
								del.marginLeft = "10";
								del.marginRight = "10"
								makeSmall.appendChild(del);
							}
						
							var message = document.createElement("blockquote");
							message.appendChild(content);
							message.appendChild(makeSmall);
							
							var divide = document.createElement("hr");
							
							if(msg["re_mid"]!="0")
							{
								var br = document.createElement("br");
								message.appendChild(br);
								message.appendChild(br);
								
								var re_text = document.createElement("pre");
								re_text.innerHTML = msg["re_content"];
								
								var re_content = document.createElement("p");
								re_content.appendChild(re_text);
							
								var re_link = document.createElement("a");
								re_link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["re_uid"];
								re_link.innerHTML = msg["re_nickname"];
							
								var re_makeSmall = document.createElement("small");
								re_makeSmall.appendChild(re_link);
								re_makeSmall.innerHTML += "   " + msg["re_create_at"];
							
								var re_message = document.createElement("blockquote");
								re_message.appendChild(re_content);
								re_message.appendChild(re_makeSmall);
								
								message.appendChild(re_message);
							}
							
							$(comment).click(prepare_comment(message,msg['mid']));
							
							document.getElementById("content").appendChild(message);
							document.getElementById("content").appendChild(divide);
						}
						$("#content").append('<div id="addMore" class="accordion" ><p class="text-center"><a onclick="load_more_friends_timeline('+friends[friends.length-1]['mid']+')">加载更多</a></p></div>');
					}
				});
}

function load_more_user_timeline(uid,lastMid)
{
	var data = "uid="+uid+"&lastMid="+lastMid;
	buildAjax(API_ROOT_PATH+"statuses/user_timeline.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var friends = JSON.parse(xmlhttp.responseText);
						friends = friends["user_timeline"];
						var message;
						
						$('#addMore').remove();
						
						if(friends.length==0)
						{
							showMessage("你已经浏览完所有动态啦~",ALERT_STATE_SUCCESS);
							return;
						}
						
						var my_uid = document.cookie.split("; ")[0];
						my_uid = my_uid.split("=")[1];
						console.log(my_uid);

						for(var i=0;i<friends.length;i++)
						{
							var msg =  friends[i];
							var text = document.createElement("p");
							text.innerHTML = msg["content"];
							
							var content = document.createElement("p");
							content.appendChild(text);
							
							var link = document.createElement("a");
							link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["uid"];
							link.innerHTML = msg["nickname"];
							
							var create_time = document.createElement("span");
							create_time.innerHTML = "   " + msg["create_at"];
							
							var makeSmall = document.createElement("small");
							makeSmall.appendChild(link);
							makeSmall.appendChild(create_time);
							
							var comment = document.createElement("a");
							$(comment).addClass("pull-right");
							comment.innerHTML = "评论";
							var brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(comment);
							makeSmall.appendChild(brace);
							
							var repo = document.createElement("a");
							$(repo).addClass("pull-right");
							if(msg["re_mid"]!="0")
							{
								$(repo).click(show_repost_modal(
									msg['re_mid'],
									"@"+msg['re_nickname']+":"+msg['re_content'],
									"//@"+msg['nickname']+":"+msg['content']));
							}
							else
							{
								$(repo).click(show_repost_modal(
									msg['mid'],
									"@"+msg['nickname']+":"+msg['content'],""));
							}
							repo.innerHTML = "转发";
							makeSmall.appendChild(repo);
							brace = document.createElement("span");
							$(brace).addClass("pull-right");
							brace.innerHTML = "　";
							makeSmall.appendChild(brace);
							
							if(msg["uid"]==my_uid)
							{
								var del = document.createElement("a");
								$(del).addClass("pull-right");
								$(del).click(prepare_destroy(msg['mid'], document.getElementById("repo_content")));
								del.innerHTML = "删除";
								del.marginLeft = "10";
								del.marginRight = "10"
								makeSmall.appendChild(del);
							}
						
							var message = document.createElement("blockquote");
							message.appendChild(content);
							message.appendChild(makeSmall);
							
							var divide = document.createElement("hr");
							
							if(msg["re_mid"]!="0")
							{
								var br = document.createElement("br");
								message.appendChild(br);
								message.appendChild(br);
								
								var re_text = document.createElement("pre");
								re_text.innerHTML = msg["re_content"];
								
								var re_content = document.createElement("p");
								re_content.appendChild(re_text);
							
								var re_link = document.createElement("a");
								re_link.href = "http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="+msg["re_uid"];
								re_link.innerHTML = msg["re_nickname"];
							
								var re_makeSmall = document.createElement("small");
								re_makeSmall.appendChild(re_link);
								re_makeSmall.innerHTML += "   " + msg["re_create_at"];
							
								var re_message = document.createElement("blockquote");
								re_message.appendChild(re_content);
								re_message.appendChild(re_makeSmall);
								
								message.appendChild(re_message);
							}
							
							$(comment).click(prepare_comment(message,msg['mid']));
							
							document.getElementById("content").appendChild(message);
							document.getElementById("content").appendChild(divide);
						}
						$("#content").append('<div id="addMore" class="accordion" ><p class="text-center"><a onclick="load_more_user_timeline('+uid+","+friends[friends.length-1]['mid']+')">加载更多</a></p></div>');
					}
				});
}

function show_repost_modal(mid,source,source_repo)
{
	return function(){
		$('#repo_mid').attr("value",mid);
		document.getElementById('repo_source').innerHTML = source.toString();
		$('#repo_content').text(source_repo);
		
		$("#modal").prepend("<textarea class='span7' rows='2' id='repo_content' placeholder='转发动态' >"+source_repo+"</textarea>");

		$('#myModal').modal('show');
		console.log(mid);
		console.log(source_repo);
	};
}

function repostModalClose()
{
	$("#repo_content").remove();
	$('#myModal').modal('hide');
}

function prepare_comment(ob,mid)
{
	return function()
	{
		$('#commentForm').remove();
		$(ob).append('<form style="display:none;margin-top:20px" id="commentForm" class="form-inline" onsubmit="return false;"><input type="hidden" id="commentMid" value="'+mid+'"><input class="span5" type="text" id="commentContent" /><button class="btn btn-small" id="commentButton" onClick="comments_create(commentMid.value,commentContent.value)">评论</button><div id="commentField"></div></form>');
		comments_show(mid)
		$('#commentForm').slideToggle();
	};					
}

function prepare_repost(mid,msg)
{
	return function(msg){
		statuses_repost(mid, msg.value);
	};
}

function prepare_destroy(mid)
{
	return function(){
		console.log(mid);
		statuses_destroy(mid);
	};
}

function comments_show(mid)
{
	var data = "mid="+mid;
	buildAjax(API_ROOT_PATH+"/comments/show.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var comments = JSON.parse(xmlhttp.responseText);
						comments = comments['comments'];
						
						document.getElementById("commentField").innerHTML = "";
						for(var i=0;i<comments.length;i++)
						{
							var comment = comments[i];
							var my_uid = document.cookie.split("; ")[0];
							my_uid = my_uid.split("=")[1];
							
							var com = '<br/><small><a href="http://192.168.67.186/S2011150210/CodeLife/user.jsp?uid="'+comment['commenter']+' >@'+comment['nickname']+'</a>：'+comment['comment']+'　('+comment['commentTime']+')';
							if(my_uid==comment['commenter'] || window.hasSuperPower == true )
							{
								com += '　<a onClick="comments_destroy('+comment['cid']+','+mid+')">删除</a></small>';
							}
							else
							{
								com += '</small>';
							}
							$('#commentField').append(com);
						}
					}
				});
	return;
}

function comments_create(mid, content)
{
	var data = "mid="+mid+"&comment="+content;
	repostModalClose();
	buildAjax(API_ROOT_PATH+"/comments/create.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var state = JSON.parse(xmlhttp.responseText);
						if(state)
						{
							document.getElementById("commentContent").value = "";
							comments_show(mid);
							showMessage(WARNING_COMMENT_SUCCESS,ALERT_STATE_SUCCESS);
						}
						else
						{
							showMessage(WARNING_COMMENT_FAILE,ALERT_STATE_ERROR);
						}
					}
				});
	return;
}

function comments_destroy(cid,mid)
{
	var data = "cid="+cid;
	repostModalClose();
	buildAjax(API_ROOT_PATH+"/comments/destroy.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var state = toJSON(xmlhttp.responseText);
						if(state==true)
						{
							comments_show(mid);
							showMessage(WARNING_DEL_COMMENT_SUCCESS,ALERT_STATE_SUCCESS);
						}
						else
						{
							showMessage(WARNING_DEL_COMMENT_FAILE,ALERT_STATE_ERROR);
						}
					}
				});
	return;
	
}

function statuses_repost(mid, content)
{
	var data = "mid="+mid+"&content="+content;
	repostModalClose();
	buildAjax(API_ROOT_PATH+"/statuses/repost.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var state = toJSON(xmlhttp.responseText);
						if(state==true)
						{
							friends_timeline();
							showMessage(WARNING_REPOST_SUCCESS,ALERT_STATE_SUCCESS);
						}
						else
						{
							showMessage(WARNING_REPOST_FAILE,ALERT_STATE_ERROR);
						}
					}
				});
	return;
}

function statuses_update(msg)
{
	var data = "content="+msg.value;
	buildAjax(API_ROOT_PATH+"/statuses/update.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var state = toJSON(xmlhttp.responseText);
						if(state==true)
						{
							msg.value = "";
							friends_timeline();
							showMessage(WARNING_UPDATE_SUCCESS,ALERT_STATE_SUCCESS);
						}
						else
						{
							alert(msg.value + WARNING_UPDATE_FAILE);
							friends_timeline();
							showMessage(WARNING_UPDATE_FAILE,ALERT_STATE_ERROR);
						}
					}
				});
	return;
}

function statuses_destroy(mid)
{
	var data = "mid="+mid;
	buildAjax(API_ROOT_PATH+"/statuses/destroy.jsp", data, function()
				{
					if(xmlhttp.readyState==4 && xmlhttp.status==200)
					{
						var state = toJSON(xmlhttp.responseText);
						if(state==true)
						{
							showMessage(WARNING_DELETE_SUCCESS,ALERT_STATE_SUCCESS);
							if(window.hasSuperPower == true)
							{
								public_timeline();
							}
							else
							{
								friends_timeline();
							}
						}
						else
						{
							showMessage(WARNING_DELETE_FAILE,ALERT_STATE_ERROR);
						}
					}
				});
	return;
}

function toJSON(str)
{
	return eval("("+str+")");
}

function showMessage(msg,state)
{
	$.globalMessenger().post({
		message: msg,
		type: state,
		showCloseButton: true
	});
}

function buildAjax(url, data, func)
{
	if(window.XMLHttpRequest)
	{
		xmlhttp=new XMLHttpRequest();
	}
	else
	{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=func;
	xmlhttp.open("POST",url,true);
	xmlhttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlhttp.send(data);
}

