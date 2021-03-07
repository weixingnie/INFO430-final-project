CREATE TABLE tblGAME
(
    gameID INT IDENTITY (1,1) PRIMARY KEY,
    gameName VARCHAR(50),
    collectionID INT FOREIGN KEY REFERENCES Collection(collectionID) NOT NULL,
    Price NUMERIC,
    PublisherID INT FOREIGN KEY REFERENCES tblPublisher(PublisherID) NOT NULL,
    MaturityRatingID INT FOREIGN KEY REFERENCES MaturityRating(MaturityRatingID) NOT NULL
);

CREATE TABLE tblGameDeveloperRole
(
    gameDeveloperRoleID INT IDENTITY (1,1) PRIMARY KEY,
    gameID INT FOREIGN KEY REFERENCES tblGame(gameID) NOT NULL,
    DevloperID INT FOREIGN KEY REFERENCES Developer(DeveloperID) NOT NULL,
    RoleID INT FOREIGN KEY REFERENCES Role(RoleID) NOT NULL
);

CREATE TABLE tblPublisher
(
    publisherID INT IDENTITY (1,1) PRIMARY KEY,
    PublisherName VARCHAR(50),
    CountryID INT FOREIGN KEY REFERENCES Country(CountryID) NOT NULL
);

CREATE TABLE tblGameConsole
(
    gameConsoleID INT IDENTITY(1,1) PRIMARY KEY,
    gameID INT FOREIGN KEY REFERENCES tblGame(gameID) NOT NULL,
    consoleID INT FOREIGN KEY REFERENCES tblConsole(consoleID) NOT NULL,
);

CREATE TABLE tblOrderStatus
(
    orderStatusID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES tblOrder(OrderID) NOT NULL,
    StatusID INT FOREIGN KEY REFERENCES tblStatus(StatusID) NOT NULL,
    DateTime DATE
);

CREATE TABLE tblDevelopment_Status
(
    StatusID INT IDENTITY (1,1) PRIMARY KEY,
    StatusName VARCHAR(50),
    StatusDesc VARCHAR(50)
);
CREATE TABLE tbldevelopment_status_game
(
    StatusGameID INT IDENTITY(1,1) PRIMARY KEY,
    StatusID INT FOREIGN KEY REFERENCES tblDevelopment_Status(StatusID) not null,
    gameID INT FOREIGN KEY REFERENCES tblGame(gameID) NOT NULL,
    DateTime DATE
);