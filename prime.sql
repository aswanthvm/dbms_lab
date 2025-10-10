SET SERVEROUTPUT ON;

DECLARE
    n NUMBER;
    i NUMBER := 2;
    flag BOOLEAN := TRUE;
BEGIN
    n := &n;

    IF n <= 1 THEN
        DBMS_OUTPUT.PUT_LINE(n || ' is not a prime number.');
    ELSE
        WHILE i <= n / 2 LOOP
            IF MOD(n, i) = 0 THEN
                flag := FALSE;
                EXIT;
            END IF;
            i := i + 1;
        END LOOP;

        IF flag THEN
            DBMS_OUTPUT.PUT_LINE(n || ' is a prime number.');
        ELSE
            DBMS_OUTPUT.PUT_LINE(n || ' is not a prime number.');
        END IF;
    END IF;
END;
/
