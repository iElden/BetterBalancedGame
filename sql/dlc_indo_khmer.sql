--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================
--==================
-- Khmer
--==================

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

-- 15/05/2021: Khmer get 0.5 Faith per pop in cities with Aqueduc
UPDATE ModifierArguments SET Value='0.5' WHERE ModifierId='BARAYS_FAITH_POPULATION' AND Name='Amount';
-- 15/05/2021: Khmer get 0.3 Culture per pop in cities with Prasat
UPDATE ModifierArguments SET Value='0.3' WHERE ModifierId='PRASAT_CULTURE_POPULATION' AND Name='Amount';

--==============================================================
--******				START BIASES					  ******
--==============================================================
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_INDONESIA' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_KHMER';
