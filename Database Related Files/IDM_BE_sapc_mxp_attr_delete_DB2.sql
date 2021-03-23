create or replace
PROCEDURE SAPC_MXP_ATTR_DELETE (Pattrid number)
IS
  rc number;
BEGIN
/****** This stored procedure enables RT to call MC_REPOSITORY_DELETE ******/

  MXP_ATTR_DELETE (Pattrid, 0, rc);
END;
create or replace synonym MXMC_RT.SAPC_MXP_ATTR_DELETE for MXMC_OPER.SAPC_MXP_ATTR_DELETE;
grant execute on MXMC_OPER.SAPC_MXP_ATTR_DELETE to mxmc_rt_role;
commit;