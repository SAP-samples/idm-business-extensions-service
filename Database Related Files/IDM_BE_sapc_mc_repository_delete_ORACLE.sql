create or replace
PROCEDURE SAPC_MC_REPOSITORY_DELETE (Prepid number)
IS
  rc number;
BEGIN
/****** This stored procedure enables RT to call MC_REPOSITORY_DELETE ******/

  MC_REPOSITORY_DELETE (Prepid, 0, rc);
END;
create or replace synonym MXMC_RT.SAPC_MC_REPOSITORY_DELETE for MXMC_OPER.SAPC_MC_REPOSITORY_DELETE;
grant execute on MXMC_OPER.SAPC_MC_REPOSITORY_DELETE to mxmc_rt_role;
commit;