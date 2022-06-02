create or replace
PROCEDURE sapc_mxp_xadd_link_audit (
                Plinkid number,
                Poperation number,
                Presponsible number,
                Pauditid number,
                Preason nvarchar2,
 Paddinfo nvarchar2
                )
IS
  c1 number;
BEGIN
/****** This stored procedure enables RT to write to link audit from toDB passes (for approval enhancement); since the original stored procedure mxp_xadd_link_audit has return value, it cannot be called directly ******/

  mxp_xadd_link_audit (Plinkid,Poperation,Presponsible,Pauditid,Preason,Paddinfo,null,null,null, c1);
  commit;
END;
grant execute on MXMC_OPER.SAPC_MXP_XADD_LINK_AUDIT to mxmc_rt_role;
commit;
