create or replace
PROCEDURE SAPC_SET_ATTR_ATTRVALUEHELP (
                PattrName nvarchar2,
                PuseLang int                
                )
IS
  v_exists varchar2(1) := 'F';
BEGIN
/****** This stored procedure enables RT to add entries into mxi_attrValueHelp ******/
    update mxi_attributes set sqlvaluestable = 'mxi_AttrValueHelp', sqlValuesId = PattrName, sqlValuesUseLanguage = PuseLang
    where attrName = PattrName;
  commit;
END;
grant execute on MXMC_OPER.SAPC_SET_ATTR_ATTRVALUEHELP to mxmc_rt_role;
commit;


