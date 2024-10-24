IF DB_ID(N'library') IS NULL
BEGIN
    CREATE DATABASE [library];
END;
GO

USE [library];
GO


IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    IF SCHEMA_ID(N'organisational_unit') IS NULL EXEC(N'CREATE SCHEMA [organisational_unit];');
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    IF SCHEMA_ID(N'location') IS NULL EXEC(N'CREATE SCHEMA [location];');
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    IF SCHEMA_ID(N'organisation') IS NULL EXEC(N'CREATE SCHEMA [organisation];');
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [location].[location] (
        [Id] int NOT NULL IDENTITY,
        [Level] int NOT NULL,
        [Name] nvarchar(150) NOT NULL,
        [Coordinates] nvarchar(50) NOT NULL,
        [ParentId] int NULL,
        CONSTRAINT [PK_location] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisation].[organisation] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(256) NOT NULL,
        CONSTRAINT [PK_organisation] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [location].[localisation] (
        [Id] int NOT NULL IDENTITY,
        [LocationId] int NOT NULL,
        [Locale] nvarchar(5) NOT NULL,
        [Name] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_localisation] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_localisation_location_LocationId] FOREIGN KEY ([LocationId]) REFERENCES [location].[location] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisation].[organisational_unit] (
        [Id] int NOT NULL IDENTITY,
        [OrganisationId] int NOT NULL,
        [ParentOrganisationalUnitId] int NULL,
        [Logo] nvarchar(max) NULL,
        [Archived] bit NOT NULL,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_organisational_unit] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_organisational_unit_organisation_OrganisationId] FOREIGN KEY ([OrganisationId]) REFERENCES [organisation].[organisation] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_organisational_unit_organisational_unit_ParentOrganisationalUnitId] FOREIGN KEY ([ParentOrganisationalUnitId]) REFERENCES [organisation].[organisational_unit] ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisational_unit].[address] (
        [Id] int NOT NULL IDENTITY,
        [AddressType] int NOT NULL,
        [Coordinates] nvarchar(50) NOT NULL,
        [Street] nvarchar(100) NOT NULL,
        [ZipCode] nvarchar(20) NOT NULL,
        [City] nvarchar(50) NOT NULL,
        [Region] nvarchar(50) NULL,
        [Country] nvarchar(100) NOT NULL,
        [FormattedAddressKey] nvarchar(100) NOT NULL,
        [OrganisationalUnitId] int NOT NULL,
        [LocationId] int NOT NULL,
        CONSTRAINT [PK_address] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_address_location_LocationId] FOREIGN KEY ([LocationId]) REFERENCES [location].[location] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_address_organisational_unit_OrganisationalUnitId] FOREIGN KEY ([OrganisationalUnitId]) REFERENCES [organisation].[organisational_unit] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisational_unit].[cardset] (
        [Id] int NOT NULL IDENTITY,
        [OrganisationalUnitId] int NOT NULL,
        [Locale] nvarchar(5) NOT NULL,
        [Key] nvarchar(1019) NOT NULL,
        [Version] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_cardset] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_cardset_organisational_unit_OrganisationalUnitId] FOREIGN KEY ([OrganisationalUnitId]) REFERENCES [organisation].[organisational_unit] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisational_unit].[image] (
        [Id] int NOT NULL IDENTITY,
        [OrganisationalUnitId] int NOT NULL,
        [AltText] nvarchar(512) NULL,
        [Url] nvarchar(256) NOT NULL,
        CONSTRAINT [PK_image] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_image_organisational_unit_OrganisationalUnitId] FOREIGN KEY ([OrganisationalUnitId]) REFERENCES [organisation].[organisational_unit] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisational_unit].[short_name] (
        [OrganisationalUnitId] int NOT NULL,
        [Name] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_short_name] PRIMARY KEY ([OrganisationalUnitId]),
        CONSTRAINT [FK_short_name_organisational_unit_OrganisationalUnitId] FOREIGN KEY ([OrganisationalUnitId]) REFERENCES [organisation].[organisational_unit] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisational_unit].[social_media] (
        [Id] int NOT NULL IDENTITY,
        [OrganisationalUnitId] int NOT NULL,
        [Url] nvarchar(256) NOT NULL,
        [DisplayName] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_social_media] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_social_media_organisational_unit_OrganisationalUnitId] FOREIGN KEY ([OrganisationalUnitId]) REFERENCES [organisation].[organisational_unit] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE TABLE [organisational_unit].[video] (
        [Id] int NOT NULL IDENTITY,
        [OrganisationalUnitId] int NOT NULL,
        [Title] nvarchar(250) NOT NULL,
        [ThumbnailUrl] nvarchar(256) NOT NULL,
        [Url] nvarchar(256) NOT NULL,
        CONSTRAINT [PK_video] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_video_organisational_unit_OrganisationalUnitId] FOREIGN KEY ([OrganisationalUnitId]) REFERENCES [organisation].[organisational_unit] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Coordinates', N'Level', N'Name', N'ParentId') AND [object_id] = OBJECT_ID(N'[location].[location]'))
        SET IDENTITY_INSERT [location].[location] ON;
    EXEC(N'INSERT INTO [location].[location] ([Id], [Coordinates], [Level], [Name], [ParentId])
    VALUES (1, N''1'', 0, N''Location'', NULL)');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Coordinates', N'Level', N'Name', N'ParentId') AND [object_id] = OBJECT_ID(N'[location].[location]'))
        SET IDENTITY_INSERT [location].[location] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Name') AND [object_id] = OBJECT_ID(N'[organisation].[organisation]'))
        SET IDENTITY_INSERT [organisation].[organisation] ON;
    EXEC(N'INSERT INTO [organisation].[organisation] ([Id], [Name])
    VALUES (1, N''Object-based user-facing monitoring'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Name') AND [object_id] = OBJECT_ID(N'[organisation].[organisation]'))
        SET IDENTITY_INSERT [organisation].[organisation] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Archived', N'Logo', N'Name', N'OrganisationId', N'ParentOrganisationalUnitId') AND [object_id] = OBJECT_ID(N'[organisation].[organisational_unit]'))
        SET IDENTITY_INSERT [organisation].[organisational_unit] ON;
    EXEC(N'INSERT INTO [organisation].[organisational_unit] ([Id], [Archived], [Logo], [Name], [OrganisationId], [ParentOrganisationalUnitId])
    VALUES (1, CAST(0 AS bit), NULL, N''Koch, Reynolds and Russel University'', 1, NULL)');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Archived', N'Logo', N'Name', N'OrganisationId', N'ParentOrganisationalUnitId') AND [object_id] = OBJECT_ID(N'[organisation].[organisational_unit]'))
        SET IDENTITY_INSERT [organisation].[organisational_unit] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'AddressType', N'City', N'Coordinates', N'Country', N'FormattedAddressKey', N'LocationId', N'OrganisationalUnitId', N'Region', N'Street', N'ZipCode') AND [object_id] = OBJECT_ID(N'[organisational_unit].[address]'))
        SET IDENTITY_INSERT [organisational_unit].[address] ON;
    EXEC(N'INSERT INTO [organisational_unit].[address] ([Id], [AddressType], [City], [Coordinates], [Country], [FormattedAddressKey], [LocationId], [OrganisationalUnitId], [Region], [Street], [ZipCode])
    VALUES (1, 0, N''West Adrielville'', N''8'', N''Wallis and Futuna'', N''furt'', 1, 1, NULL, N''46572 Maggio Meadows'', N''86422'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'AddressType', N'City', N'Coordinates', N'Country', N'FormattedAddressKey', N'LocationId', N'OrganisationalUnitId', N'Region', N'Street', N'ZipCode') AND [object_id] = OBJECT_ID(N'[organisational_unit].[address]'))
        SET IDENTITY_INSERT [organisational_unit].[address] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE UNIQUE INDEX [IX_address_LocationId] ON [organisational_unit].[address] ([LocationId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE INDEX [IX_address_OrganisationalUnitId] ON [organisational_unit].[address] ([OrganisationalUnitId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE UNIQUE INDEX [IX_cardset_OrganisationalUnitId] ON [organisational_unit].[cardset] ([OrganisationalUnitId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE INDEX [IX_image_OrganisationalUnitId] ON [organisational_unit].[image] ([OrganisationalUnitId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE INDEX [IX_localisation_LocationId] ON [location].[localisation] ([LocationId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE INDEX [IX_organisational_unit_OrganisationId] ON [organisation].[organisational_unit] ([OrganisationId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE INDEX [IX_organisational_unit_ParentOrganisationalUnitId] ON [organisation].[organisational_unit] ([ParentOrganisationalUnitId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE INDEX [IX_social_media_OrganisationalUnitId] ON [organisational_unit].[social_media] ([OrganisationalUnitId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    CREATE INDEX [IX_video_OrganisationalUnitId] ON [organisational_unit].[video] ([OrganisationalUnitId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241024011001_Initial'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20241024011001_Initial', N'8.0.8');
END;
GO

COMMIT;
GO