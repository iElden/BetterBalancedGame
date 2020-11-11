------------------------------------------------------------------------------
--	FILE:	 new_bbg_catherine_magnificient.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database leader related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******			CATHERINE THE MAGNIFICIENT(LY OPed)		 	  ******
--==============================================================================================

UPDATE Projects SET PrereqCivic='CIVIC_MEDIEVAL_FAIRES' WHERE ProjectType='PROJECT_COURT_FESTIVAL';
UPDATE ModifierArguments SET Value='40' WHERE ModifierId='PROJECT_COMPLETION_GRANT_CULTURE_BASED_ON_EXCESS_LUXURIES' AND Name='Amount';
UPDATE ModifierArguments SET Value='40' WHERE ModifierId='PROJECT_COMPLETION_GRANT_TOURISM_BASED_ON_EXCESS_LUXURIES' AND Name='Amount';
