--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================

--==================
-- Australia
--==================
-- Digger gets additional combat strength
UPDATE Units SET BaseMoves=3 WHERE UnitType='UNIT_DIGGER';
-- war production bonus reduced to 0% from 100%, liberation bonus reduced to +50% (from +100%) and 10 turns instead of 20
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_DEFENSIVE_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION' and Name='TurnsActive';

-- 18/05/2021: UI can be build on hill
INSERT INTO Improvement_ValidTerrains(ImprovementType, TerrainType) VALUES
    ('IMPROVEMENT_OUTBACK_STATION', 'TERRAIN_GRASS_HILLS'),
    ('IMPROVEMENT_OUTBACK_STATION', 'TERRAIN_PLAINS_HILLS');

--==============================================================
--******				START BIASES					  ******
--==============================================================
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasResources SET Tier=4 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_CATTLE';
UPDATE StartBiasResources SET Tier=4 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_HORSES';
UPDATE StartBiasResources SET Tier=4 WHERE CivilizationType='CIVILIZATION_AUSTRALIA' AND ResourceType='RESOURCE_SHEEP';