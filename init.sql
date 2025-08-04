-- 1) Create a database if it doesn't already exist
IF DB_ID(N'mssql') IS NULL
BEGIN
    PRINT N'Creating database [mssql]...';
    CREATE DATABASE [mssql];
END
GO

-- 2) Switch context
USE [mssql];
GO

-- 3) Drop the table if it already exists
IF OBJECT_ID(N'dbo.kubedb_init', N'U') IS NOT NULL
BEGIN
    PRINT N'Dropping existing table [dbo.kubedb_init]...';
DROP TABLE dbo.kubedb_init;
END
GO

-- 4) Create the table with an IDENTITY primary key
PRINT N'Creating table [dbo.kubedb_init]...';
CREATE TABLE dbo.kubedb_init (
    id   BIGINT             IDENTITY(1,1) NOT NULL CONSTRAINT PK_kubedb_init PRIMARY KEY,
    name NVARCHAR(255)      NULL,
    created_at DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- 5) Seed it with some test data
PRINT N'Inserting sample rows...';
INSERT INTO dbo.kubedb_init (name) VALUES
   (N'name1'),
   (N'name2'),
   (N'name3'),
   (N'name4'),
   (N'name5'),
   (N'name6'),
   (N'name7'),
   (N'name8');
GO

-- 6) Confirmation
DECLARE @cnt INT = (SELECT COUNT(*) FROM dbo.kubedb_init);
PRINT N'Inserted ' + CAST(@cnt AS NVARCHAR(10)) + N' rows into dbo.kubedb_init.';
GO
