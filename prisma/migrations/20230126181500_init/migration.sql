BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Imperfection] (
    [ImperfectionId] INT NOT NULL IDENTITY(1,1),
    [VehicleId] INT NOT NULL,
    [ContentFileId] INT,
    [OverrideName] VARCHAR(200),
    [OverrideDescription] VARCHAR(500),
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL,
    [UpdatedBy] VARCHAR(100),
    [IsHidden] BIT,
    [IsReviewed] BIT,
    CONSTRAINT [PK_Imperfection] PRIMARY KEY CLUSTERED ([ImperfectionId])
);

-- CreateTable
CREATE TABLE [dbo].[User] (
    [UserId] SMALLINT NOT NULL IDENTITY(1,1),
    [Email] VARCHAR(128) NOT NULL,
    [Name] VARCHAR(128) NOT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL,
    [DeactivatedAt] DATETIME2,
    CONSTRAINT [PK_repro_User] PRIMARY KEY CLUSTERED ([UserId]),
    CONSTRAINT [AK_repro_User_Email] UNIQUE NONCLUSTERED ([Email])
);

-- CreateTable
CREATE TABLE [dbo].[File] (
    [FileId] INT NOT NULL IDENTITY(1,1),
    [Url] VARCHAR(200),
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL,
    [ThumbnailFileId] INT,
    [PhotographerUserId] SMALLINT,
    CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED ([FileId]),
    CONSTRAINT [AK_File_Url] UNIQUE NONCLUSTERED ([Url])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_repro_Imperfection_VehicleId] ON [dbo].[Imperfection]([VehicleId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_repro_File_UpdatedAt] ON [dbo].[File]([UpdatedAt]);

-- AddForeignKey
ALTER TABLE [dbo].[Imperfection] ADD CONSTRAINT [FK_Imperfection_File] FOREIGN KEY ([ContentFileId]) REFERENCES [dbo].[File]([FileId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[File] ADD CONSTRAINT [FK_File_ThumbnailFile] FOREIGN KEY ([ThumbnailFileId]) REFERENCES [dbo].[File]([FileId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[File] ADD CONSTRAINT [FK_repro_File_User] FOREIGN KEY ([PhotographerUserId]) REFERENCES [dbo].[User]([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
