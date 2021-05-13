--==================
-- Colombia
--==================
-- only light cav get promote before attack
UPDATE Modifiers SET SubjectRequirementSetId='EJERCITO_PATRIOTA_PROMOTE_SRS_BBG' WHERE ModifierId='TRAIT_PROMOTE_NO_FINISH_MOVES';
INSERT OR IGNORE INTO RequirementSetRequirements VALUES
    ('EJERCITO_PATRIOTA_PROMOTE_SRS_BBG', 'UNIT_IS_LIGHT_CAVALRY');
INSERT OR IGNORE INTO RequirementSets VALUES
    ('EJERCITO_PATRIOTA_PROMOTE_SRS_BBG', 'REQUIREMENTSET_TEST_ALL');
-- site instead of movement
--DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_EJERCITO_PATRIOTA_EXTRA_MOVEMENT';
UPDATE Modifiers SET ModifierType='MODIFIER_PLAYER_UNIT_ADJUST_SIGHT' WHERE ModifierId='EJERCITO_PATRIOTA_EXTRA_MOVEMENT';
-- cannot produce great generals
INSERT OR IGNORE INTO ExcludedGreatPersonClasses (GreatPersonClassType, TraitType) VALUES
    ( 'GREAT_PERSON_CLASS_GENERAL', 'TRAIT_LEADER_CAMPANA_ADMIRABLE' );
-- llanero support nerf
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LLANERO_ADJACENCY_STRENGTH' AND Name='Amount';
-- hacienda comes sooner
-- UPDATE Improvements SET PrereqCivic='CIVIC_MEDIEVAL_FAIRES' WHERE ImprovementType='IMPROVEMENT_HACIENDA';
-- hacienda can only be built on flat tiles
--DELETE FROM Improvement_ValidTerrains WHERE ImprovementType='IMPROVEMENT_HACIENDA' AND TerrainType='TERRAIN_PLAINS_HILLS';
--DELETE FROM Improvement_ValidTerrains WHERE ImprovementType='IMPROVEMENT_HACIENDA' AND TerrainType='TERRAIN_GRASS_HILLS';




--==================
-- Maya
--==================
-- reduce combat bonus to 3 from 5
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='MUTAL_NEAR_CAPITAL_COMBAT' AND Name='Amount';
-- set citizen yields to same as other campuses
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_SCIENCE' AND DistrictType="DISTRICT_OBSERVATORY";
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
VALUES ('REQUIRE_PLAYER_HAS_OBSERVATORY', 'REQUIREMENT_CITY_HAS_DISTRICT');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
VALUES ('REQUIRE_PLAYER_HAS_OBSERVATORY', 'DistrictType', 'DISTRICT_OBSERVATORY');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES ('MAYA_FREE_BUILDER_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES ('MAYA_FREE_BUILDER_REQUIREMENTS', 'REQUIRES_OBJECT_6_TILES_FROM_CAPITAL_NOT_CAPITAL'),
       ('MAYA_FREE_BUILDER_REQUIREMENTS', 'CITY_IS_ORIGINAL_OWNER_REQUIREMENTS_MAYA'),
       ('MAYA_FREE_BUILDER_REQUIREMENTS', 'REQUIRE_PLAYER_HAS_OBSERVATORY');
UPDATE Modifiers SET SubjectRequirementSetId = 'MAYA_FREE_BUILDER_REQUIREMENTS' WHERE ModifierId = 'TRAIT_LEADER_NEARBY_CITIES_GAIN_BUILDER';
--- start biases ---
-- after coastals and tundra and desert; delete non-plantation lux biases; add banana bias; make flat land bias last priority
INSERT OR REPLACE INTO StartBiasResources(CivilizationType, ResourceType, Tier) VALUES
    ('CIVILIZATION_MAYA', 'RESOURCE_CITRUS', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_COFFEE', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_COCOA', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_COTTON', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_DYES', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_SILK', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_SPICES', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_SUGAR', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_TEA', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_TOBACCO', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_WINE', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_INCENSE', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_OLIVES', 3),
    ('CIVILIZATION_MAYA', 'RESOURCE_BANANAS', 4);

DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_GYPSUM';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_JADE';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_MARBLE';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_MERCURY';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_SALT';
DELETE FROM StartBiasResources WHERE CivilizationType='CIVILIZATION_MAYA' AND ResourceType='RESOURCE_IVORY';

-- Delete StartBiasTerrain
DELETE FROM StartBiasTerrains WHERE CivilizationType='CIVILIZATION_MAYA';

--==================
-- City-States
--==================
-- UPDATE Units SET CostProgressionModel='COST_PROGRESSION_PREVIOUS_COPIES', CostProgressionParam1=10 WHERE UnitType='UNIT_LAHORE_NIHANG';


--==================
-- Other
--==================
INSERT OR IGNORE INTO TypeTags (Type, Tag) VALUES
	('RESOURCE_MAIZE'  , 'CLASS_FERTILITY_RITES_FOOD');


--==================
-- Wonders
--==================
UPDATE Feature_AdjacentYields SET YieldChange=1 WHERE FeatureType='FEATURE_PAITITI' AND YieldType='YIELD_GOLD';
UPDATE Feature_AdjacentYields SET YieldChange=1 WHERE FeatureType='FEATURE_PAITITI' AND YieldType='YIELD_CULTURE';
DELETE FROM Feature_AdjacentYields WHERE FeatureType='FEATURE_BERMUDA_TRIANGLE';
