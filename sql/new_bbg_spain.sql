-- Author: iElden
-- Making this is like spain but s is silent

-- Give x2 yield instead of x3
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TRAIT_INTERCONTINENTAL_INTERNATIONAL_FAITH' AND Name='Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TRAIT_INTERCONTINENTAL_INTERNATIONAL_GOLD' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='TRAIT_INTERCONTINENTAL_INTERNATIONAL_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TRAIT_INTERCONTINENTAL_DOMESTIC_FAITH' AND Name='Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TRAIT_INTERCONTINENTAL_DOMESTIC_GOLD' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='TRAIT_INTERCONTINENTAL_DOMESTIC_PRODUCTION' AND Name='Amount';

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