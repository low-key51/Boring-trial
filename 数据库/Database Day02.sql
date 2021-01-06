-- show variables like '%time_zone';

-- select * from datatype;

 -- set time_zone='+8:00';

-- SELECT * from datatype;

insert into emp(emp_name, emp_age) values('小张', 23);

insert into emp values(3,'小李',22);  -- 如果没有指定要插入哪些字段，就是所有字段插入，按默认字段顺序

insert into emp(emp_name) values('小陈'); -- 当字段可以为null的时候可以不用插入；不为null，但是有默认值也可以不用插入


select * from emp;


select * from student;

select * from student where stu_name = '邓智友'; -- 查询姓名是邓智友的学生

select * from student where stu_sex != 1; -- 查询性别不等于1的学生（女生）
select * from student where stu_sex <> 1; -- 不等于的另一种写法

select * from student where stu_age > 20;  -- 查询年龄大于20（不包含）的学生
select * from student where stu_age >= 20; -- 查询年龄大于等于20的学生

select * from student where stu_name like '%邓%'; -- 模糊查询，用like,  内容用%代替模糊内容
select * from student where stu_name like '邓%';
select * from student where stu_name like '%友';

select * from student where stu_birthday is null;   -- 查询生日为null的学生
select * from student where stu_birthday is not null;  -- 查询生日不为null的学生

select * from student where stu_id in(2,4,5);  -- 查询编号为2，4，5的学生
select * from student where stu_id not in(2,4,5); -- 查询编号不在列表中的学生（不是2，4，5）


select * from student where stu_age>18 and stu_sex=1;  -- 查询18岁以上的男生
select * from student where stu_id =2 or stu_id=4 or stu_id=5; -- 查询学生编号等于2，或者等于4， 或者等于5
select * from student where (stu_id =2 or stu_id=4 or stu_id=5) and stu_age>=18; -- 如果多个条件，关系不清楚时通过小括号使添加更加清晰

/*
每页（page）显示两行(rows)：
第一页：1，2， 开始0 = （page-1)*rows  
第二页：3，4， 开始2 = (2-1)*2
第三页：5，6， 开始4 = (3-1)*2
*/
select * from student limit 0,2; -- limt第一个参数是起始行（0开始），第二个参数是查询多少行
select * from student limit 2,2; -- 查询第二页
select * from student limit 4,2; -- 查询第三页

select stu_name,stu_age from student; -- 按指定字段名查询
select stu_name as 姓名, stu_age as 年龄 from student; -- 给字段名起个别名
select stu_name 姓名, stu_age 年龄 from student; -- 别名的简写方式（省略as）

select count(*) from student; -- 统计表的总记录

select distinct stu_age from student; -- distinct 去掉重复记录

select * from student order by stu_age; -- order by ,排序,默认是升序
select * from student order by stu_age desc; -- 降序
/*
多个字段排序，首先按前面字段排序，如果相同再按后面一个字段排序
每个字段可以单独设置升序或降序。升序是asc， 不指明升序还是降序情况默认用的asc
*/
select * from student order by stu_age desc, stu_name asc; 
select * from student where stu_sex=1 ORDER BY stu_age; -- 如果排序和条件查询一起使用，order by 要放到where 后面

select stu_sex, count(*) from student group by stu_sex; -- 按性别分组，查询每种性别的数量
select stu_sex, max(stu_age) from student group by stu_sex; -- 按性别分组，查询每种性别最大的年龄
select stu_sex, min(stu_age) from student group by stu_sex; -- 按性别分组，查询每种性别最大的年龄
select stu_sex, avg(stu_age) from student group by stu_sex; -- 按性别分组，查询每种性别平均年龄
select stu_sex, SUM(stu_age) from student group by stu_sex; -- 按性别分组，查询每种性别求和

select stu_sex, SUM(stu_age) from student group by stu_sex order by stu_sex; -- 分组和order by 结合使用
select stu_sex, SUM(stu_age) from student where 1=1 group by stu_sex ; -- 分组和where条件结合使用，where也要放到group by 前面
select stu_sex, avg(stu_age) avg_age from student where 1=1 group by stu_sex HAVING avg_age>20; -- 对分组的结果再条件筛选用having


-- 数字相关函数
select ROUND(dt_float) from datatype  -- 取整,四舍五入
select round(3.14);

-- 字符串相关函数
select REPLACE('123456789','45','四五'); -- 替换字符串
select trim('  fdjsak   ');  -- 去掉字符串前后空格
select SUBSTR('1234567890', 4, 2); -- 截取字符串
select RIGHT('1234567890',3); -- 截取字符串右边几位
select LEFT('1234567890',3);  -- 截取字符串左边几位
select LOCATE('56','1234567890'); -- 查找一个子字符串在另一个字符串中的位置
select INSTR('1234567890','56'); -- 查找一个子字符串在另一个字符串中的位置
select LENGTH('1234567890中文'); -- 返回字符串的长度，中文字符占3个长度
select CONCAT('Hello ','HQYJ ' , '.'); -- 字符串拼接

-- 日期相关函数
select DATE_ADD(now(), INTERVAL 1 DAY); -- 日期加上一个段时间（年，月， 日，时，分，秒）
select DATE_ADD(now(), INTERVAL -1 DAY); -- 加一个负值，就相当于是减
select DATEDIFF(now(), '2020-1-1'); -- 两个日期相减，得到相差的天数
select year(now());
select MONTH(now());
select day(now());
select HOUR(now());
select MINUTE(now());
select SECOND(now());
select LAST_DAY(now()); -- 返回指定日期的最后一天
select DAYOFYEAR(now()); -- 返回指定日期在一年中是第几天
select DAYOFWEEK(now()); -- 返回星期几
select DAYOFMONTH(now());  -- 返回指定日期是当月的第几天



