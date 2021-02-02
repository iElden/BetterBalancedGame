-- Created by iElden

-- Delete Cothon full heal
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='COTHON_HEALFRIENDLY' AND Name='Amount';

-- nerf settler PM to +1
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='MEDITERRANEAN_COLONIES_EXTRA_MOVEMENT';