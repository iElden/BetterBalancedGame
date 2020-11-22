------------------------------------------------------------------------------
--	FILE:	 new_bbg_gilgamesh.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database leader related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******			GILGAMESH					 	  ******
--==============================================================================================
-- Delete some old Traits as they are buggy :( 
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_ADVENTURES_ENKIDU';

-- Give the Barb modifier + Levy Discount + Add combat experience
INSERT INTO TraitModifiers
		(TraitType,									ModifierId)
VALUES	('TRAIT_LEADER_ADVENTURES_ENKIDU', 			'TRAIT_BARBARIAN_CAMP_GOODY'),
		('TRAIT_LEADER_ADVENTURES_ENKIDU', 			'TRAIT_GILGAMESH_COMBAT_EXPERIENCE'),
		('TRAIT_LEADER_ADVENTURES_ENKIDU', 			'TRAIT_LEVY_DISCOUNT');

INSERT INTO Modifiers
		(ModifierId,										ModifierType,														SubjectRequirementSetId)
VALUES	('TRAIT_GILGAMESH_COMBAT_EXPERIENCE',				'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_EXPERIENCE_MODIFIER',			NULL);

INSERT INTO ModifierArguments
		(ModifierId,										Name,						Value)
VALUES	('TRAIT_GILGAMESH_COMBAT_EXPERIENCE',				'Amount',					20);

-- Sumerian War Carts as a starting unit in Ancient is coded on the lua front
