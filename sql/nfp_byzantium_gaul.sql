--==================
-- Byzantium
--==================
-- reduce combat bonus for holy cities
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='BYZANTIUM_COMBAT_HOLY_CITIES' AND Name='Amount';
-- remove dromon combat bonus
--DELETE FROM UnitAbilityModifiers WHERE ModifierId='DROMON_COMBAT_STRENGTH_AGAINST_UNITS';

-- Delete Byzantium religious spread (script will do it)
DELETE FROM Modifiers WHERE ModifierId='BYZANTIUM_PRESSURE_KILLS';


--==================
-- Gaul
--==================
-- set start bias to 3
UPDATE StartBiasResources SET Tier=3 WHERE CivilizationType='CIVILIZATION_GAUL';
-- set citizen yields to same as other IZ
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' AND DistrictType='DISTRICT_OPPIDUM';
-- remove culture from unit production
DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_GRANT_CULTURE_UNIT_TRAINED';
-- reduce king's combat bonus for adj units
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='AMBIORIX_NEIGHBOR_COMBAT' and Name='Amount';
-- remove ranged units from having kings combat bonus
DELETE FROM TypeTags WHERE Type='ABILITY_AMBIORIX_NEIGHBOR_COMBAT_BONUS' AND Tag='CLASS_RANGED';

-- 7/3/2021: Beta: Remove Apprenticeship free tech
DELETE FROM DistrictModifiers WHERE DistrictType='DISTRICT_OPPIDUM' AND ModifierId='OPPIDUM_GRANT_TECH_APPRENTICESHIP';

-- 7/3/2021: Beta: Culture on Mine from Political Philosophy
UPDATE Modifiers SET SubjectRequirementSetId='GAUL_MINE_CULTURE_REQUIREMENTS' WHERE ModifierType='MODIFIER_PLAYER_ADJUST_PLOT_YIELD' AND ModifierId='GAUL_MINE_CULTURE';

INSERT INTO RequirementSets
		(RequirementSetId,										RequirementSetType)
VALUES	('GAUL_MINE_CULTURE_REQUIREMENTS',						'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements
		(RequirementSetId,										RequirementId)
VALUES	('GAUL_MINE_CULTURE_REQUIREMENTS',						'REQUIRES_GAUL_PLAYER_HAS_POLITICAL_PHILOSOPHY'),
		('GAUL_MINE_CULTURE_REQUIREMENTS',						'REQUIRES_GAUL_PLOT_HAS_MINE');

INSERT INTO Requirements
		(RequirementId, 										RequirementType)
VALUES	('REQUIRES_GAUL_PLAYER_HAS_POLITICAL_PHILOSOPHY',		'REQUIREMENT_PLAYER_HAS_CIVIC'),
		('REQUIRES_GAUL_PLOT_HAS_MINE',							'REQUIREMENT_PLOT_ADJACENT_IMPROVEMENT_TYPE_MATCHES');	

INSERT INTO RequirementArguments
		(RequirementId, 									Name,						Value)
VALUES	('REQUIRES_GAUL_PLOT_HAS_MINE', 					'ImprovementType',			'IMPROVEMENT_MINE'),
		('REQUIRES_GAUL_PLAYER_HAS_POLITICAL_PHILOSOPHY', 	'CivicType', 				'CIVIC_POLITICAL_PHILOSOPHY');	
