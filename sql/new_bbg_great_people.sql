-- Reduce Imhotep to 1 charge
UPDATE GreatPersonIndividuals SET ActionCharges=1 WHERE GreatPersonIndividualType='GREAT_PERSON_INDIVIDUAL_IMHOTEP';

-- Fix Ibn Khaldun Bug
UPDATE ModifierArguments SET Value=4 WHERE Name='Amount' AND ModifierId IN
    ('GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_HAPPY_SCIENCE', 'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_HAPPY_CULTURE', 'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_HAPPY_PRODUCTION',
    'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_HAPPY_GOLD', 'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_HAPPY_FAITH');
UPDATE ModifierArguments SET Value=8 WHERE Name='Amount' AND ModifierId IN
    ('GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_ECSTATIC_SCIENCE', 'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_ECSTATIC_CULTURE', 'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_ECSTATIC_PRODUCTION',
    'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_ECSTATIC_GOLD', 'GREAT_PERSON_INDIVIDUAL_IBN_KHALDUN_EMPIRE_ECSTATIC_FAITH');