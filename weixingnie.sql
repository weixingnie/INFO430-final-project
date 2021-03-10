USE rdjiVGmock

---create table
CREATE TABLE GameGenre(
    GameGenreID INT IDENTITY(1,1) PRIMARY KEY,
    GameID INT FOREIGN KEY REFERENCES tblGAME(gameID),
    GenreID INT FOREIGN KEY REFERENCES Genre(GenreID)
)
GO

CREATE TABLE Genre(
    GenreID INT IDENTITY(1,1) PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL,
    GenreDesc VARCHAR(200) NOT NULL
)
GO

CREATE TABLE gameLanguage(
    gameLanguageID INT IDENTITY(1,1) PRIMARY KEY,
    gameID INT FOREIGN KEY REFERENCES tblGAME(gameID),
    languageID INT FOREIGN KEY REFERENCES Language_Type(languageID)
)

CREATE TABLE Language_Type(
    languageID INT IDENTITY(1,1) PRIMARY KEY,
    languageCode VARCHAR(50),
    languageName VARCHAR(50)
)

CREATE TABLE Maturity_Rating(
    MaturityRatingID INT IDENTITY(1,1) PRIMARY KEY,
    RatingName VARCHAR(50),
    RatingAbbreviation VARCHAR(50),
    RatingDescription VARCHAR(50)
)

CREATE TABLE OrderGame(
    OrderGameID INT IDENTITY(1,1) PRIMARY KEY,
    gameID INT FOREIGN KEY REFERENCES tblGAME(gameID),
    OrderID INT FOREIGN KEY REFERENCES tblOrder(OrderID),
    Quantity INT NOT NULL
)
GO

CREATE TABLE tblOrder(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES tblCustomer(customerID),
    OrderDate DATE, 
    TotalAmount INT
)
GO

CREATE TABLE tblRATING(
    RatingID INT IDENTITY(1,1) PRIMARY KEY,
    RatingNum INT,
    RatingName VARCHAR(50), 
    RatingDesc VARCHAR(50)
)
GO 

CREATE TABLE TypeOfReview(
    TypeOfReviewID INT IDENTITY(1,1) PRIMARY KEY,
    TypeOfReviewName VARCHAR(50),
    Type_Description VARCHAR(50)
)
GO 

CREATE TABLE tblReview(
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    OrderGameID INT FOREIGN KEY REFERENCES OrderGame(OrderGameID), 
    ReviewContent VARCHAR(500),
    RatingID INT FOREIGN KEY REFERENCES tblRATING(RatingID),
    TypeOfReviewID INT FOREIGN KEY REFERENCES TypeOfReview(TypeOfReviewID),
    reviewDate DATE
)
GO

/*
populate tables
*/
--maturity rating
INSERT INTO Maturity_Rating(RatingName, RatingAbbreviation, RatingDescription) VALUES ('Rating Pending', 'RP', 'Not rated yet')
INSERT INTO Maturity_Rating(RatingName, RatingAbbreviation, RatingDescription) VALUES ('Early Childhood', 'EC', 'Below 10 years old')
INSERT INTO Maturity_Rating(RatingName, RatingAbbreviation, RatingDescription) VALUES ('Everyone', 'E', 'Everyone')
INSERT INTO Maturity_Rating(RatingName, RatingAbbreviation, RatingDescription) VALUES ('Everyone 10+', 'E10+', 'Everyone 10 +')
INSERT INTO Maturity_Rating(RatingName, RatingAbbreviation, RatingDescription) VALUES ('Teen', 'T', 'Under 18')
INSERT INTO Maturity_Rating(RatingName, RatingAbbreviation, RatingDescription) VALUES ('Mature', 'M', 'Over 17+')
INSERT INTO Maturity_Rating(RatingName, RatingAbbreviation, RatingDescription) VALUES ('Adult', 'A', 'Over 18+')
--languagetype
INSERT INTO Language_Type(languageCode, languageName) VALUES ('CN', 'Chinese')
INSERT INTO Language_Type(languageCode, languageName) VALUES ('E', 'English')
INSERT INTO Language_Type(languageCode, languageName) VALUES ('JP', 'Japanese')
INSERT INTO Language_Type(languageCode, languageName) VALUES ('GN', 'German')
--rating
INSERT INTO tblRating(RatingNum, RatingName, RatingDesc) VALUES (5, 'Love the game', 'Greatest VG ever made. I love Game of throne')
INSERT INTO tblRating(RatingNum, RatingName, RatingDesc) VALUES (1, 'Hate', 'Can not believe why we put sql learing into a game')
INSERT INTO tblRating(RatingNum, RatingName, RatingDesc) VALUES (3, 'Some thoughts', 'Not good, not bad, just game')

---typeofreview
INSERT INTO TypeOfReview(TypeOfReviewName, Type_Description) VALUES ('Professional', 'Editor from IGN')
INSERT INTO TypeOfReview(TypeOfReviewName, Type_Description) VALUES ('Professional', 'Editor from Gamespot')
INSERT INTO TypeOfReview(TypeOfReviewName, Type_Description) VALUES ('Individual', 'Youtuber')

---tblorder
INSERT INTO tblOrder(CustomerID, OrderDate, TotalAmount) VALUES ((SELECT C.CustomerID FROM tblCUSTOMER C WHERE StateOfResidence = 'WA' AND CustomerFname = 'Roberto' AND CustomerLname = 'Infante' AND CustomerDOB = '1998-09-17'), GETDATE(), 1)
INSERT INTO tblOrder(CustomerID, OrderDate, TotalAmount) VALUES ((SELECT C.CustomerID FROM tblCUSTOMER C WHERE StateOfResidence = 'MN' AND CustomerFname = 'Roy' AND CustomerLname = 'Breech' AND CustomerDOB = '1984-08-25'), DATEADD(Month, -2, GETDATE()), 2)
INSERT INTO tblOrder(CustomerID, OrderDate, TotalAmount) VALUES ((SELECT C.CustomerID FROM tblCUSTOMER C WHERE StateOfResidence = 'DE' AND CustomerFname = 'Lorrie' AND CustomerLname = 'Stum' AND CustomerDOB = '1985-11-12'), DATEADD(Day, -2, GETDATE()), 3)

---Genre
INSERT INTO Genre(GenreName, GenreDesc) VALUES ('RPG', 'Role-playing game')
INSERT INTO Genre(GenreName, GenreDesc) VALUES ('ACT', 'Action focused tagtic game')
INSERT INTO Genre(GenreName, GenreDesc) VALUES ('ADV', 'Adventure game')
INSERT INTO Genre(GenreName, GenreDesc) VALUES ('RTS', 'Real time strategy game')
INSERT INTO Genre(GenreName, GenreDesc) VALUES ('GN', 'Graphic novel')

---tblOrder_GAME
INSERT INTO OrderGame(gameID, OrderID, Quantity) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-red'), (SELECT OrderID FROM tblOrder O WHERE OrderDate = '2021-03-09' AND CustomerID = 736 AND TotalAmount = 1), 1)
INSERT INTO OrderGame(gameID, OrderID, Quantity) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-gold'), (SELECT OrderID FROM tblOrder O WHERE OrderDate = '2021-03-09' AND CustomerID = 1059 AND TotalAmount = 2), 2)
INSERT INTO OrderGame(gameID, OrderID, Quantity) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-y'), (SELECT OrderID FROM tblOrder O WHERE OrderDate = '2021-03-09' AND CustomerID = 418 AND TotalAmount = 1), 1)

GO

---tblGameLanguage
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-red'), (SELECT languageID from Language_Type L WHERE L.languageName = 'Chinese'))
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-red'), (SELECT languageID from Language_Type L WHERE L.languageName = 'English'))
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-red'), (SELECT languageID from Language_Type L WHERE L.languageName = 'Japanese'))
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-red'), (SELECT languageID from Language_Type L WHERE L.languageName = 'German'))
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-y'), (SELECT languageID from Language_Type L WHERE L.languageName = 'German'))
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-gold'), (SELECT languageID from Language_Type L WHERE L.languageName = 'Chinese'))
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-gold'), (SELECT languageID from Language_Type L WHERE L.languageName = 'English'))
INSERT INTO tblGame_Language(gameID, languageID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-y'), (SELECT languageID from Language_Type L WHERE L.languageName = 'Japanese'))

---tblReview
INSERT INTO tblReview(OrderGameID, ReviewContent, RatingID, TypeOfReviewID, reviewDate) VALUES ((SELECT OrderGameID FROM OrderGame WHERE gameID = 1 AND OrderID = 1), 'Great game', (SELECT RatingID FROM tblRATING WHERE RatingName = 'Hate'), (SELECT TypeOfReviewID FROM TypeOfReview T WHERE T.TypeOfReviewName = 'Professional'), DATEADD(Month, -2, GETDATE()))
INSERT INTO tblReview(OrderGameID, ReviewContent, RatingID, TypeOfReviewID, reviewDate) VALUES ((SELECT OrderGameID FROM OrderGame WHERE gameID = 3 AND OrderID = 5), 'Fine for me', (SELECT RatingID FROM tblRATING WHERE RatingName = 'Love the game'), (SELECT TypeOfReviewID FROM TypeOfReview T WHERE T.TypeOfReviewName = 'Professional'), DATEADD(Month, -3, GETDATE()))
INSERT INTO tblReview(OrderGameID, ReviewContent, RatingID, TypeOfReviewID, reviewDate) VALUES ((SELECT OrderGameID FROM OrderGame WHERE gameID = 2 AND OrderID = 2), 'Comments on the new Game', (SELECT RatingID FROM tblRATING WHERE RatingName = 'Some thoughts'), (SELECT TypeOfReviewID FROM TypeOfReview T WHERE T.TypeOfReviewName = 'Professional'), DATEADD(DAY, -10, GETDATE()))

---GameGenre
INSERT INTO GameGenre(GameID, GenreID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-red'), (SELECT GenreID from Genre G WHERE G.GenreName = 'RPG'))
INSERT INTO GameGenre(GameID, GenreID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-y'), (SELECT GenreID from Genre G WHERE G.GenreName = 'RPG'))
INSERT INTO GameGenre(GameID, GenreID) VALUES ((SELECT gameID FROM tblGAME G WHERE gameName = 'pokemon-gold'), (SELECT GenreID from Genre G WHERE G.GenreName = 'RPG'))
/*
Previous part are all create table
Previous part are all create table
Previous part are all create table
Previous part are all create table
Previous part are all create table
Previous part are all create table
Previous part are all create table
*/
---GET CustomerID
CREATE PROCEDURE usp_GETCUSTID
    @CustomerFname VARCHAR(50),
    @CustomerLname VARCHAR(50),
    @CustomerDOB DATE,
    @CustomerAddress VARCHAR(50),
    @CustomerID INT OUTPUT 
    AS 
    SET  @CustomerID = (SELECT customerID FROM tblCUSTOMER WHERE 
                        @CustomerFname = tblCUSTOMER.CustomerFname AND
                        @CustomerLname = tblCUSTOMER.CustomerLname AND
                        @CustomerDOB = tblCUSTOMER.CustomerDOB AND 
                        @CustomerAddress = tblCUSTOMER.CustomerAddress)

GO





--- new review
CREATE PROCEDURE newReview
GO








---Create procedure for insertion
CREATE PROCEDURE uspAddOrder
@Cust_Fname VARCHAR(50),
@Cust_Lname VARCHAR(50),
@DOB DATE,
@Cust_Address VARCHAR(50),
@Total_Amount INT,
@Order_Date DATE
AS 
DECLARE @C_ID INT


EXECUTE usp_GETCUSTID 
@CustomerFname = @Cust_Fname,
@CustomerLname = @Cust_Lname,
@CustomerDOB = @DOB,
@CustomerAddress = @Cust_Address,
@CustomerID = @C_ID OUTPUT

IF @C_ID IS NULL
    BEGIN
        RAISERROR('@C_ID is NULL, Please check your information again', 11, 1)
        RETURN
    END

BEGIN TRAN T1
    INSERT INTO tblOrder(CustomerID, OrderDate, TotalAmount)
    VALUES (@C_ID, @Order_Date, @Total_Amount)
    IF @@ERROR <> 0
        ROLLBACK TRAN T1
    ELSE COMMIT TRAN T1
GO 

---Synthetic Transaction 
CREATE PROCEDURE TRANS_Order
@RUN INT 
AS 
DECLARE @Fname VARCHAR(50)
DECLARE @Lname VARCHAR(50)
DECLARE @Birth DATE
DECLARE @Quantity INT 
DECLARE @Address VARCHAR(50)
DECLARE @OrderDOB DATE 
---Number of keys in tblCustomer
DECLARE @PK INT
DECLARE @CustCount INT = (SELECT COUNT(*) FROM tblCUSTOMER)

WHILE @RUN > 0
BEGIN
SET @PK = (SELECT RAND() * @CustCount + 1)
SET @Fname = (SELECT CustomerFname FROM tblCUSTOMER WHERE CustomerID = @PK)
SET @Lname = (SELECT CustomerLname FROM tblCUSTOMER WHERE CustomerID = @PK)
SET @Birth = (SELECT CustomerDOB FROM tblCUSTOMER WHERE CustomerID = @PK)
SET @Quantity = (SELECT RAND() * 2 + 1)
SET @Address = (SELECT CustomerAddress FROM tblCUSTOMER WHERE CustomerID = @PK)
SET @OrderDOB = (SELECT GETDATE() - RAND())

EXECUTE uspAddOrder
@Cust_Fname = @Fname,
@Cust_Lname = @Lname,
@DOB = @Birth,
@Cust_Address = @Address,
@Total_Amount = @Quantity,
@Order_Date = @OrderDOB
SET @RUN = @RUN - 1
END 
GO


EXEC TRANS_Order
@RUN = 5

GO

/*
Business rule
Business rule
Business rule
Business rule
Business rule
*/

CREATE FUNCTION fn_NoR_ratedGameforChildrenAndChina()
RETURNS INT
AS 
BEGIN

DECLARE @Ret INT = 0
IF EXISTS (SELECT * FROM tblCUSTOMER C 
                JOIN tblOrder O ON O.CustomerID = C.customerID
                JOIN OrderGame OG ON OG.OrderID = O.OrderID
                JOIN tblGame G ON G.gameID = OG.gameID
                JOIN Maturity_Rating M ON M.MaturityRatingID = G.MaturityRatingID
                JOIN tblCountry CO ON CO.CountryID = C.CountryID
                WHERE CO.CountryName = 'China' 
                OR C.CustomerDOB > DATEADD(Year, -18, GETDATE())
                AND M.RatingAbbreviation = 'R')
                BEGIN
                    SET @Ret = 1
                END
RETURN @Ret
END
GO
ALTER TABLE OrderGame
ADD CONSTRAINT CHECK_NORgameForunder18ORCHINA
CHECK (dbo.fn_NoR_ratedGameforChildrenAndChina() = 0)
GO

---2. business rule
CREATE FUNCTION fn_NoReviewInlessThan48hours()
RETURNS INT
AS 
BEGIN

DECLARE @Ret INT = 0
IF EXISTS (SELECT * FROM  tblReview R 
                JOIN TypeOfReview TR ON TR.TypeOfReviewID = R.TypeOfReviewID
                JOIN tblRATING RT ON RT.RatingID = R.RatingID
                JOIN OrderGame O ON O.OrderGameID = R.OrderGameID
                JOIN tblOrder OD ON OD.OrderID = O.OrderID
                WHERE TR.TypeOfReviewName != 'Professional' 
                AND R.reviewDate < DATEADD(day, 2, OD.OrderDate))
                BEGIN
                    SET @Ret = 1
                END
RETURN @Ret
END
GO
ALTER TABLE tblReview
ADD CONSTRAINT CHECK_NOUserReviewin2Days
CHECK (dbo.fn_NoReviewInlessThan48hours() = 0)
GO

/*
Computed Columns
Computed Columns
Computed Columns
Computed Columns
Computed Columns
Computed Columns
Computed Columns
Computed Columns
*/
CREATE FUNCTION fn_Calculate_allPurchase(@Customer_ID INT)
RETURNS INT
AS
BEGIN 
    DECLARE @All_purchased_amount INT = (SELECT SUM(TotalAmount)
                                            FROM tblCUSTOMER C 
                                            JOIN tblOrder O ON C.CustomerID = O.CustomerID
                                            JOIN OrderGame OG ON OG.OrderID = O.OrderID
                                            JOIN tblGAME G ON G.gameID = OG.gameID
                                            WHERE C.CustomerID = @Customer_ID)
                                            RETURN @All_purchased_amount
END
GO 

ALTER TABLE tblCustomer
ADD totalPurchasedAmount AS dbo.fn_Calculate_allPurchase(CustomerID)
GO

CREATE FUNCTION fn_evaluate_tendency(@Customer_ID INT)
RETURNS INT 
AS
BEGIN
    DECLARE @Ret INT = (SELECT SUM(CASE 
                                    WHEN RatingAbbreviation = 'RP' THEN 0
                                    WHEN RatingAbbreviation = 'EC' THEN 1
                                    WHEN RatingAbbreviation = 'E' THEN 2
                                    WHEN RatingAbbreviation = 'E10+' THEN 2
                                    WHEN RatingAbbreviation = 'T' THEN 3
                                    WHEN RatingAbbreviation = 'M' THEN 4
                                    WHEN RatingAbbreviation = 'AO' THEN 5
                                    ELSE 0
                                    END) AS RatingValues
                                    FROM tblCUSTOMER C
                                    JOIN tblOrder O ON O.CustomerID = C.CustomerID
                                    JOIN OrderGame OG ON OG.OrderID = O.OrderID
                                    JOIN tblGame G ON G.gameID = OG.gameID
                                    JOIN Maturity_Rating M ON M.MaturityRatingID = G.MaturityRatingID
                                    JOIN tblCountry CO ON CO.CountryID = C.CountryID
                                    WHERE C.CustomerID = @Customer_ID

    )
    RETURN @Ret
END 
GO

ALTER TABLE tblCustomer
ADD thePreference AS dbo.fn_evaluate_tendency(CustomerID)
GO

/*
Create View
Create View
Create View
Create View
Create View
Create View
Create View
Create View
*/

CREATE VIEW Rank_Game
AS
WITH CTE_popular_language (languageID, languageName, copies) AS 
        (SELECT LT.languageID, LT.languageName, SUM(Quantity)  AS copies
         FROM Language_Type LT 
         JOIN tblGame_Language GL ON GL.languageID = LT.languageID
         JOIN tblGAME G ON G.gameID = GL.gameID
         JOIN OrderGame OG ON OG.gameID = G.gameID
         GROUP BY LT.languageID, LT.languageName
        )
        SELECT TOP(5) CPL.languageID, CPL.languageName, CPL.copies, S.ConsoleName,
        RANK() OVER (PARTITION BY S.ConsoleName ORDER BY CPL.copies) AS RANK 
        FROM CTE_popular_language CPL
        JOIN tblGame_Language GL ON GL.languageID = CPL.languageID
        JOIN tblGame G ON G.gameID = GL.gameID
        JOIN tblGameconsole GS ON GS.gameID = G.gameID
        JOIN tblCONSOLE S ON S.ConsoleID = GS.consoleID
GO



CREATE VIEW Most_popular_Console
AS 
WITH CTE_popular_console (ConsoleID, ConsoleName, numbers) AS 
        (SELECT C.consoleID, C.consoleName, COUNT(*) AS numbers
         FROM tblCONSOLE C   
         GROUP BY C.consoleID, C.consoleName
        )
        SELECT TOP(5) CTE.ConsoleID, CTE.ConsoleName, CTE.numbers, CT.CountryName,
        DENSE_RANK() OVER (PARTITION BY CT.CountryName ORDER BY CTE.numbers) AS RANK 
        FROM CTE_popular_console CTE
        JOIN tblGameconsole GS ON CTE.consoleID = GS.consoleID
        JOIN tblGAME G ON G.gameID = GS.gameID 
        JOIN tblPublisher P ON P.PublisherID = G.PublisherID
        JOIN tblCountry CT ON CT.CountryID = P.CountryID
GO


SELECT * FROM Most_popular_Console