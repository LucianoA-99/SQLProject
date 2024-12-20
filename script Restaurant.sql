USE [master]
GO
/****** Object:  Database [Restaurant]    Script Date: 6/12/2024 21:18:02 ******/
CREATE DATABASE [Restaurant]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Restaurant', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Restaurant.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Restaurant_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Restaurant_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Restaurant] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Restaurant].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Restaurant] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Restaurant] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Restaurant] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Restaurant] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Restaurant] SET ARITHABORT OFF 
GO
ALTER DATABASE [Restaurant] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Restaurant] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Restaurant] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Restaurant] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Restaurant] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Restaurant] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Restaurant] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Restaurant] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Restaurant] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Restaurant] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Restaurant] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Restaurant] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Restaurant] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Restaurant] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Restaurant] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Restaurant] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Restaurant] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Restaurant] SET RECOVERY FULL 
GO
ALTER DATABASE [Restaurant] SET  MULTI_USER 
GO
ALTER DATABASE [Restaurant] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Restaurant] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Restaurant] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Restaurant] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Restaurant] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Restaurant] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Restaurant', N'ON'
GO
ALTER DATABASE [Restaurant] SET QUERY_STORE = ON
GO
ALTER DATABASE [Restaurant] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Restaurant]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Position] [nvarchar](50) NOT NULL,
	[Shift] [nvarchar](20) NULL,
	[HireDate] [date] NOT NULL,
	[Salary] [decimal](10, 2) NOT NULL,
	[Phone] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[StockQuantity] [int] NOT NULL,
	[UnitOfMeasurement] [nvarchar](20) NOT NULL,
	[LastUpdated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[InvoiceDate] [datetime] NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceProducts]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceProducts](
	[InvoiceProductID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](10, 2) NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitPrice]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[InvoiceProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[DishName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[TableID] [int] NOT NULL,
	[WaiterID] [int] NOT NULL,
	[OrderDate] [datetime] NULL,
	[OrderStatus] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[TableNumber] [int] NOT NULL,
	[Capacity] [int] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Waiters]    Script Date: 6/12/2024 21:18:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Waiters](
	[EmployeeID] [int] NOT NULL,
	[WaiterID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[AssignmentDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (1, N'Carlos Rodríguez', N'Waiter', N'Morning', CAST(N'2023-01-15' AS Date), CAST(1200.00 AS Decimal(10, 2)), N'0987654321')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (2, N'María Pérez', N'Waiter', N'Afternoon', CAST(N'2022-10-20' AS Date), CAST(1200.00 AS Decimal(10, 2)), N'0981122334')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (3, N'Luis Gómez', N'Chef', N'Morning', CAST(N'2021-05-12' AS Date), CAST(1500.00 AS Decimal(10, 2)), N'0999988776')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (4, N'Sofía Castro', N'Chef', N'Afternoon', CAST(N'2020-08-25' AS Date), CAST(1500.00 AS Decimal(10, 2)), N'0976543210')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (5, N'Ana Silva', N'Manager', N'Morning', CAST(N'2018-03-10' AS Date), CAST(2000.00 AS Decimal(10, 2)), N'0965432109')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (6, N'Pedro Martínez', N'Waiter', N'Morning', CAST(N'2022-06-01' AS Date), CAST(1200.00 AS Decimal(10, 2)), N'0987766554')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (7, N'Lucía Fernández', N'Waiter', N'Afternoon', CAST(N'2021-11-20' AS Date), CAST(1200.00 AS Decimal(10, 2)), N'0995566778')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (8, N'Juan Sánchez', N'Chef', N'Night', CAST(N'2019-01-30' AS Date), CAST(1500.00 AS Decimal(10, 2)), N'0981122444')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (9, N'Cecilia López', N'Chef', N'Morning', CAST(N'2020-07-05' AS Date), CAST(1500.00 AS Decimal(10, 2)), N'0965332211')
INSERT [dbo].[Employees] ([EmployeeID], [Name], [Position], [Shift], [HireDate], [Salary], [Phone]) VALUES (10, N'Esteban González', N'Manager', N'Night', CAST(N'2017-09-25' AS Date), CAST(2000.00 AS Decimal(10, 2)), N'0977654321')
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (1, N'Mozzarella Cheese', 20, N'kg', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (2, N'Tomato Sauce', 15, N'liters', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (3, N'Pizza Dough', 50, N'units', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (4, N'Coca Cola', 40, N'bottles', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (5, N'Sprite', 30, N'bottles', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (6, N'Fanta', 25, N'bottles', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (7, N'Flour', 10, N'kg', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (8, N'Eggs', 50, N'units', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (9, N'Dulce de Leche', 5, N'kg', CAST(N'2024-12-06T17:19:43.410' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (10, N'Chicken Breast', 30, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (11, N'Mozzarella Cheese', 15, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (12, N'Sweet Corn', 10, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (13, N'Olives', 20, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (14, N'Ham', 25, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (15, N'Tomato', 30, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (16, N'Lettuce', 15, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (17, N'Olive Oil', 5, N'liters', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (18, N'Dulce de Leche', 10, N'kg', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
INSERT [dbo].[Inventory] ([ProductID], [ProductName], [StockQuantity], [UnitOfMeasurement], [LastUpdated]) VALUES (19, N'Craft Beer', 50, N'bottles', CAST(N'2024-12-06T17:25:06.563' AS DateTime))
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (1, 1, CAST(N'2024-12-06T12:35:00.000' AS DateTime), N'Card', CAST(32.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (2, 2, CAST(N'2024-12-06T13:10:00.000' AS DateTime), N'Cash', CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (3, 3, CAST(N'2024-12-06T14:10:00.000' AS DateTime), N'Card', CAST(16.50 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (4, 1, CAST(N'2024-12-07T18:40:00.000' AS DateTime), N'Card', CAST(40.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (5, 2, CAST(N'2024-12-07T19:15:00.000' AS DateTime), N'Cash', CAST(24.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (6, 3, CAST(N'2024-12-07T19:45:00.000' AS DateTime), N'Card', CAST(32.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (7, 4, CAST(N'2024-12-07T20:10:00.000' AS DateTime), N'Card', CAST(36.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (8, 5, CAST(N'2024-12-07T20:50:00.000' AS DateTime), N'Cash', CAST(22.50 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (9, 6, CAST(N'2024-12-07T21:15:00.000' AS DateTime), N'Card', CAST(28.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (10, 7, CAST(N'2024-12-07T21:45:00.000' AS DateTime), N'Cash', CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (11, 8, CAST(N'2024-12-07T22:00:00.000' AS DateTime), N'Card', CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (12, 9, CAST(N'2024-12-07T22:30:00.000' AS DateTime), N'Cash', CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[Invoice] ([InvoiceID], [OrderID], [InvoiceDate], [PaymentMethod], [TotalAmount]) VALUES (13, 10, CAST(N'2024-12-07T23:15:00.000' AS DateTime), N'Card', CAST(30.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Invoice] OFF
GO
SET IDENTITY_INSERT [dbo].[InvoiceProducts] ON 

INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (1, 1, N'Pizza Mozzarella', 2, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (2, 1, N'Refresco Coca Cola', 2, CAST(3.50 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (3, 2, N'Pizza Napolitana', 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (4, 2, N'Flan con Dulce de Leche', 2, CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (5, 3, N'Pizza Calabresa', 1, CAST(16.50 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (6, 1, N'Pizza de Pollo', 2, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (7, 1, N'Cerveza Artesanal', 1, CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (8, 2, N'Pizza de Jamón y Queso', 2, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (9, 3, N'Pizza Vegetariana', 1, CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (10, 3, N'Jugo de Naranja', 2, CAST(4.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (11, 4, N'Milanesa a la Napolitana', 2, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (12, 4, N'Agua Mineral', 2, CAST(2.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (13, 5, N'Pizza de Atún', 1, CAST(16.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (14, 6, N'Flan con Dulce de Leche', 2, CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (15, 7, N'Pizza Mozzarella', 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (16, 8, N'Pizza de Pollo', 1, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (17, 9, N'Torta de Chocotorta', 1, CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (18, 9, N'Refresco Coca Cola', 2, CAST(3.50 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (19, 10, N'Chivito al Plato', 1, CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[InvoiceProducts] ([InvoiceProductID], [InvoiceID], [ProductName], [Quantity], [UnitPrice]) VALUES (20, 10, N'Refresco Sprite', 1, CAST(3.50 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[InvoiceProducts] OFF
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (1, N'Pizza Mozzarella', N'Classic pizza with mozzarella and tomato sauce', N'Pizza', CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (2, N'Pizza Napolitana', N'Pizza with mozzarella, tomato, garlic, and basil', N'Pizza', CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (3, N'Pizza Calabresa', N'Pizza with mozzarella and spicy sausage', N'Pizza', CAST(16.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (4, N'Chivito al Plato', N'Uruguayan beef sandwich served with fries', N'Main Course', CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (5, N'Refresco Coca Cola', N'500ml bottle of Coca Cola', N'Drink', CAST(3.50 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (6, N'Refresco Sprite', N'500ml bottle of Sprite', N'Drink', CAST(3.50 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (7, N'Refresco Fanta', N'500ml bottle of Fanta', N'Drink', CAST(3.50 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (8, N'Flan con Dulce de Leche', N'Traditional flan with dulce de leche topping', N'Dessert', CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (9, N'Torta Frita', N'Fried bread with sugar, a Uruguayan treat', N'Dessert', CAST(4.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (10, N'Pizza de Pollo', N'Pizza with chicken, mozzarella, and sweet corn', N'Pizza', CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (11, N'Pizza de Jamón y Queso', N'Classic pizza with ham and mozzarella cheese', N'Pizza', CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (12, N'Pizza Vegetariana', N'Pizza with vegetables like bell pepper, mushrooms, and olives', N'Pizza', CAST(14.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (13, N'Milanesa a la Napolitana', N'Breaded beef with cheese and tomato sauce, served with fries', N'Main Course', CAST(18.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (14, N'Agua Mineral', N'500ml bottle of sparkling water', N'Drink', CAST(2.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (15, N'Jugo de Naranja', N'Freshly squeezed orange juice', N'Drink', CAST(4.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (16, N'Torta de Chocotorta', N'Traditional Argentinian chocolate cake', N'Dessert', CAST(5.50 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (17, N'Dulce de Leche Pancakes', N'Pancakes with a filling of dulce de leche', N'Dessert', CAST(6.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (18, N'Cerveza Artesanal', N'Local craft beer', N'Drink', CAST(5.00 AS Decimal(10, 2)))
INSERT [dbo].[Menu] ([MenuID], [DishName], [Description], [Category], [Price]) VALUES (19, N'Pizza de Atún', N'Pizza with tuna, onions, and mozzarella', N'Pizza', CAST(16.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (1, 3, 1, CAST(N'2024-12-06T12:30:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (2, 4, 2, CAST(N'2024-12-06T13:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (3, 1, 1, CAST(N'2024-12-06T14:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (4, 6, 3, CAST(N'2024-12-07T18:30:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (5, 7, 4, CAST(N'2024-12-07T19:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (6, 8, 2, CAST(N'2024-12-07T19:30:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (7, 9, 1, CAST(N'2024-12-07T20:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (8, 10, 5, CAST(N'2024-12-07T20:30:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (9, 3, 2, CAST(N'2024-12-07T21:00:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (10, 1, 4, CAST(N'2024-12-07T21:30:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (11, 5, 1, CAST(N'2024-12-07T22:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (12, 2, 3, CAST(N'2024-12-07T22:30:00.000' AS DateTime), N'Completed')
INSERT [dbo].[OrderDetails] ([OrderID], [TableID], [WaiterID], [OrderDate], [OrderStatus]) VALUES (13, 4, 5, CAST(N'2024-12-07T23:00:00.000' AS DateTime), N'Pending')
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Tables] ON 

INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (1, 1, 4, N'Available')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (2, 2, 4, N'Available')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (3, 3, 6, N'Occupied')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (4, 4, 2, N'Reserved')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (5, 5, 6, N'Available')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (6, 6, 4, N'Available')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (7, 7, 2, N'Occupied')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (8, 8, 6, N'Reserved')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (9, 9, 4, N'Available')
INSERT [dbo].[Tables] ([TableID], [TableNumber], [Capacity], [Status]) VALUES (10, 10, 6, N'Occupied')
SET IDENTITY_INSERT [dbo].[Tables] OFF
GO
INSERT [dbo].[Waiters] ([EmployeeID], [WaiterID], [TableID], [AssignmentDate]) VALUES (1, 1, 3, CAST(N'2024-12-06T12:00:00.000' AS DateTime))
INSERT [dbo].[Waiters] ([EmployeeID], [WaiterID], [TableID], [AssignmentDate]) VALUES (2, 2, 1, CAST(N'2024-12-06T12:30:00.000' AS DateTime))
INSERT [dbo].[Waiters] ([EmployeeID], [WaiterID], [TableID], [AssignmentDate]) VALUES (3, 5, 4, CAST(N'2024-12-06T12:45:00.000' AS DateTime))
INSERT [dbo].[Waiters] ([EmployeeID], [WaiterID], [TableID], [AssignmentDate]) VALUES (6, 3, 5, CAST(N'2024-12-06T13:00:00.000' AS DateTime))
INSERT [dbo].[Waiters] ([EmployeeID], [WaiterID], [TableID], [AssignmentDate]) VALUES (7, 4, 9, CAST(N'2024-12-06T13:15:00.000' AS DateTime))
GO
/****** Object:  Index [UQ__Tables__E8E0DB522242FAF7]    Script Date: 6/12/2024 21:18:03 ******/
ALTER TABLE [dbo].[Tables] ADD UNIQUE NONCLUSTERED 
(
	[TableNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inventory] ADD  DEFAULT (getdate()) FOR [LastUpdated]
GO
ALTER TABLE [dbo].[Invoice] ADD  DEFAULT (getdate()) FOR [InvoiceDate]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Waiters] ADD  DEFAULT (getdate()) FOR [AssignmentDate]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[OrderDetails] ([OrderID])
GO
ALTER TABLE [dbo].[InvoiceProducts]  WITH CHECK ADD FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoice] ([InvoiceID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([WaiterID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Waiters]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Waiters]  WITH CHECK ADD FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
USE [master]
GO
ALTER DATABASE [Restaurant] SET  READ_WRITE 
GO
