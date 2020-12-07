------------------------------------------------------------------------------
--	FILE:	 new_bbg_cv_2.sql
--	AUTHOR:  iElden, D. / Jack The Narrator
--	PURPOSE: Database modifications by new BBG
------------------------------------------------------------------------------
--==============================================================================================
--******				CV: FASTEST SETTING a.k.a Legacy BBG				  ******
--==============================================================================================

-- moon landing worth 5x science in culture instead of 10x
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='PROJECT_COMPLETION_GRANT_CULTURE_BASED_ON_SCIENCE_RATE' AND Name='Multiplier';
-- computers and environmentalism tourism boosts to 50% (from 25%)
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='COMPUTERS_BOOST_ALL_TOURISM';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='ENVIRONMENTALISM_BOOST_ALL_TOURISM'; 
-- base wonder tourism adjusted to 5
UPDATE GlobalParameters SET Value='5' WHERE Name='TOURISM_BASE_FROM_WONDER';
-- Reduce amount of tourism needed for foreign tourist from 200 to 150
UPDATE GlobalParameters SET Value='150' WHERE Name='TOURISM_TOURISM_TO_MOVE_CITIZEN';
-- lower number of turns to move greatworks between cities
UPDATE GlobalParameters SET Value='2' WHERE Name='GREATWORK_ART_LOCK_TIME';
-- relics give 4 tourism instead of 8
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIC';
--

-- fix same artist, same archelogist culture and tourism from bing 1 and 1 to being default numbers
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonYield=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';

-- books give 4 culture and 2 tourism each (8 and 4 for each great person)
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE YieldChange=2;
-- artworks give 4 culture and 4 tourism instead of 3 and 2 ( 12/12 for each GP)
-- artifacts give 6 culture and 6 tourism instead of 3 and 3 ( 18/18 for each GP)
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIGIOUS';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_SCULPTURE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_LANDSCAPE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_PORTRAIT';
UPDATE GreatWorks SET Tourism=6 WHERE GreatWorkObjectType='GREATWORKOBJECT_ARTIFACT';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_4';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_5';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_6';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_7';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_8';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_9';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_10';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_11';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_12';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_13';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_14';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_15';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_16';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_17';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_18';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_19';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_20';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_21';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_22';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_23';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_24';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_25';

-- music gives 12 culture and 8 tourism instead of 4 and 4 (24/16 per GP)
UPDATE GreatWorks SET Tourism=8 WHERE GreatWorkObjectType='GREATWORKOBJECT_MUSIC';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_2';
	
