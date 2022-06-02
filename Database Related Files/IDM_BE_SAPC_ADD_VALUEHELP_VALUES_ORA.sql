create or replace
PROCEDURE SAPC_ADD_VALUEHELP_VALUES (
                Pvalid nvarchar2,
                Pvalkey nvarchar2,
                Pvallocale nvarchar2,
                Pvaltext nvarchar2
                )
IS
  v_exists varchar2(1) := 'F';
BEGIN
/****** This stored procedure enables RT to add entries into mxi_attrValueHelp ******/
    begin
		if Pvallocale IS NULL THEN
			select 'T'
			into v_exists
			from mxi_attrValueHelp
			where valid = Pvalid and valKey = Pvalkey and valLocale is NULL;
		else
			select 'T'
			into v_exists
			from mxi_attrValueHelp
			where valid = Pvalid and valKey = Pvalkey and valLocale = Pvallocale;
		end if;
      exception
        when no_data_found then
          null;
      end;
      if v_exists = 'T' then
        if Pvallocale IS NULL THEN
            update mxi_attrValueHelp
            set valText = Pvaltext
            where valid = Pvalid and valKey = Pvalkey and valLocale is NULL;
        else
            update mxi_attrValueHelp
            set valText = Pvaltext
            where valid = Pvalid and valKey = Pvalkey and valLocale = Pvallocale;
        end if;
      else
        insert into mxi_attrValueHelp
        values(Pvalid, Pvalkey, Pvallocale, Pvaltext);
      end if;
  commit;
END;
grant execute on MXMC_OPER.SAPC_ADD_VALUEHELP_VALUES to mxmc_rt_role;
commit;