SET NOCOUNT ON;

CREATE TABLE result (verb integer, noun integer, elfpowa integer)

DECLARE @verb integer = 99
DECLARE @noun integer = 99

WHILE (select count(*) from result) = 0 
BEGIN

EXEC sp_compute @noun, @verb;

IF (@verb = 0 AND @noun = 0) 
BEGIN
    SELECT 'mordu'
    BREAK
END

ELSE IF @noun = 0
BEGIN
SET @noun = 99
SET @verb = @verb - 1
END

ELSE SET @noun = @noun - 1

END

SELECT * from result

DROP TABLE result