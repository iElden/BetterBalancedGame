------------------------------------------------------------------------------
--	FILE:	 new_bbg_sv_1.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******				SV: FAST SETTINGS 											 ******
--==============================================================================================

UPDATE GlobalParameters SET Value='1' WHERE Name='SCIENCE_VICTORY_POINTS_REQUIRED';
UPDATE Projects SET Cost='1500' WHERE ProjectType='PROJECT_LAUNCH_EXOPLANET_EXPEDITION';
UPDATE Projects SET Cost='1500' WHERE ProjectType='PROJECT_LAUNCH_MARS_BASE';
