
-- Create requirements for each technology
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType, 'REQUIREMENTSET_TEST_ALL' FROM Technologies;
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY' FROM Technologies;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT', 'TechnologyType', TechnologyType FROM Technologies;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_UTILS_PLAYER_HAS_' || TechnologyType, 'BBG_UTILS_PLAYER_HAS_' || TechnologyType || '_REQUIREMENT' FROM Technologies;