SET SERVEROUTPUT ON;
SET VERIFY OFF;

DECLARE	
	A money.id %TYPE := &ID;
	B money.name %TYPE := '&NAME';
	C money.taka %TYPE := &TAKA;

BEGIN
	FOR i in 1..5 LOOP
	insert into money values(A,B,C);
	A := A+1;
	END LOOP;
	
END;
/