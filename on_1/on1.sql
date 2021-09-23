SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
	newname money.name%TYPE := '&NAME' ;
	cnt number := 0;

BEGIN
		For i in (select id, name, taka from money where name = newname) LOOP
		DBMS_OUTPUT.PUT_LINE('Money');
		DBMS_OUTPUT.PUT_LINE(i.id||' '||i.name||' '||i.taka);
		cnt := 1;
		END LOOP;
		
		For j in (select id, name, taka from deposit where name = newname) LOOP
		DBMS_OUTPUT.PUT_LINE('Deposit');
		DBMS_OUTPUT.PUT_LINE(j.id||' '||j.name||' '||j.taka);
		cnt := 1;
		END LOOP;

		if cnt = 0 then 
		DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
		end if;

END;
/	