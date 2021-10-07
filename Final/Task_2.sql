clear screen;
SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT DNA CHAR PROMPT "Enter DNA String for question a = "

CREATE OR REPLACE PROCEDURE reverse_completement(DNA IN VARCHAR2)
IS

V_LENGTH NUMBER(10);
V_OUT VARCHAR2(10);
S_COM VARCHAR2(50);
S_INV VARCHAR2(50);
BEGIN
	V_LENGTH := LENGTH(DNA);
	FOR I IN 1..V_LENGTH
	LOOP
		V_OUT  := SUBSTR(DNA , I, 1);
		IF V_OUT = 'A' THEN
			S_COM := S_COM || 'T';
		ELSIF V_OUT = 'T' THEN
			S_COM := S_COM || 'A';
		ELSIF V_OUT = 'C' THEN
			S_COM := S_COM || 'G';
		ELSIF V_OUT = 'G' THEN
			S_COM := S_COM || 'C';
		END IF;
	END LOOP;

	V_LENGTH := LENGTH(S_COM);
	FOR I IN REVERSE 1..V_LENGTH
	LOOP
		V_OUT  := SUBSTR(S_COM, I, 1) ;
		S_INV := S_INV || V_OUT;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Text printed: ' || S_INV);

END reverse_completement;
/


CREATE OR REPLACE PROCEDURE Humming_dis(DNA IN VARCHAR2, T IN VARCHAR2)
IS

V_LENGTH NUMBER(10);
V_OUT VARCHAR2(10);
DIST INT;

BEGIN
	DIST := 0;
	V_LENGTH := LENGTH(DNA);
	FOR I IN REVERSE 1..V_LENGTH
	LOOP
		IF SUBSTR(DNA, I, 1) != SUBSTR(T, I, 1) THEN
			DIST := DIST + 1;
		END IF;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE('HUMMING DISTANCE = ' || DIST);
END Humming_dis;
/





---MAIN

DECLARE
	DNA VARCHAR2(50);

BEGIN
	DNA := '&DNA';
	reverse_completement(DNA);
	DBMS_OUTPUT.PUT_LINE('===========================================');

END;
/



ACCEPT DNA CHAR PROMPT "A DNA String S (FOR Q. 2(B)): "
ACCEPT T CHAR PROMPT "A DNA String T (FOR Q. 2(B)): "

DECLARE
	DNA VARCHAR2(50);
	T VARCHAR2(50);

BEGIN
	DNA := '&S';
	T := '&T';
	Humming_dis(DNA, T);

END;
/
