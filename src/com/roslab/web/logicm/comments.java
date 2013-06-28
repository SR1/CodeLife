package com.roslab.web.logicm;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

public class comments {
	
	public  ArrayList<HashMap<String, Object>> show(String mid) throws ClassNotFoundException, SQLException{

		String sql = "SELECT `b_comment`.`id`, `comment`, `commenter`, `CommentTime`, `nickname` FROM `b_comment`, `b_usersInfo` WHERE `CommentResource` = ? AND `isDel`= 0 AND `uid` = `commenter` ORDER BY `CommentTime` DESC";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, mid);
		ResultSet rs = stat.executeQuery(); 

		ArrayList<HashMap<String, Object>> comments = new ArrayList<HashMap<String, Object>>();
		while(rs.next())
		{
			HashMap<String, Object> comment = new HashMap<String, Object>();
			comment.put("cid",rs.getString("id"));
			comment.put("comment",rs.getString("comment"));
			comment.put("commenter",rs.getString("commenter"));
			comment.put("commentTime",rs.getString("CommentTime"));
			comment.put("nickname",rs.getString("nickname"));
			
			comments.add(comment);
		}
		rs.close();
		return comments;
	}
	
	public ArrayList<HashMap<String, Object>> create(HttpSession session, String mid, String comment) throws ClassNotFoundException, SQLException {
		
		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
		
		if(userInfo==null)
			return null;
		
		String sql = "INSERT INTO `b_comment` (`comment`, `commenter`, `CommentResource`) VALUES (?, ?, ?);";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1,comment);
		stat.setString(2,(String)userInfo.get("uid"));
		stat.setString(3,mid);
		
		int resultCode = stat.executeUpdate();
		
		if(resultCode!=1)
			return null;
		else
		{
			return show(mid);
		}
	}
	

	
	public boolean destroy(HttpSession session, String cid) throws ClassNotFoundException, SQLException {
		
		HashMap<String,Object> userInfo = (HashMap<String,Object>)session.getAttribute("userInfo");
		
		if(userInfo==null)
			return false;

		Boolean hasSuperPower = (Boolean)session.getAttribute("hasSuperPower");
	
		int resultCode = 0;

		if(hasSuperPower!=null && hasSuperPower==true)
		{
			String sql = "UPDATE `b_comment` SET `isDel` = '1' WHERE `id` = ? ;";
			DBConnect con = new DBConnect();
			PreparedStatement stat = con.getPreparedStatement(sql);
			stat.setString(1, cid);
			resultCode = stat.executeUpdate();
		}
		else
		{
			String sql = "UPDATE `b_comment` SET `isDel` = '1' WHERE `id` = ? AND `commenter` = ?;";
			DBConnect con = new DBConnect();
			PreparedStatement stat = con.getPreparedStatement(sql);
			stat.setString(1, cid);
			stat.setString(2,(String)userInfo.get("uid"));
			resultCode = stat.executeUpdate();
		}
		if(resultCode==0)
			return false;
		else
			return true;
	}

}
