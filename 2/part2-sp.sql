CREATE PROCEDURE sp_compute 
    @verb integer,   
    @noun integer   
AS   

SET NOCOUNT ON;

CREATE TABLE #input ([rank] integer, value integer);

INSERT INTO #input ([rank], value) VALUES
(0 , 1),
(1 , 0),
(2 , 0),
(3 , 3),
(4 , 1),
(5 , 1),
(6 , 2),
(7 , 3),
(8 , 1),
(9 , 3),
(10 , 4),
(11 , 3),
(12 , 1),
(13 , 5),
(14 , 0),
(15 , 3),
(16 , 2),
(17 , 1),
(18 , 9),
(19 , 19),
(20 , 1),
(21 , 13),
(22 , 19),
(23 , 23),
(24 , 2),
(25 , 23),
(26 , 9),
(27 , 27),
(28 , 1),
(29 , 6),
(30 , 27),
(31 , 31),
(32 , 2),
(33 , 10),
(34 , 31),
(35 , 35),
(36 , 1),
(37 , 6),
(38 , 35),
(39 , 39),
(40 , 2),
(41 , 9),
(42 , 39),
(43 , 43),
(44 , 1),
(45 , 5),
(46 , 43),
(47 , 47),
(48 , 2),
(49 , 47),
(50 , 13),
(51 , 51),
(52 , 2),
(53 , 51),
(54 , 10),
(55 , 55),
(56 , 1),
(57 , 55),
(58 , 5),
(59 , 59),
(60 , 1),
(61 , 59),
(62 , 9),
(63 , 63),
(64 , 1),
(65 , 63),
(66 , 9),
(67 , 67),
(68 , 2),
(69 , 6),
(70 , 67),
(71 , 71),
(72 , 1),
(73 , 5),
(74 , 71),
(75 , 75),
(76 , 1),
(77 , 75),
(78 , 6),
(79 , 79),
(80 , 1),
(81 , 6),
(82 , 79),
(83 , 83),
(84 , 1),
(85 , 83),
(86 , 9),
(87 , 87),
(88 , 2),
(89 , 87),
(90 , 10),
(91 , 91),
(92 , 2),
(93 , 91),
(94 , 10),
(95 , 95),
(96 , 1),
(97 , 95),
(98 , 5),
(99 , 99),
(100 , 1),
(101 , 99),
(102 , 13),
(103 , 103),
(104 , 2),
(105 , 103),
(106 , 9),
(107 , 107),
(108 , 1),
(109 , 6),
(110 , 107),
(111 , 111),
(112 , 1),
(113 , 111),
(114 , 5),
(115 , 115),
(116 , 1),
(117 , 115),
(118 , 2),
(119 , 119),
(120 , 1),
(121 , 5),
(122 , 119),
(123 , 0),
(124 , 99),
(125 , 2),
(126 , 0),
(127 , 14),
(128 , 0);

DECLARE @counter integer = 0;
DECLARE @done BIT = 0;

DECLARE @operator integer;
DECLARE @op1 integer;
DECLARE @op2 integer;
DECLARE @op1pos integer;
DECLARE @op2pos integer;
DECLARE @dest integer;

UPDATE #input set value = @verb where rank = 1 ;
UPDATE #input set value = @noun where rank = 2 ;

WHILE (1 = 1)
BEGIN

SET @operator = (SELECT value from #input where [rank] = @counter)

IF (@operator = 99) BREAK;

SET @op1pos = (SELECT [value] from #input where [rank] = @counter + 1)
SET @op2pos = (SELECT [value] from #input where [rank] = @counter + 2)
SET @op1 = (SELECT [value] from #input where [rank] = @op1pos)
SET @op2 = (SELECT [value] from #input where [rank] = @op2pos) 
SET @dest = (SELECT [value] from #input where [rank] = @counter + 3)

IF (@operator = 1) UPDATE #input SET [value] = @op1 + @op2 WHERE [rank] = @dest;

ELSE IF (@operator = 2) UPDATE #input SET [value] = @op1 * @op2 WHERE [rank] = @dest;

ELSE RAISERROR (N'wtf',  10, 1 );

SET @counter = @counter + 4
END

IF (SELECT [value] from #input where [rank] = 0) = 19690720

INSERT INTO [result] SELECT @verb as verb, @noun as noun,  100 * @verb + @noun as result;

DROP TABLE #input