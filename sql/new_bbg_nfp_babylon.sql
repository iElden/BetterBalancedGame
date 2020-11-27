--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_TRAIT_BABYLON_EUREKA', 'MODIFIER_PLAYER_ADJUST_TECHNOLOGY_BOOST');

INSERT INTO ModifierArguments(ModifierId, Name, Value, Extra) VALUES
    ('BBG_TRAIT_BABYLON_EUREKA', 'Amount', '45', '-1');

DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_BABYLON' AND ModifierID='TRAIT_EUREKA_INCREASE';
INSERT INTO TraitModifiers(TraitType, ModifierID) VALUES
    ('TRAIT_CIVILIZATION_BABYLON', 'BBG_TRAIT_BABYLON_EUREKA');