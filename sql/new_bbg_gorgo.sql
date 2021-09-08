-- Author: iElden

-- ================================
-- Military power by red card slot.
-- ================================

-- Delete old gorgo ability
DELETE FROM TraitModifiers WHERE TraitType='CULTURE_KILLS_TRAIT' AND ModifierId='UNIQUE_LEADER_CULTURE_KILLS_GRANT_ABILITY';

-- Create Modifier for each gouvernments
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId)
    SELECT 'BBG_GIVE_MODIFIER_GORGO_' || GovernmentType, 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'BBG_PLAYER_IS_GORGO'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO Modifiers(ModifierId, ModifierType)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) VALUES
    ('BBG_GIVE_MODIFIER_GORGO_ALHAMBRA', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'BBG_PLAYER_IS_GORGO'),
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL);

INSERT INTO ModifierArguments(ModifierId, Name, Value)
    SELECT 'BBG_GIVE_MODIFIER_GORGO_' || GovernmentType, 'AbilityType', 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierArguments(ModifierId, Name, Value)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'Amount', NumSlots
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_GIVE_MODIFIER_GORGO_ALHAMBRA', 'AbilityType', 'BBG_GORGO_COMBAT_ABILITY_ALHAMBRA'),
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'Amount', '1');

INSERT INTO ModifierStrings(ModifierId, Context, Text)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'Preview', 'BBG_GORGO_GOVERNMENT_COMBAT_BONUS'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'Preview', 'BBG_GORGO_ALHAMBRA_COMBAT_BONUS');

-- Create Unit Ability
INSERT INTO Types(Type, Kind)
	SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'KIND_ABILITY'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT OR IGNORE INTO Types(Type, Kind) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'KIND_ABILITY');

INSERT INTO TypeTags(Type, Tag)
    SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'CLASS_ALL_COMBAT_UNITS'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO TypeTags(Type, Tag) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'CLASS_ALL_COMBAT_UNITS');

INSERT INTO UnitAbilities(UnitAbilityType , Name, Description, Inactive)
	SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'LOC_BBG_GORGO_COMBAT_ABILITY_NAME', 'LOC_BBG_GORGO_COMBAT_ABILITY_DESCRIPTION', 1
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO UnitAbilities(UnitAbilityType , Name, Description, Inactive) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'LOC_BBG_GORGO_COMBAT_ABILITY_NAME', 'LOC_BBG_GORGO_COMBAT_ABILITY_DESCRIPTION', 1);

INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId)
    SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'BBG_MODIFIER_GORGO_' || GovernmentType
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'BBG_MODIFIER_GORGO_ALHAMBRA');

-- Attach modifier to building
INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
    ('BUILDING_ALHAMBRA', 'BBG_GIVE_MODIFIER_GORGO_ALHAMBRA');

-- Attach modifier to government
INSERT INTO GovernmentModifiers(GovernmentType, ModifierId)
    SELECT GovernmentType, 'BBG_GIVE_MODIFIER_GORGO_' || GovernmentType
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;

-- Create IS_GORGO requirement
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('BBG_PLAYER_IS_GORGO', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('BBG_PLAYER_IS_GORGO', 'BBG_PLAYER_IS_GORGO_REQUIREMENT');

INSERT INTO Requirements(RequirementId , RequirementType) VALUES
	('BBG_PLAYER_IS_GORGO_REQUIREMENT' , 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');

INSERT INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('BBG_PLAYER_IS_GORGO_REQUIREMENT' , 'LeaderType', 'LEADER_GORGO');