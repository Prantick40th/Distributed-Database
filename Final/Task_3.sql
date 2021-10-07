--CREATED BY: G. M. Shahariar
--SYSTEM DATE: 04-OCT-2021 04:39 AM
clear screen;
SET VERIFY OFF;
SET SERVEROUTPUT ON;
drop table APPS;

create table APPS(APP_ID number, APP_NAME VARCHAR2(12), RELEASE_DATE DATE);

insert into APPS values(100,'SKYPE','19-MAR-1990');
insert into APPS values(200,'ZOOM','21-JAN-1995');
insert into APPS values(1000,'MESSENGER','3-JUL-1989');
insert into APPS values(100,'SKYPE','19-MAR-1990');
insert into APPS values(2,'SIGNAL', '21-FEB-2015');
insert into APPS values(300,'TELEGRAM', '10-NOV-2014');

commit;
select * from APPS;

CREATE OR REPLACE PACKAGE APP_SEPARATE AS
    PROCEDURE FIND_APPS(AppID IN APPS.APP_ID%TYPE);
END APP_SEPARATE;
/

CREATE OR REPLACE PACKAGE BODY APP_SEPARATE AS
    PROCEDURE FIND_APPS(AppID IN APPS.APP_ID%TYPE)
    IS
    
    CAL_YER INT;
    RELEASE_DATE APPS.RELEASE_DATE%TYPE;
    
    BEGIN
        SELECT RELEASE_DATE INTO RELEASE_DATE FROM APPS WHERE APP_ID = AppID;
        
        CAL_YER = (SYSDATE - RELEASE_DATE) / 365;
         
        IF CAL_YER > 12 THEN
            DBMS_OUTPUT.PUT_LINE('More than 12 years');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Not More than 12 years');
        END IF:
        
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Multiple rows returned');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Other error');
    END;

END APP_SEPARATE;
/
