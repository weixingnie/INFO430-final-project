SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rdjiPopCustOld]
@cust_fname VARCHAR(30),
@cust_lname VARCHAR(30),
@cty_name VARCHAR(30),
@custy_name VARCHAR(30),
@cust_address VARCHAR(50),
@city VARCHAR(50),
@state CHAR(2),
@dob DATE
AS
DECLARE @cty_id int, @custy_id INT

SET @cty_id = (select CountryID from tblCOUNTRY WHERE CountryName = @cty_name)
EXEC rdji_GetCountryID
@1cty_name = @cty_name,
@1cty_id = @cty_id OUTPUT
-- ERROR HANDLING
IF @cty_id is NULL
    BEGIN
        PRINT 'There is an error in nested sproc';
        THROW 60000, '@cty_id cannot be null',1;
    END

EXEC rdji_GetCustomerTypeID
@1custy_name = @custy_name,
@1custy_id = @custy_id OUTPUT
-- ERROR HANDLING
IF @custy_id is NULL
    BEGIN
        PRINT 'There is an error in nested sproc';
        THROW 60000, '@custy_id cannot be null',1;
    END

BEGIN TRAN R1
INSERT INTO tblCUSTOMER (CustomerFname, CustomerLname, CustomerAddress, CityOfResidence, StateOfResidence, CustomerDOB, CountryID, CustomerTypeID )
VALUES(@cust_fname, @cust_lname, @cust_address, @city, @state, @dob, @cty_id, @custy_id)
IF @@ERROR<> 0
    BEGIN
        PRINT 'There was an error before'
        ROLLBACK TRAN R1
    END
ELSE
COMMIT TRAN R1

GO
