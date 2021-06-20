-- By: iElden

UPDATE ModifierArguments SET Value='50' WHERE Name='Amount' AND ModifierId IN (
    SELECT ModifierId FROM PolicyModifiers WHERE PolicyType='POLICY_LIMES'
);