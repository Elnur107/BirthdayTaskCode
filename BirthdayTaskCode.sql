CREATE FUNCTION dbo.ValidateAge
(
    @BirthDate DATE,
    @Age INT
)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @Result NVARCHAR(255);

    DECLARE @Today DATE = GETDATE();
    DECLARE @YearsPassed INT = DATEDIFF(YEAR, @BirthDate, @Today);
    DECLARE @MonthsPassed INT = DATEDIFF(MONTH, @BirthDate, @Today) % 12;
    DECLARE @DaysPassed INT = DATEDIFF(DAY, DATEADD(MONTH, @MonthsPassed, @BirthDate), @Today);

    IF @YearsPassed >= @Age
    BEGIN
        IF @MonthsPassed > 0 AND @DaysPassed > 0
            SET @Result = 'Y�l olarak doldurmu�tur, ay ve g�n olarak doldurmam��t�r';
        ELSE IF @MonthsPassed > 0
            SET @Result = 'Y�l olarak doldurmu�tur, ay olarak doldurmam��t�r';
        ELSE IF @DaysPassed > 0
            SET @Result = 'Y�l olarak doldurmu�tur, g�n olarak doldurmam��t�r';
        ELSE
            SET @Result = 'Ki�i y�l� tamamlam��t�r';
    END
    ELSE
    BEGIN
        SET @Result = 'Ki�i hen�z y�l� tamamlamam��t�r';
    END

    RETURN @Result;
END;
