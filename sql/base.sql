--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================

--==================
-- America
--==================
-- Film Studios tourism bonus reduced from 100% to 50%
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='FILMSTUDIO_ENHANCEDLATETOURISM' AND Name='Modifier';
-- American Rough Riders will now be a cav replacement
UPDATE Units SET Combat=62, Cost=340, PromotionClass='PROMOTION_CLASS_LIGHT_CAVALRY', PrereqTech='TECH_MILITARY_SCIENCE' WHERE UnitType='UNIT_AMERICAN_ROUGH_RIDER';
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_HELICOPTER' WHERE Unit='UNIT_AMERICAN_ROUGH_RIDER';
INSERT OR IGNORE INTO UnitReplaces VALUES ('UNIT_AMERICAN_ROUGH_RIDER' , 'UNIT_CAVALRY');
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='ROUGH_RIDER_BONUS_ON_HILLS';
-- Continent combat bonus: +5 attack on foreign continent, +5 defense on home continent
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('TRAIT_COMBAT_BONUS_FOREIGN_CONTINENT_BBG',    'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'UNIT_IS_DOMAIN_LAND'),
	('COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_COMBAT_BONUS_FOREIGN_CONTINENT_BBG', 'ModifierId', 'COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG'),
	('COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG', 'Amount', '5');
INSERT OR IGNORE INTO ModifierStrings (ModifierId, Context, Text) VALUES
	('COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG', 'Preview', 'LOC_PROMOTION_COMBAT_FOREIGN_CONTINENT_DESCRIPTION');
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES
	('TRAIT_LEADER_ROOSEVELT_COROLLARY', 'TRAIT_COMBAT_BONUS_FOREIGN_CONTINENT_BBG');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('REQUIREMENTS_UNIT_ON_HOME_CONTINENT',    'PLAYER_IS_DEFENDER_REQUIREMENTS'),
	('REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG', 'PLAYER_IS_ATTACKER_REQUIREMENTS'),
	('REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG', 'REQUIRES_UNIT_ON_FOREIGN_CONTINENT_BBG');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
	('REQUIRES_UNIT_ON_FOREIGN_CONTINENT_BBG', 'REQUIREMENT_UNIT_ON_HOME_CONTINENT', 1);


--==================
-- Arabia
--==================
-- Arabia's Worship Building Bonus increased from 10% to 20%
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_CULTURE' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_FAITH' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_SCIENCE' AND Name='Multiplier';
-- Arabia gets +1 Great Prophet point per turn after researching astrology
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS' , 'PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_PROPHET');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'Amount' , '1');
--UPDATE TraitModifiers SET ModifierId='TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' WHERE ModifierId='TRAIT_GUARANTEE_ONE_PROPHET';
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES ('TRAIT_CIVILIZATION_LAST_PROPHET', 'TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD');
INSERT OR IGNORE INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT OR IGNORE INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'TechnologyType' , 'TECH_ASTROLOGY');



--==================
-- China
--==================
-- +1 all yields per wonder
INSERT OR IGNORE INTO RequirementSetRequirements VALUES
	('DYNASTIC_CYCLE_TRAIT_REQUIREMENTS_BBG', 'REQUIRES_PLAYER_HAS_DYNASTIC_CYCLE_TRAIT_BBG');
INSERT OR IGNORE INTO RequirementSets VALUES
	('DYNASTIC_CYCLE_TRAIT_REQUIREMENTS_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
	('REQUIRES_PLAYER_HAS_DYNASTIC_CYCLE_TRAIT_BBG', 'REQUIREMENT_PLAYER_HAS_CIVILIZATION_OR_LEADER_TRAIT');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('REQUIRES_PLAYER_HAS_DYNASTIC_CYCLE_TRAIT_BBG', 'TraitType', 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ATTACH_WONDER_FOOD_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
	('TRAIT_ATTACH_WONDER_PROD_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
	('TRAIT_ATTACH_WONDER_FAITH_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
	('TRAIT_ATTACH_WONDER_GOLD_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
	('TRAIT_ATTACH_WONDER_SCI_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
	('TRAIT_ATTACH_WONDER_CUL_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_ATTACH_WONDER_FOOD_BBG', 'ModifierId', 'TRAIT_WONDER_FOOD_BBG'),
	('TRAIT_ATTACH_WONDER_PROD_BBG', 'ModifierId', 'TRAIT_WONDER_PROD_BBG'),
	('TRAIT_ATTACH_WONDER_FAITH_BBG', 'ModifierId', 'TRAIT_WONDER_FAITH_BBG'),
	('TRAIT_ATTACH_WONDER_GOLD_BBG', 'ModifierId', 'TRAIT_WONDER_GOLD_BBG'),
	('TRAIT_ATTACH_WONDER_SCI_BBG', 'ModifierId', 'TRAIT_WONDER_SCI_BBG'),
	('TRAIT_ATTACH_WONDER_CUL_BBG', 'ModifierId', 'TRAIT_WONDER_CUL_BBG');
INSERT OR IGNORE INTO TraitModifiers VALUES
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_FOOD_BBG'),
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_PROD_BBG'),
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_FAITH_BBG'),
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_GOLD_BBG'),
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_SCI_BBG'),
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_CUL_BBG');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_WONDER_FOOD_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE'),
	('TRAIT_WONDER_PROD_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE'),
	('TRAIT_WONDER_FAITH_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE'),
	('TRAIT_WONDER_GOLD_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE'),
	('TRAIT_WONDER_SCI_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE'),
	('TRAIT_WONDER_CUL_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_WONDER_FOOD_BBG', 'Amount', '1'),
	('TRAIT_WONDER_FOOD_BBG', 'YieldType', 'YIELD_FOOD'),
	('TRAIT_WONDER_PROD_BBG', 'Amount', '1'),
	('TRAIT_WONDER_PROD_BBG', 'YieldType', 'YIELD_PRODUCTION'),
	('TRAIT_WONDER_FAITH_BBG', 'Amount', '1'),
	('TRAIT_WONDER_FAITH_BBG', 'YieldType', 'YIELD_FAITH'),
	('TRAIT_WONDER_GOLD_BBG', 'Amount', '1'),
	('TRAIT_WONDER_GOLD_BBG', 'YieldType', 'YIELD_GOLD'),
	('TRAIT_WONDER_SCI_BBG', 'Amount', '1'),
	('TRAIT_WONDER_SCI_BBG', 'YieldType', 'YIELD_SCIENCE'),
	('TRAIT_WONDER_CUL_BBG', 'Amount', '1'),
	('TRAIT_WONDER_CUL_BBG', 'YieldType', 'YIELD_CULTURE');
-- great wall gets +1 prod, no initial gold, lowered gold and lowered culture per adj after castles
INSERT OR IGNORE INTO Improvement_YieldChanges VALUES ('IMPROVEMENT_GREAT_WALL', 'YIELD_PRODUCTION', 1);
UPDATE Improvement_YieldChanges SET YieldChange=0 WHERE ImprovementType='IMPROVEMENT_GREAT_WALL' AND YieldType='YIELD_GOLD';
UPDATE Adjacency_YieldChanges SET YieldChange=1 WHERE ID='GreatWall_Culture';
UPDATE Adjacency_YieldChanges SET YieldChange=1 WHERE ID='GreatWall_Gold';
-- Crouching Tiger now a crossbowman replacement that gets +7 when adjacent to an enemy unit
INSERT OR IGNORE INTO UnitReplaces (CivUniqueUnitType , ReplacesUnitType)
	VALUES ('UNIT_CHINESE_CROUCHING_TIGER' , 'UNIT_CROSSBOWMAN');
UPDATE Units SET Cost=190 , RangedCombat=40 , Range=2 WHERE UnitType='UNIT_CHINESE_CROUCHING_TIGER';

INSERT OR IGNORE INTO Tags (Tag , Vocabulary)
	VALUES ('CLASS_CROUCHING_TIGER' , 'ABILITY_CLASS');
INSERT OR IGNORE INTO TypeTags (Type , Tag)
	VALUES ('UNIT_CHINESE_CROUCHING_TIGER' , 'CLASS_CROUCHING_TIGER');
INSERT OR IGNORE INTO Types (Type , Kind)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags (Type , Tag)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'CLASS_CROUCHING_TIGER');
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType , Name , Description)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'LOC_ABILITY_TIGER_ADJACENCY_NAME' , 'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION');
INSERT OR IGNORE INTO UnitAbilityModifiers (UnitAbilityType , ModifierId)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'TIGER_ADJACENCY_DAMAGE');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('TIGER_ADJACENCY_DAMAGE' , 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH' , 'TIGER_ADJACENCY_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TIGER_ADJACENCY_DAMAGE', 'Amount' , '7'); 
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'PLAYER_IS_ATTACKER_REQUIREMENTS');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'ADJACENT_UNIT_REQUIREMENT');
INSERT OR IGNORE INTO ModifierStrings (ModifierId , Context , Text)
    VALUES ('TIGER_ADJACENCY_DAMAGE' , 'Preview' , 'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION');

--==================
-- Egypt
--==================
-- wonder and district on rivers bonus increased to 25%
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RIVER_FASTER_BUILDTIME_WONDER';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RIVER_FASTER_BUILDTIME_DISTRICT';
--
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('REQUIRES_PLOT_HAS_FLOODPLAINS_CPL', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('REQUIRES_PLOT_HAS_FLOODPLAINS_CPL', 'REQUIRES_PLOT_HAS_FLOODPLAINS');
-- Sphinx base Faith Increased to 2 (from 1)
UPDATE Improvement_YieldChanges SET YieldChange=2 WHERE ImprovementType='IMPROVEMENT_SPHINX' AND YieldType='YIELD_FAITH';
-- +1 Faith and +1 Culture if adjacent to a wonder, instead of 2 Faith.
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='SPHINX_WONDERADJACENCY_FAITH' AND Name='Amount';
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_TO_WONDER_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'YieldType' , 'YIELD_CULTURE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'Amount' , 1);
INSERT OR IGNORE INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_WONDERADJACENCY_CULTURE_CPLMOD');
-- Increased +1 Culture moved to Diplomatic Service (Was Natural History)
UPDATE Improvement_BonusYieldChanges SET PrereqCivic = 'CIVIC_DIPLOMATIC_SERVICE' WHERE Id = 18;
-- Now grants 1 food and 1 production on desert tiles without floodplains. Go Go Gadget bad-start fixer.
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'Amount' , '1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'Amount' , '1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_FOOD_MODIFIER');
INSERT OR IGNORE INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_FOOD_MODIFIER');
INSERT OR IGNORE INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_PRODUCTION_MODIFIER');
INSERT OR IGNORE INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER');
-- No prod nor food bonus on Floodplains
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
-- Requires Desert or Desert Hills
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');


--==================
-- England
--==================
-- Sea Dog available at Exploration now
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_ENGLISH_SEADOG';


--==================
-- France
--==================
-- move spies buffs to france and off catherine for eleanor france buff
UPDATE TraitModifiers SET TraitType='TRAIT_CIVILIZATION_WONDER_TOURISM' WHERE TraitType='FLYING_SQUADRON_TRAIT' AND ModifierId='UNIQUE_LEADER_ADD_SPY_CAPACITY';
UPDATE TraitModifiers SET TraitType='TRAIT_CIVILIZATION_WONDER_TOURISM' WHERE TraitType='FLYING_SQUADRON_TRAIT' AND ModifierId='UNIQUE_LEADER_ADD_SPY_UNIT';
UPDATE TraitModifiers SET TraitType='TRAIT_CIVILIZATION_WONDER_TOURISM' WHERE TraitType='FLYING_SQUADRON_TRAIT' AND ModifierId='UNIQUE_LEADER_SPIES_START_PROMOTED';
-- Reduce tourism bonus for wonders
UPDATE ModifierArguments SET Value='150' WHERE ModifierId='TRAIT_WONDER_DOUBLETOURISM' AND Name='ScalingFactor';
-- Chateau now gives 1 housing at Feudalism, and ajacent luxes now give stacking food in addition to stacking gold 
INSERT OR IGNORE INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_CHATEAU' , 'YIELD_FOOD' , '0');

INSERT OR IGNORE INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_CHATEAU' , 'Chateau_Luxury_Food');

INSERT OR IGNORE INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentResourceClass)
	VALUES ('Chateau_Luxury_Food' , 'Placeholder' , 'YIELD_FOOD' , '1' , '1' , 'RESOURCECLASS_LUXURY');

UPDATE Improvements SET Housing='1' , PreReqCivic='CIVIC_FEUDALISM' WHERE ImprovementType='IMPROVEMENT_CHATEAU';


--==================
-- Germany
--==================
-- Extra district comes at Guilds
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT OR IGNORE INTO RequirementArguments (RequirementId , Name , Value)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'CivicType' , 'CIVIC_GUILDS');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_GUILDS');
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_GUILDS_REQUIREMENTS' WHERE ModifierId='TRAIT_EXTRA_DISTRICT_EACH_CITY';


--==================
-- Greece
--==================
-- Greece gets their extra envoy at amphitheater instead of acropolis
DELETE FROM DistrictModifiers WHERE DistrictType='DISTRICT_ACROPOLIS';
INSERT OR IGNORE INTO TraitModifiers
	VALUES ('TRAIT_CIVILIZATION_PLATOS_REPUBLIC' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('BUILDING_IS_AMPHITHEATER_CPLMOD', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('BUILDING_IS_AMPHITHEATER_CPLMOD', 'REQUIRES_CITY_HAS_AMPHITHEATER_CPLMOD');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_CITY_HAS_AMPHITHEATER_CPLMOD', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_CITY_HAS_AMPHITHEATER_CPLMOD', 'BuildingType', 'BUILDING_AMPHITHEATER');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'BUILDING_IS_AMPHITHEATER_CPLMOD');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'ModifierId' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'Amount' , '1');
--Wildcard delayed to Political Philosophy
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD' WHERE ModifierId='TRAIT_WILDCARD_GOVERNMENT_SLOT';
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'CivicType', 'CIVIC_POLITICAL_PHILOSOPHY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'REQUIREMENTSET_TEST_ALL');

--==================
-- Greece (Gorgo)
--==================



--==================
-- India
--==================
-- Stepwell Unique Improvement gets +1 base Faith and +1 Food moved from Professional Sports to Feudalism
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_STEPWELL' AND YieldType='YIELD_FAITH'; 
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_FEUDALISM' WHERE Id='20';
-- Stepwells get +1 food per adajacent farm
INSERT OR IGNORE INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement)
	VALUES ('STEPWELL_FOOD', 'Placeholder', 'YIELD_FOOD', 1, 1, 'IMPROVEMENT_FARM');
INSERT OR IGNORE INTO Improvement_Adjacencies (ImprovementType, YieldChangeId)
	VALUES ('IMPROVEMENT_STEPWELL', 'STEPWELL_FOOD');
DELETE FROM ImprovementModifiers WHERE ModifierId='STEPWELL_FARMADJACENCY_FOOD';


--==================
-- India (Gandhi)
--==================
-- Extra belief when founding a Religion
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('EXTRA_BELIEF_MODIFIER', 'MODIFIER_PLAYER_ADD_BELIEF', 'HAS_A_RELIGION_BBG');
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
    VALUES ('TRAIT_LEADER_SATYAGRAHA', 'EXTRA_BELIEF_MODIFIER');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('HAS_A_RELIGION_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('HAS_A_RELIGION_BBG', 'REQUIRES_FOUNDED_RELIGION_BBG');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType, Inverse)
	VALUES ('REQUIRES_FOUNDED_RELIGION_BBG', 'REQUIREMENT_FOUNDED_NO_RELIGION', 1);
-- +1 movement to builders
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_SATYAGRAHA' , 'GANDHI_FAST_BUILDERS');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GANDHI_FAST_BUILDERS' , 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT' , 'UNIT_IS_BUILDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GANDHI_FAST_BUILDERS' , 'Amount' , '1');
-- +1 movement to settlers
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_SATYAGRAHA' , 'GANDHI_FAST_SETTLERS');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GANDHI_FAST_SETTLERS' , 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT' , 'UNIT_IS_SETTLER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GANDHI_FAST_SETTLERS' , 'Amount' , '1');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('UNIT_IS_SETTLER' , 'REQUIREMENT_UNIT_IS_SETTLER');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('UNIT_IS_SETTLER' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIREMENT_UNIT_IS_SETTLER' , 'REQUIREMENT_UNIT_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIREMENT_UNIT_IS_SETTLER' , 'UnitType' , 'UNIT_SETTLER');


--==================
-- Japan
--==================
-- Commercial Hubs no longer get adjacency from rivers
INSERT OR IGNORE INTO ExcludedAdjacencies (TraitType , YieldChangeId)
    VALUES
    ('TRAIT_CIVILIZATION_ADJACENT_DISTRICTS' , 'River_Gold');
-- Samurai come at Feudalism now
UPDATE Units SET PrereqCivic='CIVIC_FEUDALISM' , PrereqTech=NULL WHERE UnitType='UNIT_JAPANESE_SAMURAI';


--==================
-- Kongo
--==================
-- +100% prod towards archealogists
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES
	('TRAIT_CIVILIZATION_NKISI', 'TRAIT_ARCHAEOLOGIST_PROD_BBG');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'UnitType', 'UNIT_ARCHAEOLOGIST'),
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'Amount', '100');



--==================
-- Norway
--==================
-- Berserker no longer gets +10 on attack and -5 on defense... simplified to be base on defense and +15 on attack
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='UNIT_STRONG_WHEN_ATTACKING';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='UNIT_WEAK_WHEN_DEFENDING';
-- Berserker unit now gets unlocked at Feudalism instead of Military Tactics, and can be purchased with Faith
UPDATE Units SET Combat=35 , PrereqTech=NULL , PrereqCivic='CIVIC_FEUDALISM' WHERE UnitType='UNIT_NORWEGIAN_BERSERKER';
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_UNIT_NORWEGIAN_BERSERKER' , 'BERSERKER_FAITH_PURCHASE_CPLMOD');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'Tag' , 'CLASS_MELEE_BERSERKER');
--Berserker Movement bonus extended to all water tiles
UPDATE RequirementSets SET RequirementSetType='REQUIREMENTSET_TEST_ANY' WHERE RequirementSetId='BERSERKER_PLOT_IS_ENEMY_TERRITORY';
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES
	('BERSERKER_PLOT_IS_ENEMY_TERRITORY' , 'REQUIRES_PLOT_HAS_COAST'),
	('BERSERKER_PLOT_IS_ENEMY_TERRITORY' , 'REQUIRES_TERRAIN_OCEAN' );
-- Stave Church now gives +1 Faith to resource tiles in the city, instead of standard adjacency bonus for woods
INSERT OR IGNORE INTO Modifiers (ModifierID , ModifierType , SubjectRequirementSetId)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD' , 'STAVE_CHURCH_RESOURCE_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'YieldType' , 'YIELD_FAITH');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'Amount' , '1');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_STAVE_CHURCH' , 'STAVECHURCH_RESOURCE_FAITH');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('STAVE_CHURCH_RESOURCE_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('STAVE_CHURCH_RESOURCE_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_VISIBLE_RESOURCE');
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='STAVE_CHURCH_FAITHWOODSADJACENCY' AND Name='Amount';

-- +2 gold harbor adjacency if adjacent to holy sites
INSERT OR IGNORE INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
    VALUES
    ('District_HS_Gold_Positive' , 'LOC_HOLY_SITE_HARBOR_ADJACENCY_DESCRIPTION' , 'YIELD_GOLD' , '2'  , '1' , 'DISTRICT_HOLY_SITE'),
    ('District_HS_Gold_Negative' , 'LOC_HOLY_SITE_HARBOR_ADJACENCY_DESCRIPTION' , 'YIELD_GOLD' , '-2' , '1' , 'DISTRICT_HOLY_SITE');
INSERT OR IGNORE INTO District_Adjacencies (DistrictType , YieldChangeId)
    VALUES
    ('DISTRICT_HARBOR' , 'District_HS_Gold_Positive'),
    ('DISTRICT_HARBOR' , 'District_HS_Gold_Negative');
INSERT OR IGNORE INTO ExcludedAdjacencies (YieldChangeId , TraitType)
    VALUES
    ('District_HS_Gold_Negative' , 'TRAIT_LEADER_MELEE_COASTAL_RAIDS');
/*
INSERT OR IGNORE INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
    VALUES
    ('District_HS_Gold_Positive' , 'LOC_HOLY_SITE_HARBOR_ADJACENCY_DESCRIPTION' , 'YIELD_GOLD' , '2'  , '1' , 'DISTRICT_HOLY_SITE');
INSERT OR IGNORE INTO District_Adjacencies (DistrictType , YieldChangeId)
    VALUES
    ('DISTRICT_HARBOR' , 'District_HS_Gold_Positive');
INSERT OR IGNORE INTO ExcludedAdjacencies 
	SELECT DISTINCT TraitType, 'District_HS_Gold_Positive'
	FROM (SELECT * FROM LeaderTraits WHERE TraitType LIKE 'TRAIT_LEADER_%' GROUP BY LeaderType) 
	WHERE LeaderType!='LEADER_HARDRADA' AND TraitType!='TRAIT_LEADER_MAJOR_CIV';
*/
-- Holy Sites coastal adjacency
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'DistrictType' , 'DISTRICT_HOLY_SITE'             			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'TerrainType'  , 'TERRAIN_COAST'                  			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'YieldType'    , 'YIELD_FAITH'                    			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'Amount'       , '1'                              			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'TilesRequired', '1'                              			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'Description'  , 'LOC_DISTRICT_HOLY_SITE_NORWAY_COAST_FAITH');
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_LEADER_MELEE_COASTAL_RAIDS' , 'TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY');
-- +50% production towards Holy Sites and associated Buildings
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_LEADER_MELEE_COASTAL_RAIDS'          , 'THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'              ),
	('TRAIT_LEADER_MELEE_COASTAL_RAIDS'          , 'THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'              );
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES
	('THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'               , 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION'                 , null),
	('THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'               , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION'                 , null);
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra , SecondExtra)
	VALUES
	('THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'               , 'DistrictType' , 'DISTRICT_HOLY_SITE' , null , null),
	('THUNDERBOLT_HOLY_SITE_DISTRICT_BOOST'               , 'Amount'       , '50'                 , null , null),
	('THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'               , 'DistrictType' , 'DISTRICT_HOLY_SITE' , null , null),
	('THUNDERBOLT_HOLY_SITE_BUILDING_BOOST'               , 'Amount'       , '50'                 , null , null);


--==================
-- Rome
--==================
-- free city center building after code of laws
UPDATE Modifiers SET SubjectRequirementSetId='HAS_CODE_OF_LAWS_SET_BBG' WHERE ModifierId='TRAIT_ADJUST_NON_CAPITAL_FREE_CHEAPEST_BUILDING';
INSERT OR IGNORE INTO RequirementSets VALUES ('HAS_CODE_OF_LAWS_SET_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements VALUES ('HAS_CODE_OF_LAWS_SET_BBG', 'HAS_CODE_OF_LAWS_BBG');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
	('HAS_CODE_OF_LAWS_BBG', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('HAS_CODE_OF_LAWS_BBG', 'CivicType', 'CIVIC_CODE_OF_LAWS');
-- Baths get Culture minor adjacency bonus added
INSERT OR IGNORE INTO District_Adjacencies (DistrictType , YieldChangeId)
	VALUES ('DISTRICT_BATH' , 'District_Culture');


--==================
-- Russia
--==================
-- Lavra only gets 1 Great Prophet Point per turn
UPDATE District_GreatPersonPoints SET PointsPerTurn=1 WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_PROPHET';
-- Only gets 2 extra tiles when founding a new city instead of 8 
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TRAIT_INCREASED_TILES';
-- Cossacks have same base strength as cavalry instead of +5
UPDATE Units SET Combat=62 WHERE UnitType='UNIT_RUSSIAN_COSSACK';
-- Lavra district does not acrue Great Person Points unless city has a theater
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_ARTIST';
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_MUSICIAN';
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_WRITER';
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES
	('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIRES_DISTRICT_IS_LAVRA'),
	('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIRES_CITY_HAS_THEATER_DISTRICT');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_DISTRICT_IS_LAVRA' , 'REQUIREMENT_DISTRICT_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_DISTRICT_IS_LAVRA', 'DistrictType', 'DISTRICT_LAVRA');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
    VALUES
	('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS'),
    ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS'),
	('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
    VALUES
	('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_ARTIST'),
    ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_MUSICIAN'),
	('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_WRITER'),
	('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'Amount' , '1'),
    ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'Amount' , '1'),
    ('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'Amount' , '1');
INSERT OR IGNORE INTO DistrictModifiers ( DistrictType , ModifierId )
	VALUES
	( 'DISTRICT_LAVRA' , 'DELAY_LAVRA_ARTIST_GPP_MODIFIER' ),
	( 'DISTRICT_LAVRA' , 'DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' ),
	( 'DISTRICT_LAVRA' , 'DELAY_LAVRA_WRITER_GPP_MODIFIER' );


--==================
-- Scythia
--==================
-- Scythia no longer gets an extra light cavalry unit when building/buying one
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRASAKAHORSEARCHER' and NAME='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRALIGHTCAVALRY' and NAME='Amount';
-- Scythian Horse Archer gets a little more offense and defense, less maintenance, and can upgrade to Crossbowman before Field Cannon now
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_CROSSBOWMAN' WHERE Unit='UNIT_SCYTHIAN_HORSE_ARCHER';
UPDATE Units SET Range=2, Cost=70 WHERE UnitType='UNIT_SCYTHIAN_HORSE_ARCHER';
-- Adjacent Pastures now give +1 production in addition to faith
INSERT OR IGNORE INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_KURGAN' , 'KURGAN_PASTURE_PRODUCTION');
INSERT OR IGNORE INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentImprovement)
	VALUES ('KURGAN_PASTURE_PRODUCTION' , 'Placeholder' , 'YIELD_PRODUCTION' , 1 , 1 , 'IMPROVEMENT_PASTURE');
INSERT OR IGNORE INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_KURGAN' , 'YIELD_PRODUCTION' , 0);
INSERT OR IGNORE INTO Improvement_ValidTerrains (ImprovementType, TerrainType) VALUES
	('IMPROVEMENT_KURGAN', 'TERRAIN_PLAINS_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_GRASS_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_DESERT_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_SNOW_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_TUNDRA_HILLS');

-- Can now purchase cavalry units with faith
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD');
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD');
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'Tag' , 'CLASS_LIGHT_CAVALRY'); 
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'Tag' , 'CLASS_HEAVY_CAVALRY');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'Tag' , 'CLASS_RANGED_CAVALRY'); 


--==================
-- Spain
--==================
-- missions get +1 housing on home continent
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
	('REQUIRES_PLOT_IS_OWNER_CAPITAL_CONTINENT_BBG', 'REQUIREMENT_PLOT_IS_OWNER_CAPITAL_CONTINENT');
INSERT OR IGNORE INTO RequirementSets VALUES
	('PLOT_CAPITAL_CONTINENT_REQUIREMENTS_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements VALUES
	('PLOT_CAPITAL_CONTINENT_REQUIREMENTS_BBG', 'REQUIRES_PLOT_IS_OWNER_CAPITAL_CONTINENT_BBG');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('MISSION_HOMECONTINENT_HOUSING_BBG' , 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 'PLOT_CAPITAL_CONTINENT_REQUIREMENTS_BBG');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('MISSION_HOMECONTINENT_HOUSING_BBG' , 'Amount' , 1);
INSERT OR IGNORE INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_MISSION' , 'MISSION_HOMECONTINENT_HOUSING_BBG');
-- Missions cannot be placed next to each other
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_MISSION';
-- Missions moved to Theology
UPDATE Improvements SET PrereqCivic='CIVIC_THEOLOGY' WHERE ImprovementType='IMPROVEMENT_MISSION';
-- Missions get bonus science at Enlightenment instead of cultural heritage
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_THE_ENLIGHTENMENT' WHERE Id='17';
-- Early Fleets moved to Mercenaries
UPDATE ModifierArguments SET Value='CIVIC_MERCENARIES' WHERE Name='CivicType' AND ModifierId='TRAIT_NAVAL_CORPS_EARLY';
-- 30% discount on missionaries
INSERT OR IGNORE INTO TraitModifiers ( TraitType , ModifierId )
	VALUES ('TRAIT_LEADER_EL_ESCORIAL' , 'HOLY_ORDER_MISSIONARY_DISCOUNT_MODIFIER');

	
--==================
-- Sumeria
--==================
-- replace bugged shared xp and pillage rewards with double pillage rewards
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_ADVENTURES_ENKIDU' AND ModifierId='TRAIT_ADJUST_JOINTWAR_EXPERIENCE';
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ADJUST_PILLAGE_BBG', 'MODIFIER_PLAYER_ADJUST_IMPROVEMENT_PILLAGE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value, Extra) VALUES
	('TRAIT_ADJUST_PILLAGE_BBG', 'Amount', '2', '-1');
UPDATE TraitModifiers SET ModifierId='TRAIT_ADJUST_PILLAGE_BBG' WHERE TraitType='TRAIT_LEADER_ADVENTURES_ENKIDU' AND ModifierId='TRAIT_ADJUST_JOINTWAR_PLUNDER';
-- Sumerian War Carts are now unlocked at horseback riding and buffed
UPDATE Units SET Cost=80, Maintenance=2, BaseMoves=4, Combat=36, StrategicResource='RESOURCE_HORSES', PrereqTech='TECH_HORSEBACK_RIDING', MandatoryObsoleteTech='TECH_COMBUSTION' WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
INSERT OR IGNORE INTO UnitReplaces (CivUniqueUnitType, ReplacesUnitType) VALUES ('UNIT_SUMERIAN_WAR_CART', 'UNIT_HEAVY_CHARIOT');
-- war carts have a chance to steal defeated barbs and city state units
INSERT OR IGNORE INTO Types (Type , Kind)
	VALUES ('ABILITY_WAR_CART_CAPTURE' , 'KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags (Type, Tag)
	VALUES ('ABILITY_WAR_CART_CAPTURE', 'CLASS_WAR_CART');
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description)
	VALUES ('ABILITY_WAR_CART_CAPTURE', 'Placeholder', 'ABILITY_WAR_CART_CAPTURE_DESCRIPTION_BBG');
INSERT OR IGNORE INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	VALUES ('ABILITY_WAR_CART_CAPTURE', 'WAR_CART_CAPTURE_CS_BARBS');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES ('WAR_CART_CAPTURE_CS_BARBS', 'MODIFIER_UNIT_ADJUST_COMBAT_UNIT_CAPTURE', 'OPP_IS_CS_OR_BARB');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
	VALUES ('WAR_CART_CAPTURE_CS_BARBS', 'CanCapture', '1');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('OPP_IS_CS_OR_BARB', 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES
	('OPP_IS_CS_OR_BARB', 'REQUIRES_OPPONENT_IS_BARBARIAN'),
	('OPP_IS_CS_OR_BARB', 'REQUIRES_OPPONENT_IS_MINOR_CIV');
-- Sumeria's Ziggurat gets +1 Culture at Diplomatic Service instead of Natural History
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_DIPLOMATIC_SERVICE' WHERE ImprovementType='IMPROVEMENT_ZIGGURAT';
-- zigg gets +1 science and culture at enlightenment
INSERT OR IGNORE INTO Improvement_BonusYieldChanges (ImprovementType, YieldType, BonusYieldChange, PrereqCivic)
	VALUES
	('IMPROVEMENT_ZIGGURAT', 'YIELD_CULTURE', 1, 'CIVIC_THE_ENLIGHTENMENT'),
	('IMPROVEMENT_ZIGGURAT', 'YIELD_SCIENCE', 1, 'CIVIC_THE_ENLIGHTENMENT');



--==============================================================
--******				B U I L D I N G S			  	  ******
--==============================================================
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BARRACKS';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_STABLE';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BASILIKOI_PAIDES';
UPDATE Building_GreatPersonPoints SET PointsPerTurn=2 WHERE BuildingType='BUILDING_ARMORY';
UPDATE Building_GreatPersonPoints SET PointsPerTurn=2 WHERE BuildingType='BUILDING_MILITARY_ACADEMY';
UPDATE Building_GreatPersonPoints SET PointsPerTurn=3 WHERE BuildingType='BUILDING_SEAPORT';



--==============================================================
--******			  C I T Y - S T A T E S				  ******
--==============================================================
-- nan-modal culture per district no longer applies to city center or wonders
INSERT OR IGNORE INTO Requirements ( RequirementId, RequirementType, Inverse )
	VALUES
		( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 );
INSERT OR IGNORE INTO RequirementArguments ( RequirementId, Name, Value )
	VALUES
		( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG', 'DistrictType', 'DISTRICT_CITY_CENTER' ),
		( 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG', 'DistrictType', 'DISTRICT_AQUEDUCT' ),
		( 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG', 'DistrictType', 'DISTRICT_CANAL' ),
		( 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG', 'DistrictType', 'DISTRICT_DAM' ),
		( 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG', 'DistrictType', 'DISTRICT_NEIGHBORHOOD' ),
		( 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG', 'DistrictType', 'DISTRICT_SPACEPORT' ),
		( 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG', 'DistrictType', 'DISTRICT_WONDER' );
INSERT OR IGNORE INTO RequirementSets ( RequirementSetId, RequirementSetType )
	VALUES ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIREMENTSET_TEST_ALL' );
INSERT OR IGNORE INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
	VALUES
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_PLOT_IS_ADJACENT_TO_COAST' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG' );
UPDATE Modifiers SET SubjectRequirementSetId='SPECIAL_DISTRICT_ON_COAST_BBG' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS';


--==============================================================
--******		C U L T U R E   V I C T O R I E S		  ******
--==============================================================
-- moon landing worth 5x science in culture instead of 10x
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='PROJECT_COMPLETION_GRANT_CULTURE_BASED_ON_SCIENCE_RATE' AND Name='Multiplier';
-- computers and environmentalism tourism boosts to 50% (from 25%)
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='COMPUTERS_BOOST_ALL_TOURISM';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='ENVIRONMENTALISM_BOOST_ALL_TOURISM'; 
-- base wonder tourism adjusted to 5
UPDATE GlobalParameters SET Value='5' WHERE Name='TOURISM_BASE_FROM_WONDER';
-- Reduce amount of tourism needed for foreign tourist from 200 to 150
UPDATE GlobalParameters SET Value='150' WHERE Name='TOURISM_TOURISM_TO_MOVE_CITIZEN';
-- lower number of turns to move greatworks between cities
UPDATE GlobalParameters SET Value='2' WHERE Name='GREATWORK_ART_LOCK_TIME';
-- relics give 4 tourism instead of 8
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIC';
--

-- fix same artist, same archelogist culture and tourism from bing 1 and 1 to being default numbers
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonYield=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';

-- books give 4 culture and 2 tourism each (8 and 4 for each great person)
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE YieldChange=2;
-- artworks give 4 culture and 4 tourism instead of 3 and 2 ( 12/12 for each GP)
-- artifacts give 6 culture and 6 tourism instead of 3 and 3 ( 18/18 for each GP)
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIGIOUS';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_SCULPTURE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_LANDSCAPE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_PORTRAIT';
UPDATE GreatWorks SET Tourism=6 WHERE GreatWorkObjectType='GREATWORKOBJECT_ARTIFACT';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_4';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_5';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_6';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_7';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_8';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_9';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_10';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_11';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_12';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_13';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_14';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_15';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_16';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_17';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_18';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_19';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_20';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_21';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_22';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_23';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_24';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_25';

-- music gives 12 culture and 8 tourism instead of 4 and 4 (24/16 per GP)
UPDATE GreatWorks SET Tourism=8 WHERE GreatWorkObjectType='GREATWORKOBJECT_MUSIC';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_2';



--==============================================================
--******			  G O V E R N M E N T S				  ******
--==============================================================
-- fascism attack bonus works on defense now too
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='FASCISM_ATTACK_BUFF';
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='FASCISM_LEGACY_ATTACK_BUFF';



--==============================================================
--******			 G R E A T    P E O P L E  			  ******
--==============================================================




--==============================================================
--******				P A N T H E O N S				  ******
--==============================================================
-- religious settlements more border growth since settler removed
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='RELIGIOUS_SETTLEMENTS_CULTUREBORDER';
-- river goddess +2 HS adj on rivers, -1 housing and -1 amentiy tho
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='RIVER_GODDESS_HOLY_SITE_HOUSING_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='RIVER_GODDESS_HOLY_SITE_AMENITIES_MODIFIER' AND Name='Amount';
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('RIVER_GODDESS_HOLY_SITE_FAITH_BBG' , 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'MODIFIER_PLAYER_CITIES_RIVER_ADJACENCY');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value) VALUES
('RIVER_GODDESS_HOLY_SITE_FAITH_BBG', 'ModifierId', 'RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'Amount' , '2'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'DistrictType' , 'DISTRICT_HOLY_SITE'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'YieldType' , 'YIELD_FAITH'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'Description' , 'LOC_DISTRICT_HOLY_SITE_RIVER_FAITH');
INSERT OR IGNORE INTO BeliefModifiers VALUES
	('BELIEF_RIVER_GODDESS', 'RIVER_GODDESS_HOLY_SITE_FAITH_BBG');
-- city patron buff
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='CITY_PATRON_GODDESS_DISTRICT_PRODUCTION_MODIFIER' AND Name='Amount';
-- Dance of Aurora yields reduced... only work for flat tundra
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='DANCE_OF_THE_AURORA_FAITHTUNDRAHILLSADJACENCY' AND Name='Amount';
-- stone circles -1 faith and +1 prod
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='STONE_CIRCLES_QUARRY_FAITH_MODIFIER' and Name='Amount';
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('STONE_CIRCLES_QUARRY_PROD_BBG', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_QUARRY_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('STONE_CIRCLES_QUARRY_PROD_BBG', 'ModifierId', 'STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG'),
	('STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
	('STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG', 'Amount', '1');
INSERT OR IGNORE INTO BeliefModifiers (BeliefType, ModifierID) VALUES
	('BELIEF_STONE_CIRCLES', 'STONE_CIRCLES_QUARRY_PROD_BBG');
-- religious idols +2 gold
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_BBG', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_BBG', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_BONUS_MINE_REQUIREMENTS'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_LUXURY_MINE_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_BBG', 'ModifierId', 'RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG'),
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG', 'Amount', '2'),
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_BBG', 'ModifierId', 'RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG', 'Amount', '2'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD');
INSERT OR IGNORE INTO BeliefModifiers VALUES
	('BELIEF_RELIGIOUS_IDOLS', 'RELIGIOUS_IDOLS_BONUS_MINE_GOLD_BBG'),
	('BELIEF_RELIGIOUS_IDOLS', 'RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_BBG');
-- Goddess of the Harvest is +50% faith from chops instead of +100%
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='GODDESS_OF_THE_HARVEST_HARVEST_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='GODDESS_OF_THE_HARVEST_REMOVE_FEATURE_MODIFIER' and Name='Amount';
-- Monument to the Gods affects all wonders... not just Ancient and Classical Era
UPDATE ModifierArguments SET Value='ERA_INFORMATION' WHERE ModifierId='MONUMENT_TO_THE_GODS_ANCIENTCLASSICALWONDER_MODIFIER' AND Name='EndEra';
-- God of War now God of War and Plunder (similar to divine spark)
DELETE FROM BeliefModifiers WHERE BeliefType='BELIEF_GOD_OF_WAR';
INSERT OR IGNORE INTO Modifiers  ( ModifierId , ModifierType , SubjectRequirementSetId )
	VALUES
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_COMMERCIAL_HUB' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_HARBOR' 		),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_ENCAMPMENT' 	);
INSERT OR IGNORE INTO ModifierArguments ( ModifierId , Name , Type , Value )
	VALUES
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_MERCHANT' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_ADMIRAL'  ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_GENERAL'  ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' );
INSERT OR IGNORE INTO BeliefModifiers ( BeliefType , ModifierId )
	VALUES
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_COMHUB' ),
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_HARBOR' ),
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' );
-- Fertility Rites gives +1 food for rice and wheat and cattle
INSERT OR IGNORE INTO Tags
	(Tag                                , Vocabulary)
	VALUES 
	('CLASS_FERTILITY_RITES_FOOD'       , 'RESOURCE_CLASS');
INSERT OR IGNORE INTO TypeTags 
	(Type              , Tag)
	VALUES
	('RESOURCE_WHEAT'  , 'CLASS_FERTILITY_RITES_FOOD'),
	('RESOURCE_CATTLE' , 'CLASS_FERTILITY_RITES_FOOD'),
	('RESOURCE_RICE'   , 'CLASS_FERTILITY_RITES_FOOD');
INSERT OR IGNORE INTO Modifiers 
	(ModifierId                                         , ModifierType                                                , SubjectRequirementSetId)
	VALUES
	('FERTILITY_RITES_TAG_FOOD'                         , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER'                       , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'      ),
	('FERTILITY_RITES_TAG_FOOD_MODIFIER'                , 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD'               , 'PLOT_HAS_FERTILITY_TAG_FOOD_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments 
	(ModifierId                                         , Name                       , Value)
	VALUES
	('FERTILITY_RITES_TAG_FOOD'                         , 'ModifierId'                , 'FERTILITY_RITES_TAG_FOOD_MODIFIER'             ),
	('FERTILITY_RITES_TAG_FOOD_MODIFIER'                , 'YieldType'                 , 'YIELD_FOOD'                                    ),
	('FERTILITY_RITES_TAG_FOOD_MODIFIER'                , 'Amount'                    , '1'                                             );
INSERT OR IGNORE INTO Requirements 
	(RequirementId                                , RequirementType)
	VALUES 
	('REQUIRES_PLOT_HAS_TAG_FERTILITY_FOOD'       , 'REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES');
INSERT OR IGNORE INTO RequirementArguments 
	(RequirementId                                , Name  , Value)
	VALUES 
	('REQUIRES_PLOT_HAS_TAG_FERTILITY_FOOD'       , 'Tag'         , 'CLASS_FERTILITY_RITES_FOOD');
INSERT OR IGNORE INTO RequirementSets 
	(RequirementSetId                                 , RequirementSetType)
	VALUES 
	('PLOT_HAS_FERTILITY_TAG_FOOD_REQUIREMENTS'       , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements 
	(RequirementSetId                                 , RequirementId)
	VALUES 
	('PLOT_HAS_FERTILITY_TAG_FOOD_REQUIREMENTS'       , 'REQUIRES_PLOT_HAS_TAG_FERTILITY_FOOD');
UPDATE BeliefModifiers SET ModifierID='FERTILITY_RITES_TAG_FOOD' WHERE BeliefType='BELIEF_FERTILITY_RITES' AND ModifierID='FERTILITY_RITES_GROWTH';
-- Initiation Rites gives 25% faith for each military land unit produced
INSERT OR IGNORE INTO Modifiers 
	(ModifierId                                         , ModifierType                                                , SubjectRequirementSetId)
	VALUES
	('INITIATION_RITES_FAITH_YIELD_CPL_MOD'             , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER'                       , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD'    , 'MODIFIER_SINGLE_CITY_GRANT_YIELD_PER_UNIT_COST'            , NULL                                );
INSERT OR IGNORE INTO ModifierArguments 
	(ModifierId                                         , Name                       , Value)
	VALUES
	('INITIATION_RITES_FAITH_YIELD_CPL_MOD'             , 'ModifierId'                , 'INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD' ),
	('INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD'    , 'YieldType'                 , 'YIELD_FAITH'                                   ),
	('INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD'    , 'UnitProductionPercent'     , '25'                                            );
UPDATE BeliefModifiers SET ModifierID='INITIATION_RITES_FAITH_YIELD_CPL_MOD' WHERE BeliefType='BELIEF_INITIATION_RITES' AND ModifierID='INITIATION_RITES_FAITH_DISPERSAL';
-- Sacred Path +1 Faith Holy Site adjacency now applies to both Woods and Rainforest
INSERT OR IGNORE INTO BeliefModifiers 
	(BeliefType                   , ModifierId)
	VALUES
	('BELIEF_SACRED_PATH'         , 'SACRED_PATH_WOODS_FAITH_ADJACENCY');
INSERT OR IGNORE INTO Modifiers 
	(ModifierId                                         , ModifierType                                                , SubjectRequirementSetId)
	VALUES
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'MODIFIER_ALL_CITIES_FEATURE_ADJACENCY'                     , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments 
	(ModifierId                                         , Name                       , Value)
	VALUES
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'DistrictType'              , 'DISTRICT_HOLY_SITE'                            ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'FeatureType'               , 'FEATURE_FOREST'                                ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'YieldType'                 , 'YIELD_FAITH'                                   ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'Amount'                    , '1'                                             ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'Description'               , 'LOC_DISTRICT_SACREDPATH_WOODS_FAITH'           );
-- Lady of the Reeds and Marshes now applies pantanal
INSERT OR IGNORE INTO RequirementSetRequirements 
    (RequirementSetId              , RequirementId)
    VALUES 
    ('PLOT_HAS_REEDS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_PANTANAL'          );
INSERT OR IGNORE INTO Requirements 
    (RequirementId                          , RequirementType)
    VALUES 
    ('REQUIRES_PLOT_HAS_PANTANAL'           , 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments 
    (RequirementId                          , Name          , Value)
    VALUES 
    ('REQUIRES_PLOT_HAS_PANTANAL'           , 'FeatureType' , 'FEATURE_PANTANAL'             );



--==============================================================
--******			P O L I C Y   C A R D S				  ******
--==============================================================
-- Limes should not become obselete
DELETE FROM ObsoletePolicies WHERE PolicyType='POLICY_LIMES';
-- Adds +100% Siege Unit Production to Limes Policy Card
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
--
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'EraType' , 'ERA_ANCIENT' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'EraType' , 'ERA_CLASSICAL' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'EraType' , 'ERA_MEDIEVAL' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'EraType' , 'ERA_RENAISSANCE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'EraType' , 'ERA_INDUSTRIAL' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'EraType' , 'ERA_MODERN' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'EraType' , 'ERA_ATOMIC' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'Amount' , '100' , '-1');
	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'EraType' , 'ERA_INFORMATION' , '-1');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'Amount' , '100' , '-1');

INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_ANCIENT_ERA_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_CLASSICAL_ERA_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_MODERN_ERA_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_ATOMIC_ERA_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_INFORMATION_ERA_CPLMOD');



--==============================================================
--******				R E L I G I O N					  ******
--==============================================================
/*UPDATE UnitCommands SET VisibleInUI=0 WHERE CommandType='UNITCOMMAND_CONDEMN_HERETIC';
UPDATE Map_GreatPersonClasses SET MaxWorldInstances=6 WHERE MapSizeType='MAPSIZE_STANDARD';
UPDATE Map_GreatPersonClasses SET MaxWorldInstances=8 WHERE MapSizeType='MAPSIZE_LARGE';
UPDATE Map_GreatPersonClasses SET MaxWorldInstances=9 WHERE MapSizeType='MAPSIZE_HUGE';
UPDATE Units SET BaseSightRange=1 WHERE UnitType='UNIT_MISSIONARY';
-- remove marytr ability from prasat missionaries
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_PRASAT' AND ModifierId='PRASAT_GRANT_MARTYR'; --DLC
-- reduce debator promotion
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='APOSTLE_DEBATER' AND Name='Amount';
UPDATE ModifierArguments SET Value='100' WHERE ModifierId='APOSTLE_FOREIGN_SPREAD' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='APOSTLE_EVICT_ALL' AND Name='Amount';
-- remove spread from condemning and defeating
UPDATE GlobalParameters SET Value=0 WHERE Name='RELIGION_SPREAD_RANGE_COMBAT_VICTORY';
UPDATE GlobalParameters SET Value=0 WHERE Name='RELIGION_SPREAD_RANGE_UNIT_CAPTURE';*/

-- give monks wall breaker ability
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('ENABLE_WALL_ATTACK_WHOLE_GAME_MONK_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_ENABLE_WALL_ATTACK_WHOLE_GAME_PROMOTION_CLASS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('ENABLE_WALL_ATTACK_WHOLE_GAME_MONK_BBG', 'PromotionClass', 'PROMOTION_CLASS_MONK');
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType) VALUES
	('WARRIOR_MONK_WALL_BREAKER_BBG');
INSERT OR IGNORE INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('WARRIOR_MONK_WALL_BREAKER_BBG', 'ENABLE_WALL_ATTACK_WHOLE_GAME_MONK_BBG');
-- Nerf Inquisitors
UPDATE Units SET ReligionEvictPercent=50, SpreadCharges=2 WHERE UnitType='UNIT_INQUISITOR';
-- Religious spread from trade routes increased
UPDATE GlobalParameters SET Value='2.0' WHERE Name='RELIGION_SPREAD_TRADE_ROUTE_PRESSURE_FOR_DESTINATION';
UPDATE GlobalParameters SET Value='1.0' WHERE Name='RELIGION_SPREAD_TRADE_ROUTE_PRESSURE_FOR_ORIGIN'     ;
-- Divine Inspiration yield increased
UPDATE ModifierArguments SET Value='6' WHERE ModifierId='DIVINE_INSPIRATION_WONDER_FAITH_MODIFIER' AND Name='Amount';
-- Crusader +7 instead of +10
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='JUST_WAR_COMBAT_BONUS_MODIFIER';
-- Lay Ministry now +2 Culture and +2 Faith per Theater and Holy Site
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_CULTURE_DISTRICTS_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_FAITH_DISTRICTS_MODIFIER' AND Name='Amount';
-- Itinerant Preachers now causes a Religion to spread 40% father away instead of only 30%
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='ITINERANT_PREACHERS_SPREAD_DISTANCE';
-- Cross-Cultural Dialogue is now +1 Science for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='CROSS_CULTURAL_DIALOGUE_SCIENCE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Tithe is now +1 Gold for every 3 followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TITHE_GOLD_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- World Church is now +1 Culture for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='WORLD_CHURCH_CULTURE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Zen Meditation now only requires 1 District to get the +1 Amentity
UPDATE RequirementArguments SET Value='1' WHERE RequirementId='REQUIRES_CITY_HAS_2_SPECIALTY_DISTRICTS' AND Name='Amount';
-- Religious Communities now gives +1 Housing to Holy Sites, like it does for Shines and Temples
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_HOUSING');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'ModifierId' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'Amount' , '1');
INSERT OR IGNORE INTO BeliefModifiers (BeliefType , ModifierId)
	VALUES ('BELIEF_RELIGIOUS_COMMUNITY' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_FOLLOWS_RELIGION');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_HAS_HOLY_SITE');
-- Warrior Monks +5 Combat Strength
UPDATE Units SET Combat=40 WHERE UnitType='UNIT_WARRIOR_MONK';
-- Work Ethic now provides production equal to base yield for Shrine and Temple
DELETE From BeliefModifiers WHERE ModifierId='WORK_ETHIC_FOLLOWER_PRODUCTION';
INSERT OR IGNORE INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId)
	VALUES 
	('WORK_ETHIC_SHRINE_PRODUCTION'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_SHRINE'),
	('WORK_ETHIC_TEMPLE_PRODUCTION'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_TEMPLE'),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'MODIFIER_BUILDING_YIELD_CHANGE'      , null                              ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'MODIFIER_BUILDING_YIELD_CHANGE'      , null                              );
INSERT OR IGNORE INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('WORK_ETHIC_SHRINE_PRODUCTION'          , 'ModifierId'   , 'WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER'),
	('WORK_ETHIC_TEMPLE_PRODUCTION'          , 'ModifierId'   , 'WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER'),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'BuildingType' , 'BUILDING_SHRINE'                      ),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'YieldType'    , 'YIELD_PRODUCTION'                     ),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'Amount'       , '2'                                    ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'BuildingType' , 'BUILDING_TEMPLE'                      ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'YieldType'    , 'YIELD_PRODUCTION'                     ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'Amount'       , '4'                                    );
INSERT OR IGNORE INTO BeliefModifiers 
	(BeliefType          , ModifierId)
	VALUES 
	('BELIEF_WORK_ETHIC' , 'WORK_ETHIC_TEMPLE_PRODUCTION'),
	('BELIEF_WORK_ETHIC' , 'WORK_ETHIC_SHRINE_PRODUCTION');
-- Dar E Mehr provides +2 culture instead of faith from eras
DELETE FROM Building_YieldsPerEra WHERE BuildingType='BUILDING_DAR_E_MEHR';
INSERT OR IGNORE INTO Building_YieldChanges 
	(BuildingType          , YieldType       , YieldChange)
	VALUES 
	('BUILDING_DAR_E_MEHR' , 'YIELD_CULTURE' , '2');
-- All worship building production costs reduced	
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_CATHEDRAL'    ;
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_GURDWARA'     ;
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_MEETING_HOUSE';
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_MOSQUE'       ;
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_PAGODA'       ;
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_SYNAGOGUE'    ;
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_WAT'          ;
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_STUPA'        ;
UPDATE Buildings SET Cost='120' WHERE BuildingType='BUILDING_DAR_E_MEHR'   ;



--==============================================================
--******				S  C  O  R  E				  	  ******
--==============================================================
-- more points for techs and civics
UPDATE ScoringLineItems SET Multiplier=4 WHERE LineItemType='LINE_ITEM_CIVICS';
UPDATE ScoringLineItems SET Multiplier=3 WHERE LineItemType='LINE_ITEM_TECHS';
-- less points for wide, more for tall
UPDATE ScoringLineItems SET Multiplier=2 WHERE LineItemType='LINE_ITEM_CITIES';
UPDATE ScoringLineItems SET Multiplier=2 WHERE LineItemType='LINE_ITEM_POPULATION';
-- Wonders Provide +4 score instead of +15
UPDATE ScoringLineItems SET Multiplier=4 WHERE LineItemType='LINE_ITEM_WONDERS';
-- Great People worth only 3 instead of 5
UPDATE ScoringLineItems SET Multiplier=3 WHERE LineItemType='LINE_ITEM_GREAT_PEOPLE';
-- converting foreign populations reduced from 2 to 1
UPDATE ScoringLineItems SET Multiplier=1 WHERE LineItemType='LINE_ITEM_ERA_CONVERTED';



--==============================================================
--******				START BIASES					  ******
--==============================================================
-- t1 take up essential coastal spots first
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_ENGLAND' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_NORWAY' AND TerrainType='TERRAIN_COAST';
-- t2 must haves
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_SPAIN' AND TerrainType='TERRAIN_COAST';
INSERT OR IGNORE INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES ('CIVILIZATION_JAPAN' , 'TERRAIN_COAST' , 2);
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA';
-- t3 identities
UPDATE StartBiasFeatures SET Tier=3 WHERE CivilizationType='CIVILIZATION_BRAZIL' AND FeatureType='FEATURE_JUNGLE';
UPDATE StartBiasFeatures SET Tier=3 WHERE CivilizationType='CIVILIZATION_EGYPT' AND FeatureType='FEATURE_FLOODPLAINS';
UPDATE StartBiasResources SET Tier=3 WHERE CivilizationType='CIVILIZATION_SCYTHIA' AND ResourceType='RESOURCE_HORSES';
-- t4 river mechanics
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_SUMERIA';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_FRANCE';
-- t4 feature mechanics
UPDATE StartBiasFeatures SET Tier=4 WHERE CivilizationType='CIVILIZATION_KONGO' AND FeatureType='FEATURE_JUNGLE';
-- t4 terrain mechanics
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_GRASS_HILLS';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_PLAINS_HILLS';
-- t4 resource mechanics
INSERT OR IGNORE INTO StartBiasResources (CivilizationType , ResourceType , Tier)
	VALUES
	('CIVILIZATION_SCYTHIA' , 'RESOURCE_SHEEP'  , 4),
	('CIVILIZATION_SCYTHIA' , 'RESOURCE_CATTLE' , 4);
-- t5 last resorts
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_DESERT_HILLS';
UPDATE StartBiasFeatures SET Tier=5 WHERE CivilizationType='CIVILIZATION_KONGO' AND FeatureType='FEATURE_FOREST';



--==============================================================
--******			  U N I T S  (NON-UNIQUE)			  ******
--==============================================================
UPDATE UnitCommands SET VisibleInUI=0 WHERE CommandType='UNITCOMMAND_PRIORITY_TARGET';
UPDATE Units SET BaseMoves=3 WHERE UnitType='UNIT_MILITARY_ENGINEER';
UPDATE Units SET Cost=310 WHERE UnitType='UNIT_CAVALRY';
UPDATE Units SET PrereqTech='TECH_STIRRUPS' WHERE UnitType='UNIT_PIKEMAN';
UPDATE Units SET Combat=72 , BaseMoves=3 WHERE UnitType='UNIT_INFANTRY';
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_PRIVATEER';
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES
	('GRAPE_SHOT_REQUIREMENTS',			'PLAYER_IS_ATTACKER_REQUIREMENTS'),
	('SHRAPNEL_REQUIREMENTS',			'PLAYER_IS_ATTACKER_REQUIREMENTS');



--==============================================================
--******					W A L L S					  ******
--==============================================================
UPDATE Buildings SET OuterDefenseHitPoints=75, Cost=100 WHERE BuildingType='BUILDING_WALLS';
UPDATE Buildings SET OuterDefenseHitPoints=75, Cost=200 WHERE BuildingType='BUILDING_CASTLE';
UPDATE Buildings SET OuterDefenseHitPoints=75 WHERE BuildingType='BUILDING_STAR_FORT';
UPDATE ModifierArguments SET Value='300' WHERE ModifierId='STEEL_UNLOCK_URBAN_DEFENSES';



--==============================================================
--******			W O N D E R S  (MAN-MADE)			  ******
--==============================================================
-- Huey gives +2 culture to lake tiles
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
	VALUES ('BUILDING_HUEY_TEOCALLI', 'HUEY_LAKE_CULTURE');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES
	('HUEY_LAKE_CULTURE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'FOODHUEY_PLAYER_REQUIREMENTS'),
	('HUEY_LAKE_CULTURE_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'FOODHUEY_PLOT_IS_LAKE_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
	VALUES
	('HUEY_LAKE_CULTURE', 'ModifierId', 'HUEY_LAKE_CULTURE_MODIFIER'),
	('HUEY_LAKE_CULTURE_MODIFIER', 'Amount', '2'),
	('HUEY_LAKE_CULTURE_MODIFIER', 'YieldType', 'YIELD_CULTURE');
-- cristo gets 1 relic
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , RunOnce , Permanent)
	VALUES ('WONDER_GRANT_RELIC_BBG' , 'MODIFIER_PLAYER_GRANT_RELIC' , 1 , 1);	
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('WONDER_GRANT_RELIC_BBG' , 'Amount' , '1');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId) VALUES
	('BUILDING_CRISTO_REDENTOR', 'WONDER_GRANT_RELIC_BBG');
-- Hanging Gardens gives +1 housing to cities within 6 tiles
UPDATE Buildings SET Housing='1' WHERE BuildingType='BUILDING_HANGING_GARDENS';
INSERT OR IGNORE INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_HANGING_GARDENS' , 'HANGING_GARDENS_REGIONAL_HOUSING');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_HOUSING' , 'HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING' , 'Amount' , '1');
INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ANY');
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6');
INSERT OR IGNORE INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES');
INSERT OR IGNORE INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'BuildingType' ,'BUILDING_HANGING_GARDENS');
INSERT OR IGNORE INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'MaxRange' ,'6');
INSERT OR IGNORE INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'MinRange' ,'0');

-- Great Library unlocks at Drama & Poetry instead of Recorded History
UPDATE Buildings SET PrereqCivic='CIVIC_DRAMA_POETRY' WHERE BuildingType='BUILDING_GREAT_LIBRARY';

-- Venetian Arsenal gives 100% production boost to all naval units in all cities instead of an extra naval unit in its city each time you build one
DELETE FROM BuildingModifiers WHERE	BuildingType='BUILDING_VENETIAN_ARSENAL';

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_MELEE_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_MELEE_PRODUCTION');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RANGED_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RANGED_PRODUCTION');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RAIDER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RAIDER_PRODUCTION');

INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_CARRIER_PRODUCTION');
INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_CARRIER_PRODUCTION');



--==============================================================
--******			W O N D E R S  (NATURAL)			  ******
--==============================================================
-- great barrier reef gives +2 science adj
INSERT OR IGNORE INTO District_Adjacencies VALUES
	('DISTRICT_CAMPUS', 'BarrierReef_Science');
INSERT OR IGNORE INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentFeature) VALUES
	('BarrierReef_Science', 'LOC_DISTRICT_REEF_SCIENCE', 'YIELD_SCIENCE', 2, 1, 'FEATURE_BARRIER_REEF');
-- Several lack-luster wonders improved
UPDATE Features SET Settlement=1 WHERE FeatureType='FEATURE_CLIFFS_DOVER';
INSERT OR IGNORE INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_PANTANAL', 'YIELD_SCIENCE', 2);
INSERT OR IGNORE INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_CLIFFS_DOVER', 'YIELD_FOOD', 2);
INSERT OR IGNORE INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_DEAD_SEA', 'YIELD_FOOD', 2);
INSERT OR IGNORE INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_CRATER_LAKE', 'YIELD_FOOD', 2);
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_CRATER_LAKE' AND YieldType='YIELD_SCIENCE'; 
INSERT OR IGNORE INTO Feature_AdjacentYields (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_GALAPAGOS', 'YIELD_FOOD', 1);



--==============================================================
--******				    O T H E R					  ******
--==============================================================
-- chancery science from captured spies increased
UPDATE ModifierArguments SET Value='200' WHERE ModifierId='CHANCERY_COUNTERYSPY_SCIENCE' AND Name='Amount';
-- oil can be found on flat plains
INSERT OR IGNORE INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_OIL', 'TERRAIN_PLAINS');
-- incense +1 food
INSERT OR IGNORE INTO Resource_YieldChanges (ResourceType, YieldType, YieldChange)
	VALUES ('RESOURCE_INCENSE', 'YIELD_FOOD', 1);
-- add 1 production to fishing boat improvement
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_FISHING_BOATS' AND YieldType='YIELD_PRODUCTION';

-- Citizen specialists give +1 main yield
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_ACROPOLIS";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_CAMPUS";
UPDATE District_CitizenYieldChanges SET YieldChange=4 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_COMMERCIAL_HUB";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_ENCAMPMENT";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_HANSA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_HARBOR";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_HOLY_SITE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_INDUSTRIAL_ZONE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_LAVRA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_ROYAL_NAVY_DOCKYARD";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_THEATER";

--****		REQUIREMENTS		****--
INSERT OR IGNORE INTO Requirements
	(RequirementId , RequirementType)
	VALUES
	('PLAYER_HAS_MEDIEVAL_FAIRES_CPLMOD', 	'REQUIREMENT_PLAYER_HAS_CIVIC'),
	('PLAYER_HAS_URBANIZATION_CPLMOD', 		'REQUIREMENT_PLAYER_HAS_CIVIC'),
	('PLAYER_HAS_BANKING_CPLMOD'   , 		'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'),
	('PLAYER_HAS_ECONOMICS_CPLMOD' , 		'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT OR IGNORE INTO RequirementArguments
	(RequirementId , Name , Value)
	VALUES
	('PLAYER_HAS_MEDIEVAL_FAIRES_CPLMOD',	'CivicType', 		'CIVIC_MEDIEVAL_FAIRES'  ),
	('PLAYER_HAS_URBANIZATION_CPLMOD', 	 	'CivicType', 		'CIVIC_URBANIZATION'),
	('PLAYER_HAS_BANKING_CPLMOD'   , 		'TechnologyType', 	'TECH_BANKING'  ),
	('PLAYER_HAS_ECONOMICS_CPLMOD' , 		'TechnologyType', 	'TECH_ECONOMICS');






