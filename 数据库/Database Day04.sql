select c.*,p.* from country c, president p where c.ctr_id=p.ctr_id;


-- 修改数据
update country set ctr_name='美国' where ctr_id=1;
update new_student set stu_name='智友',stu_age=20,stu_birthday='2000-6-8' where stu_id=1;

-- 删除数据
delete from new_student where stu_id=8;
delete from new_student where stu_id>=50;

-- 删除全表数据
TRUNCATE table new_student;

-- 删除表
drop table new_student;


-- DDL（定义表结构的语句）, DML（操作数据的语句）
ALTER TABLE emp add emp_salary int not null DEFAULT 0; -- 新增一个字段
alter table emp MODIFY emp_salary varchar(10); -- 修改字段的属性
alter table emp CHANGE emp_salary emp_sal varchar(20); -- 修改字段名字或属性
alter table emp drop COLUMN emp_sal; -- 删除字段
alter table emp rename to emp_new;  -- 修改表的名称
alter table president add CONSTRAINT fk_president_country FOREIGN KEY(ctr_id) 	REFERENCES country(ctr_id); -- 添加外键
alter table president drop FOREIGN key fk_president_country; -- 删除外键

-- 创建视图
create view v_student as 
	select s.s_id,s.s_name,s.s_sex,s.s_age, c.c_name from t_stu s, t_class c  where s.c_id=c.c_id;  
-- 从视图查询数据
select * from v_student;

-- 创建索引
CREATE index idx_emp_name on emp(emp_name);

-- 存储过程
create PROCEDURE p_getage(in empid int, out empage int)
BEGIN
	select emp_age into empage from emp where emp_id=empid;
END;
-- 调用存储过程
set @id = 3;
call p_getage(@id, @age);
select @age;

-- case   when 语句
select stu_name,stu_age,	case stu_sex
		when 0 then '女'
		when 1 then '男'
		else '未知'
  END sex
	from student;

start TRANSACTION; -- 开启事务
update student set stu_age = 20 where stu_id=1;
update student set stu_age = 21 where stu_id=2;
-- commit; -- 提交事务
ROLLBACK; -- 回滚事务



-- 昨日作业
-- 学生表tblStudent（编号StuId、姓名StuName、年龄StuAge、性别StuSex）
-- 课程表tblCourse（课程编号CourseId、课程名称CourseName、教师编号TeaId）
-- 成绩表tblScore（学生编号StuId、课程编号CourseId、成绩Score）
-- 教师表tblTeacher（教师编号TeaId、姓名TeaName）

-- 1、查询“001”课程比“002”课程成绩高的所有学生的学号；
 select sc.StuId from tblScore sc ,tblScore sc1 where sc.StuId=sc1.StuId and sc.CourseId='001'and sc1.CourseId='002' and sc.Score>sc1.Score;

SELECT
	* 
FROM
	(
SELECT
	stu.stuid,
	( SELECT sc.score FROM tblscore sc WHERE sc.stuid = stu.stuid AND sc.courseid = '001' ) s001,
	( SELECT sc.score FROM tblscore sc WHERE sc.stuid = stu.stuid AND sc.courseid = '002' ) s002 
FROM
	tblstudent stu 
	) tmp 
WHERE
	tmp.s001 > tmp.s002;
	
	select stu.stuid from tblstudent stu
		where (SELECT sc.score FROM tblscore sc WHERE sc.stuid = stu.stuid AND sc.courseid = '001') > 
		(SELECT sc.score FROM tblscore sc WHERE sc.stuid = stu.stuid AND sc.courseid = '002' );
	


-- 2、查询平均成绩大于60分的同学的学号和平均成绩；
select sc.StuId,avg(sc.Score) score from tblScore sc group by sc.StuId HAVING score>60;

-- 3、查询所有同学的学号、姓名、选课数、总成绩； 

select st.StuId 学号,st.StuName 姓名,sc.c 选课数,sc.s 总成绩 
	from tblStudent st,(select sc.StuId,count(StuId) c,sum(sc.Score) s from tblScore sc group by sc.StuId) sc 
	where sc.StuId=st.StuId;
	
	select stu.stuid,stu.stuname, count(*) total,sum(sc.score) sum from tblstudent stu, tblscore sc where stu.stuid=sc.stuid
		group by stu.stuid;
	

-- 4、查询姓“李”的老师的个数； 
select count(t.TeaName) from tblTeacher t where t.TeaName like '李%';

-- 5、查询没学过“叶平”老师课的同学的学号、姓名； 
select distinct st.StuId,st.StuName from tblStudent st where st.StuId not in
	(select  st.StuId from tblStudent st,tblScore sc,tblTeacher t ,tblCourse c where st.StuId=sc.StuId and t.TeaId=c.TeaId and sc.CourseId=c.CourseId and t.TeaName ='叶平');

select stu.stuid,stu.stuname from tblstudent stu where stu.stuid not in 
	(select distinct sc.stuid from tblscore sc where sc.CourseId in
		(select c.courseid from tblteacher t,tblcourse c where t.teaname='叶平' and t.teaid=c.TeaId));



-- 6、查询学过“001”并且也学过编号“002”课程的同学的学号、姓名； 
select st.StuId,st.StuName from tblStudent st,(select sc.StuId from tblScore sc ,tblScore sc1 where sc.StuId=sc1.StuId and sc.CourseId='001'and sc1.CourseId='002') sc where sc.StuId=st.StuId; 

select stu.stuid,stu.stuname from tblstudent stu
	where stu.stuid in(select sc.stuid from tblscore sc where sc.courseid='001') 
	and stu.stuid in(select sc.stuid from tblscore sc where sc.courseid='002');

 
-- 7、查询学过“叶平”老师所教的所有课的同学的学号、姓名； 

-- select t.TeaId from tblTeacher t where t.TeaName='叶平';
-- select count(c.CourseId) from tblCourse c where c.TeaId=(select t.TeaId from tblTeacher t where t.TeaName='叶平');

SELECT 	st.StuId ,st.StuName 
FROM
	tblStudent st,
	(SELECT count( c.CourseId ) cc FROM	tblCourse c WHERE	c.TeaId = ( SELECT t.TeaId FROM tblTeacher t WHERE t.TeaName = '叶平' ) ) se,
	(SELECT	st.StuName,	count( st.StuId ) cc FROM tblStudent st,	tblScore sc,	tblTeacher t,	tblCourse c WHERE	st.StuId = sc.StuId 	AND t.TeaId = c.TeaId 	AND sc.CourseId = c.CourseId 	AND t.TeaName = '叶平' GROUP BY	st.StuName) ss
WHERE
	ss.StuName=st.StuName and ss.cc=se.cc;
	
	/*
	select stu.stuid,stu.stuname from tblstudent stu where stu.stuid in(
		select sc.stuid from tblscore sc where sc.courseid in(
			select c.courseid  from tblcourse c, tblteacher t where c.teaid = t.teaid and t.teaname='叶平'
		)
		);
	
	select count(*)  from tblcourse c, tblteacher t where c.teaid = t.teaid and t.teaname='叶平'
*/
-- ???
Select StuId,StuName From tblStudent st Where not exists
  (
   Select CourseID From tblCourse cu Inner Join tblTeacher tc On cu.TeaID=tc.TeaID 
    Where tc.TeaName='叶平' 	And CourseID not in 
    (Select CourseID From tblScore Where StuID=st.StuID)
  )
	

-- 8、查询课程编号“002”的成绩比课程编号“001”课程低的所有同学的学号、姓名； 
 select sc.StuId ,st.StuName from tblScore sc ,tblStudent st,tblScore sc1 where sc.StuId=sc1.StuId and sc.CourseId='001'and sc1.CourseId='002' and sc.Score>sc1.Score and sc.StuId=st.StuId;

-- 9、查询所有课程成绩小于60分的同学的学号、姓名；
-- select sc.StuId ,count(sc.StuId) from tblScore sc group by sc.StuId;
-- select sc.StuId ,count(sc.StuId) from tblScore sc  where sc.CourseId in(select sc.CourseId from tblScore sc)  and sc.Score<60 group by sc.StuId;
-- 
-- SELECT
-- 	es.StuId 
-- FROM
-- 	( SELECT sc.StuId, count( sc.StuId ) cc FROM tblScore sc GROUP BY sc.StuId ) es,
-- 	(SELECT	sc.StuId,	count( sc.StuId ) cc FROM tblScore sc WHERE	sc.CourseId IN ( SELECT sc.CourseId FROM tblScore sc ) 	AND sc.Score < 60 GROUP BY	sc.StuId) sf
-- 	WHERE
-- 	sf.cc=es.cc AND es.StuId=sf.StuId;
	
	select st.StuId ,st.StuName from tblStudent st,
	(
	SELECT	es.StuId FROM( SELECT sc.StuId, count( sc.StuId ) cc FROM tblScore sc GROUP BY sc.StuId ) es,(SELECT	sc.StuId ,	count( sc.StuId ) cc FROM tblScore sc WHERE	sc.CourseId IN ( SELECT sc.CourseId FROM tblScore sc ) 	AND sc.Score < 60 GROUP BY	sc.StuId) sf	WHERE sf.cc=es.cc AND es.StuId=sf.StuId
	) ss
	where ss.StuId=st.StuId;

-- 10、查询没有学全所有课的同学的学号、姓名； 
-- select count(CourseId) cc from tblCourse;
-- SELECT	st.StuName,	count( st.StuId ) cc FROM tblStudent st,	tblScore sc,	tblTeacher t,	tblCourse c WHERE	st.StuId = sc.StuId 	AND t.TeaId = c.TeaId 	AND sc.CourseId = c.CourseId  GROUP BY	st.StuName;

SELECT 	st.StuId ,st.StuName 
FROM
	tblStudent st,
	(select count(CourseId) cc from tblCourse) se,
	(SELECT	st.StuName,	count( st.StuId ) cc FROM tblStudent st,	tblScore sc,	tblTeacher t,	tblCourse c WHERE	st.StuId = sc.StuId 	AND t.TeaId = c.TeaId 	AND sc.CourseId = c.CourseId  GROUP BY	st.StuName) ss
	WHERE
	ss.StuName!=st.StuName and ss.cc=se.cc;
-- 11、查询至少有一门课与学号为“1001”的同学所学相同的同学的学号和姓名；
-- select sc.CourseId  from tblScore sc where sc.StuId=1001;
-- select distinct sc.StuId  from tblScore sc where sc.CourseId in(select sc.CourseId  from tblScore sc where sc.StuId=1001) and sc.StuId!=1001;

SELECT 	st.StuId ,st.StuName 
FROM
	tblStudent st,
	(select distinct sc.StuId cc from tblScore sc where sc.CourseId in(select sc.CourseId  from tblScore sc where sc.StuId=1001) and sc.StuId!=1001) ss
	WHERE
	 ss.cc=st.StuId;
-- 12、查询至少学过学号为“1001”同学所有课程的其他同学学号和姓名； 
-- select sc.CourseId  from tblScore sc where sc.StuId=1001;
-- select sc.StuId from tblScore sc,(select sc.CourseId  from tblScore sc where sc.StuId=1001) a where sc.CourseId=a.CourseId;
-- select aa.StuId ,count(*) cc from (select sc.StuId from tblScore sc,(select sc.CourseId  from tblScore sc where sc.StuId=1001) a where sc.CourseId=a.CourseId) aa group by aa.StuId;

select st.StuId ,st.StuName  from tblStudent st,(select aa.StuId ,count(*) cc from (select sc.StuId from tblScore sc,(select sc.CourseId  from tblScore sc where sc.StuId=1001) a where sc.CourseId=a.CourseId) aa group by aa.StuId) aaa,(select count(*) cc from tblScore sc where sc.StuId=1001)bb where aaa.cc=bb.cc and aaa.StuId!=1001 and st.StuId=aaa.StuId;
-- 13、把“SC”表中“叶平”老师教的课的成绩都更改为此课程的平均成绩； (从子查询中获取父查询中的表名，这样也行？？？？)
select c.CourseId id from tblCourse c where c.TeaId=(select t.TeaId from tblTeacher t where t.TeaName='叶平');
select sc.CourseId,avg(sc.Score) ag from tblScore sc,(select c.CourseId id from tblCourse c where c.TeaId=(select t.TeaId from tblTeacher t where t.TeaName='叶平')) aa where aa.id=sc.CourseId group by sc.CourseId;

update tblScore sc 
set sc.Score=(select sc.CourseId,avg(sc.Score) ag from tblScore sc,(select c.CourseId id from tblCourse c where c.TeaId=(select t.TeaId from tblTeacher t where t.TeaName='叶平')) aa where aa.id=sc.CourseId group by sc.CourseId).ag 
where sc.CourseId=(select sc.CourseId,avg(sc.Score) ag from tblScore sc,(select c.CourseId id from tblCourse c where c.TeaId=(select t.TeaId from tblTeacher t where t.TeaName='叶平')) aa where aa.id=sc.CourseId group by sc.CourseId).CourseId;
-- 14、查询和“1002”号的同学学习的课程完全相同的其他同学学号和姓名；  


-- 15、删除学习“叶平”老师课的SC表记录；
 

-- 16、向SC表中插入一些记录，这些记录要求符合以下条件：没有上过编号“003”课程的同学学号、'002'号课的平均成绩； 


-- 17、按平均成绩从高到低显示所有学生的“数据库”、“企业管理”、“英语”三门的课程成绩，按如下形式显示： 学生ID,,数据库,企业管理,英语,有效课程数,有效平均分 


-- 18、查询各科成绩最高和最低的分：以如下形式显示：课程ID，最高分，最低分 


-- 19、按各科平均成绩从低到高和及格率的百分数从高到低顺序 (百分数后如何格式化为两位小数??)


-- 20、查询如下课程平均成绩和及格率的百分数(用"1行"显示): 企业管理（001），马克思（002），OO&UML （003），数据库（004） 


-- 21、查询不同老师所教不同课程平均分从高到低显示 


-- 22、查询如下课程成绩第 3 名到第 6 名的学生成绩单：企业管理（001），马克思（002），UML （003），数据库（004） 格式：[学生ID],[学生姓名],企业管理,马克思,UML,数据库,平均成绩 


-- 23、统计列印各科成绩,各分数段人数:课程ID,课程名称,[100-85],[85-70],[70-60],[ <60] 


-- 24、查询学生平均成绩及其名次 


-- 25、查询各科成绩前三名的记录:(不考虑成绩并列情况)


-- 26、查询每门课程被选修的学生数 
 

-- 27、查询出只选修了一门课程的全部学生的学号和姓名 


-- 28、查询男生、女生人数 


-- 29、查询姓“张”的学生名单 


-- 31、1981年出生的学生名单(注：Student表中Sage列的类型是datetime) 
 
-- 32、查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列 


-- 33、查询平均成绩大于85的所有学生的学号、姓名和平均成绩 


-- 34、查询课程名称为“数据库”，且分数低于60的学生姓名和分数 


-- 35、查询所有学生的选课情况； 


-- 36、查询任何一门课程成绩在70分以上的姓名、课程名称和分数； 
 

-- 37、查询不及格的课程，并按课程号从大到小排列 


-- 38、查询课程编号为003且课程成绩在80分以上的学生的学号和姓名； 


-- 39、求选了课程的学生人数 


-- 40、查询选修“叶平”老师所授课程的学生中，成绩最高的学生姓名及其成绩 


-- 41、查询各个课程及相应的选修人数 


-- 42、查询不同课程成绩相同的学生的学号、课程号、学生成绩 


-- 43、查询每门功成绩最好的前两名 


-- 44、统计每门课程的学生选修人数（超过10人的课程才统计）。要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列  


-- 45、检索至少选修两门课程的学生学号 


 -- 有重复课程时用此方法(如补考)


-- 46、查询全部学生都选修的课程的课程号和课程名 


-- 47、查询没学过“叶平”老师讲授的任一门课程的学生姓名 


-- 48、查询两门以上不及格课程的同学的学号及其平均成绩 


-- 49、检索“004”课程分数小于60，按分数降序排列的同学学号 (ok)


-- 50、删除“002”同学的“001”课程的成绩 






