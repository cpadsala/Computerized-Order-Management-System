USE [master]
GO
/****** Object:  Database [TargetEntrprise]    Script Date: 6/28/2017 3:45:40 PM ******/
CREATE DATABASE [TargetEntrprise]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TargetEntrprise', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TargetEntrprise.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TargetEntrprise_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\TargetEntrprise_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TargetEntrprise] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TargetEntrprise].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TargetEntrprise] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TargetEntrprise] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TargetEntrprise] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TargetEntrprise] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TargetEntrprise] SET ARITHABORT OFF 
GO
ALTER DATABASE [TargetEntrprise] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TargetEntrprise] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TargetEntrprise] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TargetEntrprise] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TargetEntrprise] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TargetEntrprise] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TargetEntrprise] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TargetEntrprise] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TargetEntrprise] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TargetEntrprise] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TargetEntrprise] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TargetEntrprise] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TargetEntrprise] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TargetEntrprise] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TargetEntrprise] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TargetEntrprise] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TargetEntrprise] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TargetEntrprise] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TargetEntrprise] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TargetEntrprise] SET  MULTI_USER 
GO
ALTER DATABASE [TargetEntrprise] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TargetEntrprise] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TargetEntrprise] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TargetEntrprise] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [TargetEntrprise]
GO
/****** Object:  StoredProcedure [dbo].[spx_FindShipmentDetail_ByDate]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spx_FindShipmentDetail_ByDate]
@FromDate as datetime,  --input parameter from shipment page of web app
@ToDate as datetime		--input parameter from shipment page of web app
as
begin

Select S.Shipment_ID as 'Shipment No.', S.Shipment_Date as 'Shipment Received on', 
SD.Item_ID as 'Item Code Received', SD.Quantity_Count from Shipment S
join Shipment_Details SD on S.Shipment_ID = SD.Shipment_ID 
where S.Shipment_Date between @FromDate and @ToDate

end;
GO
/****** Object:  StoredProcedure [dbo].[spx_GetCreditCardDailyInfo]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spx_GetCreditCardDailyInfo]
as
begin

Select O.Order_ID, (C.First_Name+' ' +C.Last_Name) as 'Customer Name', 
PM.Payment_Mode, CI.CreditCard_Number, CI.Expiry_Date, CI.Name_on_Card, CI.CVV_Number 
from Orders O
full join Customers C on O.Customer_ID = C.Customer_ID
 join Payment_Mode PM on PM.Payment_Mode_ID = O.Payment_Mode_ID
full join CerditCard_Info CI on O.Payment_Mode_ID  = CI.Payment_Mode_ID
where PM.Payment_Mode = 'Credit Card' and CI.Payment_Date = getdate()

end

GO
/****** Object:  StoredProcedure [dbo].[spx_PostalOrder_and_CheckDailyInfo]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spx_PostalOrder_and_CheckDailyInfo]
as
begin

Select O.Order_ID, (C.First_Name+' ' +C.Last_Name) as 'Customer Name', PM.Payment_Mode, 
OP.PostalOrder_Detail, OP.Cheque_Number 
from Orders O
full join Customers C on O.Customer_ID = C.Customer_ID
 join Payment_Mode PM on PM.Payment_Mode_ID = O.Payment_Mode_ID
full join OtherPayment_Info OP on OP.Payment_Mode_ID = O.Payment_Mode_ID
where PM.Payment_Mode_ID in (2,3) -- or PM.Payment_Mode in ('Postal Order','Check')
and OP.Payment_Date = getdate()

end
GO
/****** Object:  StoredProcedure [dbo].[spx_UpdateCustomer_Order]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spx_UpdateCustomer_Order]
@OrderID as int,
@ItemID as int,
@CustomerID as int,
@ItemCount as int
as
begin 

update Order_Details  set Quantity_Ordered = @ItemCount where Order_ID = @OrderID and Item_ID = @ItemID and Item_ID in (select Item_ID from Customers where Customer_ID = @CustomerID );

end;
GO
/****** Object:  StoredProcedure [dbo].[spx_UpdateOrderStauts]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_UpdateOrderStauts]
as
begin

declare @OrderCount int;
set @OrderCount = (Select count(*) from Orders) 

declare @i int;
set @i = 0;

while @i < @OrderCount +1
begin

declare @quntityordered int;
set @quntityordered = (select Total_Quantity_Ordered from Orders where Order_ID = @i)

declare @quntityshipped int;
set @quntityshipped = (select ISNULL ((Select Total_Quantity_Shipped 
from Shipping S where S.Order_ID = @i), 0));

if @quntityordered = @quntityshipped
update Orders set Status_ID = 4 where Order_ID = @i;
else 
update Orders set Status_ID = 3 where Order_ID = @i;
set @i = @i +1;
end;
end

GO
/****** Object:  Table [dbo].[Audit_Trail]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audit_Trail](
	[Audit_Trail_ID] [int] IDENTITY(1,1) NOT NULL,
	[Trail_DateTime] [datetime] NULL,
	[AuditTransaction_Reason] [nvarchar](50) NULL,
	[Trail_Description] [nvarchar](50) NULL,
	[Item_ID] [int] NULL,
 CONSTRAINT [PK_Audit_Trail] PRIMARY KEY CLUSTERED 
(
	[Audit_Trail_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Canceled_Order]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Canceled_Order](
	[Canceled_ID] [int] IDENTITY(1,1) NOT NULL,
	[Order_ID] [int] NULL,
	[Canceled_Date] [datetime] NULL,
	[Canceled_Reason] [nvarchar](50) NULL,
 CONSTRAINT [PK_Canceled_Order] PRIMARY KEY CLUSTERED 
(
	[Canceled_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CerditCard_Info]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CerditCard_Info](
	[CreditCard_ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer_ID] [int] NULL,
	[Payment_Mode_ID] [int] NULL,
	[CreditCard_Number] [nvarchar](50) NULL,
	[Expiry_Date] [date] NOT NULL,
	[Name_on_Card] [nvarchar](50) NOT NULL,
	[CVV_Number] [int] NOT NULL,
	[Payment_Date] [datetime] NULL,
 CONSTRAINT [PK_CerditCard_Info] PRIMARY KEY CLUSTERED 
(
	[CreditCard_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Customer_ID] [int] IDENTITY(1,1) NOT NULL,
	[First_Name] [nvarchar](50) NULL,
	[Last_Name] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Shipping_Address] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](50) NULL,
	[Mobile_Number] [nvarchar](50) NULL,
	[Email_Address] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Delivery_Mode]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery_Mode](
	[Delivery_Mode_ID] [int] NOT NULL,
	[Delivery_Mode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Delivery_Mode] PRIMARY KEY CLUSTERED 
(
	[Delivery_Mode_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Item_ID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Color] [nvarchar](50) NULL,
	[Size] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
	[Price] [nvarchar](50) NULL,
	[Available_Count] [int] NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_Details]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Details](
	[Order_Details_ID] [int] IDENTITY(1,1) NOT NULL,
	[Order_ID] [int] NULL,
	[Item_ID] [int] NULL,
	[Item_Price] [nvarchar](50) NULL,
	[Quantity_Ordered] [int] NULL,
	[Priority] [nvarchar](50) NULL,
	[Personalization] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED 
(
	[Order_Details_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_Mode]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Mode](
	[Order_Mode_ID] [int] IDENTITY(1,1) NOT NULL,
	[Order_Mode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order_Mode] PRIMARY KEY CLUSTERED 
(
	[Order_Mode_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_Status]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Status](
	[Status_ID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_Order_Status] PRIMARY KEY CLUSTERED 
(
	[Status_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Order_ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer_ID] [int] NULL,
	[Order_Mode_ID] [int] NULL,
	[Payment_Mode_ID] [int] NULL,
	[Status_ID] [int] NULL,
	[Delivery_Mode_ID] [int] NULL,
	[Order_Date] [datetime] NULL,
	[isCanceled] [int] NULL,
	[Total_Quantity_Ordered] [int] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Order_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OtherPayment_Info]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherPayment_Info](
	[Payment_ID] [int] IDENTITY(1,1) NOT NULL,
	[Payment_Mode_ID] [int] NULL,
	[Customer_ID] [int] NULL,
	[Cheque_Number] [nvarchar](50) NULL,
	[PostalOrder_Detail] [nvarchar](50) NULL,
	[Payment_Date] [datetime] NULL,
 CONSTRAINT [PK_OtherPayment_Info] PRIMARY KEY CLUSTERED 
(
	[Payment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_Mode]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Mode](
	[Payment_Mode_ID] [int] IDENTITY(1,1) NOT NULL,
	[Payment_Mode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Payment_Mode] PRIMARY KEY CLUSTERED 
(
	[Payment_Mode_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Refund]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Refund](
	[Refund_ID] [int] IDENTITY(1,1) NOT NULL,
	[Canceled_ID] [int] NULL,
	[Order_ID] [int] NULL,
	[Refund_Amount] [nvarchar](50) NULL,
	[Refund_Description] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Refund_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Return_Details]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Return_Details](
	[Return_Details_ID] [int] IDENTITY(1,1) NOT NULL,
	[Return_ID] [int] NULL,
	[Item_ID] [int] NULL,
	[Return_Count] [int] NULL,
	[Return_Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_Return_Details] PRIMARY KEY CLUSTERED 
(
	[Return_Details_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Returned_Item]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Returned_Item](
	[Return_ID] [int] IDENTITY(1,1) NOT NULL,
	[Return_Date] [datetime] NULL,
	[Return_Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_Returned_Item] PRIMARY KEY CLUSTERED 
(
	[Return_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipment]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipment](
	[Shipment_ID] [int] IDENTITY(1,1) NOT NULL,
	[Shipment_Date] [datetime] NULL,
 CONSTRAINT [PK_Shipment] PRIMARY KEY CLUSTERED 
(
	[Shipment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipment_Details]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipment_Details](
	[Shipment_Detail_ID] [int] IDENTITY(1,1) NOT NULL,
	[Shipment_ID] [int] NULL,
	[Item_ID] [int] NULL,
	[Quantity_Count] [int] NULL,
 CONSTRAINT [PK_Shipment_Details] PRIMARY KEY CLUSTERED 
(
	[Shipment_Detail_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping](
	[Shipping_ID] [int] IDENTITY(1,1) NOT NULL,
	[Order_ID] [int] NULL,
	[Shipping_Date] [datetime] NULL,
	[Total_Quantity_Shipped] [int] NULL,
	[Shipping_Address] [nvarchar](50) NULL,
 CONSTRAINT [PK_Shipping] PRIMARY KEY CLUSTERED 
(
	[Shipping_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipping_Details]    Script Date: 6/28/2017 3:45:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping_Details](
	[Shipping_Detail_ID] [int] IDENTITY(1,1) NOT NULL,
	[Shipping_ID] [int] NULL,
	[Order_ID] [int] NULL,
	[Item_ID] [int] NULL,
	[Quantity_Ordered] [int] NULL,
	[Quantity_Shipped] [int] NULL,
 CONSTRAINT [PK_Shipping_Details] PRIMARY KEY CLUSTERED 
(
	[Shipping_Detail_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Audit_Trail] ON 

INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (1, CAST(0x0000A78900000000 AS DateTime), N'Delivered to customer', N'Delivered to Cust Id 7', 2)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (2, CAST(0x0000A78900000000 AS DateTime), N'Delivered to customer', N'Delivered to Cust Id 7', 3)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (3, CAST(0x0000A79B0113D008 AS DateTime), N'Inventory reload', N'Shipment received', 2)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (4, CAST(0x0000A79B0113D008 AS DateTime), N'Inventory reload', N'Shipment received', 3)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (5, CAST(0x0000A79B0113D008 AS DateTime), N'Inventory reload', N'Shipment received', 4)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (6, CAST(0x0000A79D01143286 AS DateTime), N'Inventory reload', N'Shipment received', 3)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (7, CAST(0x0000A79D01143286 AS DateTime), N'Inventory reload', N'Shipment received', 1)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (8, CAST(0x0000A79800000000 AS DateTime), N'Returned', N'Returned by cust id 7', 2)
INSERT [dbo].[Audit_Trail] ([Audit_Trail_ID], [Trail_DateTime], [AuditTransaction_Reason], [Trail_Description], [Item_ID]) VALUES (10, CAST(0x0000A79E00BD44BC AS DateTime), N'Inventory reload', N'Shipment received', 2)
SET IDENTITY_INSERT [dbo].[Audit_Trail] OFF
SET IDENTITY_INSERT [dbo].[Canceled_Order] ON 

INSERT [dbo].[Canceled_Order] ([Canceled_ID], [Order_ID], [Canceled_Date], [Canceled_Reason]) VALUES (1, 1, CAST(0x0000A78500000000 AS DateTime), N'Canceled by customer.')
SET IDENTITY_INSERT [dbo].[Canceled_Order] OFF
SET IDENTITY_INSERT [dbo].[CerditCard_Info] ON 

INSERT [dbo].[CerditCard_Info] ([CreditCard_ID], [Customer_ID], [Payment_Mode_ID], [CreditCard_Number], [Expiry_Date], [Name_on_Card], [CVV_Number], [Payment_Date]) VALUES (1, 7, 1, N'465546554554655', CAST(0xFE3F0B00 AS Date), N'Felicity Smoak', 125, CAST(0x0000A78600000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[CerditCard_Info] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Customer_ID], [First_Name], [Last_Name], [Address], [Shipping_Address], [ZipCode], [Mobile_Number], [Email_Address]) VALUES (3, N'John', N'Will', N'2408 Nutwood', N'2408 Nutwood', N'92831', N'6576576576', N'john@j.com')
INSERT [dbo].[Customers] ([Customer_ID], [First_Name], [Last_Name], [Address], [Shipping_Address], [ZipCode], [Mobile_Number], [Email_Address]) VALUES (4, N'Adam', N'Ros', N'2400 Nutwood', N'2400 Nutwood', N'92831', N'6576586596', N'adam@a.com')
INSERT [dbo].[Customers] ([Customer_ID], [First_Name], [Last_Name], [Address], [Shipping_Address], [ZipCode], [Mobile_Number], [Email_Address]) VALUES (5, N'Barry', N'Allen', N'24 Central City', N'24 Central City', N'92832', N'6576586555', N'berry@flash.com')
INSERT [dbo].[Customers] ([Customer_ID], [First_Name], [Last_Name], [Address], [Shipping_Address], [ZipCode], [Mobile_Number], [Email_Address]) VALUES (6, N'Oliver', N'Queen', N'10 Lian Yu', N'10 Lian Yu', N'98233', N'6576576569', N'oliver@arrow.com')
INSERT [dbo].[Customers] ([Customer_ID], [First_Name], [Last_Name], [Address], [Shipping_Address], [ZipCode], [Mobile_Number], [Email_Address]) VALUES (7, N'Felicity', N'Smoak', N'29 Starling City', N'29 Starling City', N'92852', N'6546586576', N'felicity@arrow.com')
INSERT [dbo].[Customers] ([Customer_ID], [First_Name], [Last_Name], [Address], [Shipping_Address], [ZipCode], [Mobile_Number], [Email_Address]) VALUES (8, N'Jim', N'Gordon', N'27 Gotham Mad City', N'27 Gotham Mad City', N'92854', N'6577586576', N'jim@gotham.com')
SET IDENTITY_INSERT [dbo].[Customers] OFF
INSERT [dbo].[Delivery_Mode] ([Delivery_Mode_ID], [Delivery_Mode]) VALUES (1, N'Basic')
INSERT [dbo].[Delivery_Mode] ([Delivery_Mode_ID], [Delivery_Mode]) VALUES (2, N'Express')
INSERT [dbo].[Delivery_Mode] ([Delivery_Mode_ID], [Delivery_Mode]) VALUES (3, N'Foreign')
INSERT [dbo].[Delivery_Mode] ([Delivery_Mode_ID], [Delivery_Mode]) VALUES (4, N'SATS')
INSERT [dbo].[Inventory] ([Item_ID], [Name], [Color], [Size], [Description], [Price], [Available_Count]) VALUES (1, N'Kitchen Cloth', N'Red', N'Large', N'A restaurant kitchen cloth', N'$5', 100)
INSERT [dbo].[Inventory] ([Item_ID], [Name], [Color], [Size], [Description], [Price], [Available_Count]) VALUES (2, N'Handkerchief', N'White', N'Small', N'A to go handkerchief', N'$3', 120)
INSERT [dbo].[Inventory] ([Item_ID], [Name], [Color], [Size], [Description], [Price], [Available_Count]) VALUES (3, N'Surface Cloth', N'Yellow', N'Extra large', N'A surface cloth dinning tables', N'$10', 110)
INSERT [dbo].[Inventory] ([Item_ID], [Name], [Color], [Size], [Description], [Price], [Available_Count]) VALUES (4, N'Cleaning Cloth', N'White', N'Medium', N'A kitchen cleaning cloth', N'$4', 125)
SET IDENTITY_INSERT [dbo].[Order_Details] ON 

INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (1, 2, 2, N'3', 5, N'high', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (2, 2, 3, N'10', 5, N'high', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (3, 1, 1, N'10', 10, N'low', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (4, 3, 4, N'4', 5, N'high', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (5, 4, 1, N'10', 15, N'low', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (6, 4, 2, N'3', 2, N'low', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (7, 5, 1, N'10', 25, N'low', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (8, 5, 3, N'10', 10, N'low', N'none')
INSERT [dbo].[Order_Details] ([Order_Details_ID], [Order_ID], [Item_ID], [Item_Price], [Quantity_Ordered], [Priority], [Personalization]) VALUES (9, 5, 2, N'3', 5, N'low', N'none')
SET IDENTITY_INSERT [dbo].[Order_Details] OFF
SET IDENTITY_INSERT [dbo].[Order_Mode] ON 

INSERT [dbo].[Order_Mode] ([Order_Mode_ID], [Order_Mode]) VALUES (1, N'Fax')
INSERT [dbo].[Order_Mode] ([Order_Mode_ID], [Order_Mode]) VALUES (2, N'Phone')
INSERT [dbo].[Order_Mode] ([Order_Mode_ID], [Order_Mode]) VALUES (3, N'Mail')
SET IDENTITY_INSERT [dbo].[Order_Mode] OFF
SET IDENTITY_INSERT [dbo].[Order_Status] ON 

INSERT [dbo].[Order_Status] ([Status_ID], [Status]) VALUES (1, N'New')
INSERT [dbo].[Order_Status] ([Status_ID], [Status]) VALUES (2, N'Pending')
INSERT [dbo].[Order_Status] ([Status_ID], [Status]) VALUES (3, N'Incomplete')
INSERT [dbo].[Order_Status] ([Status_ID], [Status]) VALUES (4, N'Completed')
SET IDENTITY_INSERT [dbo].[Order_Status] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Order_ID], [Customer_ID], [Order_Mode_ID], [Payment_Mode_ID], [Status_ID], [Delivery_Mode_ID], [Order_Date], [isCanceled], [Total_Quantity_Ordered]) VALUES (1, 5, 1, 2, 3, 1, CAST(0x0000A78300000000 AS DateTime), 1, 10)
INSERT [dbo].[Orders] ([Order_ID], [Customer_ID], [Order_Mode_ID], [Payment_Mode_ID], [Status_ID], [Delivery_Mode_ID], [Order_Date], [isCanceled], [Total_Quantity_Ordered]) VALUES (2, 7, 3, 1, 4, 2, CAST(0x0000A78500000000 AS DateTime), 0, 10)
INSERT [dbo].[Orders] ([Order_ID], [Customer_ID], [Order_Mode_ID], [Payment_Mode_ID], [Status_ID], [Delivery_Mode_ID], [Order_Date], [isCanceled], [Total_Quantity_Ordered]) VALUES (3, 6, 1, 3, 4, 3, CAST(0x0000A79300000000 AS DateTime), 0, 5)
INSERT [dbo].[Orders] ([Order_ID], [Customer_ID], [Order_Mode_ID], [Payment_Mode_ID], [Status_ID], [Delivery_Mode_ID], [Order_Date], [isCanceled], [Total_Quantity_Ordered]) VALUES (4, 3, 1, 2, 4, 1, CAST(0x0000A78E00000000 AS DateTime), 0, 17)
INSERT [dbo].[Orders] ([Order_ID], [Customer_ID], [Order_Mode_ID], [Payment_Mode_ID], [Status_ID], [Delivery_Mode_ID], [Order_Date], [isCanceled], [Total_Quantity_Ordered]) VALUES (5, 4, 2, 3, 4, 1, CAST(0x0000A79800000000 AS DateTime), 0, 40)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[OtherPayment_Info] ON 

INSERT [dbo].[OtherPayment_Info] ([Payment_ID], [Payment_Mode_ID], [Customer_ID], [Cheque_Number], [PostalOrder_Detail], [Payment_Date]) VALUES (1, 2, 6, N'212121', N'N/A', CAST(0x0000A79400000000 AS DateTime))
INSERT [dbo].[OtherPayment_Info] ([Payment_ID], [Payment_Mode_ID], [Customer_ID], [Cheque_Number], [PostalOrder_Detail], [Payment_Date]) VALUES (2, 3, 5, N'N/A', N'PN: 254654', CAST(0x0000A79400000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[OtherPayment_Info] OFF
SET IDENTITY_INSERT [dbo].[Payment_Mode] ON 

INSERT [dbo].[Payment_Mode] ([Payment_Mode_ID], [Payment_Mode]) VALUES (1, N'Credit Card')
INSERT [dbo].[Payment_Mode] ([Payment_Mode_ID], [Payment_Mode]) VALUES (2, N'Check')
INSERT [dbo].[Payment_Mode] ([Payment_Mode_ID], [Payment_Mode]) VALUES (3, N'Postal Order')
SET IDENTITY_INSERT [dbo].[Payment_Mode] OFF
SET IDENTITY_INSERT [dbo].[Refund] ON 

INSERT [dbo].[Refund] ([Refund_ID], [Canceled_ID], [Order_ID], [Refund_Amount], [Refund_Description]) VALUES (1, 1, 1, N'$50', N'Refunded the charged amount.')
SET IDENTITY_INSERT [dbo].[Refund] OFF
SET IDENTITY_INSERT [dbo].[Return_Details] ON 

INSERT [dbo].[Return_Details] ([Return_Details_ID], [Return_ID], [Item_ID], [Return_Count], [Return_Description]) VALUES (1, 1, 2, 5, N'Not as described')
SET IDENTITY_INSERT [dbo].[Return_Details] OFF
SET IDENTITY_INSERT [dbo].[Returned_Item] ON 

INSERT [dbo].[Returned_Item] ([Return_ID], [Return_Date], [Return_Description]) VALUES (1, CAST(0x0000A79800000000 AS DateTime), N'Not as described')
SET IDENTITY_INSERT [dbo].[Returned_Item] OFF
SET IDENTITY_INSERT [dbo].[Shipment] ON 

INSERT [dbo].[Shipment] ([Shipment_ID], [Shipment_Date]) VALUES (1, CAST(0x0000A79B0113D008 AS DateTime))
INSERT [dbo].[Shipment] ([Shipment_ID], [Shipment_Date]) VALUES (2, CAST(0x0000A79D01143286 AS DateTime))
SET IDENTITY_INSERT [dbo].[Shipment] OFF
SET IDENTITY_INSERT [dbo].[Shipment_Details] ON 

INSERT [dbo].[Shipment_Details] ([Shipment_Detail_ID], [Shipment_ID], [Item_ID], [Quantity_Count]) VALUES (1, 1, 2, 100)
INSERT [dbo].[Shipment_Details] ([Shipment_Detail_ID], [Shipment_ID], [Item_ID], [Quantity_Count]) VALUES (2, 1, 3, 120)
INSERT [dbo].[Shipment_Details] ([Shipment_Detail_ID], [Shipment_ID], [Item_ID], [Quantity_Count]) VALUES (3, 1, 4, 150)
INSERT [dbo].[Shipment_Details] ([Shipment_Detail_ID], [Shipment_ID], [Item_ID], [Quantity_Count]) VALUES (4, 2, 3, 100)
INSERT [dbo].[Shipment_Details] ([Shipment_Detail_ID], [Shipment_ID], [Item_ID], [Quantity_Count]) VALUES (5, 2, 1, 120)
SET IDENTITY_INSERT [dbo].[Shipment_Details] OFF
SET IDENTITY_INSERT [dbo].[Shipping] ON 

INSERT [dbo].[Shipping] ([Shipping_ID], [Order_ID], [Shipping_Date], [Total_Quantity_Shipped], [Shipping_Address]) VALUES (1, 2, CAST(0x0000A78900000000 AS DateTime), 10, N'29 Starling City 92852')
INSERT [dbo].[Shipping] ([Shipping_ID], [Order_ID], [Shipping_Date], [Total_Quantity_Shipped], [Shipping_Address]) VALUES (2, 3, CAST(0x0000A79D00000000 AS DateTime), 5, N'10 Lian Yu')
INSERT [dbo].[Shipping] ([Shipping_ID], [Order_ID], [Shipping_Date], [Total_Quantity_Shipped], [Shipping_Address]) VALUES (4, 4, CAST(0x0000A7A300000000 AS DateTime), 17, N'2408 Nutwood')
INSERT [dbo].[Shipping] ([Shipping_ID], [Order_ID], [Shipping_Date], [Total_Quantity_Shipped], [Shipping_Address]) VALUES (5, 5, CAST(0x0000A7A400000000 AS DateTime), 40, N'2400 Nutwood')
SET IDENTITY_INSERT [dbo].[Shipping] OFF
SET IDENTITY_INSERT [dbo].[Shipping_Details] ON 

INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (1, 1, 2, 2, 5, 5)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (2, 1, 2, 3, 5, 5)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (3, 2, 3, 4, 5, 5)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (4, 2, 3, 1, 10, 10)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (5, 4, 4, 1, 15, 15)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (6, 4, 4, 2, 2, 2)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (7, 5, 5, 1, 25, 25)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (8, 5, 5, 3, 10, 10)
INSERT [dbo].[Shipping_Details] ([Shipping_Detail_ID], [Shipping_ID], [Order_ID], [Item_ID], [Quantity_Ordered], [Quantity_Shipped]) VALUES (9, 5, 5, 2, 5, 5)
SET IDENTITY_INSERT [dbo].[Shipping_Details] OFF
ALTER TABLE [dbo].[Audit_Trail]  WITH CHECK ADD FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Inventory] ([Item_ID])
GO
ALTER TABLE [dbo].[Canceled_Order]  WITH CHECK ADD  CONSTRAINT [FK_Canceled_Order_Order] FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Orders] ([Order_ID])
GO
ALTER TABLE [dbo].[Canceled_Order] CHECK CONSTRAINT [FK_Canceled_Order_Order]
GO
ALTER TABLE [dbo].[CerditCard_Info]  WITH CHECK ADD  CONSTRAINT [FK_CerditCard_Info_Customer1] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customers] ([Customer_ID])
GO
ALTER TABLE [dbo].[CerditCard_Info] CHECK CONSTRAINT [FK_CerditCard_Info_Customer1]
GO
ALTER TABLE [dbo].[CerditCard_Info]  WITH CHECK ADD  CONSTRAINT [FK_CerditCard_Info_Payment_Mode] FOREIGN KEY([Payment_Mode_ID])
REFERENCES [dbo].[Payment_Mode] ([Payment_Mode_ID])
GO
ALTER TABLE [dbo].[CerditCard_Info] CHECK CONSTRAINT [FK_CerditCard_Info_Payment_Mode]
GO
ALTER TABLE [dbo].[Order_Details]  WITH CHECK ADD FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Inventory] ([Item_ID])
GO
ALTER TABLE [dbo].[Order_Details]  WITH CHECK ADD FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Orders] ([Order_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customers] ([Customer_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Delivery_Mode_ID])
REFERENCES [dbo].[Delivery_Mode] ([Delivery_Mode_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Order_Mode_ID])
REFERENCES [dbo].[Order_Mode] ([Order_Mode_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Payment_Mode_ID])
REFERENCES [dbo].[Payment_Mode] ([Payment_Mode_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Status_ID])
REFERENCES [dbo].[Order_Status] ([Status_ID])
GO
ALTER TABLE [dbo].[OtherPayment_Info]  WITH CHECK ADD FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customers] ([Customer_ID])
GO
ALTER TABLE [dbo].[OtherPayment_Info]  WITH CHECK ADD FOREIGN KEY([Payment_Mode_ID])
REFERENCES [dbo].[Payment_Mode] ([Payment_Mode_ID])
GO
ALTER TABLE [dbo].[Refund]  WITH CHECK ADD FOREIGN KEY([Canceled_ID])
REFERENCES [dbo].[Canceled_Order] ([Canceled_ID])
GO
ALTER TABLE [dbo].[Refund]  WITH CHECK ADD FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Orders] ([Order_ID])
GO
ALTER TABLE [dbo].[Return_Details]  WITH CHECK ADD FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Inventory] ([Item_ID])
GO
ALTER TABLE [dbo].[Return_Details]  WITH CHECK ADD FOREIGN KEY([Return_ID])
REFERENCES [dbo].[Returned_Item] ([Return_ID])
GO
ALTER TABLE [dbo].[Shipment_Details]  WITH CHECK ADD FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Inventory] ([Item_ID])
GO
ALTER TABLE [dbo].[Shipment_Details]  WITH CHECK ADD FOREIGN KEY([Shipment_ID])
REFERENCES [dbo].[Shipment] ([Shipment_ID])
GO
ALTER TABLE [dbo].[Shipping]  WITH CHECK ADD  CONSTRAINT [FK_Shipping_Order] FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Orders] ([Order_ID])
GO
ALTER TABLE [dbo].[Shipping] CHECK CONSTRAINT [FK_Shipping_Order]
GO
ALTER TABLE [dbo].[Shipping_Details]  WITH CHECK ADD FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Inventory] ([Item_ID])
GO
ALTER TABLE [dbo].[Shipping_Details]  WITH CHECK ADD FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Orders] ([Order_ID])
GO
ALTER TABLE [dbo].[Shipping_Details]  WITH CHECK ADD FOREIGN KEY([Shipping_ID])
REFERENCES [dbo].[Shipping] ([Shipping_ID])
GO
USE [master]
GO
ALTER DATABASE [TargetEntrprise] SET  READ_WRITE 
GO


/*****/
USE [TargetEntrprise]
GO

/****** Object:  Trigger [dbo].[TRIG_AuditTrail]    Script Date: 6/28/2017 3:51:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TRIG_AuditTrail]
ON [dbo].[Inventory]
AFTER INSERT
AS 
   
BEGIN
declare @ItemID int;
set @ItemID =  (select top 1 I.Item_ID from Inventory I 
join Shipment_Details SD on SD.Item_ID = I.Item_ID
join Shipment S on S.Shipment_ID = SD.Shipment_ID
order by S.Shipment_Date asc)

Insert into Audit_Trail values(getdate(),'Inventory reload', 'Shipment received', @ItemID);

END
GO




