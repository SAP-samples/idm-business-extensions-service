USE [MXMC_db]
GO
/****** Object:  StoredProcedure [dbo].[sapc_mxp_xadd_link_audit] 
This stored procedure enables RT to write to link audit from toDB passes (for approval enhancement); since the original stored procedure mxp_xadd_link_audit has return value, it cannot be called directly ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sapc_mxp_xadd_link_audit]
	@Plinkid int,
	@Poperation int,
	@Presponsible int,
	@Pauditid int,
	@Preason nvarchar(512),
	@Paddinfo nvarchar(1024)
AS
	exec dbo.mxp_xadd_link_audit @Plinkid, @Poperation, @Presponsible, @Pauditid, @Preason,
	  @Paddinfo, @PnewValidFrom = null, @PnewValidTo = null, @Pdelegate = null, @Perr = 0

GO

grant execute on [dbo].[sapc_mxp_xadd_link_audit] to mxmc_rt_role

GO