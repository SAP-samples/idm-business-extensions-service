USE [MXMC_db]
GO
/****** Object:  StoredProcedure [dbo].[SAPC_MXP_ATTR_DELETE] 
This stored procedure enables RT to write to call mc_repository_delete as the original stored cannot be called directly ******/

CREATE PROCEDURE [dbo].[SAPC_MXP_ATTR_DELETE]
	@Pattrid int
AS
	exec dbo.MXP_ATTR_DELETE @Pattrid, 0, null
GO

grant execute on [dbo].[SAPC_MXP_ATTR_DELETE] to mxmc_rt_role
GO