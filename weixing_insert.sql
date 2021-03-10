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