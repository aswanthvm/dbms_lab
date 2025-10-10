DECLARE
    a NUMBER := &num1;
    b NUMBER := &num2;
    c NUMBER := &num3;
    largest NUMBER;
BEGIN
    IF (a >= b) AND (a >= c) THEN
        largest := a;
    ELSIF (b >= a) AND (b >= c) THEN
        largest := b;
    ELSE
        largest := c;
    END IF;

    DBMS_OUTPUT.PUT_LINE('The largest number is: ' || largest);
END;
/
