
-- Create requirements for each technology
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