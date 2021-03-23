USE [MXMC_db]
GO
/****** Object:  StoredProcedure [dbo].[SAPC_MXP_ATTR_DELETE] 
This stored procedure enables RT to call MXP_ATTR_DELETE as the original stored procedure cannot be called directly ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SAPC_MXP_ATTR_DELETE]
	@Pattrid int
AS
	exec dbo.MXP_ATTR_DELETE @Pattrid, 0, null
GO

grant execute on [dbo].[SAPC_MXP_ATTR_DELETE] to mxmc_rt_role
GO