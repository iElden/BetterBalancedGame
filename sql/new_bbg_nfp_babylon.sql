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


-- 2020/12/16 - Ayutthaya Culture bug fix
-- https://github.com/iElden/BetterBalancedGame/issues/48

UPDATE ModifierArguments SET Value=60 WHERE ModifierId="MINOR_CIV_AYUTTHAYA_CULTURE_COMPLETE_BUILDING" AND Name="BuildingProductionPercent";
UPDATE ModifierArguments SET Value=24 WHERE ModifierId="CARDINAL_CITADEL_OF_GOD_FAITH_FINISH_BUILDINGS" AND Name="BuildingProductionPercent";
-- Scenario: Building momument on Online speed with 30 production code
-- BuildingProductionPercent    Faith   Percentage
-- 0                            0       0%
-- 1                            180     600%
-- 6                            30      100%
-- 10                           18      60% -- Current Ayutthaya 
-- 17.5                         10.5    35%
-- 24                           7.5     25% -- Correct Moksha
-- 25                           7.2     24% -- Current Moksha 
-- 50                           3.6     12%
-- 60                           3       10% -- Correct Ayutthaya
-- 6 * ProductionCost / BuildingProductionPercent = Yield
-- Therefore =>  
-- USE THIS FORMULA TO CALCULATE THE DESIRED ((BuildingProductionPercent)) FIELD
-- BuildingProductionPercent =  ProductionCost * 6 / Yield
