SET SERVEROUTPUT ON;
SET VERIFY OFF;  

-- Trigger--

CREATE OR REPLACE TRIGGER trigger_insert
AFTER INSERT 
ON Works
FOR EACH ROW
DECLARE
BEGIN
	dbms_output.put_line('Row inserted Suceessfully.');
END;
/

CREATE OR REPLACE TRIGGER trigger_remove
AFTER DELETE 
ON Works
FOR EACH ROW
DECLARE
BEGIN
	dbms_output.put_line('Row deleted Suceessfully.');
END;
/

CREATE OR REPLACE TRIGGER trigger_update
AFTER UPDATE
OF pct_time
ON Works
FOR EACH ROW
DECLARE
BEGIN
	dbms_output.put_line('Row upadated Suceessfully');
END;
/

--Package create--

CREATE OR REPLACE PACKAGE mypack AS

	FUNCTION MINIMUM_BUDGET(n IN DEPT.budget%TYPE, id IN DEPT.did%TYPE)
	RETURN INT;
	
	PROCEDURE SEARCHING_LOOP(input_id IN works.eid%TYPE);
	
END mypack;
/

--Package Body--

CREATE OR REPLACE PACKAGE BODY mypack AS

	FUNCTION MINIMUM_BUDGET(n IN DEPT.budget%TYPE, id IN DEPT.did%TYPE)
	RETURN int
	IS

	amount DEPT.budget%TYPE := 0;
	newamount DEPT.budget%TYPE := n;
	BEGIN
		select budget into amount from dept where did = id;
		IF n > amount THEN
			newamount := amount;
		END IF;
		return newamount;
	END MINIMUM_BUDGET;


	PROCEDURE SEARCHING_LOOP(input_id IN works.eid%TYPE)
	IS
	checker int := 0;
	minBudget DEPT.budget%TYPE := 9999999;

	BEGIN
		FOR i IN (
			SELECT * FROM works
		) LOOP
			IF i.eid = input_id THEN
				checker := 1;
				minBudget := mypack.MINIMUM_BUDGET(minBudget, i.did);
			END IF;
		END LOOP;
		
		IF checker = 1 THEN
			dbms_output.put_line(input_id||' '||minBudget);  
		ELSE
			dbms_output.put_line('Not Found');    
		END IF;
	END SEARCHING_LOOP;

END mypack;
/

ACCEPT EID NUMBER PROMPT "ENTER YOUR EID = "

DECLARE
    input_id int := 0;
	negative EXCEPTION;
	zero EXCEPTION;
	
BEGIN 
    input_id := &EID;
	
	IF input_id < 0 THEN
		RAISE negative;
	END IF;
	
	IF input_id = 0 THEN
		RAISE zero;
	END IF;
	
    mypack.SEARCHING_LOOP(input_id);
	
	EXCEPTION
		WHEN zero THEN
		DBMS_OUTPUT.PUT_LINE('id must be greater than 0');
		WHEN ACCESS_INTO_NULL THEN
		DBMS_OUTPUT.PUT_LINE('Null not accepted');
		WHEN negative THEN
		DBMS_OUTPUT.PUT_LINE('id cannot be -ve');
		input_id := input_id *(-1);
		DBMS_OUTPUT.PUT_LINE('Put ID ' || input_id);
		WHEN INVALID_NUMBER THEN
		DBMS_OUTPUT.PUT_LINE('Use valid id ');
        WHEN OTHERS THEN
            dbms_output.put_line('Error Occoured.');
END;
/