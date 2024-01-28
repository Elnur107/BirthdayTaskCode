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
            SET @Result = 'Yýl olarak doldurmuþtur, ay ve gün olarak doldurmamýþtýr';
        ELSE IF @MonthsPassed > 0
            SET @Result = 'Yýl olarak doldurmuþtur, ay olarak doldurmamýþtýr';
        ELSE IF @DaysPassed > 0
            SET @Result = 'Yýl olarak doldurmuþtur, gün olarak doldurmamýþtýr';
        ELSE
            SET @Result = 'Kiþi yýlý tamamlamýþtýr';
    END
    ELSE
    BEGIN
        SET @Result = 'Kiþi henüz yýlý tamamlamamýþtýr';
    END

    RETURN @Result;
END;
