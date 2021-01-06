package com.hqyj.jdbc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.hqyj.jdbc.entity.Emp;

//Dao:  data access object
public class EmpDao {
	
	public void insertEmp(Connection conn, Emp emp) {
		String sql = "insert into emp(emp_name,emp_age) values(?,?)";
		try {
			PreparedStatement statement = conn.prepareStatement(sql);
			statement.setString(1, emp.getEmpName());
			statement.setInt(2, emp.getEmpAge());
			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
