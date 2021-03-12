CREATE FUNCTION recentBought(@Customer_ID INT)
RETURNS VARCHAR(50)
AS
BEGIN 
    DECLARE @RecentGame INT = (SELECT TOP(1) G.gameName
                                    FROM tblGAME G
                                    JOIN OrderGame OG ON G.gameID = OG.gameID
                                    JOIN tblOrder O ON OG.OrderID = O.OrderID
                                    JOIN tblCUSTOMER C ON C.CustomerID = O.CustomerID
                                    WHERE C.CustomerID = @Customer_ID
                                    ORDER BY O.OrderDate DESC)
                                    RETURN @RecentGame
END
GO 

ALTER TABLE tblCustomer
ADD RecentPurchase AS dbo.recentBought(CustomerID)
GO