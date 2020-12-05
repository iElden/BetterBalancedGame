------------------------------------------------------------------------------
--	FILE:	 new_bbg_religion.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******				R E L I G I O N					  ******
--==============================================================================================
/*
-- Distance for religion spread, base game is 10
--UPDATE GlobalParameters SET Value='20' WHERE Name='RELIGION_SPREAD_ADJACENT_CITY_DISTANCE';

-- Strength for religion spread, base game is 1
--UPDATE GlobalParameters SET Value='1' WHERE Name='RELIGION_SPREAD_ADJACENT_PER_TURN_PRESSURE';

-- Adjust Itinerant preachers base game is 30% so 3 for 10, hence changing from 6 for 20 to maintain 30% ratio
--UPDATE ModifierArguments SET Value='3' WHERE ModifierId='ITINERANT_PREACHERS_SPREAD_DISTANCE';

-- This is to increase the Strength of the pressure base on the civic tree
INSERT OR IGNORE INTO Types 
	(Type, Kind)
	VALUES
	('MODIFIER_ALL_CITIES_RELIGION_PRESSURE', 'KIND_MODIFIER');

INSERT OR IGNORE INTO DynamicModifiers 
	(ModifierType, CollectionType, EffectType)
	VALUES
	('MODIFIER_ALL_CITIES_RELIGION_PRESSURE', 'COLLECTION_PLAYER_CITIES', 'EFFECT_ADJUST_CITY_RELIGION_PRESSURE');

INSERT OR IGNORE INTO Modifiers 
	(ModifierId, ModifierType)
	VALUES
	('MODIIFIER_DECREASE_75_RELIGIOUS_PRESSURE', 'MODIFIER_ALL_CITIES_RELIGION_PRESSURE'),
	('MODIIFIER_ADD_25_RELIGIOUS_PRESSURE', 'MODIFIER_ALL_CITIES_RELIGION_PRESSURE'),
	('MODIIFIER_ADD_50_RELIGIOUS_PRESSURE', 'MODIFIER_ALL_CITIES_RELIGION_PRESSURE'),
	('MODIIFIER_ADD_100_RELIGIOUS_PRESSURE', 'MODIFIER_ALL_CITIES_RELIGION_PRESSURE');

INSERT OR IGNORE INTO ModifierArguments 
	(ModifierId, Name, Value)
	VALUES
	('MODIIFIER_DECREASE_75_RELIGIOUS_PRESSURE', 'Amount','-75'),
	('MODIIFIER_ADD_25_RELIGIOUS_PRESSURE', 'Amount', '25'),
	('MODIIFIER_ADD_50_RELIGIOUS_PRESSURE', 'Amount', '50'),
	('MODIIFIER_ADD_100_RELIGIOUS_PRESSURE', 'Amount', '100');

--INSERT OR IGNORE INTO CivicModifiers 
--	(CivicType , ModifierId)
--	VALUES
--	('CIVIC_CODE_OF_LAWS','MODIIFIER_DECREASE_75_RELIGIOUS_PRESSURE'),
--	('CIVIC_MYSTICISM','MODIIFIER_ADD_25_RELIGIOUS_PRESSURE'),
--	('CIVIC_THEOLOGY','MODIIFIER_ADD_50_RELIGIOUS_PRESSURE'),
--	('CIVIC_REFORMED_CHURCH','MODIIFIER_ADD_50_RELIGIOUS_PRESSURE');
*/	

UPDATE ModifierArguments SET Value='0' WHERE ModifierId='DANCE_OF_THE_AURORA_FAITHTUNDRAHILLSADJACENCY' AND Name='Amount';
