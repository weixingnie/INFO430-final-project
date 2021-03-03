-- Business rule
-- You cannot order a game that its development status is Soon Available if you are a 
-- customer type guest

CREATE FUNCTION fn_OrderForNonReleasedGames()
RETURNS INTEGER
AS
BEGIN

DECLARE @Ret INT = 0
    IF EXISTS (
        SELECT *
        FROM  tblOrder O
        JOIN tblCUSTOMER C ON C.CustomerID = O.CustomerID
        JOIN tblCUSTOMER_TYPE CT ON CT.CustomerTypeID = C.CustomerTypeID
        join tblORDER_GAME OG ON O.OrderID = OG.OrderID
        JOIN tblGAME G ON G.GameID = OG.GameID
        JOIN tblDEVELOPMENT_STATUS_GAME DSN ON DSN.GameID = G.GameID
        JOIN tblDEVELOPMENT_STATUS DS ON DS.StatusID = DSN.StatusID
        WHERE StatusName = 'Soon Available'
        AND C.CustomerTypeID = 'Guest'
    )
    BEGIN
    SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE tblORDER WITH NOCHECK 
ADD CONSTRAINT cn_NoGuestPrePurchase
CHECK (dbo.fn_OrderForNonReleasedGames() = 0)
GO

