CREATE OR REPLACE PROCEDURE SAPC_DELETE_ASSIGNMENT (pLinkId number)
/*
 * 2022-04-14 SAP NN: Delete assignments that cannot be deleted elsewise (like state not allowed)
 */
 
IS
	lPvoMskey number;
	lAddAudit number;
	lValAddAudit number;
BEGIN
	lPvoMskey := 0;
	lAddAudit := 0;
	lValAddAudit := 0;
	
	-- get pvo by MX_LINK_REFERENCE = mcUniqueId; delete pvo
	BEGIN
		SELECT mskey into lPvoMskey from idmv_vna where attrName = 'MX_LINK_REFERENCE' and sVal = CAST(pLinkId AS VARCHAR(20));
	EXCEPTION WHEN NO_DATA_FOUND THEN dbms_output.put_line('No PVO found for Link [' || pLinkId || ']');
	END;
	dbms_output.put_line('MSKEY of PVO: [' || lPvoMskey || ']');
	IF lPvoMskey > 0 THEN
		dbms_output.put_line('Deleting PVO [' || lPvoMskey || ']');
		MC_RESET_IDS_MSKEY(lPvoMskey);
	END IF;
	
	-- get mcValidateAddAudit & mcAddAudit, set state to failed (1101)
	BEGIN
		SELECT mcAddAudit into lAddAudit FROM idmv_link_ext where mcUniqueId = pLinkId;
	EXCEPTION WHEN NO_DATA_FOUND THEN dbms_output.put_line('No Add Audit found for Link [' || pLinkId || ']');
	END;
	BEGIN
		SELECT mcValidateAddAudit into lValAddAudit FROM idmv_link_ext where mcUniqueId = pLinkId;
		EXCEPTION WHEN NO_DATA_FOUND THEN dbms_output.put_line('No Validate Add Audit found for Link [' || pLinkId || ']');
	END;
	
	dbms_output.put_line('mcAddAudit: [' || lAddAudit || '] mcValidateAddAudit: [' || lValAddAudit || ']');
	IF lAddAudit > 0 THEN
		dbms_output.put_line('Setting Add Audit [' || lAddAudit || '] to state error');
		update mxp_audit set provstatus = 1101 where auditid = lAddAudit;
		delete from mxp_provision where auditref = lAddAudit;
	END IF;
	IF lValAddAudit > 0 THEN
		dbms_output.put_line('Setting Validate Add Audit [' || lValAddAudit || '] to state error');
		update mxp_audit set provstatus = 1101 where auditid = lValAddAudit;
		delete from mxp_provision where auditref = lValAddAudit;
	END IF;
	
	-- set link state to deleted (2) and exec state to failed (4)
	update mxi_link set mcLinkState = 2, mcExecState = 4 where mcUniqueId = pLinkId;

END;

GRANT EXECUTE ON SAPC_DELETE_ASSIGNMENT TO mxmc_rt_role;

commit;
