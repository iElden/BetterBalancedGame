--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================
--==================
-- Khmer
--==================

-- 23/04/2021 : Major rework of khmer from Firaxis

-- Domrey Unique Unit will now be a Catapult replacement that has a higher melee strength and bombard strength
-- UPDATE Units SET Combat=28, Bombard=40, Cost=140, Maintenance=2, PrereqTech='TECH_ENGINEERING', MandatoryObsoleteTech='TECH_STEEL' WHERE UnitType='UNIT_KHMER_DOMREY';
--UPDATE UnitUpgrades SET UpgradeUnit='UNIT_BOMBARD' WHERE Unit='UNIT_KHMER_DOMREY';
--INSERT OR IGNORE INTO UnitReplaces (CivUniqueUnitType, ReplacesUnitType)
--	VALUES ('UNIT_KHMER_DOMREY', 'UNIT_CATAPULT');
-- Prasat gives a free Missionary when built instead of giving martyr ability to them
--DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_PRASAT' AND ModifierId='PRASAT_GRANT_MARTYR';
--INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , RunOnce , Permanent)
--    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY' , 1 , 1);
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'UnitType' , 'UNIT_MISSIONARY');
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'Amount' , '1');
--INSERT OR IGNORE INTO BuildingModifiers (BuildingType , ModifierId)
--    VALUES ('BUILDING_PRASAT' , 'PRASAT_GRANT_MISSIONARY_CPLMOD');
-- Trade routes to or from other civilizations give +2 Faith to both parties
--INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
--	VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS');
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER' , 'YieldType' , 'YIELD_FAITH');
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER' , 'Amount' , '2');
--INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
--	VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_FROM_OTHERS');
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES' , 'YieldType' , 'YIELD_FAITH');
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES' , 'Amount' , '2');
--INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
--	VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL');
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES' , 'YieldType' , 'YIELD_FAITH');
--INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--    VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES' , 'Amount' , '2');
--INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
--	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER');
--INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
--	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES');
--INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
--	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES');

-- 03/05/2021: Remove Food Equal to holy site adjacency.
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_MONASTERIES_KING' AND ModifierId='TRAIT_MONASTERIES_KING_ADJACENCY_FOOD';
-- Holy site gain +2 food adjacency for river.
INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_HOLY_SITE_RIVER_FOOD_ADJACENCY', 'MODIFIER_PLAYER_CITIES_RIVER_ADJACENCY');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_HOLY_SITE_RIVER_FOOD_ADJACENCY', 'Amount', '2'),
    ('BBG_HOLY_SITE_RIVER_FOOD_ADJACENCY', 'Description', 'LOC_BBG_HOLY_SITE_RIVER_FOOD_ADJACENCY'),
    ('BBG_HOLY_SITE_RIVER_FOOD_ADJACENCY', 'DistrictType', 'DISTRICT_HOLY_SITE'),
    ('BBG_HOLY_SITE_RIVER_FOOD_ADJACENCY', 'YieldType', 'YIELD_FOOD');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_LEADER_MONASTERIES_KING', 'BBG_HOLY_SITE_RIVER_FOOD_ADJACENCY');


--==============================================================
--******				START BIASES					  ******
--==============================================================
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_INDONESIA' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_KHMER';





