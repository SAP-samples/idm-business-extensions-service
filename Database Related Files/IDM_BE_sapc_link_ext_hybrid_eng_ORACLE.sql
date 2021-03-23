CREATE VIEW SAPC_LINK_EXT_HYBRID (userMSKEY, userMSKEYVALUE, privilegeMSKEY, privilegeMSKEYVALUE, roleMSKEY, roleMSKEYVALUE, assignedDirect, exexutionState, executionStateText, validFrom, validTo) AS
/****** View showing inherited links and direct links with inheritance path; also showing inherited links where direct assignment and inheritance exists on same link ******/

select userMSKEY, userMSKEYVALUE, privilegeMSKEY, privilegeMSKEYVALUE, roleMSKEY, roleMSKEYVALUE, assignedDirect, executionState,
 case when executionState < 2 then 'OK' when executionState < 3 then 'Rejected' when executionState < 512 then 'Failed'
  when executionState < 513 then 'Pending' when executionState < 1025 then 'Removal Failed' when executionState < 1026 then 'Removed OK'
  when executionState < 1027 then 'Removal Rejected' when  executionState < 1537 then 'Removal Pending' when executionState < 1544 then 'Removal Failed'
  else 'Unknown' end executionStateText, validFrom, validTo from
(select mcThisMSKEY userMSKEY, mcThisMSKEYVALUE as userMSKEYVALUE, mcOtherMSKEY privilegeMSKEY, mcOtherMSKEYVALUE privilegeMSKEYVALUE,
   null roleMSKEY, null roleMSKEYVALUE, mcAssignedDirect assignedDirect, mcExecState executionState,
   CAST(TO_CHAR(mcValidFrom, 'YYYY-MM-DD') as NVARCHAR2(10)) validFrom, CAST(TO_CHAR(mcValidTo, 'YYYY-MM-DD') as NVARCHAR2(10)) validTo
  from idmv_link_ext where mcThisOcName = 'MX_PERSON' and mcAttrName = 'MXREF_MX_PRIVILEGE' and mcAssignedDirect = 1
 UNION
 /* assignmentrelations on inherited privs */
 select userRole.mcThisMSKEY userMSKEY, userRole.mcThisMSKEYVALUE userMSKEYVALUE, privRole.mcThisMSKEY privilegeMSKEY, privRole.mcThisMSKEYVALUE privilegeMSKEYVALUE,
  userRole.mcOtherMSKEY roleMSKEY, userRole.mcOtherMSKEYVALUE roleMSKEYVALUE, 0 assignedDirect, userPriv.mcExecState executionState,
  case when userRole.mcValidFrom is not null then CAST(TO_CHAR(userRole.mcValidFrom, 'YYYY-MM-DD') as NVARCHAR2(10)) when privRole.mcValidFrom is not null then CAST(TO_CHAR(privRole.mcValidFrom, 'YYYY-MM-DD') as NVARCHAR2(10)) else null end validFrom,
  case when userRole.mcValidTo   is not null then CAST(TO_CHAR(userRole.mcValidTo,   'YYYY-MM-DD') as NVARCHAR2(10)) when privRole.mcValidTo   is not null then CAST(TO_CHAR(privRole.mcValidTo,   'YYYY-MM-DD') as NVARCHAR2(10)) else null end validTo
  from idmv_link_ext privRole, idmv_link_ext userRole, idmv_link_ext userPriv
  where userRole.mcThisOcName = 'MX_PERSON' and userRole.mcAttrName = 'MXREF_MX_ROLE' and userRole.mcExecState in (0,1)
   and privRole.mcThisOcName = 'MX_PRIVILEGE' and privRole.mcAttrName = 'MXREF_MX_ROLE' and privRole.mcExecState in (0,1)
   and userPriv.mcThisOcName = 'MX_PERSON' and userPriv.mcAttrName = 'MXREF_MX_PRIVILEGE'
   and privRole.mcOtherMSKEY = userRole.mcOtherMSKEY and privRole.mcThisMSKEY = userPriv.mcOtherMSKEY and userRole.mcThisMSKEY = userPriv.mcThisMSKEY)
order by userMSKEY, privilegeMSKEY, assignedDirect desc, roleMSKEY;

grant select on SAPC_LINK_EXT_HYBRID to mxmc_rt_role;

commit;
