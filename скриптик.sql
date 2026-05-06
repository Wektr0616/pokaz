USE [master]
GO
CREATE DATABASE [EmploymentBureau]
GO
USE [EmploymentBureau]
GO
/****** Object:  Table [dbo].[Admins]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[AdminID] [int] NOT NULL,
	[FullName] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CandidateResponses]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateResponses](
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[CandidateID] [int] NOT NULL,
	[VacancyID] [int] NOT NULL,
	[ResumeID] [int] NULL,
	[CoverLetter] [text] NULL,
	[Status] [varchar](50) NULL,
	[ResponseDate] [datetime] NULL,
	[EmployerComment] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Candidates]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidates](
	[CandidateID] [int] NOT NULL,
	[FullName] [varchar](255) NOT NULL,
	[Profession] [varchar](100) NULL,
	[ExperienceYears] [int] NULL,
	[Education] [varchar](255) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CandidateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommissionHistory]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[PaymentStatus] [varchar](50) NOT NULL,
	[PaymentDate] [datetime] NULL,
	[InvoiceNumber] [varchar](50) NULL,
	[Notes] [text] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CommissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommissionSettings]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommissionSettings](
	[SettingID] [int] IDENTITY(1,1) NOT NULL,
	[SettingName] [varchar](100) NOT NULL,
	[CommissionPercent] [decimal](5, 2) NOT NULL,
	[MinCommission] [decimal](10, 2) NULL,
	[MaxCommission] [decimal](10, 2) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployerResponses]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployerResponses](
	[EmployerResponseID] [int] IDENTITY(1,1) NOT NULL,
	[EmployerID] [int] NOT NULL,
	[CandidateID] [int] NOT NULL,
	[VacancyID] [int] NULL,
	[ResumeID] [int] NULL,
	[Message] [text] NULL,
	[Status] [varchar](50) NULL,
	[ResponseDate] [datetime] NULL,
	[InterviewDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployerResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employers]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employers](
	[EmployerID] [int] NOT NULL,
	[CompanyName] [varchar](255) NOT NULL,
	[INN] [varchar](12) NOT NULL,
	[ContactPerson] [varchar](255) NULL,
	[Industry] [varchar](100) NULL,
	[CompanyDescription] [text] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resumes]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[IsVisible] [bit] NULL,
	[IsPrimary] [bit] NULL,
	[Status] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResumeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[Description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
	[RegistrationDate] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vacancies]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VacancyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_CommissionDetails]    Script Date: 05.05.2026 22:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Представление для удобного просмотра комиссий с деталями
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
INSERT [dbo].[Admins] ([AdminID], [FullName]) VALUES (1, N'Главный Администратор')
INSERT [dbo].[Admins] ([AdminID], [FullName]) VALUES (8, N'Модератор Контента')
INSERT [dbo].[Admins] ([AdminID], [FullName]) VALUES (9, N'Техническая Поддержка')
GO
SET IDENTITY_INSERT [dbo].[CandidateResponses] ON 

INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (1, 2, 2, 1, N'Здравствуйте! Интересует вакансия дизайнера. Хотел бы расширить свои навыки в области дизайна интерфейсов.', N'Рассматривается', CAST(N'2026-03-10T08:59:15.703' AS DateTime), N'Нестандартный случай, требуется собеседование')
INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (2, 3, 3, 2, N'Добрый день! Имею опыт управления дизайн-проектами, хочу развиваться в направлении IT-менеджмента.', N'Приглашен на собеседование', CAST(N'2026-03-10T08:59:15.727' AS DateTime), N'Сильный кандидат, назначить встречу на понедельник')
INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (3, 4, 1, 3, N'Приветствую! Ранее работал разработчиком, сейчас менеджер. Рассматриваю возврат к разработке на позицию Tech Lead.', N'Приглашен на собеседование', CAST(N'2026-03-10T08:59:15.730' AS DateTime), N'')
INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (4, 2, 3, 1, N'Также интересует позиция PM в IT Solutions. Есть опыт менторинга junior-разработчиков.', N'Новый', CAST(N'2026-03-10T08:59:15.730' AS DateTime), NULL)
INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (5, 3, 2, 2, N'Очень рада возможности присоединиться к вашей команде!', N'Принят на работу', CAST(N'2026-03-10T08:59:20.440' AS DateTime), N'Выходит на работу с 1 апреля 2026')
INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (6, 15, 6, 6, N'', N'Принят на работу', CAST(N'2026-03-12T13:44:57.407' AS DateTime), N'')
INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (7, 15, 7, 6, N'rrr', N'Принят на работу', CAST(N'2026-03-16T12:18:25.973' AS DateTime), N'')
INSERT [dbo].[CandidateResponses] ([ResponseID], [CandidateID], [VacancyID], [ResumeID], [CoverLetter], [Status], [ResponseDate], [EmployerComment]) VALUES (8, 15, 8, 6, N'', N'Принят на работу', CAST(N'2026-04-29T22:07:40.017' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[CandidateResponses] OFF
GO
INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) VALUES (2, N'Иванов Иван Иванович', N'Разработчик C# / .NET', 5, N'МГТУ им. Баумана, инженер-программист', CAST(N'2026-03-10T08:44:17.563' AS DateTime), CAST(N'2026-03-10T08:44:17.563' AS DateTime))
INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) VALUES (3, N'Петрова Светлана Сергеевна', N'UX/UI Дизайнер', 3, N'СПбГУ, дизайнер', CAST(N'2026-03-10T08:44:17.563' AS DateTime), CAST(N'2026-03-10T08:44:17.563' AS DateTime))
INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) VALUES (4, N'Сидоров Алексей Петрович', N'Project Manager', 7, N'ВШЭ, менеджмент', CAST(N'2026-03-10T08:44:17.563' AS DateTime), CAST(N'2026-03-10T08:44:17.563' AS DateTime))
INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) VALUES (10, N'Новиков Дмитрий Александрович', N'Data Scientist', 4, N'МФТИ, прикладная математика', CAST(N'2026-03-10T08:59:16.140' AS DateTime), CAST(N'2026-03-10T08:59:16.140' AS DateTime))
INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) VALUES (11, N'Увольненный Сотрудник', N'Бухгалтер', 10, N'РГЭУ, бухучет', CAST(N'2026-03-10T08:59:20.347' AS DateTime), CAST(N'2026-03-10T08:59:20.347' AS DateTime))
INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) VALUES (12, N'авававав', N'Программист', 7, N'Высшие', CAST(N'2026-03-10T11:52:24.320' AS DateTime), CAST(N'2026-03-10T11:52:24.320' AS DateTime))
INSERT [dbo].[Candidates] ([CandidateID], [FullName], [Profession], [ExperienceYears], [Education], [CreatedDate], [UpdatedDate]) VALUES (15, N'fdf', N'Разработчик сайтов', 7, N'Высшие', CAST(N'2026-03-12T13:11:54.780' AS DateTime), CAST(N'2026-03-12T13:11:54.780' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[CommissionHistory] ON 

INSERT [dbo].[CommissionHistory] ([CommissionID], [ResponseID], [CandidateID], [EmployerID], [VacancyID], [AnnualSalary], [CommissionPercent], [CommissionAmount], [PaymentStatus], [PaymentDate], [InvoiceNumber], [Notes], [CreatedDate], [UpdatedDate]) VALUES (1, 7, 15, 13, 7, CAST(78.00 AS Decimal(12, 2)), CAST(15.00 AS Decimal(5, 2)), CAST(11.70 AS Decimal(12, 2)), N'Оплачено', CAST(N'2026-04-30T18:17:45.690' AS DateTime), N'INV-000001-20260430', N'Автоматический расчёт при трудоустройстве. Среднемесячная ЗП: 7 ? ? 12 мес. = 78 ?. Комиссия 15,00%
[Оплачено 30.04.2026 18:17]', CAST(N'2026-04-29T19:39:34.967' AS DateTime), CAST(N'2026-04-30T18:17:45.690' AS DateTime))
INSERT [dbo].[CommissionHistory] ([CommissionID], [ResponseID], [CandidateID], [EmployerID], [VacancyID], [AnnualSalary], [CommissionPercent], [CommissionAmount], [PaymentStatus], [PaymentDate], [InvoiceNumber], [Notes], [CreatedDate], [UpdatedDate]) VALUES (2, 6, 15, 13, 6, CAST(60300000.00 AS Decimal(12, 2)), CAST(15.00 AS Decimal(5, 2)), CAST(9045000.00 AS Decimal(12, 2)), N'Оплачено', CAST(N'2026-04-30T18:17:28.600' AS DateTime), N'INV-000002-20260430', N'Автоматический расчёт при трудоустройстве. Среднемесячная ЗП: 5 025 000 ? ? 12 мес. = 60 300 000 ?. Комиссия 15,00%
[Оплачено 30.04.2026 18:17]', CAST(N'2026-04-29T19:39:59.290' AS DateTime), CAST(N'2026-04-30T18:17:33.360' AS DateTime))
INSERT [dbo].[CommissionHistory] ([CommissionID], [ResponseID], [CandidateID], [EmployerID], [VacancyID], [AnnualSalary], [CommissionPercent], [CommissionAmount], [PaymentStatus], [PaymentDate], [InvoiceNumber], [Notes], [CreatedDate], [UpdatedDate]) VALUES (3, 8, 15, 13, 8, CAST(660000.00 AS Decimal(12, 2)), CAST(15.00 AS Decimal(5, 2)), CAST(99000.00 AS Decimal(12, 2)), N'Оплачено', CAST(N'2026-04-30T18:17:20.680' AS DateTime), N'INV-000003-20260430', N'Автоматический расчёт при трудоустройстве. Среднемесячная ЗП: 55 000 ? ? 12 мес. = 660 000 ?. Комиссия 15,00%
[Оплачено 30.04.2026 18:17]', CAST(N'2026-04-29T22:08:33.243' AS DateTime), CAST(N'2026-04-30T18:17:20.793' AS DateTime))
SET IDENTITY_INSERT [dbo].[CommissionHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[CommissionSettings] ON 

INSERT [dbo].[CommissionSettings] ([SettingID], [SettingName], [CommissionPercent], [MinCommission], [MaxCommission], [IsActive]) VALUES (1, N'StandardCommission', CAST(15.00 AS Decimal(5, 2)), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[CommissionSettings] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployerResponses] ON 

INSERT [dbo].[EmployerResponses] ([EmployerResponseID], [EmployerID], [CandidateID], [VacancyID], [ResumeID], [Message], [Status], [ResponseDate], [InterviewDate]) VALUES (3, 7, 4, 1, 3, N'Алексей, спасибо за интерес. Однако мы ищем разработчика с актуальным техническим бэкграундом, без длительного перерыва в кодинге.', N'Отклонено', CAST(N'2026-03-10T08:59:15.880' AS DateTime), NULL)
INSERT [dbo].[EmployerResponses] ([EmployerResponseID], [EmployerID], [CandidateID], [VacancyID], [ResumeID], [Message], [Status], [ResponseDate], [InterviewDate]) VALUES (6, 7, 2, 3, 1, N'Иван, ищем Tech Lead для команды из 5 разработчиков. Ваш опыт и технический бэкграунд отлично подходят. Готовы обсудить?', N'Рассматривается', CAST(N'2026-03-10T08:59:15.900' AS DateTime), NULL)
INSERT [dbo].[EmployerResponses] ([EmployerResponseID], [EmployerID], [CandidateID], [VacancyID], [ResumeID], [Message], [Status], [ResponseDate], [InterviewDate]) VALUES (7, 13, 15, 6, 8, N'привет медвед ты кроусафчик пойдём к нам работать', N'Приглашен на собеседование', CAST(N'2026-03-16T08:12:13.677' AS DateTime), CAST(N'2026-03-13T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[EmployerResponses] OFF
GO
INSERT [dbo].[Employers] ([EmployerID], [CompanyName], [INN], [ContactPerson], [Industry], [CompanyDescription], [CreatedDate], [UpdatedDate]) VALUES (5, N'TechCorp Inc.', N'7701234567', N'Смирнов Дмитрий Владимирович', N'Информационные технологии', N'Крупная IT-компания, разработка ПО', CAST(N'2026-03-10T08:44:17.590' AS DateTime), CAST(N'2026-03-10T08:44:17.590' AS DateTime))
INSERT [dbo].[Employers] ([EmployerID], [CompanyName], [INN], [ContactPerson], [Industry], [CompanyDescription], [CreatedDate], [UpdatedDate]) VALUES (6, N'Creative Studio', N'7809876543', N'Козлова Анна Михайловна', N'Дизайн и креатив', N'Студия веб-дизайна и брендинга', CAST(N'2026-03-10T08:44:17.590' AS DateTime), CAST(N'2026-03-10T08:44:17.590' AS DateTime))
INSERT [dbo].[Employers] ([EmployerID], [CompanyName], [INN], [ContactPerson], [Industry], [CompanyDescription], [CreatedDate], [UpdatedDate]) VALUES (7, N'IT Solutions', N'7705557777', N'Морозов Павел Сергеевич', N'Информационные технологии', N'Аутсорсинг IT-услуг', CAST(N'2026-03-10T08:44:17.590' AS DateTime), CAST(N'2026-03-10T08:44:17.590' AS DateTime))
INSERT [dbo].[Employers] ([EmployerID], [CompanyName], [INN], [ContactPerson], [Industry], [CompanyDescription], [CreatedDate], [UpdatedDate]) VALUES (13, N'ООО Ромашка', N'1231231231', N'Силёткин Киил Сегеевич', N'IT', NULL, CAST(N'2026-03-11T08:26:25.570' AS DateTime), CAST(N'2026-03-11T08:26:25.570' AS DateTime))
INSERT [dbo].[Employers] ([EmployerID], [CompanyName], [INN], [ContactPerson], [Industry], [CompanyDescription], [CreatedDate], [UpdatedDate]) VALUES (14, N'АОА Пендосцы', N'234234234442', N'Мфртьянов Дмитрий Иванович', N'Химия', NULL, CAST(N'2026-03-11T11:53:14.927' AS DateTime), CAST(N'2026-03-11T11:53:14.927' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Resumes] ON 

INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [FilePath], [FileName], [FileSize], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) VALUES (1, 2, N'Senior .NET Developer', N'Опыт разработки на C# более 5 лет...', NULL, NULL, NULL, N'C#, .NET, ASP.NET Core, SQL, Entity Framework, Docker', CAST(150000.00 AS Decimal(10, 2)), N'Полная занятость', N'Полный день', 1, 1, N'Активно', CAST(N'2026-03-10T08:44:17.570' AS DateTime), CAST(N'2026-03-10T08:44:17.570' AS DateTime))
INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [FilePath], [FileName], [FileSize], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) VALUES (2, 3, N'UX/UI Designer', N'Дизайн мобильных и веб-приложений...', NULL, NULL, NULL, N'Figma, Adobe XD, Photoshop, Sketch, Prototyping', CAST(100000.00 AS Decimal(10, 2)), N'Полная занятость', N'Удаленная работа', 1, 1, N'Активно', CAST(N'2026-03-10T08:44:17.570' AS DateTime), CAST(N'2026-03-10T08:44:17.570' AS DateTime))
INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [FilePath], [FileName], [FileSize], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) VALUES (3, 4, N'Project Manager IT', N'Управление IT-проектами, Agile/Scrum...', NULL, NULL, NULL, N'Agile, Scrum, Jira, Confluence, Team Management', CAST(180000.00 AS Decimal(10, 2)), N'Полная занятость', N'Полный день', 1, 1, N'Активно', CAST(N'2026-03-10T08:44:17.570' AS DateTime), CAST(N'2026-03-10T08:44:17.570' AS DateTime))
INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [FilePath], [FileName], [FileSize], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) VALUES (4, 10, N'Data Scientist / ML Engineer', N'Машинное обучение, анализ данных, Python, TensorFlow...', NULL, NULL, NULL, N'Python, R, SQL, Machine Learning, Deep Learning, Data Analysis', CAST(200000.00 AS Decimal(10, 2)), N'Полная занятость', N'Гибкий график', 1, 1, N'Активно', CAST(N'2026-03-10T08:59:16.140' AS DateTime), CAST(N'2026-03-10T08:59:16.140' AS DateTime))
INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [FilePath], [FileName], [FileSize], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) VALUES (5, 2, N'Архивное резюме Иванова', N'Старая версия резюме...', NULL, NULL, NULL, N'C#, SQL', CAST(100000.00 AS Decimal(10, 2)), N'Частичная занятость', N'Удаленно', 0, 0, N'Архив', CAST(N'2026-03-10T08:59:20.407' AS DateTime), CAST(N'2026-03-10T08:59:20.407' AS DateTime))
INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [FilePath], [FileName], [FileSize], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) VALUES (6, 15, N'Создатель сайтов', N'', NULL, NULL, NULL, N'С', CAST(100000.00 AS Decimal(10, 2)), N'Полная занятость', N'Полный день', 1, 0, N'Активно', CAST(N'2026-03-12T13:43:10.403' AS DateTime), CAST(N'2026-03-12T13:43:10.410' AS DateTime))
INSERT [dbo].[Resumes] ([ResumeID], [CandidateID], [Title], [ResumeText], [FilePath], [FileName], [FileSize], [Skills], [SalaryExpectation], [EmploymentType], [WorkSchedule], [IsVisible], [IsPrimary], [Status], [CreatedDate], [UpdatedDate]) VALUES (8, 15, N'для проверки', N'', NULL, NULL, NULL, N'С', CAST(100000.00 AS Decimal(10, 2)), N'Полная занятость', N'Полный день', 1, 1, N'Активно', CAST(N'2026-03-16T08:10:20.437' AS DateTime), CAST(N'2026-03-16T08:10:20.437' AS DateTime))
SET IDENTITY_INSERT [dbo].[Resumes] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (1, N'Admin', N'Администратор системы')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (2, N'Candidate', N'Соискатель работы')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (3, N'Employer', N'Работодатель')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (1, 1, N'admin@buro.ru', N'+7(999)000-00-00', N'admin123', CAST(N'2026-03-10T08:44:17.267' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (2, 2, N'ivanov@mail.ru', N'+7(916)111-11-11', N'password123', CAST(N'2026-03-10T08:44:17.563' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (3, 2, N'petrova@mail.ru', N'+7(917)222-22-22', N'password123', CAST(N'2026-03-10T08:44:17.563' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (4, 2, N'sidorov@mail.ru', N'+7(918)333-33-33', N'password123', CAST(N'2026-03-10T08:44:17.563' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (5, 3, N'techcorp@company.ru', N'+7(495)100-10-10', N'company123', CAST(N'2026-03-10T08:44:17.590' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (6, 3, N'creative@studio.ru', N'+7(812)200-20-20', N'company123', CAST(N'2026-03-10T08:44:17.590' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (7, 3, N'it-solutions@company.ru', N'+7(495)300-30-30', N'company123', CAST(N'2026-03-10T08:44:17.590' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (8, 1, N'moderator@buro.ru', N'+7(999)111-11-11', N'admin123', CAST(N'2026-03-10T08:59:15.697' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (9, 1, N'support@buro.ru', N'+7(999)222-22-22', N'admin123', CAST(N'2026-03-10T08:59:15.697' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (10, 2, N'novikov@mail.ru', N'+7(919)444-44-44', N'password123', CAST(N'2026-03-10T08:59:15.920' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (11, 2, N'fired@mail.ru', N'+7(000)000-00-00', N'password123', CAST(N'2026-03-10T08:59:20.343' AS DateTime), 0)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (12, 2, N'n121f@mail.com', N'89222222222', N'123456', CAST(N'2026-03-10T11:52:24.297' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (13, 3, N'rab@gmail.com', N'8911111111111', N'111111', CAST(N'2026-03-11T08:26:25.570' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (14, 3, N'писка@gmail.com', N'45646464646456456456', N'12345678', CAST(N'2026-03-11T11:53:14.887' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [RoleID], [Email], [Phone], [PasswordHash], [RegistrationDate], [IsActive]) VALUES (15, 2, N'sos@gmail.com', N'89545567676', N'111111', CAST(N'2026-03-12T13:11:54.780' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Vacancies] ON 

INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (1, 5, N'Разработчик C# / .NET', N'Разработка корпоративных приложений на .NET Core', N'Опыт работы от 3 лет, C#, ASP.NET Core, SQL', CAST(120000.00 AS Decimal(10, 2)), CAST(180000.00 AS Decimal(10, 2)), N'Полная занятость', 3, N'Москва', 1, CAST(N'2026-03-10T08:44:17.590' AS DateTime), CAST(N'2026-03-10T08:44:17.590' AS DateTime))
INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (2, 6, N'UX/UI Дизайнер', N'Создание дизайна мобильных приложений', N'Портфолио, Figma, Adobe Creative Suite', CAST(90000.00 AS Decimal(10, 2)), CAST(130000.00 AS Decimal(10, 2)), N'Полная занятость', 2, N'Санкт-Петербург', 1, CAST(N'2026-03-10T08:44:17.590' AS DateTime), CAST(N'2026-03-10T08:44:17.590' AS DateTime))
INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (3, 7, N'Project Manager', N'Управление проектами разработки ПО', N'Опыт в IT от 5 лет, знание Agile', CAST(150000.00 AS Decimal(10, 2)), CAST(200000.00 AS Decimal(10, 2)), N'Полная занятость', 5, N'Москва', 1, CAST(N'2026-03-10T08:44:17.590' AS DateTime), CAST(N'2026-03-10T08:44:17.590' AS DateTime))
INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (4, 5, N'Data Scientist', N'Разработка ML-моделей для анализа бизнес-метрик', N'Python, SQL, ML опыт от 2 лет, статистика', CAST(180000.00 AS Decimal(10, 2)), CAST(250000.00 AS Decimal(10, 2)), N'Полная занятость', 2, N'Москва', 1, CAST(N'2026-03-10T08:59:20.310' AS DateTime), CAST(N'2026-03-10T08:59:20.310' AS DateTime))
INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (5, 6, N'Junior Designer', N'Помощник дизайнера', N'Figma базовый', CAST(40000.00 AS Decimal(10, 2)), CAST(60000.00 AS Decimal(10, 2)), N'Стажировка', 0, N'Санкт-Петербург', 0, CAST(N'2026-03-10T08:59:20.440' AS DateTime), CAST(N'2026-03-10T08:59:20.440' AS DateTime))
INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (6, 13, N'Разработчик сайтов', N'авава', N'выв', CAST(50000.00 AS Decimal(10, 2)), CAST(10000000.00 AS Decimal(10, 2)), N'Частичная занятость', 7, N'Лукоянов', 1, CAST(N'2026-03-11T08:59:59.920' AS DateTime), CAST(N'2026-03-11T09:15:46.667' AS DateTime))
INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (7, 13, N'rr', N'fff', N'fff', CAST(1.00 AS Decimal(10, 2)), CAST(12.00 AS Decimal(10, 2)), N'Полная занятость', 4, N'rrr', 1, CAST(N'2026-03-16T12:17:24.247' AS DateTime), CAST(N'2026-03-16T12:17:24.247' AS DateTime))
INSERT [dbo].[Vacancies] ([VacancyID], [EmployerID], [Position], [Description], [Requirements], [SalaryFrom], [SalaryTo], [EmploymentType], [ExperienceRequired], [City], [IsActive], [CreatedDate], [UpdatedDate]) VALUES (8, 13, N'd', N'ааа', N'ааа', CAST(10000.00 AS Decimal(10, 2)), CAST(100000.00 AS Decimal(10, 2)), N'Полная занятость', 3, N'моа', 1, CAST(N'2026-04-29T22:07:15.777' AS DateTime), CAST(N'2026-04-29T22:07:15.787' AS DateTime))
SET IDENTITY_INSERT [dbo].[Vacancies] OFF
GO
/****** Object:  Index [UQ__Candidat__3916FC98CB22AA0C]    Script Date: 05.05.2026 22:46:25 ******/
ALTER TABLE [dbo].[CandidateResponses] ADD UNIQUE NONCLUSTERED 
(
	[CandidateID] ASC,
	[VacancyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CommissionHistory_EmployerID]    Script Date: 05.05.2026 22:46:25 ******/
CREATE NONCLUSTERED INDEX [IX_CommissionHistory_EmployerID] ON [dbo].[CommissionHistory]
(
	[EmployerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CommissionHistory_PaymentStatus]    Script Date: 05.05.2026 22:46:25 ******/
CREATE NONCLUSTERED INDEX [IX_CommissionHistory_PaymentStatus] ON [dbo].[CommissionHistory]
(
	[PaymentStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Employer__C490CCF5C8844BA3]    Script Date: 05.05.2026 22:46:25 ******/
ALTER TABLE [dbo].[Employers] ADD UNIQUE NONCLUSTERED 
(
	[INN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B616067ACD442]    Script Date: 05.05.2026 22:46:25 ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D105349640B9C5]    Script Date: 05.05.2026 22:46:25 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CandidateResponses] ADD  DEFAULT ('Новый') FOR [Status]
GO
ALTER TABLE [dbo].[CandidateResponses] ADD  DEFAULT (getdate()) FOR [ResponseDate]
GO
ALTER TABLE [dbo].[Candidates] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Candidates] ADD  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[CommissionHistory] ADD  DEFAULT ('Ожидает оплаты') FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[CommissionHistory] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CommissionSettings] ADD  DEFAULT ((15.00)) FOR [CommissionPercent]
GO
ALTER TABLE [dbo].[CommissionSettings] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[EmployerResponses] ADD  DEFAULT ('Отправлено') FOR [Status]
GO
ALTER TABLE [dbo].[EmployerResponses] ADD  DEFAULT (getdate()) FOR [ResponseDate]
GO
ALTER TABLE [dbo].[Employers] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Employers] ADD  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[Resumes] ADD  DEFAULT ((1)) FOR [IsVisible]
GO
ALTER TABLE [dbo].[Resumes] ADD  DEFAULT ((0)) FOR [IsPrimary]
GO
ALTER TABLE [dbo].[Resumes] ADD  DEFAULT ('Активно') FOR [Status]
GO
ALTER TABLE [dbo].[Resumes] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Resumes] ADD  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Vacancies] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Vacancies] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Vacancies] ADD  DEFAULT (getdate()) FOR [UpdatedDate]
GO
ALTER TABLE [dbo].[Admins]  WITH CHECK ADD FOREIGN KEY([AdminID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CandidateResponses]  WITH CHECK ADD FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[CandidateResponses]  WITH CHECK ADD FOREIGN KEY([ResumeID])
REFERENCES [dbo].[Resumes] ([ResumeID])
GO
ALTER TABLE [dbo].[CandidateResponses]  WITH CHECK ADD FOREIGN KEY([VacancyID])
REFERENCES [dbo].[Vacancies] ([VacancyID])
GO
ALTER TABLE [dbo].[Candidates]  WITH CHECK ADD FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CommissionHistory]  WITH CHECK ADD FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[CommissionHistory]  WITH CHECK ADD FOREIGN KEY([EmployerID])
REFERENCES [dbo].[Employers] ([EmployerID])
GO
ALTER TABLE [dbo].[CommissionHistory]  WITH CHECK ADD FOREIGN KEY([ResponseID])
REFERENCES [dbo].[CandidateResponses] ([ResponseID])
GO
ALTER TABLE [dbo].[CommissionHistory]  WITH CHECK ADD FOREIGN KEY([VacancyID])
REFERENCES [dbo].[Vacancies] ([VacancyID])
GO
ALTER TABLE [dbo].[EmployerResponses]  WITH CHECK ADD FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[EmployerResponses]  WITH CHECK ADD FOREIGN KEY([EmployerID])
REFERENCES [dbo].[Employers] ([EmployerID])
GO
ALTER TABLE [dbo].[EmployerResponses]  WITH CHECK ADD FOREIGN KEY([ResumeID])
REFERENCES [dbo].[Resumes] ([ResumeID])
GO
ALTER TABLE [dbo].[EmployerResponses]  WITH CHECK ADD FOREIGN KEY([VacancyID])
REFERENCES [dbo].[Vacancies] ([VacancyID])
GO
ALTER TABLE [dbo].[Employers]  WITH CHECK ADD FOREIGN KEY([EmployerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Resumes]  WITH CHECK ADD FOREIGN KEY([CandidateID])
REFERENCES [dbo].[Candidates] ([CandidateID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Vacancies]  WITH CHECK ADD FOREIGN KEY([EmployerID])
REFERENCES [dbo].[Employers] ([EmployerID])
GO