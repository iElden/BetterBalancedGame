------------------------------------------------------------------------------
--	FILE:	 new_bbg_sv_1.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******				SV: FAST SETTINGS 											 ******
--==============================================================================================

UPDATE GlobalParameters SET Value='45' WHERE Name='SCIENCE_VICTORY_POINTS_REQUIRED';
UPDATE Projects SET Cost='1500' WHERE ProjectType='PROJECT_LAUNCH_EXOPLANET_EXPEDITION';
UPDATE Projects SET Cost='1500' WHERE ProjectType='PROJECT_LAUNCH_MARS_BASE';

UPDATE Technologies SET Cost='1700' WHERE TechnologyType='TECH_SEASTEADS';
UPDATE Technologies SET Cost='1700' WHERE TechnologyType='TECH_ADVANCED_AI';
UPDATE Technologies SET Cost='1700' WHERE TechnologyType='TECH_ADVANCED_POWER_CELLS';
UPDATE Technologies SET Cost='1700' WHERE TechnologyType='TECH_CYBERNETICS';
UPDATE Technologies SET Cost='1700' WHERE TechnologyType='TECH_PREDICTIVE_SYSTEMS';
UPDATE Technologies SET Cost='2000' WHERE TechnologyType='TECH_OFFWORLD_MISSION';