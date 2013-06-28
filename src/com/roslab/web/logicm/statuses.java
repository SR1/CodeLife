package com.roslab.web.logicm;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
 
public class statuses {
	
	private static String SQL_FRIENDS_TIMMELINE = "SELECT DISTINCT  u1.`uid` ,  u1.`nickname` , m1.`id` mid, m1.`content` , m1.`postTime` create_at, u2.`uid` re_uid, u2.`nickname` re_nickname, m2.`id` re_mid, m2.`content` re_content, m2.`postTime` re_create_at FROM `b_mircoblog` m1, `b_mircoblog` m2, `b_usersInfo` u1, `b_usersInfo` u2, `b_relationship` WHERE m1.`user` =  u1.`uid` AND m1.`RetweetSource` = m2.`id` AND m2.`user` = u2.`uid` AND `b_relationship`.`followed` = m1.`user` AND m1.`isDel` = 0 AND  `folloer` = ? ORDER BY m1.`postTime` DESC LIMIT 0 , 20";
	private static String SQL_FRIENDS_TIMMELINE_WITH_LASTMID = "SELECT DISTINCT  u1.`uid` ,  u1.`nickname` , m1.`id` mid, m1.`content` , m1.`postTime` create_at, u2.`uid` re_uid, u2.`nickname` re_nickname, m2.`id` re_mid, m2.`content` re_content, m2.`postTime` re_create_at FROM `b_mircoblog` m1, `b_mircoblog` m2, `b_usersInfo` u1, `b_usersInfo` u2, `b_relationship` WHERE m1.`user` =  u1.`uid` AND m1.`RetweetSource` = m2.`id` AND m2.`user` = u2.`uid` AND `b_relationship`.`followed` = m1.`user` AND  m1.`isDel` = 0 AND `folloer` = ? AND m1.`id` < ? ORDER BY m1.`postTime` DESC LIMIT 0 , 20";
	private static String SQL_USER_TIMELINE = "SELECT DISTINCT  u1.`uid` ,  u1.`nickname` , m1.`id` mid, m1.`content` , m1.`postTime` create_at, u2.`uid` re_uid, u2.`nickname` re_nickname, m2.`id` re_mid, m2.`content` re_content, m2.`postTime` re_create_at FROM `b_mircoblog` m1, `b_mircoblog` m2, `b_usersInfo` u1, `b_usersInfo` u2 WHERE m1.`user` =  u1.`uid` AND m1.`RetweetSource` = m2.`id` AND m2.`user` = u2.`uid` AND m1.`isDel` = 0 AND  m1.`user` = ? ORDER BY m1.`postTime` DESC LIMIT 0 , 20";
	private static String SQL_USER_TIMELINE_WITH_LASTMID = "SELECT DISTINCT  u1.`uid` ,  u1.`nickname` , m1.`id` mid, m1.`content` , m1.`postTime` create_at, u2.`uid` re_uid, u2.`nickname` re_nickname, m2.`id` re_mid, m2.`content` re_content, m2.`postTime` re_create_at FROM `b_mircoblog` m1, `b_mircoblog` m2, `b_usersInfo` u1, `b_usersInfo` u2 WHERE m1.`user` =  u1.`uid` AND m1.`RetweetSource` = m2.`id` AND m2.`user` = u2.`uid` AND m1.`isDel` = 0 AND  m1.`user` = ? AND m1.`id` < ? ORDER BY m1.`postTime` DESC LIMIT 0 , 20";

	private static String SQL_ALL_TIMMELINE = "SELECT DISTINCT u1.`uid` ,  u1.`nickname` , m1.`id` mid, m1.`content` , m1.`postTime` create_at,  u2.`uid` re_uid, u2.`nickname` re_nickname, m2.`id` re_mid, m2.`content` re_content, m2.`postTime` re_create_at FROM `b_mircoblog` m1, `b_mircoblog` m2, `b_usersInfo` u1, `b_usersInfo` u2 WHERE m1.`user` =  u1.`uid` AND m1.`RetweetSource` = m2.`id` AND m2.`user` = u2.`uid` AND m1.`id` <> '0' AND m1.`isDel` = 0 ORDER BY m1.`id` DESC LIMIT 0 , 20";
	private static String SQL_ALL_TIMMELINE_WITH_LASTMID = "SELECT DISTINCT u1.`uid` ,  u1.`nickname` , m1.`id` mid, m1.`content` , m1.`postTime` create_at,  u2.`uid` re_uid, u2.`nickname` re_nickname, m2.`id` re_mid, m2.`content` re_content, m2.`postTime` re_create_at FROM `b_mircoblog` m1, `b_mircoblog` m2, `b_usersInfo` u1, `b_usersInfo` u2 WHERE m1.`user` =  u1.`uid` AND m1.`RetweetSource` = m2.`id` AND m2.`user` = u2.`uid` AND m1.`id` <> '0' AND m1.`isDel` = 0 AND m1.`id` < ? ORDER BY m1.`id` DESC LIMIT 0 , 20;";	//获取全部动态
	
	// statuses/public_timeline
	public ArrayList<HashMap<String, Object>> public_timeline() throws ClassNotFoundException, SQLException
	{
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(SQL_ALL_TIMMELINE);
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> messages = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String, Object> message = new HashMap<String, Object>();
			message.put("uid",rs.getString("uid"));
			message.put("nickname",rs.getString("nickname"));
			message.put("mid",rs.getString("mid"));
			message.put("content",rs.getString("content"));
			message.put("create_at",rs.getString("create_at"));
			message.put("re_uid",rs.getString("re_uid"));
			message.put("re_nickname",rs.getString("re_nickname"));
			message.put("re_mid",rs.getString("re_mid"));
			message.put("re_content",rs.getString("re_content"));
			message.put("re_create_at",rs.getString("re_create_at"));
			
			messages.add(message);
		}
		rs.close();
		return messages;
	}
	//获取指定 mid 之后的20条动态
	public ArrayList<HashMap<String, Object>> public_timeline(String lastMid) throws ClassNotFoundException, SQLException
	{
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(SQL_ALL_TIMMELINE_WITH_LASTMID);
		stat.setString(1,lastMid);
		
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> messages = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String, Object> message = new HashMap<String, Object>();
			message.put("uid",rs.getString("uid"));
			message.put("nickname",rs.getString("nickname"));
			message.put("mid",rs.getString("mid"));
			message.put("content",rs.getString("content"));
			message.put("create_at",rs.getString("create_at"));
			message.put("re_uid",rs.getString("re_uid"));
			message.put("re_nickname",rs.getString("re_nickname"));
			message.put("re_mid",rs.getString("re_mid"));
			message.put("re_content",rs.getString("re_content"));
			message.put("re_create_at",rs.getString("re_create_at"));
			
			messages.add(message);
		}
		rs.close();
		return messages;
	}
	
	
	// statuses/user_timeline	获取用户发布的微博
	public ArrayList<HashMap<String, Object>> user_timeline(String uid) throws ClassNotFoundException, SQLException
	{
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(SQL_USER_TIMELINE);
		stat.setString(1, uid);
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> messages = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String, Object> message = new HashMap<String, Object>();
			message.put("uid",rs.getString("uid"));
			message.put("nickname",rs.getString("nickname"));
			message.put("mid",rs.getString("mid"));
			message.put("content",rs.getString("content"));
			message.put("create_at",rs.getString("create_at"));
			message.put("re_uid",rs.getString("re_uid"));
			message.put("re_nickname",rs.getString("re_nickname"));
			message.put("re_mid",rs.getString("re_mid"));
			message.put("re_content",rs.getString("re_content"));
			message.put("re_create_at",rs.getString("re_create_at"));
			
			messages.add(message);
		}
		rs.close();
		return messages;
	}
	
	// statuses/user_timeline	获取用户发布的微博
	public ArrayList<HashMap<String, Object>> user_timeline(String uid,String lastMid) throws ClassNotFoundException, SQLException
	{
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(SQL_USER_TIMELINE_WITH_LASTMID);
		stat.setString(1, uid);
		stat.setString(2, lastMid);
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> messages = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String, Object> message = new HashMap<String, Object>();
			message.put("uid",rs.getString("uid"));
			message.put("nickname",rs.getString("nickname"));
			message.put("mid",rs.getString("mid"));
			message.put("content",rs.getString("content"));
			message.put("create_at",rs.getString("create_at"));
			message.put("re_uid",rs.getString("re_uid"));
			message.put("re_nickname",rs.getString("re_nickname"));
			message.put("re_mid",rs.getString("re_mid"));
			message.put("re_content",rs.getString("re_content"));
			message.put("re_create_at",rs.getString("re_create_at"));
			
			messages.add(message);
		}
		rs.close();
		return messages;
	}
	
	// statuses/friends_timeline	获取当前登录用户及其所关注用户的在指定微博之前的微博
	public ArrayList<HashMap<String, Object>> friends_timeline(HttpSession session, String lastMid) throws ClassNotFoundException, SQLException
	{	

		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
	
		if(userInfo==null)
			return null;
		
		String sql = SQL_FRIENDS_TIMMELINE_WITH_LASTMID;
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, (String)userInfo.get("uid"));
		stat.setString(2, lastMid);
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> messages = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String, Object> message = new HashMap<String, Object>();
			message.put("uid",rs.getString("uid"));
			message.put("nickname",rs.getString("nickname"));
			message.put("mid",rs.getString("mid"));
			message.put("content",rs.getString("content"));
			message.put("create_at",rs.getString("create_at"));
			message.put("re_uid",rs.getString("re_uid"));
			message.put("re_nickname",rs.getString("re_nickname"));
			message.put("re_mid",rs.getString("re_mid"));
			message.put("re_content",rs.getString("re_content"));
			message.put("re_create_at",rs.getString("re_create_at"));
			
			messages.add(message);
		}
		rs.close();
		return messages;
	}
	
	// statuses/friends_timeline	获取当前登录用户及其所关注用户的最新微博
	public ArrayList<HashMap<String, Object>> friends_timeline(HttpSession session) throws ClassNotFoundException, SQLException
	{	

		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
	
		if(userInfo==null)
			return null;
		String sql = SQL_FRIENDS_TIMMELINE;
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, (String)userInfo.get("uid"));
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> messages = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String, Object> message = new HashMap<String, Object>();
			message.put("uid",rs.getString("uid"));
			message.put("nickname",rs.getString("nickname"));
			message.put("mid",rs.getString("mid"));
			message.put("content",rs.getString("content"));
			message.put("create_at",rs.getString("create_at"));
			message.put("re_uid",rs.getString("re_uid"));
			message.put("re_nickname",rs.getString("re_nickname"));
			message.put("re_mid",rs.getString("re_mid"));
			message.put("re_content",rs.getString("re_content"));
			message.put("re_create_at",rs.getString("re_create_at"));
			
			messages.add(message);
		}
		rs.close();
		return messages;
	}
	
	// statuses/update	发布一条微博信息
	public boolean update(HttpSession session, String content) throws ClassNotFoundException, SQLException
	{
		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
	
		if(userInfo==null)
		return false;
		
		String sql = "INSERT INTO `b_mircoblog` (`content`, `user`, `isRetweet`, `RetweetSource`) VALUES ( ? , ? , '0', '0')";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, content);
		stat.setString(2, (String)userInfo.get("uid"));
		
		int resultCode = stat.executeUpdate();
		
		if(resultCode==0)
			return false;
		else
			return true;
	}
	// statuses/repost	转发一条微博信息
	public boolean repost(HttpSession session, String mid, String content) throws ClassNotFoundException, SQLException
	{
		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
	
		if(userInfo==null)
		return false;
		
		String sql = "INSERT INTO `b_mircoblog` (`content`, `user`, `isRetweet`, `RetweetSource`) VALUES ( ? , ? , ? , ? )";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, content);
		stat.setString(2, (String)userInfo.get("uid"));
		stat.setString(3, "1");
		stat.setString(4, mid);
		
		int resultCode = stat.executeUpdate();
		
		if(resultCode==0)
			return false;
		else
			return true;
	} 
	
	// statuses/destroy	删除微博信息
	public boolean destroy(HttpSession session, String mid) throws ClassNotFoundException, SQLException
	{
		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
	
		if(userInfo==null)
			return false;

		Boolean hasSuperPower = (Boolean)session.getAttribute("hasSuperPower");
	
		int resultCode = 0;
		
		if(hasSuperPower!=null && hasSuperPower==true)
		{
			String sql = "UPDATE `b_mircoblog` SET `isDel` = '1' WHERE `id` = ? ;";
			DBConnect con = new DBConnect();
			PreparedStatement stat = con.getPreparedStatement(sql);
			stat.setString(1, mid);
			
			resultCode = stat.executeUpdate();
			
		}
		else
		{
			String sql = "UPDATE `b_mircoblog` SET `isDel` = '1' WHERE `id` = ? AND `user` = ? ;";
			DBConnect con = new DBConnect();
			PreparedStatement stat = con.getPreparedStatement(sql);
			stat.setString(1, mid);
			stat.setString(2, (String)userInfo.get("uid"));
			
			resultCode = stat.executeUpdate();
		}
		if(resultCode==0)
			return false;
		else
			return true;
	}
}
