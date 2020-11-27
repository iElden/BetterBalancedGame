--==============================================================
--******			       CITY STATES      			  ******
--==============================================================

-- Ngazargamu give 10% reduction insead on 20% reduction
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='MINOR_CIV_NGAZARGAMU_BARRACKS_STABLE_PURCHASE_BONUS';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='MINOR_CIV_NGAZARGAMU_ARMORY_PURCHASE_BONUS';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='MINOR_CIV_NGAZARGAMU_MILITARY_ACADEMY_PURCHASE_BONUS';