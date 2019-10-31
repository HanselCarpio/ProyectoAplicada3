CREATE DATABASE aplicada

USE aplicada

CREATE SCHEMA EX


CREATE TABLE EX.CLIENT
(
 ID	INT IDENTITY(1,1)  constraint ID_PK Primary Key NOT NULL
,[NAME] VARCHAR(100)
,PERSONAL_ID INT
,MIGRATED BIT
,INSERTION_DATE DATETIME
)

--DECLARE @local_FLAG INT = 1
--WHILE (@local_FLAG <= 1000)
--BEGIN
--	INSERT INTO EX.CLIENT
--	(
--	 [NAME]
--	 ,PERSONAL_ID
--	 ,MIGRATED
--	 ,INSERTION_DATE
--	)
--	VALUES
--	(
--	'HANSEL ARAYA CARPIO'
--	,1234567890
--	,0
--	,GETDATE()
--	)

--	SELECT
--		@local_FLAG
--		,@local_FLAG

--	SELECT @local_FLAG = @local_FLAG + 1
--END

--SELECT * FROM EX.CLIENT


CREATE TABLE EX.TELEPHONE
(
 ID	INT IDENTITY(1,1)  constraint ID_TELEPHONE_PK Primary Key NOT NULL
 ,CLIENT_ID INT
 ,TELEPHONE VARCHAR(50)
 ,MIGRATED BIT
 ,INSERTION_DATE DATETIME
)

--DECLARE @local_FLAG INT = 1
--WHILE (@local_FLAG <= 1000)
--BEGIN
--	INSERT INTO EX.TELEPHONE
--	(
--	 CLIENT_ID
--	 ,TELEPHONE
--	 ,MIGRATED
--	 ,INSERTION_DATE
--	)
--	VALUES
--	(
--	3
--	,'88888888'
--	,0
--	,GETDATE()
--	)

--	SELECT
--		@local_FLAG
--		,@local_FLAG

--	SELECT @local_FLAG = @local_FLAG + 1
--END


CREATE TABLE EX.ADDRESS
(
 ID	INT IDENTITY(1,1)  constraint ID_ADDRESS_PK Primary Key NOT NULL
 ,CLIENT_ID INT
,ADDRESS VARCHAR(100)
,MIGRATED BIT
,INSERTION_DATE DATETIME
)

--DECLARE @local_FLAG INT = 1
--WHILE (@local_FLAG <= 1000)
--BEGIN
--	INSERT INTO EX.ADDRESS
--	(
--	 CLIENT_ID
--	 ,ADDRESS
--	 ,MIGRATED
--	 ,INSERTION_DATE
--	)
--	VALUES
--	(
--	'3'
--	,'SAN RAFAEL, POR EL EBAIS'
--	,0
--	,GETDATE()
--	)

--	SELECT
--		@local_FLAG
--		,@local_FLAG

--	SELECT @local_FLAG = @local_FLAG + 1
--END


CREATE TABLE EX.EMAIL
(
 ID	INT IDENTITY(1,1)  constraint ID_EMAIL_PK Primary Key NOT NULL
 ,CLIENT_ID INT
,EMAIL VARCHAR(50)
,MIGRATED BIT
,INSERTION_DATE DATETIME
)

--DECLARE @local_FLAG INT = 1
--WHILE (@local_FLAG <= 1000)
--BEGIN
--	INSERT INTO EX.EMAIL
--	(
--	 CLIENT_ID
--	 ,EMAIL
--	 ,MIGRATED
--	 ,INSERTION_DATE
--	)
--	VALUES
--	(
--	3
--	,'hansel.carpio@gmail.com'
--	,0
--	,GETDATE()
--	)

--	SELECT
--		@local_FLAG
--		,@local_FLAG

--	SELECT @local_FLAG = @local_FLAG + 1
--END



CREATE TABLE EX.CREDITCARD
(
 ID	INT IDENTITY(1,1)  constraint ID_CREDITCARD_PK Primary Key NOT NULL
 ,CLIENT_ID INT
,CREDITCARD VARCHAR(50)
,MIGRATED BIT
,INSERTION_DATE DATETIME
)

--DECLARE @local_FLAG INT = 1
--WHILE (@local_FLAG <= 1000)
--BEGIN
--	INSERT INTO EX.CREDITCARD
--	(
--	 CLIENT_ID
--	 ,CREDITCARD
--	 ,MIGRATED
--	 ,INSERTION_DATE
--	)
--	VALUES
--	(
--	3
--	,'098765432123'
--	,0
--	,GETDATE()
--	)

--	SELECT
--		@local_FLAG
--		,@local_FLAG

--	SELECT @local_FLAG = @local_FLAG + 1
--END


CREATE TABLE EX.ORDERNUMBER
(
 ID	INT IDENTITY(1,1)  constraint ID_ORDERNUMBER_PK Primary Key NOT NULL
 ,CLIENT_ID INT
,ORDERNUMBER INT
,MIGRATED BIT
,INSERTION_DATE DATETIME
)

--Llenado de Tablas
--DECLARE @local_FLAG INT = 1
--WHILE (@local_FLAG <= 1000)
--BEGIN
--	INSERT INTO EX.ORDERNUMBER
--	(
--	 CLIENT_ID
--	 ,ORDERNUMBER
--	 ,MIGRATED
--	 ,INSERTION_DATE
--	)
--	VALUES
--	(
--	3
--	,8765432
--	,0
--	,GETDATE()
--	)

--	SELECT
--		@local_FLAG
--		,@local_FLAG

--	SELECT @local_FLAG = @local_FLAG + 1
--END


--------------------------------------ENCRIPTACION DE COLUMNAS--------------------------------------

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '12345';


CREATE CERTIFICATE CERTIFICADO WITH SUBJECT = 'PROTECCION DE DATOS';


CREATE SYMMETRIC KEY CLAVE  WITH ALGORITHM = AES_128   ENCRYPTION BY CERTIFICATE CERTIFICADO;


ALTER TABLE EX.ADDRESS  ADD ADDRESS_ENCRIPTED varbinary(MAX) NULL

OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
UPDATE EX.ADDRESS SET ADDRESS_ENCRIPTED = EncryptByKey (Key_GUID('CLAVE'), ADDRESS) FROM EX.ADDRESS ;
CLOSE SYMMETRIC KEY CLAVE;

SELECT * FROM EX.ADDRESS


ALTER TABLE EX.CREDITCARD  ADD CREDITCARD_ENCRIPTED varbinary(MAX) NULL

OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
UPDATE EX.CREDITCARD SET CREDITCARD_ENCRIPTED = EncryptByKey (Key_GUID('CLAVE'), CREDITCARD) FROM EX.CREDITCARD ;
CLOSE SYMMETRIC KEY CLAVE;

SELECT * FROM EX.CREDITCARD


ALTER TABLE EX.EMAIL  ADD EMAIL_ENCRIPTED varbinary(MAX) NULL

OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
UPDATE EX.EMAIL SET EMAIL_ENCRIPTED = EncryptByKey (Key_GUID('CLAVE'), EMAIL) FROM EX.EMAIL ;
CLOSE SYMMETRIC KEY CLAVE;

SELECT * FROM EX.EMAIL


ALTER TABLE EX.TELEPHONE  ADD TELEPHONE_ENCRIPTED varbinary(MAX) NULL

OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
UPDATE EX.TELEPHONE SET TELEPHONE_ENCRIPTED = EncryptByKey (Key_GUID('CLAVE'), TELEPHONE) FROM EX.TELEPHONE ;
CLOSE SYMMETRIC KEY CLAVE;

SELECT * FROM EX.TELEPHONE


--Desencriptar columnas
OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
SELECT EMAIL_ENCRIPTED
    AS 'Encrypted Email',
    CONVERT(varchar, DecryptByKey(EMAIL_ENCRIPTED))
    AS 'Decrypted Email'
    FROM EX.EMAIL;
CLOSE SYMMETRIC KEY CLAVE;


OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
SELECT TELEPHONE_ENCRIPTED
    AS 'Encrypted telephone',
    CONVERT(varchar, DecryptByKey(TELEPHONE_ENCRIPTED))
    AS 'Decrypted telephone'
    FROM EX.TELEPHONE;
CLOSE SYMMETRIC KEY CLAVE;


OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
SELECT ADDRESS_ENCRIPTED
    AS 'Encrypted address',
    CONVERT(varchar, DecryptByKey(ADDRESS_ENCRIPTED))
    AS 'Decrypted address'
    FROM EX.ADDRESS;
CLOSE SYMMETRIC KEY CLAVE;


OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;
SELECT CREDITCARD_ENCRIPTED
    AS 'Encrypted creditcard',
    CONVERT(varchar, DecryptByKey(CREDITCARD_ENCRIPTED))
    AS 'Decrypted creditcard'
    FROM EX.CREDITCARD;
CLOSE SYMMETRIC KEY CLAVE;

---------------------------------------------------------------------------------

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<HANSEL>
-- Create date: <>
-- Description:	<>
-- =============================================
CREATE PROCEDURE EX.spExtractor
@TABLE_NAME VARCHAR (50),
@FIRST_DATE DATE,
@SECOND_DATE DATE
	AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
	--Se abre la llave de seguridad de las columnas
	OPEN SYMMETRIC KEY CLAVE DECRYPTION BY CERTIFICATE CERTIFICADO;

	IF @TABLE_NAME = 'CLIENT' BEGIN
		SELECT
			ID
			,[NAME]
			,PERSONAL_ID
		INTO TEMP
		FROM EX.CLIENT
		WHERE MIGRATED = 0 AND (INSERTION_DATE BETWEEN @FIRST_DATE AND @SECOND_DATE)

		UPDATE EX.CLIENT
		SET MIGRATED = 1
		FROM EX.CLIENT
			JOIN TEMP
				ON EX.CLIENT.ID = TEMP.ID

			SELECT
			 t.ID
			,t.[NAME]
			,t.PERSONAL_ID
			FROM TEMP T
				JOIN TEMP
				ON T.ID = TEMP.ID
	END

	ELSE IF @TABLE_NAME = 'ADDRESS' BEGIN
		SELECT
			CLIENT_ID
			,CONVERT(varchar, DecryptByKey(ADDRESS))
			AS 'ADDRESS'
		INTO TEMP
		FROM EX.ADDRESS
		WHERE MIGRATED = 0 AND (INSERTION_DATE BETWEEN @FIRST_DATE AND @SECOND_DATE)

		UPDATE EX.ADDRESS
		SET MIGRATED = 1
		FROM EX.ADDRESS
			JOIN TEMP
				ON EX.ADDRESS.CLIENT_ID = TEMP.CLIENT_ID

			SELECT
			 t.CLIENT_ID
			,t.ADDRESS
			FROM TEMP T
				JOIN TEMP
				ON T.CLIENT_ID = TEMP.CLIENT_ID
	END

	ELSE IF @TABLE_NAME = 'CREDITCARD' BEGIN
	   SELECT
			CLIENT_ID
			,CONVERT(varchar, DecryptByKey(CREDITCARD))
			AS 'CREDITCARD'
		INTO TEMP
		FROM EX.CREDITCARD
		WHERE MIGRATED = 0 AND (INSERTION_DATE BETWEEN @FIRST_DATE AND @SECOND_DATE)

		UPDATE EX.CREDITCARD
		SET MIGRATED = 1
		FROM EX.CREDITCARD
			JOIN TEMP
				ON EX.CREDITCARD.CLIENT_ID = TEMP.CLIENT_ID

			SELECT
			 t.CLIENT_ID
			,t.CREDITCARD
			FROM TEMP T
				JOIN TEMP
				ON T.CLIENT_ID = TEMP.CLIENT_ID
	END

	ELSE IF @TABLE_NAME = 'EMAIL' BEGIN
	   SELECT
			CLIENT_ID
			,CONVERT(varchar, DecryptByKey(EMAIL))
			AS 'EMAIL'
		INTO TEMP
		FROM EX.EMAIL
		WHERE MIGRATED = 0 AND (INSERTION_DATE BETWEEN @FIRST_DATE AND @SECOND_DATE)

		UPDATE EX.EMAIL
		SET MIGRATED = 1
		FROM EX.EMAIL
			JOIN TEMP
				ON EX.EMAIL.CLIENT_ID = TEMP.CLIENT_ID

			SELECT
			 t.CLIENT_ID
			,t.EMAIL
			FROM TEMP T
				JOIN TEMP
				ON T.CLIENT_ID = TEMP.CLIENT_ID
	END

	ELSE IF @TABLE_NAME = 'ORDERNUMBER' BEGIN
	   SELECT
			CLIENT_ID
			,ORDERNUMBER
			AS 'ORDERNUMBER'
		INTO TEMP
		FROM EX.ORDERNUMBER
		WHERE MIGRATED = 0 AND (INSERTION_DATE BETWEEN @FIRST_DATE AND @SECOND_DATE)

		UPDATE EX.ORDERNUMBER
		SET MIGRATED = 1
		FROM EX.ORDERNUMBER
			JOIN TEMP
				ON EX.ORDERNUMBER.CLIENT_ID = TEMP.CLIENT_ID

			SELECT
			 t.CLIENT_ID
			,t.ORDERNUMBER
			FROM TEMP T
				JOIN TEMP
				ON T.CLIENT_ID = TEMP.CLIENT_ID
	END

	ELSE IF @TABLE_NAME = 'TELEPHONE' BEGIN
		SELECT
			CLIENT_ID
			,CONVERT(varchar, DecryptByKey(TELEPHONE))
			AS 'TELEPHONE'
		INTO TEMP
		FROM EX.TELEPHONE
		WHERE MIGRATED = 0 AND (INSERTION_DATE BETWEEN @FIRST_DATE AND @SECOND_DATE)

		UPDATE EX.TELEPHONE
		SET MIGRATED = 1
		FROM EX.TELEPHONE
			JOIN TEMP
				ON EX.TELEPHONE.CLIENT_ID = TEMP.CLIENT_ID

			SELECT
			 t.CLIENT_ID
			,t.TELEPHONE
			FROM TEMP T
				JOIN TEMP
				ON T.CLIENT_ID = TEMP.CLIENT_ID
	END

		DROP TABLE TEMP
		CLOSE SYMMETRIC KEY CLAVE;

	END TRY
	BEGIN CATCH

	END CATCH

END

-------------------------------------------------------------------------

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<HANSEL>
-- Create date: <>
-- Description:	<>
-- =============================================

CREATE PROCEDURE EX.spJobDeleteEmail
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM EX.EMAIL
	WHERE MIGRATED = 1

END

-----------------------------------------------------------------------------

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<HANSEL>
-- Create date: <>
-- Description:	<>
-- =============================================

CREATE PROCEDURE EX.spJobDeleteAddress
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM EX.ADDRESS
	WHERE MIGRATED = 1

END

------------------------------------------------------------------------------

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<HANSEL>
-- Create date: <>
-- Description:	<>
-- =============================================

CREATE PROCEDURE EX.spJobDeleteteTelephone
	AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM EX.TELEPHONE
	WHERE MIGRATED = 1

END

---------------------------------------------------------------------------------

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters
-- command (Ctrl-Shift-M) to fill in the parameter
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<HANSEL>
-- Create date: <>
-- Description:	<>
-- =============================================
CREATE PROCEDURE EX.spDeleteClientsOrderNumberCreditcard
@TABLE_NAME VARCHAR (50)
	AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY

	IF @TABLE_NAME = 'CLIENT' BEGIN

		DELETE FROM EX.CLIENT
		WHERE MIGRATED = 1

	END

	ELSE IF @TABLE_NAME = 'ORDERNUMBER' BEGIN

		DELETE FROM EX.ORDERNUMBER
		WHERE MIGRATED = 1
	END

	ELSE IF @TABLE_NAME = 'CREDITCARD' BEGIN

		DELETE FROM EX.CREDITCARD
		WHERE MIGRATED = 1
	END

	END TRY
	BEGIN CATCH

	END CATCH

END