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



-- Babylon - Nalanda infinite technology re-suze fix.
-- Remove the trait modifier from the Nalanda Minor
--  This was the initial cause of the problem.  
--   The context was destroyed when suzerain was lost, and recreated when suzerain was gained.  
--   Moving the context to the Game instance solves this problem.
DELETE FROM TraitModifiers WHERE ModifierId="MINOR_CIV_NALANDA_FREE_TECHNOLOGY";

-- We don't care about these modifiers anymore, they are connected to the TraitModifier
DELETE FROM Modifiers WHERE ModifierId="MINOR_CIV_NALANDA_FREE_TECHNOLOGY_MODIFIER";
DELETE FROM Modifiers WHERE ModifierId="MINOR_CIV_NALANDA_FREE_TECHNOLOGY";

-- Attach the modifier to check for improvement to each player
INSERT INTO Modifiers 
	(ModifierId, ModifierType)
	VALUES
	('MINOR_CIV_NALANDA_MAHAVIHARA', "MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER");

-- Modifier to actually check if the improvement is built, only done once
INSERT INTO Modifiers 
	(ModifierId, ModifierType, OwnerRequirementSetId, RunOnce, Permanent)
	VALUES
	('MINOR_CIV_NALANDA_MAHAVIHARA_TECH_ON_FIRST_BUILD', "MODIFIER_PLAYER_GRANT_RANDOM_TECHNOLOGY", "PLAYER_HAS_MAHAVIHARA", 1, 1);

INSERT INTO ModifierArguments
    (ModifierId, Name, Type, Value)
    VALUES
    ('MINOR_CIV_NALANDA_MAHAVIHARA', 'ModifierId', 'ARGTYPE_IDENTITY', 'MINOR_CIV_NALANDA_MAHAVIHARA_TECH_ON_FIRST_BUILD'),
    ('MINOR_CIV_NALANDA_MAHAVIHARA_TECH_ON_FIRST_BUILD', 'Amount', 'ARGTYPE_IDENTITY', 1);

-- Modifier which triggers and attaches to all players when game is created 
INSERT INTO GameModifiers
    (ModifierId)
    VALUES
    ('MINOR_CIV_NALANDA_MAHAVIHARA');


-- 2020/12/19 - Add Mahavihara faith adjacencies for Lavra as well as Holy Site
-- https://github.com/iElden/BetterBalancedGame/issues/51
INSERT INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict)
    VALUES ("Mahavihara_Lavra_Faith", "Placeholder","YIELD_FAITH", 1, 1, "DISTRICT_LAVRA");

INSERT INTO Improvement_Adjacencies (ImprovementType, YieldChangeId)
    VALUES ("IMPROVEMENT_MAHAVIHARA","Mahavihara_Lavra_Faith");