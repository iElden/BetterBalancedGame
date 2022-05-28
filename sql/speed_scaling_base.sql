-- by: iElden
-- THIS FILE ONLY LOAD IF THE GAMESPEED IS SET TO "ONLINE" !!

-- Religion spread power x2 in Online Speed.
UPDATE GlobalParameters SET Value=2 WHERE Name='RELIGION_SPREAD_ADJACENT_PER_TURN_PRESSURE';
