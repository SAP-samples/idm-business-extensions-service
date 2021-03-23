USE [MXMC_db]
GO

/****** Object:  StoredProcedure [dbo].[sapc_update_link_audit] 
This stored procedure enables RT to write updadte link audit from toDB passes, for example writing ticket number into link audit reason ****/
SET ANSINULL ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sapc_update_link_audit]
@Plinkid int,
	@Poperation int,
	@Pauditid int,
	@Preason nvarchar(512)
AS
	update mxi_link_audit set mcReason = @Preason
	where mcLinkId = @Plinkid and mcOperation = @Poperation and mcAuditId = (select refAudit from mxp_audit where auditid = @Pauditid)

GO

grant execute on [dbo].[sapc_update_link_audit] to mxmc_rt_role

GO