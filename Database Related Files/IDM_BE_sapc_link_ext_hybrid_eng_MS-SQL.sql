USE [MXMC_db]
GO

/****** Object:  View [dbo].[ SAPC_LINK_EXT_HYBRID] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[SAPC_LINK_EXT_HYBRID]
AS
/****** View showing inherited links and direct links with inheritance path; also showing inherited links where direct assignment and inheritance exists on same link ******/

select userMSKEY, userMSKEYVALUE, privilegeMSKEY, privilegeMSKEYVALUE, roleMSKEY, roleMSKEYVALUE, assignedDirect, executionState, 
 case when executionState < 2 then 'OK' when executionState < 3 then 'Rejected' when executionState < 512 then 'Failed'
  when executionState < 513 then 'Pending' when executionState < 1025 then 'Removal Failed' when executionState < 1026 then 'Removed OK'
  when executionState < 1027 then 'Removal Rejected' when  executionState < 1537 then 'Removal Pending' when executionState < 1544 then 'Removal Failed'
  else 'Unknown' end as executionStateText, validFrom, validTo from 
(select mcThisMSKEY userMSKEY, mcThisMSKEYVALUE as userMSKEYVALUE, mcOtherMSKEY privilegeMSKEY, mcOtherMSKEYVALUE privilegeMSKEYVALUE,
   null roleMSKEY, null roleMSKEYVALUE, mcAssignedDirect assignedDirect, mcExecState executionState,
   convert(VARCHAR(10), mcValidFrom, 121) as validFrom, convert(VARCHAR(10), mcValidTo, 121) as validTo
  from idmv_link_ext with (nolock) where mcThisOcName = 'MX_PERSON' and mcAttrName = 'MXREF_MX_PRIVILEGE' and mcAssignedDirect = 1
 UNION
 /* assignmentrelations on inherited privs */
 select userRole.mcThisMSKEY userMSKEY, userRole.mcThisMSKEYVALUE userMSKEYVALUE, privRole.mcThisMSKEY privilegeMSKEY, privRole.mcThisMSKEYVALUE privilegeMSKEYVALUE,
  userRole.mcOtherMSKEY roleMSKEY, userRole.mcOtherMSKEYVALUE roleMSKEYVALUE, 0 assignedDirect, userPriv.mcExecState executionState,
  case when userRole.mcValidFrom is not null then convert(VARCHAR(10), userRole.mcValidFrom, 121) when privRole.mcValidFrom is not null then convert(VARCHAR(10), privRole.mcValidFrom, 121) else null end as validFrom,
  case when userRole.mcValidTo   is not null then convert(VARCHAR(10), userRole.mcValidTo,   121) when privRole.mcValidTo   is not null then convert(VARCHAR(10), privRole.mcValidTo,   121) else null end as validTo
  from idmv_link_ext privRole with (nolock), idmv_link_ext userRole with (nolock), idmv_link_ext userPriv with (nolock)
  where userRole.mcThisOcName = 'MX_PERSON' and userRole.mcAttrName = 'MXREF_MX_ROLE' and userRole.mcExecState in (0,1)
   and privRole.mcThisOcName = 'MX_PRIVILEGE' and privRole.mcAttrName = 'MXREF_MX_ROLE' and privRole.mcExecState in (0,1)
   and userPriv.mcThisOcName = 'MX_PERSON' and userPriv.mcAttrName = 'MXREF_MX_PRIVILEGE'
   and privRole.mcOtherMSKEY = userRole.mcOtherMSKEY and privRole.mcThisMSKEY = userPriv.mcOtherMSKEY and userRole.mcThisMSKEY = userPriv.mcThisMSKEY) as t123
GO
grant select on dbo.sapc_link_ext_hybrid to <DB-prefix>_rt_role
GO
