-- Created by iElden

-- Delete Cothon full heal
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='COTHON_HEALFRIENDLY' AND Name='Amount';

-- Delete settler PM
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='MEDITERRANEAN_COLONIES_EXTRA_MOVEMENT';