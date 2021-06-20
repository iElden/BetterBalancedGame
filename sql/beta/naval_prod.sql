-- By: iElden

UPDATE ModifierArguments SET Value='50' WHERE Name='Amount' AND ModifierId IN (
    SELECT ModifierId FROM PolicyModifiers WHERE PolicyType IN
        ('POLICY_MARITIME_INDUSTRIES', 'POLICY_PRESS_GANGS', 'POLICY_INTERNATIONAL_WATERS')
);