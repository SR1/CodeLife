package com.roslab.web.logicm;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;


public class users {
	// users/show	获取用户信息
	public HashMap<String,Object> show(String uid) throws ClassNotFoundException, SQLException
	{ 
		String sql = "select `uid`, `nickname`, `sign`, `gender`, `info`,`pic` from `b_usersInfo` where `uid` = ?";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid);
		ResultSet rs = stat.executeQuery();

		if(rs.next())
		{
			HashMap<String,Object> userInfo = new HashMap<String, Object>();
		
			userInfo.put("uid",rs.getString(1));
			userInfo.put("username",rs.getString(2));
			userInfo.put("signature",rs.getString(3));
			userInfo.put("gender",rs.getString(4));
			userInfo.put("info",rs.getString(5));
			userInfo.put("pic",rs.getString("pic"));
			
			rs.close();
			
			userInfo.put("follower",followerNum(uid));
			userInfo.put("folloed",followedNum(uid));
			userInfo.put("message",mircoblogNum(uid));
		
			return userInfo;
		}
		rs.close();
		return null;
	}
	
	public String followerNum (String uid) throws ClassNotFoundException, SQLException
	{
		String sql = "SELECT COUNT(`folloer`) num FROM `b_relationship` WHERE `Secret` = '0' AND `followed` = ? AND `folloer` <> ? ";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid);
		stat.setString(2, uid);
		ResultSet rs = stat.executeQuery();
		
		String num ;
		if(rs.next())
		{
			num = rs.getString("num");
		}
		else
		{
			num = "0";
		}
		rs.close();
		return num;
	}
	
	public String followedNum (String uid) throws ClassNotFoundException, SQLException
	{
		String sql = "SELECT COUNT(`followed`) num FROM `b_relationship` WHERE `Secret` = '0' AND `folloer` = ? AND `followed` <> ? ";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid);
		stat.setString(2, uid);
		ResultSet rs = stat.executeQuery();
		
		String num ;
		if(rs.next())
		{
			num = rs.getString("num");
		}
		else
		{
			num = "0";
		}
		rs.close();
		return num;
	}
	
	public String mircoblogNum (String uid) throws ClassNotFoundException, SQLException
	{
		String sql = "SELECT COUNT(`id`) num FROM `b_mircoblog` WHERE `isDel`= 0 AND `user` = ? ;";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid);
		ResultSet rs = stat.executeQuery();
		
		String num ;
		if(rs.next())
		{
			num = rs.getString("num");
		}
		else
		{
			num = "0";
		}
		rs.close();
		return num;
	}
	
	
}
