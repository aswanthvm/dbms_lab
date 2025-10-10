set serveroutput on

declare
    num1     number := &num1;
    num2     number := &num2;
    operator char(1) := '&operator';
    result   number;

begin
    case operator
        when '+' then
            result := num1 + num2;
        when '-' then
            result := num1 - num2;
        when '*' then
            result := num1 * num2;
        when '/' then
            if num2 = 0 then
                dbms_output.put_line('Error: Division by zero is not allowed.');
                return;
            else
                result := num1 / num2;
            end if;
        else
            dbms_output.put_line('Error: Invalid operator.');
            return;
    end case;

    dbms_output.put_line('Result: ' || result);

end;
/