/*
================================================================================
  EmploymentBureau — ПОРТАТИВНЫЙ СКРИПТ ДЛЯ ПЕРЕНОСА НА ЛЮБОЙ ПК

  Что изменено для переносимости:
  1. Пути к файлам БД берутся автоматически из SERVERPROPERTY (SQL 2012+)
  2. Добавлена проверка существования БД + удаление если нужно
  3. Все ALTER DATABASE убраны — не нужны для переноса
  4. Добавлены индексы для быстродействия
  5. Убраны лишние настройки (ANSI, ARITHABORT и т.д.)
  6. Добавлена совместимость со старыми версиями SQL Server
================================================================================
*/

USE [master]
GO

-- ═══════════════════════════════════════════════════════════════
-- 1. ОПРЕДЕЛЯЕМ ПУТИ К ФАЙЛАМ БД АВТОМАТИЧЕСКИ
-- ═══════════════════════════════════════════════════════════════
DECLARE @DataPath NVARCHAR(512)
DECLARE @LogPath NVARCHAR(512)

-- Для SQL Server 2012+ (SQL Express 2017 подходит)
SET @DataPath = CONVERT(NVARCHAR(512), SERVERPROPERTY('InstanceDefaultDataPath'))
SET @LogPath = CONVERT(NVARCHAR(512), SERVERPROPERTY('InstanceDefaultLogPath'))

-- Fallback для старых версий (через master.mdf)
IF @DataPath IS NULL
BEGIN
    SELECT @DataPath = SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
    FROM master.sys.master_files
    WHERE database_id = 1 AND file_id = 1
    SET @LogPath = @DataPath
END

-- Убеждаемся что путь заканчивается на IF RIGHT(@DataPath, 1) <> '\' SET @DataPath = @DataPath + '\'
IF RIGHT(@LogPath, 1) <> '\' SET @LogPath = @LogPath + '\'

PRINT 'Data path: ' + @DataPath
PRINT 'Log path: ' + @LogPath

-- ═══════════════════════════════════════════════════════════════
-- 2. УДАЛЯЕМ БД ЕСЛИ УЖЕ СУЩЕСТВУЕТ
-- ═══════════════════════════════════════════════════════════════
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'EmploymentBureau')
BEGIN
    PRINT 'Database EmploymentBureau exists, dropping...'
    ALTER DATABASE [EmploymentBureau] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [EmploymentBureau]
    PRINT 'Database dropped.'
END

-- ═══════════════════════════════════════════════════════════════
-- 3. СОЗДАЁМ БАЗУ ДАННЫХ С АВТОПУТЯМИ
-- ═══════════════════════════════════════════════════════════════
DECLARE @SQL NVARCHAR(MAX)

SET @SQL = N'
CREATE DATABASE [EmploymentBureau]
ON PRIMARY
(   NAME = N''EmploymentBureau'',
    FILENAME = ''' + @DataPath + N'EmploymentBureau.mdf'',
    SIZE = 8192KB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 65536KB )
LOG ON
(   NAME = N''EmploymentBureau_log'',
    FILENAME = ''' + @LogPath + N'EmploymentBureau_log.ldf'',
    SIZE = 8192KB,
    MAXSIZE = 2048GB,
    FILEGROWTH = 65536KB )'

EXEC sp_executesql @SQL

PRINT 'Database EmploymentBureau created successfully.'
GO

USE [EmploymentBureau]
GO

-- ═══════════════════════════════════════════════════════════════
-- 4. СОЗДАЁМ ТАБЛИЦЫ
-- ═══════════════════════════════════════════════════════════════

CREATE TABLE [dbo].[Roles](
    [RoleID] [int] IDENTITY(1,1) NOT NULL,
    [RoleName] [varchar](50) NOT NULL,
    [Description] [varchar](255) NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleID] ASC)
)
GO

CREATE TABLE [dbo].[Users](
    [UserID] [int] IDENTITY(1,1) NOT NULL,
    [RoleID] [int] NOT NULL,
    [Email] [varchar](100) NOT NULL,
    [Phone] [varchar](20) NOT NULL,
    [PasswordHash] [varchar](255) NOT NULL,
    [RegistrationDate] [datetime] NULL CONSTRAINT [DF_Users_RegistrationDate] DEFAULT (getdate()),
    [IsActive] [bit] NULL CONSTRAINT [DF_Users_IsActive] DEFAULT ((1)),
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserID] ASC)
)
GO

CREATE TABLE [dbo].[Admins](
    [AdminID] [int] NOT NULL,
    [FullName] [varchar](255) NULL,
    CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED ([AdminID] ASC)
)
GO

CREATE TABLE [dbo].[Candidates](
    [CandidateID] [int] NOT NULL,
    [FullName] [varchar](255) NOT NULL,
    [Profession] [varchar](100) NULL,
    [ExperienceYears] [int] NULL,
    [Education] [varchar](255) NULL,
    [CreatedDate] [datetime] NULL CONSTRAINT [DF_Candidates_CreatedDate] DEFAULT (getdate()),
    [UpdatedDate] [datetime] NULL CONSTRAINT [DF_Candidates_UpdatedDate] DEFAULT (getdate()),
    CONSTRAINT [PK_Candidates] PRIMARY KEY CLUSTERED ([CandidateID] ASC)
)
GO

CREATE TABLE [dbo].[Employers](
    [EmployerID] [int] NOT NULL,
    [CompanyName] [varchar](255) NOT NULL,
    [INN] [varchar](12) NOT NULL,
    [ContactPerson] [varchar](255) NULL,
    [Industry] [varchar](100) NULL,
    [CompanyDescription] [text] NULL,
    [CreatedDate] [datetime] NULL CONSTRAINT [DF_Employers_CreatedDate] DEFAULT (getdate()),
    [UpdatedDate] [datetime] NULL CONSTRAINT [DF_Employers_UpdatedDate] DEFAULT (getdate()),
    CONSTRAINT [PK_Employers] PRIMARY KEY CLUSTERED ([EmployerID] ASC)
)
GO

CREATE TABLE [dbo].[Vacancies](
    [VacancyID] [int] IDENTITY(1,1) NOT NULL,
    [EmployerID] [int] NOT NULL,
    [Position] [varchar](255) NOT NULL,
    [Description] [text] NULL,
    [Requirements] [text] NULL,
    [SalaryFrom] [decimal](10, 2) NULL,
    [SalaryTo] [decimal](10, 2) NULL,
    [EmploymentType] [varchar](50) NULL,
    [ExperienceRequired] [int] NULL,
    [City] [varchar](100) NULL,
    [IsActive] [bit] NULL CONSTRAINT [DF_Vacancies_IsActive] DEFAULT ((1)),
    [CreatedDate] [datetime] NULL CONSTRAINT [DF_Vacancies_CreatedDate] DEFAULT (getdate()),
    [UpdatedDate] [datetime] NULL CONSTRAINT [DF_Vacancies_UpdatedDate] DEFAULT (getdate()),
    CONSTRAINT [PK_Vacancies] PRIMARY KEY CLUSTERED ([VacancyID] ASC)
)
GO

CREATE TABLE [dbo].[Resumes](
    [ResumeID] [int] IDENTITY(1,1) NOT NULL,
    [CandidateID] [int] NOT NULL,
    [Title] [varchar](255) NOT NULL,
    [ResumeText] [text] NOT NULL,
    [FilePath] [varchar](500) NULL,
    [FileName] [varchar](255) NULL,
    [FileSize] [int] NULL,
    [Skills] [text] NULL,
    [SalaryExpectation] [decimal](10, 2) NULL,
    [EmploymentType] [varchar](50) NULL,
    [WorkSchedule] [varchar](50) NULL,
    [IsVisible] [bit] NULL CONSTRAINT [DF_Resumes_IsVisible] DEFAULT ((1)),
    [IsPrimary] [bit] NULL CONSTRAINT [DF_Resumes_IsPrimary] DEFAULT ((0)),
    [Status] [varchar](50) NULL CONSTRAINT [DF_Resumes_Status] DEFAULT ('Опубликовано'),
    [CreatedDate] [datetime] NULL CONSTRAINT [DF_Resumes_CreatedDate] DEFAULT (getdate()),
    [UpdatedDate] [datetime] NULL CONSTRAINT [DF_Resumes_UpdatedDate] DEFAULT (getdate()),
    CONSTRAINT [PK_Resumes] PRIMARY KEY CLUSTERED ([ResumeID] ASC)
)
GO

CREATE TABLE [dbo].[CandidateResponses](
    [ResponseID] [int] IDENTITY(1,1) NOT NULL,
    [CandidateID] [int] NOT NULL,
    [VacancyID] [int] NOT NULL,
    [ResumeID] [int] NULL,
    [CoverLetter] [text] NULL,
    [Status] [varchar](50) NULL CONSTRAINT [DF_CandidateResponses_Status] DEFAULT ('Новый'),
    [ResponseDate] [datetime] NULL CONSTRAINT [DF_CandidateResponses_ResponseDate] DEFAULT (getdate()),
    [EmployerComment] [text] NULL,
    CONSTRAINT [PK_CandidateResponses] PRIMARY KEY CLUSTERED ([ResponseID] ASC)
)
GO

CREATE TABLE [dbo].[EmployerResponses](
    [EmployerResponseID] [int] IDENTITY(1,1) NOT NULL,
    [EmployerID] [int] NOT NULL,
    [CandidateID] [int] NOT NULL,
    [VacancyID] [int] NULL,
    [ResumeID] [int] NULL,
    [Message] [text] NULL,
    [Status] [varchar](50) NULL CONSTRAINT [DF_EmployerResponses_Status] DEFAULT ('На рассмотрении'),
    [ResponseDate] [datetime] NULL CONSTRAINT [DF_EmployerResponses_ResponseDate] DEFAULT (getdate()),
    [InterviewDate] [datetime] NULL,
    CONSTRAINT [PK_EmployerResponses] PRIMARY KEY CLUSTERED ([EmployerResponseID] ASC)
)
GO

CREATE TABLE [dbo].[CommissionSettings](
    [SettingID] [int] IDENTITY(1,1) NOT NULL,
    [SettingName] [varchar](100) NOT NULL,
    [CommissionPercent] [decimal](5, 2) NOT NULL CONSTRAINT [DF_CommissionSettings_CommissionPercent] DEFAULT ((15.00)),
    [MinCommission] [decimal](10, 2) NULL,
    [MaxCommission] [decimal](10, 2) NULL,
    [IsActive] [bit] NULL CONSTRAINT [DF_CommissionSettings_IsActive] DEFAULT ((1)),
    CONSTRAINT [PK_CommissionSettings] PRIMARY KEY CLUSTERED ([SettingID] ASC)
)
GO

CREATE TABLE [dbo].[CommissionHistory](
    [CommissionID] [int] IDENTITY(1,1) NOT NULL,
    [ResponseID] [int] NOT NULL,
    [CandidateID] [int] NOT NULL,
    [EmployerID] [int] NOT NULL,
    [VacancyID] [int] NOT NULL,
    [AnnualSalary] [decimal](12, 2) NOT NULL,
    [CommissionPercent] [decimal](5, 2) NOT NULL,
    [CommissionAmount] [decimal](12, 2) NOT NULL,
    [PaymentStatus] [varchar](50) NOT NULL CONSTRAINT [DF_CommissionHistory_PaymentStatus] DEFAULT ('Ожидает оплаты'),
    [PaymentDate] [datetime] NULL,
    [InvoiceNumber] [varchar](50) NULL,
    [Notes] [text] NULL,
    [CreatedDate] [datetime] NOT NULL CONSTRAINT [DF_CommissionHistory_CreatedDate] DEFAULT (getdate()),
    [UpdatedDate] [datetime] NULL,
    CONSTRAINT [PK_CommissionHistory] PRIMARY KEY CLUSTERED ([CommissionID] ASC)
)
GO

-- ═══════════════════════════════════════════════════════════════
-- 5. ВНЕШНИЕ КЛЮЧИ (FK) — КАСКАДНОЕ УДАЛЕНИЕ ГДЕ ВОЗМОЖНО
-- ═══════════════════════════════════════════════════════════════

ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleID]) REFERENCES [dbo].[Roles] ([RoleID])
GO

ALTER TABLE [dbo].[Admins] ADD CONSTRAINT [FK_Admins_Users] FOREIGN KEY([AdminID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Candidates] ADD CONSTRAINT [FK_Candidates_Users] FOREIGN KEY([CandidateID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Employers] ADD CONSTRAINT [FK_Employers_Users] FOREIGN KEY([EmployerID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Resumes] ADD CONSTRAINT [FK_Resumes_Candidates] FOREIGN KEY([CandidateID]) REFERENCES [dbo].[Candidates] ([CandidateID]) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Vacancies] ADD CONSTRAINT [FK_Vacancies_Employers] FOREIGN KEY([EmployerID]) REFERENCES [dbo].[Employers] ([EmployerID]) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[CandidateResponses] ADD CONSTRAINT [FK_CandidateResponses_Candidates] FOREIGN KEY([CandidateID]) REFERENCES [dbo].[Candidates] ([CandidateID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CandidateResponses] ADD CONSTRAINT [FK_CandidateResponses_Vacancies] FOREIGN KEY([VacancyID]) REFERENCES [dbo].[Vacancies] ([VacancyID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CandidateResponses] ADD CONSTRAINT [FK_CandidateResponses_Resumes] FOREIGN KEY([ResumeID]) REFERENCES [dbo].[Resumes] ([ResumeID]) ON DELETE SET NULL
GO

ALTER TABLE [dbo].[EmployerResponses] ADD CONSTRAINT [FK_EmployerResponses_Employers] FOREIGN KEY([EmployerID]) REFERENCES [dbo].[Employers] ([EmployerID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployerResponses] ADD CONSTRAINT [FK_EmployerResponses_Candidates] FOREIGN KEY([CandidateID]) REFERENCES [dbo].[Candidates] ([CandidateID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployerResponses] ADD CONSTRAINT [FK_EmployerResponses_Vacancies] FOREIGN KEY([VacancyID]) REFERENCES [dbo].[Vacancies] ([VacancyID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployerResponses] ADD CONSTRAINT [FK_EmployerResponses_Resumes] FOREIGN KEY([ResumeID]) REFERENCES [dbo].[Resumes] ([ResumeID]) ON DELETE SET NULL
GO

ALTER TABLE [dbo].[CommissionHistory] ADD CONSTRAINT [FK_CommissionHistory_Candidates] FOREIGN KEY([CandidateID]) REFERENCES [dbo].[Candidates] ([CandidateID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommissionHistory] ADD CONSTRAINT [FK_CommissionHistory_Employers] FOREIGN KEY([EmployerID]) REFERENCES [dbo].[Employers] ([EmployerID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommissionHistory] ADD CONSTRAINT [FK_CommissionHistory_Vacancies] FOREIGN KEY([VacancyID]) REFERENCES [dbo].[Vacancies] ([VacancyID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommissionHistory] ADD CONSTRAINT [FK_CommissionHistory_CandidateResponses] FOREIGN KEY([ResponseID]) REFERENCES [dbo].[CandidateResponses] ([ResponseID]) ON DELETE CASCADE
GO

-- ═══════════════════════════════════════════════════════════════
-- 6. УНИКАЛЬНЫЕ ИНДЕКСЫ
-- ═══════════════════════════════════════════════════════════════

ALTER TABLE [dbo].[Employers] ADD CONSTRAINT [UQ_Employers_INN] UNIQUE NONCLUSTERED ([INN] ASC)
GO

ALTER TABLE [dbo].[Roles] ADD CONSTRAINT [UQ_Roles_RoleName] UNIQUE NONCLUSTERED ([RoleName] ASC)
GO

ALTER TABLE [dbo].[Users] ADD CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED ([Email] ASC)
GO

ALTER TABLE [dbo].[CandidateResponses] ADD CONSTRAINT [UQ_CandidateResponses_CandidateVacancy] UNIQUE NONCLUSTERED ([CandidateID] ASC, [VacancyID] ASC)
GO

-- ═══════════════════════════════════════════════════════════════
-- 7. ПРОИЗВОДИТЕЛЬНОСТЬ: ДОПОЛНИТЕЛЬНЫЕ ИНДЕКСЫ
-- ═══════════════════════════════════════════════════════════════

CREATE NONCLUSTERED INDEX [IX_CommissionHistory_EmployerID] ON [dbo].[CommissionHistory]([EmployerID] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_CommissionHistory_PaymentStatus] ON [dbo].[CommissionHistory]([PaymentStatus] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_Vacancies_EmployerID] ON [dbo].[Vacancies]([EmployerID] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_Resumes_CandidateID] ON [dbo].[Resumes]([CandidateID] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_CandidateResponses_CandidateID] ON [dbo].[CandidateResponses]([CandidateID] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_CandidateResponses_VacancyID] ON [dbo].[CandidateResponses]([VacancyID] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_EmployerResponses_EmployerID] ON [dbo].[EmployerResponses]([EmployerID] ASC)
GO

CREATE NONCLUSTERED INDEX [IX_EmployerResponses_CandidateID] ON [dbo].[EmployerResponses]([CandidateID] ASC)
GO

-- ═══════════════════════════════════════════════════════════════
-- 8. ПРЕДСТАВЛЕНИЕ (VIEW) ДЛЯ КОМИССИЙ
-- ═══════════════════════════════════════════════════════════════

CREATE VIEW [dbo].[vw_CommissionDetails] AS
SELECT 
    ch.CommissionID,
    ch.ResponseID,
    c.FullName AS CandidateName,
    c.Profession AS CandidateProfession,
    e.CompanyName AS EmployerName,
    e.INN AS EmployerINN,
    v.Position AS VacancyPosition,
    v.City AS VacancyCity,
    ch.AnnualSalary,
    ch.CommissionPercent,
    ch.CommissionAmount,
    ch.PaymentStatus,
    ch.PaymentDate,
    ch.InvoiceNumber,
    ch.Notes,
    ch.CreatedDate,
    ch.UpdatedDate,
    DATEDIFF(day, ch.CreatedDate, ISNULL(ch.PaymentDate, GETDATE())) AS DaysToPayment
FROM [dbo].[CommissionHistory] ch
JOIN [dbo].[Candidates] c ON ch.CandidateID = c.CandidateID
JOIN [dbo].[Employers] e ON ch.EmployerID = e.EmployerID
JOIN [dbo].[Vacancies] v ON ch.VacancyID = v.VacancyID
GO

-- ═══════════════════════════════════════════════════════════════
-- 9. ТЕСТОВЫЕ ДАННЫЕ (опционально — можно удалить для продакшена)
-- ═══════════════════════════════════════════════════════════════

SET IDENTITY_INSERT [dbo].[Roles] ON
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (1, 'Admin', 'Администратор системы')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (2, 'Candidate', 'Соискатель / кандидат')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (3, 'Employer', 'Работодатель')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO

SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) 
VALUES (1, 1, 'admin@buro.ru', '+7(999)000-00-00', 'admin123', '2026-03-10T08:44:17.267', 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) 
VALUES (2, 2, 'ivanov@mail.ru', '+7(916)111-11-11', 'password123', '2026-03-10T08:44:17.563', 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) 
VALUES (5, 3, 'techcorp@company.ru', '+7(495)100-10-10', 'company123', '2026-03-10T08:44:17.590', 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO

INSERT [dbo].[Admins] ([AdminID], [FullName]) VALUES (1, 'Администратор системы')
GO

INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) 
VALUES (2, 'Иванов Иван Иванович', 'Разработчик C# / .NET', 5, 'МГУ им. Ломоносова', '2026-03-10T08:44:17.563', '2026-03-10T08:44:17.563')
GO

INSERT [dbo].[Employers] ([EmployerID], [CompanyName], [INN], [ContactPerson], [Industry], [CreatedDate], [UpdatedDate]) 
VALUES (5, 'TechCorp Inc.', '7701234567', 'Петров Петр Петрович', 'Информационные технологии', '2026-03-10T08:44:17.590', '2026-03-10T08:44:17.590')
GO

INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) 
VALUES (1, 5, 'Разработчик C# / .NET', 'Разработка приложений на .NET Core', 'Опыт от 3 лет, C#, ASP.NET Core, SQL', 120000.00, 180000.00, 'Полная занятость', 3, 'Москва', 1, '2026-03-10T08:44:17.590', '2026-03-10T08:44:17.590')
GO

INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) 
VALUES (1, 2, 'Senior .NET Developer', 'Опыт работы с C# более 5 лет...', 'C#, .NET, ASP.NET Core, SQL, Entity Framework', 150000.00, 'Полная занятость', 'Полный день', 1, 1, 'Опубликовано', '2026-03-10T08:44:17.570', '2026-03-10T08:44:17.570')
GO

INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) 
VALUES (1, 2, 1, 1, 'Здравствуйте! Интересует вакансия...', 'На рассмотрении', '2026-03-10T08:59:15.703', NULL)
GO

INSERT [dbo].[CommissionSettings] ([SettingID], [SettingName], [CommissionPercent], [MinCommission], [MaxCommission], [IsActive]) 
VALUES (1, 'StandardCommission', 15.00, NULL, NULL, 1)
GO

PRINT '========================================'
PRINT 'БАЗА ДАННЫХ EmploymentBureau ГОТОВА!'
PRINT '========================================'
GO
