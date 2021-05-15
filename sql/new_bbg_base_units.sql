------------------------------------------------------------------------------
--	FILE:	 new_bbg_base_units.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database leader related modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******						STANDARD UNITS FROM VANILLA GAME							******
--==============================================================================================
-- Jack the Ripper proposal (31/12/2020) to boost Naval Movement
-- Base is 3, Resource cost / Maintenance is 1 in GS
UPDATE Units SET BaseMoves='4' WHERE  UnitType='UNIT_SUBMARINE';

-- Base is 4
UPDATE Units SET BaseMoves='6' WHERE  UnitType='UNIT_DESTROYER';
-- Base is 3
UPDATE Units SET BaseMoves='5' WHERE  UnitType='UNIT_AIRCRAFT_CARRIER';

-- Battleship Ranged Combat from 70 to 75
UPDATE Units SET Combat='65', RangedCombat='75' WHERE UnitType='UNIT_BATTLESHIP';
