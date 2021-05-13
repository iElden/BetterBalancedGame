------------------------------------------------------------------------------
--	FILE:	 new_bbg_england.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database Civilization related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******				ENGLAND						   ******
--==============================================================================================

UPDATE District_GreatPersonPoints SET PointsPerTurn=1 WHERE DistrictType='DISTRICT_ROYAL_NAVY_DOCKYARD' AND GreatPersonClassType='GREAT_PERSON_CLASS_ADMIRAL';

INSERT OR IGNORE INTO DistrictModifiers(DistrictType, ModifierId) VALUES
	('DISTRICT_ROYAL_NAVY_DOCKYARD', 'BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
	('BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD', 'MODIFIER_SINGLE_CITY_ADJUST_GREAT_PERSON_POINT', NULL, 'BUILDING_IS_LIGHTHOUSE');

INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value) VALUES
	('BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_ADMIRAL'),
	('BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD', 'Amount', '1');

-- nerf redcoat bonus on foreign continent
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='REDCOAT_FOREIGN_COMBAT';