/* 创建两个一对多关联表：*/
create table t_stu( 
	s_id int not null auto_increment primary key comment '学生编号',
	s_name varchar(50) not null comment '学生姓名',  
	s_sex int not null default 1 comment '性别。1-男，0-女',
	s_age int not null default 0 comment '学生年龄',
	c_id int not null comment '班级编号'
);

create table t_class(
	c_id int not null auto_increment primary key comment '班级编号',
	c_name varchar(50) not null comment '班级名称'
);


-- 多表关联查询
select s.*, c.c_name from t_stu s, t_class c  where s.c_id=c.c_id; -- 简化的内联
select s.*, c.c_name from t_stu s, t_class c where s.c_id = c.c_id and s.s_age>21; -- 关联查询可以使用其它查询条件
select s.*, c.c_name from t_stu s, t_class c where s.c_id = c.c_id order by s.s_age desc; -- 关联查询可以排序
select count(*) total, c.c_name from t_stu s, t_class c where s.c_id = c.c_id GROUP BY c.c_id; -- 关联查询使用分组
select count(*) total, c.c_name from t_stu s, t_class c where s.c_id = c.c_id GROUP BY c.c_id HAVING total>1;

-- 内联，外联，交叉联接
select s.*, c.c_name from t_stu s inner join t_class c on s.c_id=c.c_id; -- 内联查询
SELECT s.*, c.c_name from t_stu s left join t_class c on s.c_id=c.c_id;  -- 左联
select s.*, c.c_name from t_stu s right join t_class c on s.c_id=c.c_id; -- 右联
select s.*, c.c_name from t_stu s cross join t_class c; -- 交叉连接，笛卡尔

-- 子查询
select s.*,(select c.c_name from t_class c where c.c_id=s.c_id) c_name from t_stu s; -- 子查询作为字段
select tmp.* from (select sin.* from t_stu sin where sin.s_sex=1) tmp  where tmp.s_age>22;  -- 子查询作为临时表
select s.* from t_stu s where s.c_id in (select c.c_id from t_class c where c.c_name like '%计科%'); -- 子查询作为where条件

-- 子查询的应用
insert into student(stu_name,stu_age,stu_sex,stu_birthday) 
	(select stu_name,stu_age,stu_sex,stu_birthday from student);  -- 插入语句的values用子查询
	
create table new_student (select * from student); -- 用子查询来创建一个新表

-- 利用not in方式实现一个表存在，另一给表不存在
select c.* from t_class c where c.c_id not in(select DISTINCT s.c_id from t_stu s); 
-- 利用外联方式通过判断null 实现一个表存在，另一个表不存在
select s.*,c.c_name from t_stu s right join t_class c on s.c_id=c.c_id where s.s_name is null;
-- 利用exists(只要子查询返回记录，结果就为真，当前这条记录就会被查出来)实现一个表存在，另一个表不存在
select c.c_name from t_class c where not EXISTS(select s.* from t_stu s where s.c_id=c.c_id);


-- 查询表里重复的记录
select s.* from t_stu s where s.s_name in(
	select tmp.s_name from 
		(select count(*) total,s.s_name from t_stu s GROUP BY s.s_name HAVING total>1) tmp
);


/*
创建多对多关系表：产品表product, 功能表func, 中间表product_func
*/
create table product(
	p_id int not null auto_increment PRIMARY key comment '产品编号',
	p_name varchar(50) not null comment '产品名称'
);

create table func(
	f_id int not null auto_increment primary key comment '功能编号',
	f_name varchar(50) not null comment '功能名称'
);

create table product_func(
	p_id int not null comment '产品编号',
	f_id int not null comment '功能编号'
);

insert into product(p_name) values('华为P40');
insert into product(p_name) values('华为M40');
insert into product(p_name) values('小米10');
insert into product(p_name) values('VIVO X10');
insert into product(p_name) values('OPPO R10');
insert into product(p_name) values('苹果12');

insert into func(f_name) values('智能手机');
insert into func(f_name) values('大屏手机');
insert into func(f_name) values('拍照手机');
insert into func(f_name) values('5G手机');
insert into func(f_name) values('音乐手机');
insert into func(f_name) values('超长待机');

insert into product_func(p_id,f_id) values(1,1);
insert into product_func(p_id,f_id) values(1,3);
insert into product_func(p_id,f_id) values(1,4);
insert into product_func(p_id,f_id) values(3,1);
insert into product_func(p_id,f_id) values(3,6);
insert into product_func(p_id,f_id) values(4,3);
insert into product_func(p_id,f_id) values(4,5);

select p.*,f.* 
	from product p, func f, product_func pf
		where p.p_id = pf.p_id and f.f_id = pf.f_id;
			-- and p.p_name='华为P40';


-- 上一天的作业

-- 1
select * from employee where emp_deptno=30;
   
-- 2 
select emp_name,emp_no,emp_deptno,emp_job from employee where emp_job='clerk';
  
-- 3 
select * from employee where emp_comm>emp_salary;
  
-- 4  
select * from employee where emp_comm>(emp_salary*0.6);

  
-- 5
select * from employee where (emp_deptno=10 and emp_job='manager') or (emp_deptno=20 and emp_job='clerk') ;

-- 6 
select * from employee where (emp_deptno=10 and emp_job='manager') or (emp_deptno=20 and emp_job='clerk') or (emp_job!='clerk'and emp_job!='maneger' and emp_salary>2000);
  
-- 7 
select DISTINCT emp_job from employee where emp_comm is not null;
   
-- 8
select * from employee where emp_comm is null or emp_comm<100;
  
-- 9 
 select * from employee where datediff(LAST_DAY(emp_hiredate),emp_hiredate)=2;
  
-- 10
--先使用MONTHS_BETWEEN(SYSDATE,hiredate)求出雇佣的月份，然后除以12的到雇佣的年份  
select * from employee where YEAR(now())-year(emp_hiredate)>12;
   
-- 11
SELECT CONCAT(UPPER(SUBSTR(emp_name,1,1)),LOWER(SUBSTR(emp_name,2))) AS out_put FROM employee;
  
-- 12
select * from employee where LENGTH(emp_name)=5; 
-- 13
select * from employee where emp_name like '%R%';
-- 14
select SUBSTR(emp_name,1,3) from employee;
-- 15
select REPLACE(emp_name,'a','A') from employee;
-- 16
SELECT  * from employee where YEAR(now())-year(emp_hiredate)>=10;
-- 17
select * from employee ORDER BY emp_name;
-- 18
select emp_name,emp_hiredate from employee ORDER BY emp_hiredate;
-- 19
select emp_name,emp_job,emp_salary from employee ORDER BY emp_job desc,emp_salary asc;
-- 20、显示所有员工的姓名、加入公司的年份和月份、按接受所在雇佣月排序，若月的相同则按最早年份的员工排在最前面  
-- 本程序需要求出所雇的日期的年份和月份，然后再来显示  to_char()
select emp_name,YEAR(emp_hiredate),MONTH(emp_hiredate) from employee order by MONTH(emp_hiredate),YEAR(emp_hiredate) asc;
  
-- 21、显示一个月为30天的情况下，所有员工的日薪，忽略余数  trunc()
select round(emp_salary/30) from employee;

-- 22
select emp_name from employee where MONTH(emp_hiredate)=2;
-- 23
select emp_name, DATEDIFF(NOW(),emp_hiredate) from employee;
-- 24
SELECT * from employee where emp_name like '%A%';




