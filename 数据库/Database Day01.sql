-- show databases; -- 注释
-- show tables;
-- select * from  student;

-- 使用SQL创建数据库test，用utf8编码
/*
CREATE DATABASE test 
	DEFAULT CHARACTER SET utf8
	COLLATE utf8_general_ci;
	*/
	
	-- 删除数据库
-- 	drop database test;

-- 创建表
CREATE TABLE emp(
	emp_id int not null auto_increment PRIMARY KEY comment '员工编号',
	emp_name varchar(50) not null comment '员工姓名',
	emp_age int DEFAULT 0 comment '年龄'
);
