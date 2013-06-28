package com.roslab.web.logicm;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

public class friendships {

	public ArrayList<HashMap<String, Object>> friends(String uid) throws ClassNotFoundException, SQLException
	{ 
		String sql = "SELECT `uid`, `nickname`, `sign`, `gender`, `info`, `follower`, `followed`,`pic` FROM `b_usersInfo` WHERE `uid` IN (SELECT `followed` FROM `b_relationship` WHERE `Secret`='0' AND `folloer`= ? AND `followed` <> ?);";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid);
		stat.setString(2, uid);
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> friends = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{ 
			HashMap<String,Object> userInfo = new HashMap<String, Object>();
			
			userInfo.put("uid",rs.getString(1));
			userInfo.put("username",rs.getString(2));
			userInfo.put("signature",rs.getString(3));
			userInfo.put("gender",rs.getString(4));
			userInfo.put("info",rs.getString(5));
			userInfo.put("follower",rs.getString(6));
			userInfo.put("folloed",rs.getString(7));
			userInfo.put("pic",rs.getString("pic"));
		
			friends.add(userInfo);
		}
		rs.close();
		return friends;
	}
	public ArrayList<HashMap<String, Object>> secret_friends(HttpSession session) throws ClassNotFoundException, SQLException
	{
		ArrayList<HashMap<String, Object>> friends = new ArrayList<HashMap<String, Object>>();
		HashMap<String,Object> myInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
		if(myInfo==null)
			return friends;
		
		String sql = "SELECT `uid`, `nickname`, `sign`, `gender`, `info`, `follower`, `followed`,`pic` FROM `b_usersInfo` WHERE `uid` IN (SELECT `followed` FROM `b_relationship` WHERE `folloer`= ? AND `followed` <> ? AND `Secret` <> '0')";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);

		
		String myuid = (String)myInfo.get("uid");
		stat.setString(1, myuid);
		stat.setString(2, myuid);
		
		ResultSet rs = stat.executeQuery();
		while(rs.next())
		{
			HashMap<String,Object> userInfo = new HashMap<String, Object>();
			
			userInfo.put("uid",rs.getString(1));
			userInfo.put("username",rs.getString(2));
			userInfo.put("signature",rs.getString(3));
			userInfo.put("gender",rs.getString(4));
			userInfo.put("info",rs.getString(5));
			userInfo.put("follower",rs.getString(6));
			userInfo.put("followed",rs.getString(7));
			userInfo.put("pic",rs.getString("pic"));
		
			friends.add(userInfo);
		}
		rs.close();
		return friends;
	}
	
	public ArrayList<HashMap<String, Object>> followers(String uid) throws ClassNotFoundException, SQLException
	{
		String sql = "SELECT `uid`, `nickname`, `sign`, `gender`, `info`, `follower`, `followed`,`pic` FROM `b_usersInfo` WHERE `uid` IN (SELECT `folloer` FROM `b_relationship` WHERE `Secret`='0' AND `followed`= ? AND `folloer` <> ?);";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid);
		stat.setString(2, uid);
		ResultSet rs = stat.executeQuery();
		ArrayList<HashMap<String, Object>> followers = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String,Object> userInfo = new HashMap<String, Object>();
			
			userInfo.put("uid",rs.getString(1));
			userInfo.put("username",rs.getString(2));
			userInfo.put("signature",rs.getString(3));
			userInfo.put("gender",rs.getString(4));
			userInfo.put("info",rs.getString(5));
			userInfo.put("follower",rs.getString(6));
			userInfo.put("followed",rs.getString(7));
			userInfo.put("pic",rs.getString("pic"));
		
			followers.add(userInfo);
		}
		rs.close();
		return followers;
	}
	
	public boolean destroy(HttpSession session, String uid) throws ClassNotFoundException, SQLException
	{
		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
		
		if(userInfo==null)
			return false;
		
		String myuid = (String)userInfo.get("uid");
		if(isFollowed(myuid,uid))
		{
			String sql = "DELETE FROM `b_relationship` WHERE `folloer` = ? AND `followed` = ? ;";
			DBConnect con = new DBConnect();
			PreparedStatement stat = con.getPreparedStatement(sql);
			stat.setString(1, myuid);
			stat.setString(2, uid);
			int resultCode = stat.executeUpdate();
			if(resultCode>0)
			{
//				sql = "UPDATE `b_usersInfo` SET `follower` = (`follower`-1) WHERE `uid` = 2; " +
//					  "UPDATE `b_usersInfo` SET `followed` = (`followed`-1) WHERE `uid` = 1; " +
//					  "UPDATE `b_usersInfo` SET `followed` = 0 WHERE `followed` < 0; " +
//					  "UPDATE `b_usersInfo` SET `follower` = 0 WHERE `follower` < 0;";
//				stat = con.getPreparedStatement(sql);
//				stat.setString(1, uid);
//				stat.setString(2, myuid);
//				stat.executeUpdate();
				return true;
			}
			else
				return false;
		}
		
		return false;
	}
	
	public boolean create(HttpSession session, String uid, String secret) throws ClassNotFoundException, SQLException
	{
		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
		
		if(userInfo==null)
			return false; 
		
		String myuid = (String)userInfo.get("uid");
		if(!isFollowed(myuid,uid))
		{
			String sql = "INSERT INTO `b_relationship` (`folloer`, `followed`, `Secret`) VALUES ( ? , ? , ?);";
			DBConnect con = new DBConnect();
			PreparedStatement stat = con.getPreparedStatement(sql);
			stat.setString(1, myuid);
			stat.setString(2, uid);
			stat.setString(3, secret);
			int resultCode = stat.executeUpdate();
			if(resultCode>0)
			{
//				sql = "UPDATE `b_usersInfo` SET `follower` = `follower`+1 WHERE `uid` = 2; " +
//					  "UPDATE `b_usersInfo` SET `followed` = `followed`+1 WHERE `uid` = 1;";
//				stat = con.getPreparedStatement(sql);
//				stat.setString(1, uid);
//				stat.setString(2, myuid);
				return true;
			}
			else
				return false;
		}
		
		return false;
	}
	
	public static boolean isFollowed(String uid1, String uid2) throws ClassNotFoundException, SQLException
	{ 
		String sql = "SELECT COUNT(`id`) FROM `b_relationship` WHERE `folloer` = ? AND `followed` = ? ;";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid1);
		stat.setString(2, uid2);
		ResultSet rs = stat.executeQuery();
		rs.next();
		boolean isFollowed = rs.getInt(1)>0?true:false;
		rs.close();
		
		return isFollowed;
	}
}
