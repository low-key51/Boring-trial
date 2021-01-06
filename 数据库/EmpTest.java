package com.hqyj.jdbc;

import java.sql.Connection;

import org.junit.Before;
import org.junit.Test;

import com.hqyj.jdbc.dao.EmpDao;
import com.hqyj.jdbc.entity.Emp;

public class EmpTest {
	private Connection connection;
	private EmpDao empDao;
	
	@Before
	public void init() {
		connection = DbUtil.getConnection();
		empDao = new EmpDao();
		
	}
	
	@Test
	public void testInsert() {
		Emp emp = new Emp("Jack", 21);
		empDao.insertEmp(connection, emp);
		
	}
	
	
}
