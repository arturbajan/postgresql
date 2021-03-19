-- FUNCTION: public.fx_yhq(date, character varying)

-- DROP FUNCTION public.fx_yhq(date, character varying);

CREATE OR REPLACE FUNCTION public.fx_yhq(
	dt_arg date,
	param character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare v_ans character varying;
begin 

IF upper(param)='Y' then  
v_ans:=to_char(dt_arg,'YYYY');

end if;

IF upper(param)='Q' then 
v_ans:=to_char(dt_arg,'YYYY')||'_Q'||to_char(dt_arg,'Q');
end if;

IF upper(param)='H' and to_number(to_char(dt_arg,'Q'),'99') <3 then 
v_ans:=to_char(dt_arg,'YYYY')||'_H1';
end if;
IF upper(param)='H' and to_number(to_char(dt_arg,'Q'),'99') >2 then 
v_ans:=to_char(dt_arg,'YYYY')||'_H2';
end if;

return v_ans;
end;
$BODY$;

ALTER FUNCTION public.fx_yhq(date, character varying)
    OWNER TO postgres;

COMMENT ON FUNCTION public.fx_yhq(date, character varying)
    IS 'param Y->YEAR,  H->HALF, Q->QUARTER ';
