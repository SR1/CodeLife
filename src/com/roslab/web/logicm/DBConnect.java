package com.roslab.web.logicm;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class DBConnect { 

	PreparedStatement stat = null;
	Connection conn = null;
	  
	public DBConnect() throws ClassNotFoundException, SQLException
	{
		Class.forName(BasicConfig.DB_DRIVER); 
		conn = DriverManager.getConnection(BasicConfig.DB_URL, BasicConfig.DB_USERNAME, BasicConfig.DB_PASSWORD);
	}
	
	public PreparedStatement getPreparedStatement(String sql) throws ClassNotFoundException, SQLException
	{
		if(conn==null)
		{
			Class.forName(BasicConfig.DB_DRIVER); 
			conn = DriverManager.getConnection(BasicConfig.DB_URL, BasicConfig.DB_USERNAME, BasicConfig.DB_PASSWORD);
		} 
		 
		stat = conn.prepareStatement(sql);
		return stat;
	}
	
	protected void finalize() throws SQLException
    {
          if(stat!=null)
        	  stat.close();
          if(conn!=null)
        	  conn.close();
     }
}
