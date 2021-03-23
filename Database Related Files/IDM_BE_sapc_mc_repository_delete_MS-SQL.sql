USE [MXMC_db]
GO
/****** Object:  StoredProcedure [dbo].[SAPC_MC_REPOSITORY_DELETE] 
This stored procedure enables RT to write to call mc_repository_delete as the original stored procedure has return value, it cannot be called directly ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SAPC_MC_REPOSITORY_DELETE]
	@Prepid int
AS
	exec dbo.MC_REPOSITORY_DELETE @Prepid, 0, null
GO

grant execute on [dbo].[SAPC_MC_REPOSITORY_DELETE] to mxmc_rt_role
GO