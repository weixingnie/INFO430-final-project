-- Business rule
-- A customer who hasn't made at least 5 game orders cannot have the customer type Mewtwo which is the
-- best customer type you can get

CREATE FUNCTION fn_rdjiMewtwoCustomerType()
RETURNS INTEGER
AS
BEGIN  

DECLARE @Ret INTEGER = 0
    IF EXISTS (
        SELECT C.CustomerID, COUNT(O.OrderID) AS NumOfOrders
        FROM tblCUSTOMER_TYPE ct
        JOIN tblCUSTOMER c on ct.CustomerTypeID = c.CustomerTypeID
        JOIN tblOrder O ON O.CustomerID = C.CustomerID
        GROUP BY C.CustomerID
        HAVING COUNT(O.OrderID) < 5
    )
    BEGIN
        SET @Ret = 1
    END
RETURN @Ret
END
GO

ALTER TABLE tblCUSTOMER WITH NOCHECK
ADD CONSTRAINT cn_NoMewtwoForFree
CHECK (dbo.fn_rdjiMewtwoCustomerType() = 0)
GO


