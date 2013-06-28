package com.roslab.web.logicm;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.servlet.http.HttpSession;

import com.roslab.web.logicm.DBConnect;

public class login {

	public boolean verify(HttpSession session,String uid, String upw) throws ClassNotFoundException, SQLException
	{ 
		String sql = "select id,isSuperMan from b_users where email=? and password=password(?)";
		DBConnect con = new DBConnect();
		PreparedStatement stat = con.getPreparedStatement(sql);
		stat.setString(1, uid);
		stat.setString(2, upw);
		ResultSet rs = stat.executeQuery();
		
		HashMap<String,Object> userInfo = new HashMap<String,Object>();
		if(rs.next())
		{
			users us = new users();
			userInfo = us.show(rs.getString(1));
			session.setAttribute("userInfo", userInfo);
			
			if("1".equals(rs.getString("isSuperMan")))
			{
				session.setAttribute("hasSuperPower", true);
			}
			else
			{
				session.setAttribute("hasSuperPower", false);
			}

			rs.close();
			return true;
		}
		session.setAttribute("hasSuperPower", false);
		rs.close();
		return false;
	}
}
