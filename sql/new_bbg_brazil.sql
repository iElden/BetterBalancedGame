-- Author: iElden

-- Carnivals don't require population
UPDATE Districts SET RequiresPopulation=0 WHERE DistrictType IN ('DISTRICT_STREET_CARNIVAL', 'DISTRICT_WATER_STREET_CARNIVAL');

-- Up Minas by +5/+5 to match battleship up
UPDATE Units SET Combat=75, RangedCombat=85 WHERE UnitType='UNIT_BRAZILIAN_MINAS_GERAES';