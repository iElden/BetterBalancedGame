------------------------------------------------------------------------------
--	FILE:	 new_bbg_sumer.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database Civilization related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******				SUMER						   ******
--==============================================================================================
-- Delete old Trait as they are moved and reworked to Gilgamesh
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_FIRST_CIVILIZATION';

-- Farms adjacent to a River yield +1 food, Farms adjacent to a River get + 1 prop if next to Zigurat
INSERT INTO TraitModifiers
		(TraitType,											ModifierId)
VALUES	('TRAIT_CIVILIZATION_FIRST_CIVILIZATION', 			'FIRST_CIVILIZATION_FARM_FOOD'),
		('TRAIT_CIVILIZATION_FIRST_CIVILIZATION', 			'FIRST_CIVILIZATION_WAR_CART_PREMIUM'),
		('TRAIT_CIVILIZATION_FIRST_CIVILIZATION', 			'FIRST_CIVILIZATION_FARM_PROD');

INSERT INTO Modifiers
		(ModifierId,										ModifierType,											SubjectRequirementSetId,						SubjectStackLimit)
VALUES	('FIRST_CIVILIZATION_FARM_FOOD',					'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',					'FIRST_CIVILIZATION_FARM_FOOD_REQUIREMENTS',	NULL),
		('FIRST_CIVILIZATION_WAR_CART_PREMIUM',				'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PURCHASE_COST',		NULL,											1),
		('FIRST_CIVILIZATION_FARM_PROD',					'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',					'FIRST_CIVILIZATION_FARM_PROD_REQUIREMENTS',	NULL);

INSERT INTO ModifierArguments
		(ModifierId,										Name,							Value)
VALUES	('FIRST_CIVILIZATION_FARM_FOOD',				'YieldType',					'YIELD_FOOD'),
		('FIRST_CIVILIZATION_FARM_FOOD',				'Amount',						1),

		('FIRST_CIVILIZATION_FARM_PROD',				'YieldType',					'YIELD_PRODUCTION'),
		('FIRST_CIVILIZATION_FARM_PROD',				'Amount',						1),
-- This makes War Carts cost 120 gold in Online speed		
		('FIRST_CIVILIZATION_WAR_CART_PREMIUM',			'UnitType',						'UNIT_SUMERIAN_WAR_CART'),
		('FIRST_CIVILIZATION_WAR_CART_PREMIUM',			'Amount',						-40);

INSERT INTO RequirementSets
		(RequirementSetId,										RequirementSetType)
VALUES	('FIRST_CIVILIZATION_FARM_FOOD_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL'),
		('FIRST_CIVILIZATION_FARM_PROD_REQUIREMENTS',			'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,										RequirementId)
VALUES	('FIRST_CIVILIZATION_FARM_FOOD_REQUIREMENTS',			'REQUIRES_PLOT_HAS_FARM'),
		('FIRST_CIVILIZATION_FARM_FOOD_REQUIREMENTS',			'REQUIRES_PLOT_ADJACENT_TO_RIVER'),

		('FIRST_CIVILIZATION_FARM_PROD_REQUIREMENTS',			'REQUIRES_PLOT_HAS_FARM'),
		('FIRST_CIVILIZATION_FARM_PROD_REQUIREMENTS',			'REQUIRES_PLOT_ADJACENT_TO_ZIGGURAT'),
		('FIRST_CIVILIZATION_FARM_PROD_REQUIREMENTS',			'REQUIRES_PLAYER_HAS_EARLY_EMPIRE');

INSERT INTO Requirements
		(RequirementId, 										RequirementType)
VALUES	('REQUIRES_CITY_HAS_WATER_MILL',						'REQUIREMENT_CITY_HAS_BUILDING'),
		('REQUIRES_PLOT_ADJACENT_TO_ZIGGURAT',					'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES'),
		('REQUIRES_PLAYER_HAS_EARLY_EMPIRE' , 					'REQUIREMENT_PLAYER_HAS_CIVIC');	

INSERT INTO RequirementArguments
		(RequirementId, 							Name,						Value)
VALUES	('REQUIRES_CITY_HAS_WATER_MILL', 			'BuildingType',				'BUILDING_WATER_MILL'),
		('REQUIRES_PLOT_ADJACENT_TO_ZIGGURAT', 		'ImprovementType',			'IMPROVEMENT_ZIGGURAT'),
		('REQUIRES_PLAYER_HAS_EARLY_EMPIRE', 		'CivicType', 				'CIVIC_EARLY_EMPIRE');	


-- Ziggurat buff
UPDATE Improvements SET SameAdjacentValid		= 0, Housing					= 1,  TilesRequired			= 1 WHERE ImprovementType = 'IMPROVEMENT_ZIGGURAT';

INSERT INTO Improvement_YieldChanges
		(ImprovementType,				YieldType,						YieldChange)
VALUES	('IMPROVEMENT_ZIGGURAT',		'YIELD_FAITH',					0);

-- +1 faith for every 2 adjacent farms. +1 faith for each adjacent District.
INSERT INTO Improvement_Adjacencies
		(ImprovementType,				YieldChangeId)
VALUES	('IMPROVEMENT_ZIGGURAT',		'Ziggurat_Faith_Farm'),
		('IMPROVEMENT_ZIGGURAT',		'Ziggurat_Faith_District');

INSERT INTO Adjacency_YieldChanges
		(ID,							Description,	YieldType,			YieldChange,	TilesRequired,	AdjacentImprovement,	OtherDistrictAdjacent)
VALUES	('Ziggurat_Faith_Farm',			'Placeholder',	'YIELD_FAITH',		1,				2,				'IMPROVEMENT_FARM',		0),
		('Ziggurat_Faith_District',		'Placeholder',	'YIELD_FAITH',		1,				1,				NULL,					1);


-- Sumerian War Carts are nerfed to 26 (BASE = 30)
-- 20-12-07 Hotfix: Nerf from 28->26
UPDATE Units SET Combat=26 WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
-- Sumerian War Carts are cost is dimished to 55 (BASE = 55)
-- 20-12-07 Hotfix: Revert to 55 cost
UPDATE Units SET Cost=55 WHERE UnitType='UNIT_SUMERIAN_WAR_CART';	


-- 20-12-07 Hotfix: Increase war-cart strength vs. barbs
INSERT OR IGNORE INTO Types (Type, Kind) VALUES
	('ABILITY_WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG', 'KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags VALUES
	('ABILITY_WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG' ,'CLASS_WAR_CART');
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
	('ABILITY_WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG', 'LOC_ABILITY_WAR_CART_COMBAT_STRENGTH_VS_BARBS_NAME_BBG', 'LOC_ABILITY_WAR_CART_COMBAT_STRENGTH_VS_BARBS_DESCRIPTION_BBG', 0);
INSERT OR IGNORE INTO UnitAbilityModifiers VALUES
	('ABILITY_WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG', 'WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG');

INSERT OR IGNORE INTO Modifiers
		(ModifierId, ModifierType, SubjectRequirementSetId)
VALUES	('WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG','MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQUIREMENTS_OPPONENT_IS_BARBARIAN');

INSERT OR IGNORE INTO ModifierStrings
		(ModifierId, Context, Text)
VALUES	('WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG','Preview', 'LOC_ABILITY_WAR_CART_COMBAT_STRENGTH_VS_BARBS_DESCRIPTION_BBG');

INSERT INTO ModifierArguments
		(ModifierId, Name, Value)
VALUES	('WAR_CART_COMBAT_STRENGTH_VS_BARBS_BBG', 'Amount', 4);

-- Sumerian War Carts as a starting unit in Ancient is coded on the lua front
