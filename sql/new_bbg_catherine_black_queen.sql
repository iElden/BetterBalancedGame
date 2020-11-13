------------------------------------------------------------------------------
--	FILE:	 new_bbg_catherine_black_queen.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database leader related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******			CATHERINE 														 	  ******
--==============================================================================================


INSERT OR IGNORE INTO Requirements
	(RequirementId , RequirementType)
	VALUES
	('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY' , 		'REQUIREMENT_PLAYER_HAS_CIVIC');	
	
INSERT OR IGNORE INTO RequirementArguments
	(RequirementId , Name, Value)
	VALUES
	('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY' , 		'CivicType', 'CIVIC_POLITICAL_PHILOSOPHY');	

INSERT OR IGNORE INTO RequirementSets
	(RequirementSetId , RequirementSetType)
	VALUES
	('PLAYER_HAS_POLITICAL_PHILOSOPHY' , 		'REQUIREMENTSET_TEST_ALL');	
	
INSERT OR IGNORE INTO RequirementSetRequirements
	(RequirementSetId , RequirementId)
	VALUES
	('PLAYER_HAS_POLITICAL_PHILOSOPHY' , 		'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY');	

UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY' WHERE ModifierId='UNIQUE_LEADER_ADD_VISIBILITY' AND ModifierType='MODIFIER_PLAYER_ADD_DIPLO_VISIBILITY';


	
