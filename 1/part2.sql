CREATE table  #elfpowa (mass integer NOT NULL, fuel integer NOT NULL);

CREATE TABLE #buffer (mass integer, fuel integer);

 

INSERT INTO #elfpowa (mass, fuel) VALUES 
(0, 94735),
(0, 80130),
(0, 127915),
(0, 145427),
(0, 89149),
(0, 91232),
(0, 100629),
(0, 97340),
(0, 86278),
(0, 87034),
(0, 147351),
(0, 123045),
(0, 91885),
(0, 85973),
(0, 64130),
(0, 113244),
(0, 58968),
(0, 76296),
(0, 127931),
(0, 98145),
(0, 120731),
(0, 98289),
(0, 110340),
(0, 118285),
(0, 60112),
(0, 57177),
(0, 58791),
(0, 59012),
(0, 66950),
(0, 139387),
(0, 145378),
(0, 86204),
(0, 147082),
(0, 84956),
(0, 134161),
(0, 148664),
(0, 74278),
(0, 96746),
(0, 144525),
(0, 81214),
(0, 70966),
(0, 107050),
(0, 134179),
(0, 138587),
(0, 80236),
(0, 139871),
(0, 104439),
(0, 64643),
(0, 145453),
(0, 94791),
(0, 51690),
(0, 94189),
(0, 148476),
(0, 79956),
(0, 81760),
(0, 149796),
(0, 109544),
(0, 57533),
(0, 142999),
(0, 126419),
(0, 115434),
(0, 57092),
(0, 64244),
(0, 109663),
(0, 94701),
(0, 109265),
(0, 145851),
(0, 95183),
(0, 84433),
(0, 53818),
(0, 106234),
(0, 127380),
(0, 149774),
(0, 59601),
(0, 138851),
(0, 54488),
(0, 100877),
(0, 136952),
(0, 61538),
(0, 67705),
(0, 60299),
(0, 130769),
(0, 113176),
(0, 106723),
(0, 133280),
(0, 111065),
(0, 63688),
(0, 139307),
(0, 122703),
(0, 60162),
(0, 89567),
(0, 63994),
(0, 66608),
(0, 126376),
(0, 136052),
(0, 112255),
(0, 98525),
(0, 134023),
(0, 141479),
(0, 98200)


INSERT INTO #buffer SELECT * from #elfpowa

TRUNCATE TABLE #elfpowa;

INSERT INTO #elfpowa SELECT 
    (fuel / 3 - 2) as mass,
    (fuel / 3 - 2) / 3 - 2 as fuel
    from #buffer;

TRUNCATE TABLE #buffer;


WHILE (SELECT COUNT(fuel) from #elfpowa where fuel > 0) > 1
BEGIN
INSERT INTO #buffer SELECT * from #elfpowa

TRUNCATE TABLE #elfpowa;

INSERT INTO #elfpowa SELECT 
    mass + fuel as mass,
    CASE
        WHEN fuel <= 0 THEN 0
        WHEN (fuel / 3 - 2) > 0 THEN  (fuel / 3 - 2)
        ELSE 0
    END as fuel
    from #buffer;

TRUNCATE TABLE #buffer;

END


Select sum(mass) from #elfpowa

DROP TABLE #elfpowa
DROP TABLE #buffer

