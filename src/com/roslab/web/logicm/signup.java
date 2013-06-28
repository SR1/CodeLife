package com.roslab.web.logicm;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpSession;


public class signup {

	public boolean signUp(HttpSession session, String email, String password) throws ClassNotFoundException, SQLException
	{
		if(isSignUpable(email))
		{ 
			String sql = "INSERT INTO `b_users` (`email`, `password`) VALUES ( ? , password(?));";
			DBConnect con = new DBConnect();
			PreparedStatement stat = con.getPreparedStatement(sql);
			stat.setString(1, email);
			stat.setString(2, password);
			int isSucc = stat.executeUpdate();
			String uid = null;
			if(isSucc>0)
			{
				sql = "select id from b_users where email=? and password=password(?)";
				con = new DBConnect();
				stat = con.getPreparedStatement(sql);
				stat.setString(1, email);
				stat.setString(2, password);
				ResultSet rs = stat.executeQuery();
				if(rs.next())
				{
					uid = rs.getString("id");
					rs.close();
					
					Random rd = new Random();
					int p = rd.nextInt(20);
					String plink = BasicConfig.ROOT_PATH + "/img/userface/b"+p+".jpg";
					
					sql = "INSERT INTO `b_usersInfo` (`uid`,`pic`,`nickname`) VALUES (?,?,?);";
					con = new DBConnect();
					stat = con.getPreparedStatement(sql);
					stat.setString(1, uid);
					stat.setString(2, plink);
					stat.setString(3, "注册用户"+email.substring(0,1));
					stat.executeUpdate();

					login lg = new login();
					lg.verify(session, email, password);
					

					statuses st = new statuses();
					boolean isUpdate = st.update(session, Tools.htmlEncode("终于！在今天！毅然决然地成为了一名光荣的码农！"));
					

					sql = "INSERT INTO `b_relationship` (`folloer`, `followed`, `Secret`) VALUES ( ? , ? , ?);";
					con = new DBConnect();
					stat = con.getPreparedStatement(sql);
					stat.setString(1, uid);
					stat.setString(2, uid);
					stat.setString(3, "0");
					stat.executeUpdate();
					
					session.setAttribute("userInfo", null);
					
					return true;
				}
				
			}
		}
		return false;
	}

	public boolean isSignUpable(String email) throws ClassNotFoundException, SQLException
	{
		String sql = "select count(id) from b_users where email=? ;";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, email);
		ResultSet rs = stat.executeQuery();
		
		rs.next();
		boolean isEmailExist = rs.getInt(1)>0 ? true : false;
		
		rs.close();
		return !isEmailExist;
	}
}