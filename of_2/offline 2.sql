/* 
Q: Show faculty name taking database and 
check if the faculty takes more than 2 courses. 
*/

SET SERVEROUTPUT ON;

DECLARE
	faculty_id faculty.fid %TYPE;
	faculty_name faculty.fname %TYPE;
	cnt number(4) := 0;
BEGIN
	select course.fid into faculty_id
	from course
	where cname='Database';
	
	select faculty.fname into faculty_name 
	from faculty
	where fid=faculty_id;
	
	
	FOR t IN 
	(SELECT cname from course where fid=faculty_id)
	LOOP
		DBMS_OUTPUT.PUT_LINE(faculty_name||' -> ' ||t.cname);
	END LOOP;
	
	select count(course.fid) into cnt
	from course
	where fid=faculty_id
	group by fid;
	
	DBMS_OUTPUT.NEW_LINE;
	DBMS_OUTPUT.NEW_LINE;
	
	CASE
		when cnt = 2 then 
			DBMS_OUTPUT.PUT_LINE('He takes 2 courses');
		when cnt > 2 then 
			DBMS_OUTPUT.PUT_LINE('He takes more than 2 courses');
		else
			DBMS_OUTPUT.PUT_LINE('He takes only 1 course');
	END CASE;
	
END;
/