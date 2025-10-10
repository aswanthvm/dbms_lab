SET SERVEROUTPUT ON;

DECLARE
    n NUMBER;
    rem NUMBER;
    sum NUMBER := 0;
BEGIN
    n := &n;

    WHILE n > 0 LOOP
        rem := MOD(n, 10);
        sum := sum + rem;
        n := FLOOR(n / 10);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Sum of digits = ' || sum);
END;
/
