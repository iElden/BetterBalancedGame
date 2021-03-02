-- BBG Great work

-- Relic
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIC';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE YieldType='YIELD_FAITH' AND
  EXISTS(SELECT * FROM GreatWorks WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIC' AND
         GreatWorks.GreatWorkType = GreatWork_YieldChanges.GreatWorkType);

-- Writing
UPDATE GreatWorks SET Tourism=2 WHERE GreatWorkObjectType='GREATWORKOBJECT_WRITING';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE YieldType='YIELD_CULTURE' AND
  EXISTS(SELECT * FROM GreatWorks WHERE GreatWorkObjectType='GREATWORKOBJECT_WRITING' AND
         GreatWorks.GreatWorkType = GreatWork_YieldChanges.GreatWorkType);

-- Music
UPDATE GreatWorks SET Tourism=8 WHERE GreatWorkObjectType='GREATWORKOBJECT_MUSIC';
UPDATE GreatWork_YieldChanges SET YieldChange=12 WHERE YieldType='YIELD_CULTURE' AND
  EXISTS(SELECT * FROM GreatWorks WHERE GreatWorkObjectType='GREATWORKOBJECT_MUSIC' AND
         GreatWorks.GreatWorkType = GreatWork_YieldChanges.GreatWorkType);

-- Artifact
UPDATE GreatWorks SET Tourism=6 WHERE GreatWorkObjectType='GREATWORKOBJECT_ARTIFACT';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE YieldType='YIELD_CULTURE' AND
  EXISTS(SELECT * FROM GreatWorks WHERE GreatWorkObjectType='GREATWORKOBJECT_ARTIFACT' AND
         GreatWorks.GreatWorkType = GreatWork_YieldChanges.GreatWorkType);

-- Artist
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType IN
    ('GREATWORKOBJECT_PORTRAIT', 'GREATWORKOBJECT_LANDSCAPE', 'GREATWORKOBJECT_RELIGIOUS', 'GREATWORKOBJECT_SCULPTURE');
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE YieldType='YIELD_CULTURE' AND
  EXISTS(SELECT * FROM GreatWorks WHERE GreatWorkObjectType IN
    ('GREATWORKOBJECT_PORTRAIT', 'GREATWORKOBJECT_LANDSCAPE', 'GREATWORKOBJECT_RELIGIOUS', 'GREATWORKOBJECT_SCULPTURE')
  AND GreatWorks.GreatWorkType = GreatWork_YieldChanges.GreatWorkType
  );