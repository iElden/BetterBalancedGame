------------------------------------------------------------------------------
--	FILE:	 new_bbg_mother_russia.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database Civilization related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******				MOTHER RUSSIA					   ******
--==============================================================================================
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_MOTHER_RUSSIA' AND ModifierId='TRAIT_INCREASED_TUNDRA_FAITH';
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_MOTHER_RUSSIA' AND ModifierId='TRAIT_INCREASED_TUNDRA_HILLS_FAITH';


INSERT OR IGNORE INTO TraitModifiers
	(TraitType , ModifierId)
	VALUES
	('TRAIT_CIVILIZATION_MOTHER_RUSSIA' , 		'TRAIT_ONE_FAITH');	
	
INSERT OR IGNORE INTO Modifiers
	(ModifierId , ModifierType)
	VALUES
	('TRAIT_ONE_FAITH' , 		'MODIFIER_PLAYER_ADJUST_YIELD_CHANGE');	

INSERT OR IGNORE INTO ModifierArguments
	(ModifierId , Name, Value)
	VALUES
	('TRAIT_ONE_FAITH'  , 		'Amount', 1),
	('TRAIT_ONE_FAITH'  , 		'YieldType', 'YIELD_FAITH');

-- /!\ REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG is definied in base.sql (nan_madol nerf)

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
    ('PLOT_HAS_TUNDRA_REQUIREMENTS', 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG'),
    ('PLOT_HAS_TUNDRA_HILLS_REQUIREMENTS', 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG');