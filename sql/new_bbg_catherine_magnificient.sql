------------------------------------------------------------------------------
--	FILE:	 new_bbg_catherine_magnificient.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database leader related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******			CATHERINE THE MAGNIFICIENT(LY OPed)		 	  ******
--==============================================================================================
INSERT OR IGNORE INTO Requirements
	(RequirementId , RequirementType)
	VALUES
	('REQUIRES_PLAYER_HAS_MEDIEVAL_FAIRES' , 		'REQUIREMENT_PLAYER_HAS_CIVIC');	
	
INSERT OR IGNORE INTO RequirementArguments
	(RequirementId , Name, Value)
	VALUES
	('REQUIRES_PLAYER_HAS_MEDIEVAL_FAIRES' , 		'CivicType', 'CIVIC_MEDIEVAL_FAIRES');	

INSERT OR IGNORE INTO RequirementSets
	(RequirementSetId , RequirementSetType)
	VALUES
	('PLAYER_HAS_MEDIEVAL_FAIRES' , 		'REQUIREMENTSET_TEST_ALL');	
	
INSERT OR IGNORE INTO RequirementSetRequirements
	(RequirementSetId , RequirementId)
	VALUES
	('PLAYER_HAS_MEDIEVAL_FAIRES' , 		'REQUIRES_PLAYER_HAS_MEDIEVAL_FAIRES');	


UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_MEDIEVAL_FAIRES' WHERE ModifierType='MODIFIER_PLAYER_ALLOW_PROJECT_CATHERINE';
-- UPDATE ModifierArguments SET Value='40' WHERE ModifierId='PROJECT_COMPLETION_GRANT_CULTURE_BASED_ON_EXCESS_LUXURIES' AND Name='Amount';
-- UPDATE ModifierArguments SET Value='40' WHERE ModifierId='PROJECT_COMPLETION_GRANT_TOURISM_BASED_ON_EXCESS_LUXURIES' AND Name='Amount';

