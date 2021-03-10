USE rdjiVGmock

-- GETid FOR cOUNTRY
go
ALTER PROCEDURE getCountryID_Shourya
    @Country_Name VARCHAR(50),
    @Country_Abbv VARCHAR(50),
    @C_ID INT OUTPUT
AS
BEGIN
    SET @C_ID = (select CountryID
    from tblCOUNTRY
    WHERE CountryName = @Country_Name
        AND CountryAbbreviation = @Country_Abbv)
END
GO

-- getID for publisher
CREATE PROCEDURE getPublisherID_Shourya
    @Publisher_name VARCHAR(50),
    @C_Name VARCHAR(50),
    @C_Abbv VARCHAR(50),
    @P_ID INT OUTPUT
AS
DECLARE @cty_id INT


EXECUTE getCountryID_Shourya
    @Country_Name = @C_Name,
    @Country_Abbv = @C_Abbv,
    @C_ID = @cty_id OUTPUT

IF @cty_id IS NULL
        BEGIN
    PRINT "@cty_id is NULL, please go check";
    THROW 54667, '@cty_id is NULL, please go check', 1;
END

SET @P_ID = (SELECT PublisherID
FROM tblPublisher
WHERE PublisherName = @Publisher_name
    AND CountryID = @cty_id)

GO

-- getID for Collection
CREATE PROCEDURE getCollectionID_Shourya
    @Collection_Name VARCHAR(50),
    @Collection_ID INT OUTPUT
AS
BEGIN
    SET @Collection_ID = (select CollectionID
    from tblCollection
    WHERE CollectionName = @Collection_Name)
END
GO


-- getID for Maturity Rating
CREATE PROCEDURE getMaturityRatingID_Shourya
    @MaturityRating_Name VARCHAR(50),
    @MaturityRating_Abbv VARCHAR(50),
    @MaturityRating_ID INT OUTPUT
AS
BEGIN
    SET @MaturityRating_ID = (select MaturityRatingID
    from Maturity_Rating
    WHERE RatingName = @MaturityRating_Name
        AND RatingAbbreviation = @MaturityRating_Abbv)
END
GO


-- procedure to get developerID
CREATE PROCEDURE getDeveloperID_Shourya
    @D_Fname VARCHAR(50),
    @D_Lname VARCHAR(50),
    @D_DOB DATE,
    @C_Name VARCHAR(50),
    @C_Abbv VARCHAR(50),
    @D_ID INT OUTPUT
AS
DECLARE @cty_id INT

EXECUTE getCountryID_Shourya
    @Country_Name = @C_Name,
    @Country_Abbv = @C_Abbv,
    @C_ID = @cty_id OUTPUT


IF @cty_id IS NULL
    BEGIN
    PRINT '@cty_id is NULL, please go check';
    THROW 54667, '@cty_id is NULL, please go check', 1;
END


BEGIN
    SET @D_ID = (SELECT DeveloperID
    FROM tblDeveloper
    WHERE Fname = @D_Fname
        AND Lname = @D_Lname
        AND DOB = @D_DOB
        AND CountryID = @cty_id)
END
GO

-- Stored procedure to get RoleID
CREATE PROCEDURE getRoleID_Shourya
    @Role_Name VARCHAR(50),
    @Role_ID INT OUTPUT
AS
BEGIN
    SET @Role_ID = (select RoleID
    from tblRole
    WHERE RoleName = @Role_Name)
END
GO

-- stored procedure to getGameID
CREATE PROCEDURE getGameID_Shourya
    @game_Name VARCHAR(50),
    @Coll_Name VARCHAR(50),
    @MR_Name VARCHAR(50),
    @MR_Abbv VARCHAR(50),
    @Price_val NUMERIC,
    @Publish_name VARCHAR(50),
    @Coun_Name VARCHAR(50),
    @Coun_Abbv VARCHAR(50),
    @G_ID INT OUTPUT
AS
DECLARE @Coll_ID INT,
        @Pubhlish_ID INT,
        @MR_ID INT


EXECUTE getPublisherID_Shourya
    @Publisher_name = @Publish_name,
    @C_Name = @Coun_Name,
    @C_Abbv = @Coun_Abbv,
    @P_ID = @Pubhlish_ID OUTPUT

IF @Pubhlish_ID IS NULL
        BEGIN
    PRINT '@Pubhlish_ID is NULL, please go check';
    THROW 54667, '@Pubhlish_ID is NULL, please go check', 1;
END

EXECUTE getCollectionID_Shourya
    @Collection_Name = @Coll_Name,
    @Collection_ID = @Coll_ID OUTPUT
IF @Coll_ID IS NULL
        BEGIN
    PRINT '@Coll_ID is NULL, please go check';
    THROW 54667, '@Coll_ID is NULL, please go check', 1;
END

EXECUTE getMaturityRatingID_Shourya
    @MaturityRating_Name = @MR_Name,
    @MaturityRating_Abbv = @MR_Abbv,
    @MaturityRating_ID = @MR_ID OUTPUT

IF @MR_ID IS NULL
BEGIN
    PRINT '@MR_ID is NULL, please go check';
    THROW 54667, '@MR_ID is NULL, please go check', 1;
END
BEGIN
    SET @G_id =(SELECT gameID
    FROM tblGame
    WHERE GameName = @game_Name
        AND collectionID = @Coll_ID
        AND Price = @Price_val
        AND PublisherID = @Pubhlish_ID
        AND MaturityRatingID = @MR_ID)
END 
GO


-- procedure to populate the gameDeveloperRole table
CREATE PROCEDURE popGameDeveloperRole_Shourya
    @g_Name VARCHAR(50),
    @Collec_Name VARCHAR(50),
    @MRA_Name VARCHAR(50),
    @MRA_Abbv VARCHAR(50),
    @Price_value NUMERIC,
    @Pub_name VARCHAR(50),
    @Con_Name VARCHAR(50),
    @Con_Abbv VARCHAR(50),
    @R_Name VARCHAR(50),
    @Dev_Fname VARCHAR(50),
    @Dev_Lname VARCHAR(50),
    @Dev_DOB DATE
AS
DECLARE @Game_ID INT,
        @Dev_ID INT, 
        @RO_ID INT

EXECUTE getRoleID_Shourya
    @Role_Name = @R_Name,
    @Role_ID = @RO_ID OUTPUT
IF @RO_ID IS NULL
        BEGIN
    PRINT '@RO_ID is NULL, please go check';
    THROW 54667, '@RO_ID is NULL, please go check', 1;
END

EXECUTE getDeveloperID_Shourya
    @D_Fname = @Dev_Fname,
    @D_Lname = @Dev_Lname,
    @D_DOB = @Dev_DOB,
    @C_Name = @Con_Name,
    @C_Abbv = @Con_Abbv,
    @D_ID = @Dev_ID OUTPUT

IF @Dev_ID IS NULL
        BEGIN
    PRINT '@D_ID is NULL, please go check';
    THROW 54667, '@D_ID is NULL, please go check', 1;
END


EXECUTE getGameID_Shourya
    @game_Name = @g_Name,
    @Coll_Name = @Collec_Name,
    @MR_Name = @MRA_Name,
    @MR_Abbv = @MRA_Abbv,
    @Price_val = @Price_value,
    @Publish_name = @Pub_name,
    @Coun_Name = @Con_Name,
    @Coun_Abbv = @Con_Abbv,
    @G_ID = @Game_ID OUTPUT
IF @Game_ID IS NULL
        BEGIN
    PRINT '@Game_ID is NULL, please go check';
    THROW 54667, '@Game_ID is NULL, please go check', 1;
END


BEGIN TRAN T1
INSERT INTO tblgameDeveloperRole
    (
    gameID,
    DevloperID,
    RoleID
    )
VALUES
    (
        @Game_ID,
        @Dev_ID,
        @RO_ID
)
IF @@ERROR <> 0
        BEGIN
    PRINT 'There is an error'
    ROLLBACK TRAN T1
END
ELSE
    COMMIT TRAN T1
GO



-- Store Procedure to populate Game
CREATE PROCEDURE popGame_Shourya
    @game_Name VARCHAR(50),
    @Coll_Name VARCHAR(50),
    @MR_Name VARCHAR(50),
    @MR_Abbv VARCHAR(50),
    @Price_val NUMERIC,
    @Publish_name VARCHAR(50),
    @Coun_Name VARCHAR(50),
    @Coun_Abbv VARCHAR(50)
AS
DECLARE @Coll_ID INT,
        @Pubhlish_ID INT,
        @MR_ID INT


EXECUTE getPublisherID_Shourya
    @Publisher_name = @Publish_name,
    @C_Name = @Coun_Name,
    @C_Abbv = @Coun_Abbv,
    @P_ID = @Pubhlish_ID OUTPUT

IF @Pubhlish_ID IS NULL
        BEGIN
    PRINT '@Pubhlish_ID is NULL, please go check';
    THROW 54667, '@Pubhlish_ID is NULL, please go check', 1;
END


EXECUTE getCollectionID_Shourya
    @Collection_Name = @Coll_Name,
    @Collection_ID = @Coll_ID OUTPUT
IF @Coll_ID IS NULL
        BEGIN
    PRINT '@Coll_ID is NULL, please go check';
    THROW 54667, '@Coll_ID is NULL, please go check', 1;
END


EXECUTE getMaturityRatingID_Shourya
    @MaturityRating_Name = @MR_Name,
    @MaturityRating_Abbv = @MR_Abbv,
    @MaturityRating_ID = @MR_ID OUTPUT

IF @MR_ID IS NULL
BEGIN
    PRINT '@MR_ID is NULL, please go check';
    THROW 54667, '@MR_ID is NULL, please go check', 1;
END


BEGIN TRAN T1
INSERT INTO tblGame
    (
    GameName,
    CollectionID,
    Price,
    PublisherID,
    MaturityRatingID
    )
VALUES
    (
        @game_name,
        @Coll_ID,
        @Price_val,
        @Pubhlish_ID,
        @MR_ID
)
IF @@ERROR <> 0
        BEGIN
    PRINT 'There is an error'
    ROLLBACK TRAN T1
END
ELSE
    COMMIT TRAN T1
GO



-- Synthetic transactions for popGameDeveloperRole Procedure
CREATE PROCEDURE wrapper_popGameDeveloperRole_Shourya
    @RUN INT
AS
DECLARE @DeveloperCount INT = (SELECT COUNT(*)
FROM tblDeveloper)

DECLARE @RoleCount INT = (SELECT COUNT(*)
FROM tblRole)

DECLARE @GameCount INT = (SELECT COUNT(*)
FROM tblGame)

DECLARE @CountryCount INT = (SELECT COUNT(*)
FROM tblCOUNTRY)

DECLARE @CollectionCount INT = (SELECT COUNT(*)
FROM tblCollection)

DECLARE @PublisherCount INT = (SELECT COUNT(*)
FROM tblPublisher)

DECLARE @MRCount INT = (SELECT COUNT(*)
FROM Maturity_Rating)

DECLARE  @g_Namez VARCHAR(50),
    @Collec_Namez VARCHAR(50),
    @MRA_Namez VARCHAR(50),
    @MRA_Abbvz VARCHAR(50),
    @Price_valuez NUMERIC,
    @Pub_namez VARCHAR(50),
    @Con_Namez VARCHAR(50),
    @Con_Abbvz VARCHAR(50),
    @R_Namez VARCHAR(50),
    @Dev_Fnamez VARCHAR(50),
    @Dev_Lnamez VARCHAR(50),
    @Dev_DOBz DATE

DECLARE @PK INT
DECLARE @RAND INT

WHILE @RUN > 0
BEGIN

    SET @PK = (SELECT RAND() * @DeveloperCount + 1)
    SET @Dev_Fnamez = (SELECT Fname
    FROM tblDeveloper
    WHERE developerID = @PK)
    SET @Dev_Lnamez = (SELECT Lname
    FROM tblDeveloper
    WHERE developerID = @PK)
    SET @Dev_DOBz = (SELECT DOB
    FROM tblDeveloper
    WHERE developerID = @PK)

    SET @PK = (SELECT RAND() * @RoleCount + 1)
    SET @R_Namez = (SELECT RoleName
    FROM tblRole
    WHERE RoleID = @PK)

    SET @PK = (SELECT RAND() * @CountryCount + 1)
    SET @Con_Namez = (SELECT CountryName
    FROM tblCOUNTRY
    WHERE CountryID = @PK)
    SET @Con_Abbvz = (SELECT CountryAbbreviation
    FROM tblCOUNTRY
    WHERE CountryID = @PK)

    SET @PK = (SELECT RAND() * @PublisherCount + 1)
    SET @Pub_namez = (SELECT PublisherName
    FROM tblPublisher
    WHERE PublisherID = @PK)

    SET @PK = (SELECT RAND() * @CollectionCount + 1)
    SET @Collec_namez = (SELECT CollectionName
    FROM tblCollection
    WHERE CollectionID = @PK)

    SET @PK = (SELECT RAND() * @GameCount + 1)
    SET @g_Namez = (SELECT gameName
    FROM tblGame
    WHERE gameID = @PK)
    SET @Price_valuez = (SELECT Price
    from tblGame
    WHERE gameID = @PK)

    SET @PK = (SELECT RAND() * @MRCount + 1)
    SET @MRA_Namez = (SELECT RatingName
    FROM Maturity_Rating
    WHERE MaturityRatingID = @PK)
    SET @MRA_Abbvz = (SELECT RatingAbbreviation
    FROM Maturity_Rating
    WHERE MaturityRatingID = @PK)

    EXEC popGameDeveloperRole_Shourya
    @g_Name = @g_Namez,
    @Collec_Name = @Collec_Namez,
    @MRA_Name = @MRA_Namez,
    @MRA_Abbv = @MRA_Abbvz,
    @Price_value = @Price_valuez,
    @Pub_name = @Pub_namez,
    @Con_Name = @Con_Namez,
    @Con_Abbv = @Con_Abbvz,
    @R_Name = @R_Namez,
    @Dev_Fname = @Dev_Fnamez,
    @Dev_Lname = @Dev_Lnamez,
    @Dev_DOB = @Dev_DOBz

    SET @RUN = @RUN - 1
END 
