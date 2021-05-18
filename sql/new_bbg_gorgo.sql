-- Author: iElden

-- Delete old gorgo ability

DELETE FROM TraitModifiers WHERE TraitType='CULTURE_KILLS_TRAIT' AND ModifierId='UNIQUE_LEADER_CULTURE_KILLS_GRANT_ABILITY';

-- ================================
-- Military power by red card slot.
-- ================================
-- Create Modifier for each gouvernments
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'BBG_PLAYER_IS_GORGO'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) VALUES
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'BBG_PLAYER_IS_GORGO');

INSERT INTO ModifierArguments(ModifierId, Name, Value)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'Amount', NumSlots
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'Amount', '1');

INSERT INTO ModifierStrings(ModifierId, Context, Text)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'Preview', 'BBG_GORGO_GOVERNMENT_COMBAT_BONUS'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'Preview', 'BBG_GORGO_ALHAMBRA_COMBAT_BONUS');

-- Attach modifier to building
INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
    ('BUILDING_ALHAMBRA', 'BBG_MODIFIER_GORGO_ALHAMBRA');

-- Attach modifier to government
INSERT INTO GovernmentModifiers(GovernmentType, ModifierId)
    SELECT GovernmentType, 'BBG_MODIFIER_GORGO_' || GovernmentType
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;

-- Create IS_GORGO requirement
INSERT OR IGNORE INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('BBG_PLAYER_IS_GORGO', 'REQUIREMENTSET_TEST_ANY');

INSERT OR IGNORE INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('BBG_PLAYER_IS_GORGO', 'BBG_PLAYER_IS_GORGO_REQUIREMENT');

INSERT OR IGNORE INTO Requirements(RequirementId , RequirementType) VALUES
	('BBG_PLAYER_IS_GORGO_REQUIREMENT' , 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');

INSERT OR IGNORE INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('BBG_PLAYER_IS_GORGO_REQUIREMENT' , 'LeaderType', 'LEADER_GORGO');