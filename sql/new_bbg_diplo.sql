-- By: iElden

-- Each City-state suz give 2 diplomatic favor.
UPDATE GlobalParameters SET Value=2 WHERE Name='WORLD_CONGRESS_SUZERAIN_FAVOR_PER_TURN';

-- DV Resolution to -3 points (from -2)
UPDATE ModifierArguments SET Value='-3' WHERE ModifierId='SUBTRACT_DIPLOMATIC_VICTORY_POINTS' AND Name='Amount';