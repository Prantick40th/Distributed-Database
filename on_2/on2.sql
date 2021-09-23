SET SERVEROUTPUT ON;
SET VERIFY OFF;  

ACCEPT EID NUMBER PROMPT "ENTER YOUR EID = "


CREATE OR REPLACE FUNCTION MINIMUM_BUDGET(n IN DEPT.budget%TYPE, id IN DEPT.did%TYPE)
RETURN DEPT.budget%TYPE
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
/


CREATE OR REPLACE PROCEDURE SEARCHING_LOOP(input_id IN works.eid%TYPE)
IS
checker int := 0;
minBudget DEPT.budget%TYPE := 9999999;

BEGIN
    FOR i IN (
        SELECT * FROM works
    ) LOOP
        IF i.eid = input_id THEN
            checker := 1;
            minBudget := MINIMUM_BUDGET(minBudget, i.did);
        END IF;
	END LOOP;
	
    IF checker = 1 THEN
        dbms_output.put_line(input_id||' '||minBudget);  
    ELSE
        dbms_output.put_line('Not Found');    
    END IF;
END SEARCHING_LOOP;
/

DECLARE
    input_id int := 0;
BEGIN 
    input_id := &EID;
    SEARCHING_LOOP(input_id);
END;
/