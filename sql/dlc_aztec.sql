--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================

--==================
-- Aztec
--==================
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_MELEE_PRODUCTION_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_MELEE_PRODUCTION_BBG', 'UnitPromotionClass', 'PROMOTION_CLASS_MELEE'),
	('TRAIT_MELEE_PRODUCTION_BBG', 'EraType', 'NO_ERA'),
	('TRAIT_MELEE_PRODUCTION_BBG', 'Amount', '50');
INSERT OR IGNORE INTO TraitModifiers VALUES
	('TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS', 'TRAIT_MELEE_PRODUCTION_BBG');
-- Aztec Tlachtli Unique Building is now slightly cheaper and is +3 Culture instead of +2 Faith/+1 Culture
DELETE FROM Building_YieldChanges WHERE BuildingType='BUILDING_TLACHTLI' AND YieldType='YIELD_FAITH';
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_TLACHTLI';
UPDATE Buildings SET Cost=100 WHERE BuildingType='BUILDING_TLACHTLI';