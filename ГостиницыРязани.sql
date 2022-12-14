USE [master]
GO
/****** Object:  Database [ГостиницыРязани]    Script Date: 03.11.2022 13:52:33 ******/
CREATE DATABASE [ГостиницыРязани]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ГстиницыРязани', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ГстиницыРязани.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ГстиницыРязани_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ГстиницыРязани_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ГостиницыРязани] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ГостиницыРязани].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ГостиницыРязани] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET ARITHABORT OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ГостиницыРязани] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ГостиницыРязани] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ГостиницыРязани] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ГостиницыРязани] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ГостиницыРязани] SET  MULTI_USER 
GO
ALTER DATABASE [ГостиницыРязани] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ГостиницыРязани] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ГостиницыРязани] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ГостиницыРязани] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ГостиницыРязани] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ГостиницыРязани] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ГостиницыРязани] SET QUERY_STORE = OFF
GO
USE [ГостиницыРязани]
GO
/****** Object:  UserDefinedFunction [dbo].[ЗаселениеКлиентов]    Script Date: 03.11.2022 13:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ЗаселениеКлиентов]
(
	-- Add the parameters for the function here
	@IdClient nvarchar(255),
	@startDate datetime,
	@endDate datetime
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @result bit
	
	-- Add the T-SQL statements to compute the return value here
	   if exists(select * from Проживание Inner Join Клиенты On Проживание.КодКлиента = Клиенты.КодКлиента where ФИО=@IdClient and ((@endDate>ДатаЗаезда and @endDate<ДатаВыезда) or (@startDate>ДатаЗаезда and @startDate<ДатаВыезда) or ((@startDate<ДатаЗаезда and @startDate<ДатаВыезда) and (@endDate>ДатаЗаезда and @endDate>ДатаВыезда))))
	   begin
	      Set @result = 0
	   end
	   else 
	   begin
	      set @result=1
	   end

	-- Return the result of the function
	RETURN @result

END
GO
/****** Object:  Table [dbo].[Клиенты]    Script Date: 03.11.2022 13:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Клиенты](
	[КодКлиента] [int] NOT NULL,
	[ФИО] [nvarchar](255) NULL,
	[ДатаРождения] [datetime] NULL,
	[АдресПроживания] [nvarchar](255) NULL,
 CONSTRAINT [PK_Клиенты] PRIMARY KEY CLUSTERED 
(
	[КодКлиента] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Гостиницы]    Script Date: 03.11.2022 13:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Гостиницы](
	[Номер] [int] NOT NULL,
	[Название] [nvarchar](255) NOT NULL,
	[Директор] [nvarchar](255) NOT NULL,
	[Телефон] [nvarchar](255) NOT NULL,
	[Категория] [int] NOT NULL,
	[Адрес] [nvarchar](255) NOT NULL,
	[ЧислоМест] [int] NULL,
	[ЦенаНочь] [int] NULL,
 CONSTRAINT [PK_Гостиницы] PRIMARY KEY CLUSTERED 
(
	[Номер] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Проживание]    Script Date: 03.11.2022 13:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Проживание](
	[Код] [int] NOT NULL,
	[КодКлиента] [int] NOT NULL,
	[НомерГостиницы] [int] NULL,
	[НомерКомнаты] [int] NULL,
	[ДатаЗаезда] [date] NULL,
	[ДатаВыезда] [date] NULL,
	[Оплата] [int] NULL,
 CONSTRAINT [PK_Проживание] PRIMARY KEY CLUSTERED 
(
	[Код] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ПроживаниеКлиентов]    Script Date: 03.11.2022 13:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ПроживаниеКлиентов]
AS
SELECT        dbo.Проживание.Код, dbo.Клиенты.ФИО, dbo.Гостиницы.Название, dbo.Проживание.НомерКомнаты, dbo.Проживание.ДатаЗаезда, dbo.Проживание.ДатаВыезда, dbo.Проживание.Оплата
FROM            dbo.Гостиницы INNER JOIN
                         dbo.Проживание ON dbo.Гостиницы.Номер = dbo.Проживание.НомерГостиницы INNER JOIN
                         dbo.Клиенты ON dbo.Проживание.КодКлиента = dbo.Клиенты.КодКлиента AND dbo.Проживание.КодКлиента = dbo.Клиенты.КодКлиента
GO
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (1, N'Ока', N'Твардовский Г.П.', N'+7 (955) 723-31-97', 3, N'Куйбышевское шоссе, д. 25, стр.15', 50, 1541)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (2, N'Арагон', N'Иванов Ф. А.', N'+7 (991) 296-42-95', 3, N'улица Кудрявцева, 25', 30, 2554)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (3, N'АМАКС Конгресс-отель', N'Смирнова К. А.', N'+7 (989) 270-71-61', 4, N'Первомайский проспект, д.54', 448, 3500)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (4, N'Атлантик', N'Артамонов Т. М.', N'+7 (917) 405-28-82', 2, N'улица Ленина, д. 4 корпус 1, строение 1', NULL, 1972)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (5, N'Старый город', N'Зайцев М. С.', N'+7 (973) 123-99-58', 4, N'ул. Мюнстерская, 2', 50, 3390)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (6, N'Женева', N'Гаврилова А. Я.', N'+7 (911) 857-43-70', 3, N'ул. Маяковского, д. 109 к.2', 22, 2439)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (7, N'GREENFEEL', N'Мельников Н. Е.', N'+7 (918) 887-59-86', 3, N'улица Октябрьская, д.31, корп.2', 51, 1874)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (8, N'Ловеч', N'Новикова В. П.', N'+7 (976) 618-40-75', 3, N'Ploshad Dimitrova,4', NULL, 2443)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (9, N'Пик ', N'Беляев М. М.', N'+7 (920) 510-73-57', 2, N'ул. Есенина, д.64/32', NULL, 2128)
INSERT [dbo].[Гостиницы] ([Номер], [Название], [Директор], [Телефон], [Категория], [Адрес], [ЧислоМест], [ЦенаНочь]) VALUES (10, N'Бриз', N'Смирнов И. В.', N'+7 (938) 474-49-17', 3, N'Соколовская улица, 19/5', 14, 1358)
GO
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (1, N'Зайцев А. Л.', CAST(N'1964-02-21T00:00:00.000' AS DateTime), N'г. Ноябрьск, Совхозная ул., д. 10 кв.141')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (2, N'Анисимов А. Д.', CAST(N'1960-12-26T00:00:00.000' AS DateTime), N'г. Томск, 17 Сентября ул., д. 2 кв.72')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (3, N'Фетисов Т. П.', CAST(N'1993-04-20T00:00:00.000' AS DateTime), N'г. Каменск - Уральский, Центральный пер., д. 20 кв.213')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (4, N'Беляева К. В.', CAST(N'1967-07-29T00:00:00.000' AS DateTime), N'г. Череповец, Светлая ул., д. 24 кв.20')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (5, N'Гришин Д. Г.', CAST(N'1961-05-29T00:00:00.000' AS DateTime), N'г. Кострома, Дачная ул., д. 11 кв.16')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (6, N'Никитина Н. М.', CAST(N'1982-12-02T00:00:00.000' AS DateTime), N'г. Чебоксары, Колхозный пер., д. 17 кв.29')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (7, N'Еремеев Е. М.', CAST(N'1964-04-16T00:00:00.000' AS DateTime), N'г. Элиста, Лесная ул., д. 7 кв.54')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (8, N'Анохина А. Е.
', CAST(N'1981-10-09T00:00:00.000' AS DateTime), N'г. Орск, Белорусская ул., д. 4 кв.122')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (9, N'Харитонов М. Т.', CAST(N'1975-08-28T00:00:00.000' AS DateTime), N'г. Орск, Полевой пер., д. 13 кв.213')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (10, N'Мельникова М. А.', CAST(N'2000-05-16T00:00:00.000' AS DateTime), N'г. Миасс, Центральная ул., д. 3 кв.124')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (11, N'Волкова П. А.', CAST(N'1971-08-17T00:00:00.000' AS DateTime), N'г. Евпатория, Максима Горького ул., д. 3 кв.92')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (12, N'Соболев К. Д.', CAST(N'1985-08-17T00:00:00.000' AS DateTime), N'г. Камышин, Садовый пер., д. 20 кв.15')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (13, N'Смирнов М. В.', CAST(N'1986-12-07T00:00:00.000' AS DateTime), N'г. Ижевск, Тихая ул., д. 21 кв.71')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (14, N'Денисова Е. Т.', CAST(N'1997-08-22T00:00:00.000' AS DateTime), N'г. Майкоп, Юбилейная ул., д. 6 кв.89')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (15, N'Никифорова П. Ф.', CAST(N'1977-12-13T00:00:00.000' AS DateTime), N'г. Саранск, Радужная ул., д. 2 кв.173')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (16, N'ппппп', CAST(N'2022-09-27T00:00:00.000' AS DateTime), N'пппп')
INSERT [dbo].[Клиенты] ([КодКлиента], [ФИО], [ДатаРождения], [АдресПроживания]) VALUES (17, N'ko', CAST(N'2022-10-05T00:00:00.000' AS DateTime), N'mkm')
GO
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (1, 1, 6, 12, CAST(N'2022-03-23' AS Date), CAST(N'2022-09-20' AS Date), 441459)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (2, 2, 1, 4, CAST(N'2022-01-07' AS Date), CAST(N'2022-01-22' AS Date), 23115)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (3, 3, 9, 9, CAST(N'2022-07-16' AS Date), CAST(N'2022-08-15' AS Date), 63840)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (4, 4, 2, 1, CAST(N'2022-03-24' AS Date), CAST(N'2022-04-15' AS Date), 56188)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (5, 5, 5, 13, CAST(N'2022-08-02' AS Date), CAST(N'2022-09-16' AS Date), 152550)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (6, 6, 3, 7, CAST(N'2022-04-08' AS Date), CAST(N'2022-06-13' AS Date), 231000)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (7, 7, 10, 18, CAST(N'2022-05-12' AS Date), CAST(N'2022-08-05' AS Date), 115430)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (8, 8, 7, 3, CAST(N'2022-03-22' AS Date), CAST(N'2022-08-29' AS Date), 299840)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (9, 9, 3, 8, CAST(N'2022-01-23' AS Date), CAST(N'2022-03-29' AS Date), 227500)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (10, 10, 9, 12, CAST(N'2022-01-19' AS Date), CAST(N'2022-04-19' AS Date), 191520)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (11, 11, 8, 7, CAST(N'2022-06-09' AS Date), CAST(N'2022-08-18' AS Date), 171010)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (12, 12, 2, 6, CAST(N'2022-01-30' AS Date), CAST(N'2022-04-21' AS Date), 206874)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (13, 13, 2, 15, CAST(N'2022-01-30' AS Date), CAST(N'2022-03-30' AS Date), 150686)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (14, 14, 6, 2, CAST(N'2022-08-14' AS Date), CAST(N'2022-08-19' AS Date), 12195)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (15, 15, 4, 4, CAST(N'2022-09-13' AS Date), CAST(N'2022-09-16' AS Date), 5916)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (16, 16, 4, 45, CAST(N'2022-09-26' AS Date), CAST(N'2022-10-12' AS Date), 555555)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (18, 2, 2, 5, CAST(N'2022-11-01' AS Date), CAST(N'2022-11-03' AS Date), 555)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (19, 2, 4, 55, CAST(N'2022-11-01' AS Date), CAST(N'2022-11-03' AS Date), 5555)
INSERT [dbo].[Проживание] ([Код], [КодКлиента], [НомерГостиницы], [НомерКомнаты], [ДатаЗаезда], [ДатаВыезда], [Оплата]) VALUES (20, 6, 4, 45, CAST(N'2022-11-01' AS Date), CAST(N'2022-11-03' AS Date), 454545)
GO
ALTER TABLE [dbo].[Проживание]  WITH CHECK ADD  CONSTRAINT [FK_Проживание_Гостиницы] FOREIGN KEY([НомерГостиницы])
REFERENCES [dbo].[Гостиницы] ([Номер])
GO
ALTER TABLE [dbo].[Проживание] CHECK CONSTRAINT [FK_Проживание_Гостиницы]
GO
ALTER TABLE [dbo].[Проживание]  WITH CHECK ADD  CONSTRAINT [FK_Проживание_Клиенты1] FOREIGN KEY([КодКлиента])
REFERENCES [dbo].[Клиенты] ([КодКлиента])
GO
ALTER TABLE [dbo].[Проживание] CHECK CONSTRAINT [FK_Проживание_Клиенты1]
GO
/****** Object:  StoredProcedure [dbo].[ОплатаПроживания]    Script Date: 03.11.2022 13:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ОплатаПроживания] 
	-- Add the parameters for the stored procedure here
	@Гостиница nvarchar(255),
	@ДатаЗаезда date,
	@ДатаВыезда date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT        dbo.Гостиницы.Название,@ДатаЗаезда as ДатаЗаезда, @ДатаВыезда as ДатаВыезда,  dbo.Гостиницы.ЦенаНочь, dbo.Гостиницы.ЦенаНочь * DATEDIFF(day, @ДатаЗаезда, @ДатаВыезда) as Оплата
FROM            dbo.Гостиницы INNER JOIN
                         dbo.Проживание ON dbo.Гостиницы.Номер = dbo.Проживание.НомерГостиницы 
						 where @Гостиница=dbo.Гостиницы.Название
END
GO
/****** Object:  StoredProcedure [dbo].[ФункцияЗаселения]    Script Date: 03.11.2022 13:52:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ФункцияЗаселения]
	-- Add the parameters for the stored procedure here
	@client nvarchar(255), @sDate date, @eDate date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [dbo].[ЗаселениеКлиентов](@client, @sDate , @eDate)
	from Проживание
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[11] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Гостиницы"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Проживание"
            Begin Extent = 
               Top = 6
               Left = 481
               Bottom = 136
               Right = 669
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Клиенты"
            Begin Extent = 
               Top = 48
               Left = 798
               Bottom = 178
               Right = 991
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ПроживаниеКлиентов'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ПроживаниеКлиентов'
GO
USE [master]
GO
ALTER DATABASE [ГостиницыРязани] SET  READ_WRITE 
GO
