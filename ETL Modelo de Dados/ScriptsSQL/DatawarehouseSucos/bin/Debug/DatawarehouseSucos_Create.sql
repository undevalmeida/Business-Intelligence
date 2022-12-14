﻿/*
Deployment script for DatawarehouseSucos

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DatawarehouseSucos"
:setvar DefaultFilePrefix "DatawarehouseSucos"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating database $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating Table [dbo].[Dim_Categoria]...';


GO
CREATE TABLE [dbo].[Dim_Categoria] (
    [Cod_Categoria]  NVARCHAR (50)  NOT NULL,
    [Desc_Categoria] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Cod_Categoria] ASC)
);


GO
PRINT N'Creating Table [dbo].[Dim_Marca]...';


GO
CREATE TABLE [dbo].[Dim_Marca] (
    [Cod_Marca]     NVARCHAR (50)  NOT NULL,
    [Desc_Marca]    NVARCHAR (200) NULL,
    [Cod_Categoria] NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Cod_Marca] ASC)
);


GO
PRINT N'Creating Table [dbo].[Dim_Clientes]...';


GO
CREATE TABLE [dbo].[Dim_Clientes] (
    [Cod_Cliente]   NVARCHAR (50)  NOT NULL,
    [Desc_Cliente]  NVARCHAR (200) NULL,
    [Cod_Cidade]    NVARCHAR (50)  NULL,
    [Desc_Cidade]   NVARCHAR (200) NULL,
    [Cod_Estado]    NVARCHAR (50)  NULL,
    [Desc_Estado]   NVARCHAR (200) NULL,
    [Cod_Regiao]    NVARCHAR (50)  NULL,
    [Desc_Regiao]   NVARCHAR (200) NULL,
    [Cod_Segmento]  NVARCHAR (50)  NULL,
    [Desc_Segmento] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Cod_Cliente] ASC)
);


GO
PRINT N'Creating Table [dbo].[Dim_Produto]...';


GO
CREATE TABLE [dbo].[Dim_Produto] (
    [Cod_Produto]  NVARCHAR (50)  NOT NULL,
    [Desc_Produto] NVARCHAR (200) NULL,
    [Atr_Tamanho ] NVARCHAR (200) NULL,
    [Atr_Sabor]    NVARCHAR (200) NULL,
    [Cod_Marca]    NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Cod_Produto] ASC)
);


GO
PRINT N'Creating Table [dbo].[Dim_Fabrica]...';


GO
CREATE TABLE [dbo].[Dim_Fabrica] (
    [Cod_Fabrica]  NVARCHAR (50) NOT NULL,
    [Desc_Fabrica] NCHAR (200)   NULL,
    PRIMARY KEY CLUSTERED ([Cod_Fabrica] ASC)
);


GO
PRINT N'Creating Table [dbo].[Dim_Organizacional]...';


GO
CREATE TABLE [dbo].[Dim_Organizacional] (
    [Cod_Filho]  NVARCHAR (50)  NOT NULL,
    [Desc_Filho] NVARCHAR (200) NULL,
    [Cod_Pai]    NVARCHAR (50)  NULL,
    [Esquerda]   INT            NULL,
    [Direita]    INT            NULL,
    [Nível]      INT            NULL,
    PRIMARY KEY CLUSTERED ([Cod_Filho] ASC)
);


GO
PRINT N'Creating Table [dbo].[Dim_Tempo]...';


GO
CREATE TABLE [dbo].[Dim_Tempo] (
    [Cod_Dia]            NVARCHAR (50) NOT NULL,
    [Data]               DATE          NULL,
    [CodSemana]          INT           NULL,
    [Nome_Dia_Semana]    NVARCHAR (50) NULL,
    [Cod_Mes]            INT           NULL,
    [Nome_Mes]           NVARCHAR (50) NULL,
    [Cod_Mes_Ano]        NVARCHAR (50) NULL,
    [Nome_Mes_Ano]       NVARCHAR (50) NULL,
    [Cod_Trimestre]      INT           NULL,
    [Nome_Trimestre]     NVARCHAR (50) NULL,
    [Cod_Trimestre_Ano]  NVARCHAR (50) NULL,
    [Nome_Trimestre_Ano] NVARCHAR (50) NULL,
    [Cod_Semestre]       INT           NULL,
    [Nome_Semestre]      NVARCHAR (50) NULL,
    [Cod_Semestre_Ano]   NCHAR (10)    NULL,
    [Nome_Semestre_Ano]  NVARCHAR (50) NULL,
    [Ano]                NVARCHAR (50) NULL,
    [Tipo_Dia]           NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Cod_Dia] ASC)
);


GO
PRINT N'Creating Table [dbo].[Fato_001]...';


GO
CREATE TABLE [dbo].[Fato_001] (
    [Cod_Cliente]        NVARCHAR (50) NOT NULL,
    [Cod_Produto]        NVARCHAR (50) NOT NULL,
    [Cod_Organizacional] NVARCHAR (50) NOT NULL,
    [Cod_Fabrica]        NVARCHAR (50) NOT NULL,
    [Cod_Dia]            NVARCHAR (50) NOT NULL,
    [Faturamento]        FLOAT (53)    NULL,
    [Imposto]            FLOAT (53)    NULL,
    [Custo_Variavel]     FLOAT (53)    NULL,
    [Quantidade_Vendida] FLOAT (53)    NULL,
    [Unidades_Vendidas]  FLOAT (53)    NULL,
    PRIMARY KEY CLUSTERED ([Cod_Cliente] ASC, [Cod_Produto] ASC, [Cod_Organizacional] ASC, [Cod_Fabrica] ASC, [Cod_Dia] ASC)
);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Dim_Marca_Dim_Categoria]...';


GO
ALTER TABLE [dbo].[Dim_Marca]
    ADD CONSTRAINT [FK_Dim_Marca_Dim_Categoria] FOREIGN KEY ([Cod_Categoria]) REFERENCES [dbo].[Dim_Categoria] ([Cod_Categoria]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Dim_Produto_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Dim_Produto]
    ADD CONSTRAINT [FK_Dim_Produto_Dim_Produto] FOREIGN KEY ([Cod_Marca]) REFERENCES [dbo].[Dim_Marca] ([Cod_Marca]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Dim_Organizacional_Dim_Organizacional]...';


GO
ALTER TABLE [dbo].[Dim_Organizacional]
    ADD CONSTRAINT [FK_Dim_Organizacional_Dim_Organizacional] FOREIGN KEY ([Cod_Pai]) REFERENCES [dbo].[Dim_Organizacional] ([Cod_Filho]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Fato_001_Dim_Cliente]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_Cliente] FOREIGN KEY ([Cod_Cliente]) REFERENCES [dbo].[Dim_Clientes] ([Cod_Cliente]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Fato_001_Dim_Produto]...';


GO
ALTER TABLE [dbo].[Fato_001]
    ADD CONSTRAINT [FK_Fato_001_Dim_Produto] FOREIGN KEY ([Cod_Produto]) REFERENCES [dbo].[Dim_Produto] ([Cod_Produto]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9291e02a-fe32-4ab7-aaae-428e3f9df4c3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9291e02a-fe32-4ab7-aaae-428e3f9df4c3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8b618adf-8e2e-4bad-afb0-3a3b0776b0c8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8b618adf-8e2e-4bad-afb0-3a3b0776b0c8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b135b8d6-260e-4cae-a4c7-6ab9958889ee')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b135b8d6-260e-4cae-a4c7-6ab9958889ee')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5a05d076-6158-4aa0-9822-70a905e4541f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5a05d076-6158-4aa0-9822-70a905e4541f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd10c5efb-9e13-4c59-8a82-d2b12b2fe512')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d10c5efb-9e13-4c59-8a82-d2b12b2fe512')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3cc7cde9-65fa-40d1-976f-17360af71438')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3cc7cde9-65fa-40d1-976f-17360af71438')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '31b47a84-543d-467f-b8eb-b2b18589b292')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('31b47a84-543d-467f-b8eb-b2b18589b292')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9fb2cc35-a3e5-4141-9d01-8e70c2225478')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9fb2cc35-a3e5-4141-9d01-8e70c2225478')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e595bb60-b1d4-45f5-b8e3-33af37e667e5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e595bb60-b1d4-45f5-b8e3-33af37e667e5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8a102b38-f2e0-42d3-aa25-4381957cbb9c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8a102b38-f2e0-42d3-aa25-4381957cbb9c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3860d46d-897a-4490-95c7-1f24552b4c53')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3860d46d-897a-4490-95c7-1f24552b4c53')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '81ee1dc1-0896-40db-bbca-a95e653e30a0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('81ee1dc1-0896-40db-bbca-a95e653e30a0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bbf87ecf-e45e-4008-bc3e-40affe194e08')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bbf87ecf-e45e-4008-bc3e-40affe194e08')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0a732980-21ea-4025-a35b-e5f4b82ed8be')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0a732980-21ea-4025-a35b-e5f4b82ed8be')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '41945de2-e7b1-499d-ac4e-2ad625bf717c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('41945de2-e7b1-499d-ac4e-2ad625bf717c')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Update complete.';


GO
