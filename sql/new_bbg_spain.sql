-- Author: iElden
-- Making this is like spain but s is silent

-- Spain got coastal bias again
INSERT INTO StartBiasTerrains(CivilizationType, TerrainType, Tier) VALUES
    ('CIVILIZATION_SPAIN', 'TERRAIN_COAST', 2);

-- Give x2 yield instead of x3
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TRAIT_INTERCONTINENTAL_INTERNATIONAL_FAITH' AND Name='Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TRAIT_INTERCONTINENTAL_INTERNATIONAL_GOLD' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='TRAIT_INTERCONTINENTAL_INTERNATIONAL_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TRAIT_INTERCONTINENTAL_DOMESTIC_FAITH' AND Name='Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TRAIT_INTERCONTINENTAL_DOMESTIC_GOLD' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='TRAIT_INTERCONTINENTAL_DOMESTIC_PRODUCTION' AND Name='Amount';

-- ==== MISSIONS ====
-- missions get +1 housing on home continent
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
	('BBG_REQUIRES_PLOT_IS_OWNER_CAPITAL_CONTINENT', 'REQUIREMENT_PLOT_IS_OWNER_CAPITAL_CONTINENT');
INSERT OR IGNORE INTO RequirementSets VALUES
	('BBG_PLOT_CAPITAL_CONTINENT_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements VALUES
	('BBG_PLOT_CAPITAL_CONTINENT_REQUIREMENTS', 'BBG_REQUIRES_PLOT_IS_OWNER_CAPITAL_CONTINENT');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId) VALUES
    ('BBG_MISSION_HOMECONTINENT_HOUSING' , 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 'BBG_PLOT_CAPITAL_CONTINENT_REQUIREMENTS'),
    ('BBG_MISSION_HOMECONTINENT_FOOD' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'BBG_PLOT_CAPITAL_CONTINENT_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)VALUES
    ('BBG_MISSION_HOMECONTINENT_HOUSING' , 'Amount' , '1'),
    ('BBG_MISSION_HOMECONTINENT_FOOD' , 'YieldType', 'YIELD_FOOD'),
    ('BBG_MISSION_HOMECONTINENT_FOOD' , 'Amount', '1');
INSERT OR IGNORE INTO ImprovementModifiers (ImprovementType , ModifierId) VALUES
    ('IMPROVEMENT_MISSION' , 'BBG_MISSION_HOMECONTINENT_HOUSING'),
    ('IMPROVEMENT_MISSION' , 'BBG_MISSION_HOMECONTINENT_FOOD');
-- Missions cannot be placed next to each other
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_MISSION';
-- Missions moved to Theology
UPDATE Improvements SET PrereqTech=NULL, PrereqCivic='CIVIC_THEOLOGY' WHERE ImprovementType='IMPROVEMENT_MISSION';
-- Missions get bonus science at +1 at Enlightenment instead of +2 at cultural heritage
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_THE_ENLIGHTENMENT', BonusYieldChange=1 WHERE Id='17';
-- Change missions Yield
DELETE FROM ImprovementModifiers WHERE ImprovementType='IMPROVEMENT_MISSION' AND ModifierID IN ('MISSION_NEWCONTINENT_FAITH', 'MISSION_NEWCONTINENT_FOOD');
DELETE FROM Improvement_Adjacencies WHERE ImprovementType='IMPROVEMENT_MISSION' AND YieldChangeId='Mission_Science_HolySite';
INSERT INTO Adjacency_YieldChanges(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict) VALUES
    ('BBG_Mission_Faith_HS', 'placeholder', 'YIELD_FAITH', 1, 1, 'DISTRICT_HOLY_SITE');
INSERT INTO Improvement_Adjacencies(ImprovementType, YieldChangeId) VALUES
    ('IMPROVEMENT_MISSION', 'BBG_Mission_Faith_HS');



-- Can make fleet with shipyard.
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) VALUES
    ('BBG_SPAIN_FLEET_DISCOUNT', 'MODIFIER_CITY_CORPS_ARMY_ADJUST_DISCOUNT', 'BBG_PLAYER_IS_SPAIN');

INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_SPAIN_FLEET_DISCOUNT', 'UnitDomain', 'DOMAIN_SEA'),
    ('BBG_SPAIN_FLEET_DISCOUNT', 'Amount', '25');

INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
    ('BUILDING_SHIPYARD', 'BBG_SPAIN_FLEET_DISCOUNT');

-- +25% production toward harbour building.
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId) VALUES
	('TRAIT_CIVILIZATION_TREASURE_FLEET' , 'BBG_SPAIN_BUILDING_PROD_BOOST');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , OwnerRequirementSetId) VALUES
	('BBG_SPAIN_BUILDING_PROD_BOOST' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION' , NULL , NULL);
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value) VALUES
	('BBG_SPAIN_BUILDING_PROD_BOOST' , 'DistrictType' , 'DISTRICT_HARBOR'),
	('BBG_SPAIN_BUILDING_PROD_BOOST' , 'Amount'       , '25');

-- Leader is Phillipe Requirement.
INSERT OR IGNORE INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('BBG_PLAYER_IS_SPAIN', 'REQUIREMENTSET_TEST_ANY');

INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('BBG_PLAYER_IS_SPAIN', 'BBG_PLAYER_IS_SPAIN_REQUIREMENT');

INSERT OR IGNORE INTO Requirements(RequirementId , RequirementType) VALUES
	('BBG_PLAYER_IS_SPAIN_REQUIREMENT' , 'REQUIREMENT_PLAYER_TYPE_MATCHES');

INSERT OR IGNORE INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('BBG_PLAYER_IS_SPAIN_REQUIREMENT' , 'CivilizationType', 'CIVILIZATION_SPAIN');