
-- Portugal UI (Feitora) nerf
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TRADE_GOLD_FROM_FEITORIA' AND Name='Amount';

-- Nau can build only 1 Feitora
UPDATE Units SET BuildCharges=1 WHERE UnitType='UNIT_PORTUGUESE_NAU';

-- Remove trade route on meet
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_JOAO_III' AND ModifierId='TRAIT_JOAO_TRADE_ROUTE_ON_MEET';

-- ===Give 1 traderoute per era===
INSERT INTO Requirements(RequirementId, RequirementType)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'REQUIREMENT_GAME_ERA_IS'
    FROM Eras;
INSERT INTO RequirementArguments(RequirementId, Name, Value)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENT', 'EraType', EraType
    FROM Eras;
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL'
    FROM Eras;
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId)
    SELECT 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENTS', 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENT'
    FROM Eras;

INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId, RunOnce, Permanent)
    SELECT 'BBG_GRANT_TRADE_ROUTE_ON_' || EraType, 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY', 'BBG_PLAYER_IS_IN_' || EraType || '_REQUIREMENTS', 1, 1
    FROM Eras;
INSERT INTO ModifierArguments (ModifierId, Name, Value)
    SELECT 'BBG_GRANT_TRADE_ROUTE_ON_' || EraType, 'Amount', '1'
    FROM Eras;

INSERT INTO TraitModifiers(TraitType, ModifierId)
    SELECT 'TRAIT_LEADER_JOAO_III', 'BBG_GRANT_TRADE_ROUTE_ON_' || EraType
    FROM Eras;


-- === Etemenanki ===
UPDATE ModifierArguments SET Value=1 WHERE ModifierId='ETEMENANKI_SCIENCE_MARSH' AND Name='Amount';