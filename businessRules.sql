-- Business Rule #! for shourya
-- A customer cannot buy more than 5 units of a single game ever. 

CREATE FUNCTION fn_CannotOrderMorethan5Games()
RETURNS INTEGER
AS
BEGIN

    DECLARE @Ret INT = 0
    IF EXISTS ( 
    SELECT *
    FROM tblCustomer AS C, tblOrder AS O, OrderGame AS OG
    WHERE C.CustomerID = O.CustomerID AND O.OrderID = OG.OrderID
    GROUP BY C.CustomerID, OG.gameID
    HAVING OG.Quantity > 5
    )
    BEGIN
        SET @Ret = 1
    END
    RETURN @Ret
END
GO

ALTER TABLE tblORDER WITH NOCHECK 
ADD CONSTRAINT cn_NoGuestPrePurchase
CHECK (dbo.fn_CannotOrderMorethan5Games() = 0)
GO


-- Business Rule #2 for Shourya
-- An order cannot be cancelled it has status "shipped" or "in-transit"

CREATE FUNCTION fn_canBeCancelled()
RETURNS INTEGER
AS
BEGIN

    DECLARE @Ret INT = 0
    IF EXISTS ( 
    SELECT *
    FROM tblOrder AS O, orderStatus AS OS, tblStatus AS S
    WHERE O.OrderID = OS.OrderID
        AND OS.StatusID = S.StatusID
        AND (S.StatusName  = 'Shipped' OR S.StatusName = 'In-transit')
    )
    BEGIN
        SET @Ret = 1
    END
    RETURN @Ret
END
GO

ALTER TABLE tblORDER WITH NOCHECK 
ADD CONSTRAINT cn_canBeCancelled
CHECK (dbo.fn_canBeCancelled()= 0)
GO







