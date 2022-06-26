
-- Create requirements for each technology (Babylon)
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType, 'REQUIREMENTSET_TEST_ALL' FROM Technologies;
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY' FROM Technologies;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'TechnologyType', TechnologyType FROM Technologies;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType, 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT' FROM Technologies;

-- Create requirements for each ressources
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('PLAYER_CAN_SEE_HORSES_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_IRON_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_NITER_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_COAL_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_ALUMINUM_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_OIL_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PLAYER_CAN_SEE_URANIUM_CPLMOD', 	'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('PLAYER_CAN_SEE_HORSES_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_HORSES'),
	('PLAYER_CAN_SEE_IRON_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_IRON'),
	('PLAYER_CAN_SEE_NITER_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_NITER'),
	('PLAYER_CAN_SEE_COAL_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_COAL'),
	('PLAYER_CAN_SEE_ALUMINUM_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_ALUMINUM'),
	('PLAYER_CAN_SEE_OIL_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_OIL'),
	('PLAYER_CAN_SEE_URANIUM_CPLMOD', 'REQUIRES_PLAYER_CAN_SEE_URANIUM');

--==== Create Requirement for each city-states (Teddy-RR) ====--
-- Create table
CREATE TABLE BBG_CityStates(
    LeaderType TEXT NOT NULL PRIMARY KEY,
    InheritFrom TEXT,
    BaseYieldType TEXT
);
-- Fill table
INSERT INTO BBG_CityStates(LeaderType, InheritFrom, BaseYieldType)
    SELECT LeaderType, InheritFrom, (CASE InheritFrom
        WHEN 'LEADER_MINOR_CIV_TRADE' THEN 'YIELD_GOLD'
        WHEN 'LEADER_MINOR_CIV_SCIENTIFIC' THEN 'YIELD_SCIENCE'
        WHEN 'LEADER_MINOR_CIV_CULTURAL' THEN 'YIELD_CULTURE'
        WHEN 'LEADER_MINOR_CIV_RELIGIOUS' THEN 'YIELD_FAITH'
        ELSE 'YIELD_PRODUCTION' END)
    FROM Leaders WHERE InheritFrom LIKE 'LEADER\_MINOR\_CIV\_%' ESCAPE '\' AND InheritFrom!='LEADER_MINOR_CIV_DEFAULT';

-- Create Requirement for each City-State type
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT DISTINCT 'BBG_PLAYER_IS_' || InheritFrom, 'REQUIREMENTSET_TEST_ANY' FROM BBG_CityStates;
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_PLAYER_IS_' || LeaderType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES' FROM BBG_CityStates;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_PLAYER_IS_' || LeaderType || '_REQUIREMENT', 'LeaderType', LeaderType FROM BBG_CityStates;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_PLAYER_IS_' || InheritFrom, 'BBG_PLAYER_IS_' || LeaderType || '_REQUIREMENT' FROM BBG_CityStates;