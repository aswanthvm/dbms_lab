DECLARE
    num NUMBER := &num;
    rev NUMBER := 0;
    rem NUMBER;
    temp NUMBER;
BEGIN
    temp := num;
    WHILE temp > 0 LOOP
        rem := MOD(temp, 10);
        rev := rev * 10 + rem;
        temp := temp / 10;
    END LOOP;

    IF num = rev THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is a Palindrome');
    ELSE
        DBMS_OUTPUT.PUT_LINE(num || ' is Not a Palindrome');
    END IF;
END;
/
