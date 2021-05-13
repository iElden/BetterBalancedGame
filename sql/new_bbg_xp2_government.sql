--
-- Government xp2
--

-- Replace +2 favor on renaissance wall with monarchy to +2 culture
UPDATE Modifiers SET ModifierType='MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE' WHERE ModifierId='MONARCHY_STARFORT_FAVOR';
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='MONARCHY_STARFORT_FAVOR';

DELETE FROM ModifierArguments WHERE ModifierId='MONARCHY_STARFORT_FAVOR';
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('MONARCHY_STARFORT_FAVOR', 'BuildingType', 'BUILDING_STAR_FORT'),
    ('MONARCHY_STARFORT_FAVOR', 'YieldType', 'YIELD_CULTURE'),
    ('MONARCHY_STARFORT_FAVOR', 'Amount', '2');

-- merchant republic now 1311 instead of 1221
UPDATE Government_SlotCounts SET NumSlots=3 WHERE GovernmentType = 'GOVERNMENT_MERCHANT_REPUBLIC' AND GovernmentSlotType = 'SLOT_ECONOMIC';
UPDATE Government_SlotCounts SET NumSlots=1 WHERE GovernmentType = 'GOVERNMENT_MERCHANT_REPUBLIC' AND GovernmentSlotType = 'SLOT_DIPLOMATIC';