

-- Grand Bazaar buff
UPDATE Building_GreatPersonPoints SET PointsPerTurn=2 WHERE BuildingType='BUILDING_GRAND_BAZAAR';
UPDATE Building_YieldChanges SET YieldChange=6 WHERE BuildingType='BUILDING_GRAND_BAZAAR' AND YieldType='YIELD_GOLD';
-- Grand Bazaar same ability than bank
INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
    ('BUILDING_GRAND_BAZAAR', 'BBG_BANK_TRADEROUTE_FROM_DOMESTIC'),
    ('BUILDING_GRAND_BAZAAR', 'BBG_BANK_TRADEROUTE_TO_DOMESTIC'),
    ('BUILDING_GRAND_BAZAAR', 'BBG_BANK_TRADEROUTE_FROM_INTERNATIONAL'),
    ('BUILDING_GRAND_BAZAAR', 'BBG_BANK_TRADEROUTE_TO_INTERNATIONAL');
-- Grand Bazaar traderoute capacity
INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_GRAND_BAZAAR_TRADEROUTE_CAPACITY', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_GRAND_BAZAAR_TRADEROUTE_CAPACITY', 'Amount', '1');
INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
    ('BUILDING_GRAND_BAZAAR', 'BBG_GRAND_BAZAAR_TRADEROUTE_CAPACITY');

-- Give one title governor
INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, SubjectRequirementSetId) VALUES
    ('BBG_GRAND_BAZAAR_GOV_POINT', 'MODIFIER_ALL_PLAYERS_ADJUST_GOVERNOR_POINTS', 1, 1, 'BBG_BUILDING_IS_GRAND_BAZAAR');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_GRAND_BAZAAR_GOV_POINT', 'Delta', '1');
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('BBG_BUILDING_IS_GRAND_BAZAAR', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('BBG_BUILDING_IS_GRAND_BAZAAR', 'BBG_BUILDING_IS_GRAND_BAZAAR_REQUIREMENT');
INSERT INTO Requirements(RequirementId , RequirementType) VALUES
	('BBG_BUILDING_IS_GRAND_BAZAAR_REQUIREMENT' , 'REQUIREMENT_PLAYER_HAS_BUILDING');
INSERT INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('BBG_BUILDING_IS_GRAND_BAZAAR_REQUIREMENT' , 'BuildingType', 'BUILDING_GRAND_BAZAAR');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_BUILDING_GRAND_BAZAAR', 'BBG_GRAND_BAZAAR_GOV_POINT');