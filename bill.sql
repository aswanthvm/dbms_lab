set serveroutput on
declare
    units number := &units;
    bill number := 0;
begin
    if units <= 100 then
        bill:= units * 6;
    elsif units <= 300 then
        bill := (100 * 6) + ((units - 100) * 7.5);
    else
        bill := (100 * 6) + (200*7.5) + ((units - 300) * 9.25);
    end if;
    dbms_output.put_line('The electricity bill for ' || units || ' units is Rs ' || bill);
end;
/