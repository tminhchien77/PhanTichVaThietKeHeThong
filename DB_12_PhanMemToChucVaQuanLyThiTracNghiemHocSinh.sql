USE [master]
GO
/****** Object:  Database [KiemTraHS]    Script Date: 25/12/2021 10:05:49 SA ******/
CREATE DATABASE [KiemTraHS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KiemTraHS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KiemTraHS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KiemTraHS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\KiemTraHS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [KiemTraHS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KiemTraHS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KiemTraHS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KiemTraHS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KiemTraHS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KiemTraHS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KiemTraHS] SET ARITHABORT OFF 
GO
ALTER DATABASE [KiemTraHS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KiemTraHS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KiemTraHS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KiemTraHS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KiemTraHS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KiemTraHS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KiemTraHS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KiemTraHS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KiemTraHS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KiemTraHS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KiemTraHS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KiemTraHS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KiemTraHS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KiemTraHS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KiemTraHS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KiemTraHS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KiemTraHS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KiemTraHS] SET RECOVERY FULL 
GO
ALTER DATABASE [KiemTraHS] SET  MULTI_USER 
GO
ALTER DATABASE [KiemTraHS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KiemTraHS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KiemTraHS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KiemTraHS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KiemTraHS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [KiemTraHS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'KiemTraHS', N'ON'
GO
ALTER DATABASE [KiemTraHS] SET QUERY_STORE = OFF
GO
USE [KiemTraHS]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_isUsed]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_isUsed] (@idQues int)
RETURNS BIT
AS 
BEGIN
	DECLARE @count int =0;
	SELECT @count= COUNT(*) from KiemTraHS.dbo.CT_BAITHI cb WHERE cb.MaCauHoi =@idQues
	IF @count=0 RETURN 0
	RETURN 1
END
GO
/****** Object:  UserDefinedFunction [dbo].[GETSCORE]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GETSCORE](@MAHS CHAR(9), @MADANGKY INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @RES FLOAT
	SET @RES = (SELECT DIEM FROM DIEM WHERE MAHS = @MAHS AND MADANGKY = @MADANGKY)
	RETURN @RES
END
GO
/****** Object:  UserDefinedFunction [dbo].[shuffle]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[shuffle]()
returns char(4)
begin

	DECLARE @v_retval VARCHAR(4) = '';
	DECLARE @v_chars CHAR(4) = 'ABCD';
	DECLARE @u_pos INT;
	DECLARE @u INT;

	SET @u = 4;
	WHILE (@u > 0)
	BEGIN
		
		SET @u_pos = (SELECT FLOOR((SELECT MyRAND FROM Get_RAND) * @u + 1));
		
		SET @v_retval = CONCAT(@v_retval, SUBSTRING(@v_chars, @u_pos, 1));
		SET @v_chars = CONCAT(LEFT(@v_chars, @u_pos - 1), SUBSTRING(@v_chars, @u_pos+1, @u-1));
		SET @u = @u - 1;
	END;

	RETURN @v_retval;
    

END;
GO
/****** Object:  View [dbo].[Get_RAND]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Get_RAND]
AS
SELECT RAND() AS MyRAND
GO
/****** Object:  Table [dbo].[BAIHOC]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAIHOC](
	[MaBaiHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenBai] [nvarchar](100) NOT NULL,
	[MaMon] [int] NOT NULL,
	[MaHocKy] [int] NOT NULL,
 CONSTRAINT [PK_BAIHOC] PRIMARY KEY CLUSTERED 
(
	[MaBaiHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BAIHOCKT]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAIHOCKT](
	[MaDangKy] [int] NOT NULL,
	[MaBaiHoc] [int] NOT NULL,
 CONSTRAINT [PK_BAIHOCKT] PRIMARY KEY CLUSTERED 
(
	[MaDangKy] ASC,
	[MaBaiHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CT_BAITHI]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_BAITHI](
	[MaCauHoi] [int] NOT NULL,
	[MaDangKy] [int] NOT NULL,
	[ThuTuDapAn] [char](10) NOT NULL,
	[STTCau] [int] NOT NULL,
	[MaHS] [char](9) NOT NULL,
	[LuaChon] [char](1) NULL,
 CONSTRAINT [PK_ChiTietDeThi] PRIMARY KEY CLUSTERED 
(
	[MaCauHoi] ASC,
	[MaDangKy] ASC,
	[MaHS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DANGKYKIEMTRA]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DANGKYKIEMTRA](
	[MaDangKy] [int] IDENTITY(1,1) NOT NULL,
	[ThoiGianBatDau] [datetime] NOT NULL,
	[ThoiGianLamBai] [int] NULL,
	[MaLoai] [int] NOT NULL,
	[SoCauHoi] [int] NULL,
 CONSTRAINT [PK_DANGKYKIEMTRA] PRIMARY KEY CLUSTERED 
(
	[MaDangKy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIEM]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIEM](
	[MaHS] [char](9) NOT NULL,
	[MaDangKy] [int] NOT NULL,
	[Diem] [float] NULL,
 CONSTRAINT [PK_Diem] PRIMARY KEY CLUSTERED 
(
	[MaHS] ASC,
	[MaDangKy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GV_MON]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GV_MON](
	[MaGV] [char](8) NOT NULL,
	[MaMon] [int] NOT NULL,
	[MaPhuTrach] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PHUCTRACHMON] PRIMARY KEY CLUSTERED 
(
	[MaPhuTrach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GIAOVIEN]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MaGV] [char](8) NOT NULL,
	[Ho] [nvarchar](50) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[MatKhau] [nchar](100) NOT NULL,
	[TrangThai] [bit] NOT NULL,
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MaGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOCKY]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOCKY](
	[MaHK] [int] IDENTITY(1,1) NOT NULL,
	[HocKy] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HocKy] PRIMARY KEY CLUSTERED 
(
	[MaHK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOCSINH]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOCSINH](
	[MaHS] [char](9) NOT NULL,
	[Ho] [nvarchar](50) NOT NULL,
	[Ten] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[MaLop] [int] NULL,
	[MatKhau] [nchar](100) NULL,
 CONSTRAINT [PK_HOCSINH] PRIMARY KEY CLUSTERED 
(
	[MaHS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHOI]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHOI](
	[MaKhoi] [int] IDENTITY(1,1) NOT NULL,
	[Khoi] [int] NOT NULL,
 CONSTRAINT [PK_KHOI] PRIMARY KEY CLUSTERED 
(
	[MaKhoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAIKIEMTRA]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAIKIEMTRA](
	[MaLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](50) NOT NULL,
	[ThoiGianLamBai] [int] NULL,
	[MaHK] [int] NULL,
 CONSTRAINT [PK_LOAIKIEMTRA] PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOP]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOP](
	[MaLop] [int] IDENTITY(1,1) NOT NULL,
	[TenLop] [nchar](10) NOT NULL,
	[NamHoc] [int] NOT NULL,
	[MaKhoi] [int] NOT NULL,
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOPKT]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOPKT](
	[MaDangKy] [int] NOT NULL,
	[MaLop] [int] NOT NULL,
 CONSTRAINT [PK_LOPKT] PRIMARY KEY CLUSTERED 
(
	[MaDangKy] ASC,
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MON]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MON](
	[MaMon] [int] IDENTITY(1,1) NOT NULL,
	[TenMon] [nvarchar](50) NOT NULL,
	[MaKhoi] [int] NOT NULL,
 CONSTRAINT [PK_MON] PRIMARY KEY CLUSTERED 
(
	[MaMon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NH_CAUHOI]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NH_CAUHOI](
	[MaCauHoi] [int] IDENTITY(1,1) NOT NULL,
	[NoiDung] [ntext] NOT NULL,
	[A] [ntext] NOT NULL,
	[B] [ntext] NOT NULL,
	[C] [ntext] NOT NULL,
	[D] [ntext] NOT NULL,
	[DapAn] [char](1) NOT NULL,
	[TrangThai] [bit] NOT NULL,
	[MaBaiHoc] [int] NOT NULL,
 CONSTRAINT [PK_NganHangCauHoi] PRIMARY KEY CLUSTERED 
(
	[MaCauHoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PC_GIANGDAY]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PC_GIANGDAY](
	[MaLop] [int] NOT NULL,
	[MaPhuTrach] [int] NOT NULL,
 CONSTRAINT [PK_PHUCTRACHLOP] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC,
	[MaPhuTrach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BAIHOC] ON 

INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (1, N'Tập hợp', 1, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (2, N'Phép cộng và phép trừ số tự nhiên', 1, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (3, N'Hình có trục đối xứng', 1, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (4, N'Mở rộng phân số. Phân số bằng nhau', 1, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (5, N'Đo độ dài (tiếp theo)', 4, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (6, N'Đo thể tích chất lỏng', 4, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (7, N'Khối lượng Đo khối lượng', 4, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (8, N'Trọng lực Đơn vị lực', 4, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (9, N'Sự nở vì nhiệt của chất lỏng', 4, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (10, N'Sự nở vì nhiệt của chất rắn', 4, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (11, N'Sự sôi (tiếp theo)', 4, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (101, N'Đo độ dài', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (102, N'Đo thể tích chất lỏng', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (103, N'Lực Hai lực cân bằng', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (104, N'Trọng lực Đơn vị lực', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (105, N'Lực đàn hồi', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (106, N'Khối lượng riêng Trọng lượng riêng', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (107, N'Máy cơ đơn giản', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (108, N'Mặt phẳng nghiêng', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (109, N'Đòn bẩy', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (110, N'Ròng rọc', 102, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (111, N'Sự nở vì nhiệt của chất rắn', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (112, N'Sự nở vì nhiệt của chất lỏng', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (113, N'Một số ứng dụng của sự nở vì nhiệt', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (114, N'Nhiệt kế thang đo nhiệt độ', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (115, N'Sự nóng chảy và sự đông đặc', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (116, N'Sự nóng chảy và sự đông đặc (tiếp theo)', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (117, N'Sự bay hơi và sự ngưng tụ', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (118, N'Sự bay hơi và sự ngưng tụ 2', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (119, N'Sự sôi', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (120, N'Tổng kết', 102, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (121, N'TẬP HỢP', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (122, N'CÁC PHÉP TÍNH SỐ TỰ NHIÊN', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (123, N'SỐ NGUYÊN TỐ', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (124, N'QUAN HỆ CHIA HẾT VÀ TÍNH CHẤT', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (125, N'PHÉP CỘNG TRỪ SỐ NGUYÊN', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (126, N'PHÉP NHÂN HAI SỐ NGUYÊN', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (127, N'HÌNH HỌC', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (128, N'CHU VI VÀ DIỆN TÍCH CÁC HÌNH HỌC', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (129, N'HÌNH TRỤC ĐỐI XỨNG', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (130, N'HÌNH CÓ TÂM ĐỐI XỨNG', 101, 1)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (131, N'PHÂN SỐ', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (132, N'RÚT GỌN PHÂN SỐ', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (133, N'SO SÁNH PHÂN SỐ', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (134, N'PHÉP CỘNG PHÂN SỐ', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (135, N'PHÉP NHÂN PHÂN SỐ', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (136, N'SỐ THẬP PHÂN', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (137, N'DIỂM VÀ ĐƯỜNG THẲNG', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (138, N'GÓC SỐ ĐO GÓC', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (139, N'TAM GIÁC VÀ TIA PHÂN GIÁC', 101, 2)
INSERT [dbo].[BAIHOC] ([MaBaiHoc], [TenBai], [MaMon], [MaHocKy]) VALUES (140, N'ĐƯỜNG TRÒN', 101, 2)
SET IDENTITY_INSERT [dbo].[BAIHOC] OFF
GO
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (1, 4)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (1, 5)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (4, 1)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (4, 2)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (4, 3)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (4, 5)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (4, 6)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (4, 7)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (4, 8)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (5, 1)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (5, 2)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (6, 1)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (6, 2)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (7, 6)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (8, 1)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (8, 2)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (8, 3)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (9, 121)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (10, 126)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (11, 123)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (11, 124)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (11, 127)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (12, 122)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (12, 125)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (12, 127)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (12, 132)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (12, 134)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (12, 137)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (13, 123)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (13, 126)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (13, 128)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (14, 122)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (14, 124)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (14, 128)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (14, 133)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (14, 136)
INSERT [dbo].[BAIHOCKT] ([MaDangKy], [MaBaiHoc]) VALUES (14, 138)
GO
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (7, 1, N'BADC      ', 1, N'HS21-0001', N'A')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (10, 1, N'ACBD      ', 3, N'HS21-0001', NULL)
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (11, 1, N'CBAD      ', 2, N'HS21-0001', N'B')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (12, 7, N'CBDA      ', 1, N'HS21-0001', N'C')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (13, 7, N'BDCA      ', 2, N'HS21-0001', N'C')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (354, 10, N'DABC      ', 5, N'HS21-0001', N'B')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (355, 10, N'CDBA      ', 2, N'HS21-0001', N'B')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (357, 10, N'BDAC      ', 3, N'HS21-0001', N'B')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (358, 10, N'ABCD      ', 1, N'HS21-0001', N'D')
INSERT [dbo].[CT_BAITHI] ([MaCauHoi], [MaDangKy], [ThuTuDapAn], [STTCau], [MaHS], [LuaChon]) VALUES (359, 10, N'ADCB      ', 4, N'HS21-0001', N'B')
GO
SET IDENTITY_INSERT [dbo].[DANGKYKIEMTRA] ON 

INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (1, CAST(N'2021-12-03T00:00:00.000' AS DateTime), 45, 1, 3)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (3, CAST(N'2021-12-12T00:00:00.000' AS DateTime), 45, 1, 20)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (4, CAST(N'2021-12-19T00:00:00.000' AS DateTime), 3, 2, 15)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (5, CAST(N'2021-12-20T00:00:00.000' AS DateTime), 20, 2, 5)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (6, CAST(N'2021-12-20T00:00:00.000' AS DateTime), 45, 3, 4)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (7, CAST(N'2021-12-20T00:00:00.000' AS DateTime), 10, 1, 2)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (8, CAST(N'2021-12-28T00:00:00.000' AS DateTime), 46, 3, 1)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (9, CAST(N'2021-12-27T00:00:00.000' AS DateTime), 60, 4, 10)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (10, CAST(N'2022-01-07T00:00:00.000' AS DateTime), 10, 1, 5)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (11, CAST(N'2021-12-25T03:00:00.000' AS DateTime), 10, 1, 5)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (12, CAST(N'2022-01-07T12:00:00.000' AS DateTime), 60, 5, 5)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (13, CAST(N'2021-12-26T00:00:00.000' AS DateTime), 15, 2, 10)
INSERT [dbo].[DANGKYKIEMTRA] ([MaDangKy], [ThoiGianBatDau], [ThoiGianLamBai], [MaLoai], [SoCauHoi]) VALUES (14, CAST(N'2021-12-26T00:00:00.000' AS DateTime), 60, 5, 10)
SET IDENTITY_INSERT [dbo].[DANGKYKIEMTRA] OFF
GO
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0001', 1, 6.6666666666666661)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0001', 5, 0)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0001', 6, 0)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0001', 7, 5)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0001', 10, 4)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0001', 11, 0)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0004', 5, 0)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0004', 6, 0)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0004', 7, 0)
INSERT [dbo].[DIEM] ([MaHS], [MaDangKy], [Diem]) VALUES (N'HS21-0004', 11, 0)
GO
SET IDENTITY_INSERT [dbo].[GV_MON] ON 

INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-001', 1, 3)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-002', 1, 4)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-001', 4, 6)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-002', 4, 7)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-001', 2, 8)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-001', 101, 9)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-001', 102, 10)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-001', 103, 11)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-002', 101, 12)
INSERT [dbo].[GV_MON] ([MaGV], [MaMon], [MaPhuTrach]) VALUES (N'GV21-002', 104, 13)
SET IDENTITY_INSERT [dbo].[GV_MON] OFF
GO
INSERT [dbo].[GIAOVIEN] ([MaGV], [Ho], [Ten], [NgaySinh], [MatKhau], [TrangThai]) VALUES (N'GV21-001', N'Phạm Văn', N'Minh', CAST(N'2000-06-16' AS Date), N'3244185981728979115075721453575112                                                                  ', 1)
INSERT [dbo].[GIAOVIEN] ([MaGV], [Ho], [Ten], [NgaySinh], [MatKhau], [TrangThai]) VALUES (N'GV21-002', N'Nguyễn Đức', N'Tú', CAST(N'2000-11-26' AS Date), N'3244185981728979115075721453575112                                                                  ', 1)
INSERT [dbo].[GIAOVIEN] ([MaGV], [Ho], [Ten], [NgaySinh], [MatKhau], [TrangThai]) VALUES (N'GV21-003', N'Ngô Mạnh', N'Cường', CAST(N'2000-04-25' AS Date), N'3244185981728979115075721453575112                                                                  ', 1)
GO
SET IDENTITY_INSERT [dbo].[HOCKY] ON 

INSERT [dbo].[HOCKY] ([MaHK], [HocKy]) VALUES (1, N'Học kỳ 1')
INSERT [dbo].[HOCKY] ([MaHK], [HocKy]) VALUES (2, N'Học kỳ 2')
SET IDENTITY_INSERT [dbo].[HOCKY] OFF
GO
INSERT [dbo].[HOCSINH] ([MaHS], [Ho], [Ten], [NgaySinh], [MaLop], [MatKhau]) VALUES (N'HS21-0001', N'Trần Minh', N'Chiến', CAST(N'2000-12-05' AS Date), 2, N'3244185981728979115075721453575112                                                                  ')
INSERT [dbo].[HOCSINH] ([MaHS], [Ho], [Ten], [NgaySinh], [MaLop], [MatKhau]) VALUES (N'HS21-0002', N'Trần Anh', N'Đức', CAST(N'2000-06-06' AS Date), 3, N'123                                                                                                 ')
INSERT [dbo].[HOCSINH] ([MaHS], [Ho], [Ten], [NgaySinh], [MaLop], [MatKhau]) VALUES (N'HS21-0003', N'Lương Ngọc', N'Đại', CAST(N'2000-04-12' AS Date), 4, N'123                                                                                                 ')
INSERT [dbo].[HOCSINH] ([MaHS], [Ho], [Ten], [NgaySinh], [MaLop], [MatKhau]) VALUES (N'HS21-0004', N'Nguyễn Minh', N'Đoan', CAST(N'2000-08-12' AS Date), 2, N'123                                                                                                 ')
INSERT [dbo].[HOCSINH] ([MaHS], [Ho], [Ten], [NgaySinh], [MaLop], [MatKhau]) VALUES (N'HS21-0005', N'Đỗ Văn', N'Nam', CAST(N'2000-05-14' AS Date), 3, N'123                                                                                                 ')
INSERT [dbo].[HOCSINH] ([MaHS], [Ho], [Ten], [NgaySinh], [MaLop], [MatKhau]) VALUES (N'HS21-0006', N'Phạm Thanh', N'Qui', CAST(N'2000-02-02' AS Date), 4, N'123                                                                                                 ')
GO
SET IDENTITY_INSERT [dbo].[KHOI] ON 

INSERT [dbo].[KHOI] ([MaKhoi], [Khoi]) VALUES (1, 6)
INSERT [dbo].[KHOI] ([MaKhoi], [Khoi]) VALUES (2, 7)
INSERT [dbo].[KHOI] ([MaKhoi], [Khoi]) VALUES (3, 8)
INSERT [dbo].[KHOI] ([MaKhoi], [Khoi]) VALUES (4, 9)
SET IDENTITY_INSERT [dbo].[KHOI] OFF
GO
SET IDENTITY_INSERT [dbo].[LOAIKIEMTRA] ON 

INSERT [dbo].[LOAIKIEMTRA] ([MaLoai], [TenLoai], [ThoiGianLamBai], [MaHK]) VALUES (1, N'Kiểm tra miệng', 10, NULL)
INSERT [dbo].[LOAIKIEMTRA] ([MaLoai], [TenLoai], [ThoiGianLamBai], [MaHK]) VALUES (2, N'Kiểm tra 15 phút', 15, NULL)
INSERT [dbo].[LOAIKIEMTRA] ([MaLoai], [TenLoai], [ThoiGianLamBai], [MaHK]) VALUES (3, N'Kiểm tra 45 phút', 45, NULL)
INSERT [dbo].[LOAIKIEMTRA] ([MaLoai], [TenLoai], [ThoiGianLamBai], [MaHK]) VALUES (4, N'Kiểm tra cuối kỳ 1', 60, 1)
INSERT [dbo].[LOAIKIEMTRA] ([MaLoai], [TenLoai], [ThoiGianLamBai], [MaHK]) VALUES (5, N'Kiểm tra cuối kỳ 2', 60, 2)
INSERT [dbo].[LOAIKIEMTRA] ([MaLoai], [TenLoai], [ThoiGianLamBai], [MaHK]) VALUES (6, N'Bài tập về nhà', 30, NULL)
SET IDENTITY_INSERT [dbo].[LOAIKIEMTRA] OFF
GO
SET IDENTITY_INSERT [dbo].[LOP] ON 

INSERT [dbo].[LOP] ([MaLop], [TenLop], [NamHoc], [MaKhoi]) VALUES (2, N'6A1       ', 2021, 1)
INSERT [dbo].[LOP] ([MaLop], [TenLop], [NamHoc], [MaKhoi]) VALUES (3, N'6A2       ', 2021, 1)
INSERT [dbo].[LOP] ([MaLop], [TenLop], [NamHoc], [MaKhoi]) VALUES (4, N'7A1       ', 2021, 2)
SET IDENTITY_INSERT [dbo].[LOP] OFF
GO
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (1, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (4, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (5, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (6, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (6, 3)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (7, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (8, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (8, 3)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (9, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (9, 3)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (10, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (11, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (11, 3)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (12, 2)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (13, 3)
INSERT [dbo].[LOPKT] ([MaDangKy], [MaLop]) VALUES (14, 2)
GO
SET IDENTITY_INSERT [dbo].[MON] ON 

INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (1, N'Toán 9', 4)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (2, N'Ngữ Văn 9', 4)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (3, N'Sinh học 9', 4)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (4, N'Vật lý 9', 4)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (6, N'Địa lý 9', 4)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (101, N'Toán Học 6', 1)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (102, N'Vật Lý 6', 1)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (103, N'Sinh Học 6', 1)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (104, N'Anh Văn 6', 1)
INSERT [dbo].[MON] ([MaMon], [TenMon], [MaKhoi]) VALUES (105, N'Tin Học', 1)
SET IDENTITY_INSERT [dbo].[MON] OFF
GO
SET IDENTITY_INSERT [dbo].[NH_CAUHOI] ON 

INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (7, N'Số đối của số -4/5 là: ', N'4/5', N'5/-4', N'-4/5', N'5/4', N'A', 0, 4)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (8, N'Hai số nào sau đây là nghịch đảo của nhau?', N'1,3 và 3,1', N'-2/3 và 3/2', N'-0,2 và -5', N'1 và -1', N'C', 1, 4)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (10, N'Trong các khẳng định sau, khẳng định nào đúng?', N'20/11 = -20/11', N' 5/9 = 5/-9', N'25/35 = 2/3', N'-30/4 = 15/-2', N'D', 0, 4)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (11, N'Để đo khoảng cách từ Trái Đất lên Mặt Trời người ta dùng đơn vị:', N'Kilômét', N'Năm ánh sáng', N'Dặm', N'Hải lí', N'B', 1, 5)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (12, N'Người ta đo thể tích chất lỏng bằng bình chia độ có ĐCNN là 0,5 cm3. Hãy chỉ ra kết quả đúng trong những trường hợp dưới đây?', N'V1=22,3cm3', N'V2=22,50cm3', N'V3=22,5cm3', N'V4=22cm3', N'C', 0, 6)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (13, N'Một người bán dầu chỉ có một cái ca 0,5 lít và một cái ca 1 lít. Người đó chỉ bán được dầu cho khách hàng nào sau đây?', N'Khách hàng cần mua 1,4 lít', N'Khách hàng cần mua 3,5 lít', N'Khách hàng cần mua 2,7 lít', N'Khách hàng cần mua 3,2 lít', N'B', 1, 6)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (14, N'Cân một túi hoa quả, kết quả là 1553g. ĐCNN của cân đã dùng là:', N'5g', N'100g', N'10g', N'1g', N'D', 1, 7)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (15, N'Một bạn kéo một vật lên theo phương thẳng đúng thì phải sử dụng một lực nhỏ nhất bằng 200N. Hỏi rằng nếu hai bạn cùng kéo vật đó lên theo phường thẳng đúng thì mỗi bạn phải sử dụng một lượ nhỏ nhất bằng bao nhiêu?', N'50N', N'100N', N'200N', N'10N', N'C', 1, 8)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (16, N'Hộp quẹt ga khi còn đầy ga trong quẹt nếu đem phơi nắng thì sẽ dễ bị nổ. Giải thích tại sao?', N'Vì khi phơi nắng, nhiệt độ tăng, ga ở dạng lỏng sẽ giảm thể tích làm hộp quẹt bị nổ.', N'Vì khi phơi nắng, nhiệt độ tăng, ga ở dạng khí sẽ tăng thể tích làm hộp quẹt bị nổ.', N'Vì khi phơi nắng, nhiệt độ tăng, ga ở dạng khí sẽ giảm thể tích làm hộp quẹt bị nổ.', N'Vì khi phơi nắng, nhiệt độ tăng, ga ở dạng lỏng sẽ tăng thể tích làm hộp quẹt bị nổ.', N'D', 1, 9)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (17, N'Tại sao gạch lát ở vỉa hè có khoảng cách giữa các viên gạch lớn hơn so với các viên gạch được lát trong nhà? Hãy chọn câu trả lời đúng nhất.', N'Vì ngoài trời thời tiết rất nóng, phải chừa khoảng cách để có sự dãn nở giữa các viên gạch.', N'Vì lát như thế là rất lợi cho gạch.', N'Vì lát như thế mới hợp mỹ quan thành phố.', N'Cả A, B, C đều đúng', N'A', 1, 10)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (18, N'Trong thang nhiệt độ Farenhai, nhiệt độ của nước đang sôi là:', N'32oF', N'100oF', N'212oF  ', N'0oF', N'C', 1, 11)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (101, N'Trước khi đo độ dài của một vật, cần phải ước lượng độ dài cần đo để', N'CHọn dụng cụ đo thích hợp ', N'Chọn thước đo thích hợp ', N'Đo chiều dài cho chính xác ', N'Có cách đặt mắt cho đúng cách', N'B', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (102, N'Một bạn dùng thước đo chiều cao của một cái cốc hình trụ. Kết quả đo là 10,4cm. ĐCNN của thước có giá trị nào trong các giá trị sau ', N'2mm', N'1cm', N'10dm', N'1m', N'A', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (103, N'Trong số các thước dưới đây, thước nào thích hợp nhất để đo độ dài sân trường em', N'Thước thẳng có GHĐ 1m và ĐCNN 1mm', N'Thước cuộn có GHĐ 5m và ĐCNN 5mm', N'Thước dây có GHĐ 150cm và ĐCNN 1mm ', N'Thước thẳng có GHĐ 1m và ĐCNN 1cm', N'B', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (104, N'Điền số thích hợp: 6,5km = ........ m = ......... dm', N' 6500; 65000', N'65000; 650000', N'650; 6500', N'65000; 650', N'A', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (105, N'Một cái bàn có chiều dài lớn hơn 0,5m và nhỏ hơn 1m . Dùng thước nào sau đây để đo chiều dài của bàn là thuận lợi nhất và chính xác nhất?', N'Thước có GHĐ là 1m và ĐCNN là 1mm', N'Thước có GHĐ là 20cm và ĐCNN là 1mm', N'Thước có GHĐ là 0,5m và ĐCNN là 1cm', N'Thước có GHĐ là 1m và ĐCNN là 1cm', N'A', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (106, N'Đơn vị đo độ dài hợp pháp thường dùng ở nước ta là:', N'Đềximét (dm)', N'Mét (m)', N'Xentimét (cm)', N'Milimét (mm)', N'B', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (107, N'Giới hạn đo (GHĐ) của thước là:', N'Độ dài lớn nhất ghi trên thước.', N'Độ dài nhỏ nhất ghi trên thước.', N'Độ dài giữa 2 vạch chia liên tiếp trên thước.', N'Độ dài giữa 2 vạch chia nhỏ nhất trên thước.', N'A', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (108, N'Trong số các thước dưới đây, thước nào thích hợp nhất để đo độ dài sân trường em?', N'Thước thẳng có GHĐ 1m và ĐCNN 1mm', N'Thước cuộn có GHĐ 5m và ĐCNN 5mm', N'Thước dây có GHĐ 150cm và ĐCNN 1mm', N'Thước thẳng có GHĐ 1m và ĐCNN 1cm', N'B', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (109, N'Chọn thước đo thích hợp để đo bề dày cuốn Vật lí 6', N'Thước thẳng có GHĐ 1,5m và ĐCNN 1cm', N'Thước dây có GHĐ 1m và ĐCNN 0,5cm', N'Thựớc kẻ có GHĐ 20cm và ĐCNN 1mm', N'Thước dây có GHĐ 1m và ĐCNN 5cm', N'C', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (110, N'Chọn thước đo thích hợp để đo chu vi miệng cốc', N'Thước thẳng có GHĐ 1,5m và ĐCNN 1cm', N'Thước dây có GHĐ 1m và ĐCNN 0,5cm', N'Thựớc kẻ có GHĐ 20cm và ĐCNN 1mm', N'Thựớc kẻ có GHĐ 2m và ĐCNN 1cm', N'B', 1, 101)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (111, N'Một người bán dầu chỉ có một cái ca 0,5lits và một cái ca 1 lít. Người đó chỉ bán được dầu cho khách hàng nào sau đây ?', N'khách hàng mua 1,4 lít', N'khách hàng mua 3,5 lít', N'khách hàng mua 2,7 lít ', N'khách hàng mua 3,2 lít', N'B', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (112, N'Hãy chọn bình chia độ phù hợp nhất trong các bình chia độ dưới đây để đo thể tích của một lượng chất lỏng còn gần đầy chai 0,5 lít ?', N'Bình 1000ml có vạch chia đến 10ml', N'Bình 500ml có vạch chia đến 2ml', N'Bình 100ml có vạch chia đến 1ml', N'Bình 500ml có vạch chia đến 5ml', N'B', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (113, N'Khi đo thể tích chất lỏng cần ?', N'Đặt mắt nhìn ngang với độ cao với mực chất lỏng trong bình', N'Đặt bình chia độ nằm ngang', N'Đặt mắt nhìn xiên với độ cao với mực chất lỏng trong bình', N'Đặt mắt nhìn vuông góc với độ cao với mực chất lỏng trong bình', N'A', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (114, N'Điền số thích hợp: 1 m3 = ........lít = ........ml', N'100 lít; 10000 ml', N'100 lít; 1000000 ml', N'1000 lít; 100000 ml', N'1000 lít; 1000000 ml', N'D', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (115, N'Điền vào chỗ trống: 150ml = ................... m3 = .................... l', N'0,00015 m3 = 0,15l', N'0,00015 m3 = 0,015l', N'0,000015 m3 = 0,15l', N'0,0015 m3 = 0,015l', N'A', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (116, N'Đơn vị đo thể tích thường dùng là:', N'mét (m)', N'kilogam (kg)', N'mét khối (m3) và lít (l).', N'mét vuông (m2)', N'C', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (117, N'Người ta đã đo thể tích chất lỏng bằng bình chia độ có ĐCNN 0,5cm3. Hãy chỉ ra cách ghi kết quả đúng trong những trường hợp dưới đây:', N'V1 = 20,2cm3.', N'V2 = 20,50cm3.', N'V3 = 20,5cm3.', N'V4 = 20cm3.', N'C', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (118, N'Người ta muốn chứa 20 lít nước bằng các can nhỏ có ghi 1,5 lít. Phải dùng ít nhất bao nhiêu can?', N'11', N'12', N'13', N'14', N'D', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (119, N'Câu nào sau đây là đúng nhất? Nếu trên can nhựa chỉ thấy ghi 3 lít, thì có nghĩa là', N'Can chỉ nên dùng đựng tối đa 3 lít.', N'ĐCNN của can là 3 lít.', N'GHĐ của can là 3 lít.', N'Cả ba phương án A, B, C đều đúng.', N'D', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (120, N'Để đo thể tích của một chất lỏng còn gần đầy chai 1 lít, trong các bình chia độ đã cho sau đây, chọn bình bình chia độ nào phù hợp nhất?', N'Bình 100ml và có vạch chia tới 1ml.', N'Bình 500ml và có vạch chia tới 5ml.', N'Bình 1000ml và có vạch chia tới 5ml.', N'Bình 2000ml và có vạch chia tới 5ml.', N'C', 1, 102)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (121, N'Để nâng 1 vật có trọng lượng 30N ta phải dùng lực như nào trong các lực dưới đây', N'F<30N', N'F=30N', N'F>20N', N'20N<F<300N', N'B', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (122, N'Một bạn kéo một vật lên theo phương thẳng đúng thì phải sử dụng một lực nhỏ nhất bằng 200N. Hỏi rằng nếu hai bạn cùng kéo vật đó lên theo phường thẳng đúng thì mỗi bạn phải sử dụng một lượ nhỏ nhất bằng bao nhiêu?', N'50N', N'200N', N'100N', N'10N', N'C', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (123, N'Lực nào không phải là lực đẩy trong các lực sau ', N'Lực của vận động viên đẩy tạ dùng để ném quả tạ ', N'Lực của tay học sinh tác dụng làm bay tàu bay giấy ', N'Lực của tay học sinh tác dụng vào cặp khi xách cặp đến trường ', N'Lực của lò xo bị ép tác dụng vào tay người', N'C', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (124, N'Lực nào không phải lực kéo trong các lực sau ', N'Lực của vật tác dụng vào sợi dây kéo nó ', N'Lực của không khí tác dụng vào quả bóng làm quả bóng bay lên ', N'Lực của tay người tác dụng vào lò xo làm lò xo dãn ra ', N'Lực của lò xo tác dụng vào tay khi nó đang bị dãn ', N'B', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (125, N'Cặp lực nào không cân bằng trong các cặp lực sau ', N'Lực của mặt nước và lực của Trái Đất tác dụng vào thuyền để thuyền đứng yên trên mặt nước ', N'Lực của hai em bé kéo hai đầu sợi dây khi sợi dây đứng yên ', N'Lực là lò xo tác dụng vào vật và lực mà vật tác dụng vào lò xo ', N'Lực nâng của sàn và lực hút của Trái đất tác dụng vào bàn ', N'C', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (126, N'Chọn đáp án đúng. Hai lực cân bằng:', N'Là hai lực mạnh như nhau, có cùng phương và cùng chiều, tác dụng vào cùng một vật.', N'Là hai lực mạnh như nhau, có cùng phương nhưng ngược chiều, tác dụng vào cùng một vật.', N'Là hai lực mạnh như nhau, ngược phương và ngược chiều, tác dụng vào cùng một vật.', N'Là hai lực mạnh như nhau, có cùng phương nhưng ngược chiều, tác dụng vào 2 vật ngược chiều nhau.', N'B', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (127, N'Phát biểu nào sau đây không đúng?', N'Tác dụng đẩy, kéo của vật này lên vật khác gọi là lực.', N'Nếu chỉ có hai lực tác dụng vào cùng một vật mà vật vẫn đứng yên, thì hai lực đó là hai lực cân bằng.', N'Hai lực cân bằng là hai lực mạnh như nhau, có cùng phương nhưng ngược chiều.', N'Nếu chỉ có hai lực tác dụng vào cùng một vật thì hai lực đó là hai lực cân bằng.', N'D', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (128, N'Lấy ngón tay cái và ngón tay trỏ ép hai đầu một lò xo bút bi lại. Nhận xét về tác dụng của ngón tay lên lò xo và của lò xo lên ngón tay. Chọn câu trả lời đúng.', N'Lực mà ngón cái tác dụng lên lò xo và lực mà lò xo tác dụng lên ngón cái là hai lực cân bằng', N'Lực mà ngón trỏ tác dụng lên lò xo và lực mà lò xo tác dụng lên ngón trỏ là hai lực cân bằng', N'Lực mà hai ngón tay tác dụng lên lò xo là hai lực cân bằng', N'Các câu trả lời A,B,C đều đúng', N'D', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (129, N'Dùng các từ thích hợp để điền vào chỗ trống: Khi một lực sĩ bắt đầu ném một quả tạ, lực sĩ đã tác dụng vào quả tạ một ……..', N'Lực nâng', N'Lực kéo', N'Lực uốn', N'Lực đẩy', N'D', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (130, N'Công việc nào dưới đây không cần dùng đến lực?', N'Xách 1 xô nước.', N'Nâng một tấm gỗ.', N'Đẩy 1 chiếc xe.', N'Đọc một trang sách.', N'D', 1, 103)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (131, N'Một bóng đèn được trei trên cây cột điện giữ nguyên vị trí vì:', N'Chịu lực giữ của sợi dây ', N'Chịu lực hút của Trái đất ', N'Không chịu lực nào tác dụng ', N'Chịu tác dụng của hai lực cân bằng là lực hút của Trái đất và lực giữ của sợi dây ', N'D', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (132, N' Trường hợp nào sau đây là ví dụ về trọng lực có thể làm cho một vật đang đứng yên phải chuyển động ', N' Quả bóng được đá thì lăn trên sân ', N' Một vật được tay kéo trượt trên mặt bàn nằm ngang ', N' Một vật được thả thì rơi xuống ', N'Một vật được ném thì bay lên cao ', N'C', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (133, N'Lực nào sau đây không phải trọng lực ', N'Lực làm cho nước mưa rơi xuống ', N'Lực tác dụng lên một vật nặng treo vào lò xo làm cho lò xo dãn ra', N'Lực tác dụng vào viên phấn khi viên phấn được buông ra khỏi tay khi cầm ', N'Lực nam châm tác dụng vào hòn bi sắt ', N'D', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (134, N'Trọng lượng một vật 40g là:', N'400N', N'4N', N'0,4N', N'40N', N'C', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (135, N'Hãy chọn câu lập luận đúng trong các câu dưới đây:', N'Một con tàu vũ trụ bay quanh Trái Đất thì không bị Trái Đất hút nữa. Vì nếu bị hút thì nó đã rơi ngay xuống Trái Đất.', N'Một con tàu vũ tru bay quanh Trái Đất thì không bị Trái Đất hút.Vì ta thấy nhà du hành vũ trụ bị lơ lửng trong con tàu.', N'Một con tàu vũ trụ bay quanh Trái Đất vẫn bị Trái Đất hút. Nhưng lực hút này bi cân bằng bởi lực đẩy của động cơ.', N'Mặt trăng luôn luôn bị Trái Đất hút. Nhưng Mặt Trăng không bị rơi vào Trái Đất, vì lực hút có tác dụng làm Mặt Trăng quay tròn quanh Trái Đất.', N'D', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (136, N'Số liệu nào dưới đây phù hợp với một học sinh THCS?', N'Khối lượng 400g', N'Trọng lượng 400N', N'Chiều cao 400mm', N'Vòng ngực 400cm', N'B', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (137, N'Chỉ có thể nói về trọng lực của vật nào sau đây?', N'Trái Đất', N'Mặt trăng', N'Mặt trời', N'Hòn đá trên mặt đất', N'D', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (138, N'Một chiếc tàu thùy nổi được trên mặt nước là nhờ có những lực nào tác dụng vào nó?', N'Chỉ nhờ trọng lực do Trái Đất hút xuống phía dưới', N'Chỉ nhờ lực nâng của nước đẩy lên', N'Nhờ trọng lực do Trái Đất hút xuống và lực nâng của nước đẩy lên cân bằng nhau.', N'Nhờ lực hút của Trái Đất, lực nâng của nước và lực đẩy của chân vịt phía sau tàu.', N'C', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (139, N'Nếu so sánh một quả cân 1 kg và một tập giấy 1 kg thì:', N'Tập giấy có khối lượng lớn hơn', N'Quả cân có trọng lượng lớn hơn', N'Quả cân và tập giấy có trọng lượng bằng nhau', N'Quả cân và tập giấy có thể tích bằng nhau', N'C', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (140, N'Ba khối kim loại: 1kg đồng, 1kg sắt và 1kg nhôm. Khối nào có trọng lượng lớn nhất?', N'Khối đồng.', N'Khối sắt.', N'Khối nhôm.', N'Ba khối có trọng lượng bằng nhau.', N'D', 1, 104)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (141, N'Lực nào sau đây không phải lực đàn hồi?', N'Lực của lò xo bút bi tác dụng vào ngòi bút ', N'Lực của quả bóng tác dụng vào tường khi quả bóng va chạm với tường ', N'Lực của giảm xóc xe máy tác dụng vào khung xe máy ', N'Lực tâng tác dụng vào cánh máy bay khi máy bay chuyển động ', N'D', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (142, N'Phát biểu nào sau đây về lực đàn hồi của lò xo là đúng?', N'Trong hai trường hợp lò xo có chiều dài khác nhau: trường hợp nào lò xo dài hơn thì lực đàn hồi mạnh hơn ', N'Độ biến dạng của lo xo càng nhỏ thì lực đàn hồi càng nhỏ ', N'Chiều dài của lò xo khi bị kéo dãn càng lớn thì lực đàn hồi càng nhỏ ', N'Chiều dài của lò xo khi bị nén càng nhỏ thì lực đàn hồi càng nhỏ ', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (143, N'Đặt một lò xo trên nền nhà và sat tường. Lấy tay ép lò xo vào tường, lò xo bị biến dạng. Lực nào sau đây gây ra sự biến dang của lò xo', N'Lực của tay ', N'Lực của tường ', N'Lực của tay và tường ', N'Lực của tay, tường và Trái đất ', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (144, N'Dùng 1 quả nặng có khối lượng bằng 50g treo vào đầu lò xo, lò xo bị biến dang. Muốn lò xo dãn ra 3cm phải làm thế nào?', N'Treo thêm một quả nặng 50g ', N'Thay quả nặng 50g bằng quả nặng 100g', N'Treo thêm quả nặng 100g', N'Cả 3 phương án trên đều sai ', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (145, N'Lực nào dưới đây là lực đàn hồi?', N'Trọng lực của một quả nặng', N'Lực hút của một nam châm tác dụng lên một miếng sắt', N'Lực đẩy của lò xo dưới yên xe đạp', N'Lực kết dính giữa một tờ giấy dán trên bảng với mặt bảng', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (146, N'Biến dạng của vật nào dưới dây là biến dạng đàn hồi?', N'Cục đất sét', N'Sợi dây đồng', N'Sợi dây cao su', N'Quả ổi chín', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (147, N'Treo thẳng đứng một lò xo, đầu dưới gắn với một quả cân 10g thì lò xo có độ dài là 11cm; nếu thay bằng quả cân 200g thì lò xo có độ dài là 11,5cm. Hỏi nếu treo quả cân 500g thì lò xo có độ dài bao nhiêu?', N'12cm', N'12,5cm', N'13cm', N'13,5cm', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (148, N'Nếu treo quả cân 1kg vào một cái “cân lò xo”của cân có độ dài 10cm. Nếu treo quả cân 0,5kg thì lò xo có độ dài 6cm. Hỏi nếu treo quả cân 200g thì lò xo sẽ có độ dài bao nhiêu?', N'7,6cm', N'5cm', N'3,6cm', N'2,5cm', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (149, N'Nếu treo một quả cân 100g vào một sợi dây cao su thì khi đã đứng yên quả cân chịu tác dụng', N'Chỉ của trọng lực có độ lớn 1N', N'Chỉ của lực đàn hồi có độ lớn là 10N', N'Của trọng lực có độ lớn 1N và lực đàn hồi có độ lớn 1N', N'Của trọng lực có độ lớn 1N và lực đàn hồi có độ lớn 10N', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (150, N'Vật nào dưới đây không có tính chất đàn hồi:', N'Một quả bóng cao su', N'Một quả bóng bàn', N'Một hòn đá', N'Một chiếc lưỡi cưa', N'C', 1, 105)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (151, N'Công thức nào dưới đây tính trọng lượng riêng của một chất theo trọng lượng và thể tích?', N'D=P.V', N'd=VP', N'd=V.D', N'd=P/V', N'D', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (152, N'CHo biết 13,5kg nhôm có thể tích là 5dm3. Khối lượng riêng của nhôm bằng bao nhiêu?', N'2700kg/dm3', N'2700kg/m3', N'270kh/m3', N'260kg/m3', N'B', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (153, N'Một vật bằng sắt có khối lượng riêng là 7800kh/m3; thể tích 50dm3.Khối lượng của vật là:', N'390kg ', N'312kg ', N'390000kg', N'156kg', N'A', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (154, N'Một hộp sữa Ông thọ có khối lượng 397g và có thể tích 320cm3. Hãy tính khối lượng riêng của sữa trong hộp theo đơn vị kg/m3', N'1440,6 kg/m3', N'1240,6 kg/m3', N'1740,6 kg/m3', N'1300,6 kg/m3', N'B', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (155, N'Biết 10 lít cát có khối lượng 15 kg. Tính thể tích của 1 tấn cát.', N'0,667m3', N'0,667m4', N'0,778m3', N'0,778m4', N'A', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (156, N'Cho biết 1kg nước có thể tích 1 lít còn 1kg dầu hỏa có thể tích 5/4 lít. Phát biểu nào sau đây là đúng?', N'1 lít nước có thể tích lớn hơn 1 lít dầu hỏa', N'1 lít dầu hỏa có khối lượng lớn hơn 1 lít nước', N'Khối lượng riêng của dầu hỏa bằng 5/4 khối lượng riêng của dầu hỏa', N'Khối lượng riêng của nước bằng 5/4 khối lượng riêng của dầu hỏa.', N'D', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (157, N'Người ta thường nói đồng nặng hơn nhôm. Câu giải thích nào sau đây là không đúng?', N'Vì trọng lượng của đồng lớn hơn trọng lượng của nhôm', N'Vì trọng lượng riêng của đồng lớn hơn trọng lượng riêng của nhôm', N'Vì khối lượng riêng của đồng lớn hơn khối lượng riêng của nhôm', N'Vì trọng lượng riêng của miếng đồng lớn hơn trọng lượng của miếng nhôm có cùng thể tích.', N'A', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (158, N'Khối lượng riêng của nhôm là bao nhiêu?', N'1300,6kg/m3', N'2700N', N'2700kg/m3', N'2700N/m3', N'C', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (159, N'Muốn đo khối lượng riêng của các hòn bi thủy tinh, ta cần dùng những dụng cụ gì? Hãy chọn câu trả lời đúng.', N'Chỉ cần dùng một cái cân', N'Chỉ cần dùng một cái lực kế.', N'Chỉ cần dùng một cái bình chia độ.', N'Cần dùng một cái cân và một cái bình chia độ.', N'D', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (160, N'Biết 10 lít cát có khối lượng 15kg. Tính trọng lượng của một đống cát 3 m3.', N'60000N', N'30000N', N'45000N', N'50000N', N'C', 1, 106)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (161, N'Một bác thợ xây muốn kéo một bao ximang lên một mái nhà theo phương thẳng đứng thì bác đó phải sử dụng lực nào trong các lực sau, biết rằng khối lượng của bao ximang là 50kg ', N'50N', N'500N', N'450N', N'5N', N'B', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (162, N'Vật nào dưới đây thuộc máy cơ đơn giản', N'Đòn bảy ', N'Lực kế', N'Thước cuộn ', N'Bình tràn', N'A', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (163, N'Máy cơ đơn giản', N'Làm thay đổi phương của trọng lực tác dụng lên vật.', N'Giúp con người làm việc có nhanh hơn.', N'Giúp con người kéo vật lên với lực kéo lớn hơn trọng lượng của vật.', N'Giúp con người nâng vật nặng lên cao dễ dàng hơn.', N'D', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (164, N'Những loại máy móc, dụng cụ nào sau đây sử dụng nguyên lí của các máy cơ đơn giản:', N'Cầu bập bênh', N'Xe gắn máy', N'Xe đạp', N'Máy bơm nước', N'A', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (165, N'Chọn câu sai. Trường hợp nao sau đây có thể dùng máy cơ đơn giản?', N'Đưa xe máy lên xe tải.', N'Dắt xe máy từ đường vào nhà cao hơn mặt đường.', N'Kéo xe máy ra khỏi hố sâu, khi xe bị sa hố.', N'Không có trường hợp nào kể trên.', N'D', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (166, N'Người ta thường sử dụng ròng rọc để làm các việc nào sau đây?', N'Đưa thùng hàng lên ô tô tải.', N'Đưa xô vữa lên cao.', N'Kéo thùng nước từ giếng lên.', N'B và C đúng', N'D', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (167, N'Chọn từ thích hợp điền vào chỗ trống. Khi kéo vật lên theo phương thẳng đứng cần phải dùng lực…………trọng lượng của vật.', N'nhỏ hơn', N'ít nhất bằng', N'luôn luôn lớn hơn', N'gần bằng', N'B', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (168, N'Chọn phát biểu sai. Máy cơ đơn giản đã mang lại những lợi ích như thế nào cho con người?', N'giảm hao phí sức lao động.', N'tăng năng suất lao động.', N'thực hiện công việc dễ dàng.', N'gây khó khăn và cản trở công việc.', N'D', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (169, N'Một người thợ xây muốn dùng lực khoảng 250N để kéo một bao xi măng 50kg lên tầng thứ 10 của tòa nhà đang xây, một học sinh muốn dùng lực lớn hơn 100N để kéo một gàu nước 10kg từ giếng lên, một người nông dân muốn dùng lực khoảng 300N để dịch chuyển một hòn đá 100kg. Muốn vậy:', N'người thợ xây phải dùng ròng rọc, người học sinh cũng phải dùng ròng rọc, người nông dân phải dùng đòn bẩy.', N'người thợ xây phải dùng ròng rọc, người học sinh không phải dùng máy cơ đơn giản, người nông dân phải dùng đòn bẩy.', N'người thợ xây phải dùng mặt phẳng nghiêng, người học sinh cũng phải dùng mặt phẳng nghiêng, người nông dân phải dùng đòn bẩy.', N'người thợ xây phải dùng ròng rọc, người học sinh cũng phải dùng ròng rọc, người nông dân phải dùng mặt phẳng nghiêng.', N'B', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (170, N'Dụng cụ nào sau đây không phải là máy cơ đơn giản?', N'Cái búa nhổ đinh', N'Cái bấm móng tay', N'Cái thước dây', N'Cái kìm', N'C', 1, 107)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (171, N'Kết luận nào là đúng khi nới về việc sủ sựng mặt phẳng nghiêng để đưa một thùng hàng lên thùng xe ô tô ', N'Lực để kéo vật lên nhỏ hơn trọng lương của thùng hàng ', N'Lực để kéo vật bằng trọng lượng của thùng hàng ', N'Lực để kéo vật lên lớn hơn trọng lượng của thùng hàng ', N'Lực để kéo vật lên có cường độ bất kì', N'A', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (172, N'Kéo từ từ một vật có khối lượng 100kg trên một mặt phẳng nghiêng nhẵn. Kết luận nào sau đây là đúng khi nói về cường độ của lực kéo đó.', N'Lực kéo bằng 100N', N'Lực kéo nhỏ hơn 1000N ', N'Lực kéo bằng 1000N ', N'Lực lớn hơn 500N', N'B', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (173, N'Công việc nào trong các công việc dưới đây không sử dụng mặt phẳng nghiêng ', N'Dùng mặt phẳng nghiêng có thể làm thay đổi hướng của lực ', N'Dùng mặt phẳng nghiêng có thể làm giảm cường độ lực kéo ', N'Dùng mặt phẳng nghiêng có độ nghiêng càng nhỏ thì lực kéo vật trên mặt phẳng nghiêng càng nhỏ', N'Dùng mặt phẳng nghiêng chỉ có thể làm hướng của lực nhưng không ', N'C', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (174, N'Trong các cách sau, cách nào không làm giảm được độ nghiêng của mặt phẳng nghiêng?', N'tăng chiều dài của mặt phẳng nghiêng.', N'giảm chiều dài của mặt phẳng nghiêng.', N'giảm chiều cao kê của mặt phẳng nghiêng.', N'tăng chiều dài của mặt phẳng nghiêng đồng thời giảm chiều cao kê mặt phẳng nghiêng.', N'B', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (175, N'Điền từ thích hợp vào chỗ trống: Dùng mặt phẳng nghiêng có thể làm………. tác dụng của lực.', N'tăng', N'thay đổi hướng', N'giảm', N'lệch đi', N'B', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (176, N'Kết luận nào là đúng khi nói về việc sử dụng mặt phẳng nghiêng để đưa một thùng hàng lên thùng xe ô tô?', N'Lực để kéo vật lên nhỏ hơn trọng lượng của thùng hàng.', N'Lực để kéo vật lên bằng trọng lượng của thùng hàng.', N'Lực để kéo vật lên lớn hơn trọng lượng của thùng hàng.', N'Lực để kéo vật lên có cường độ bất kì.', N'A', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (177, N'Khi dùng mặt phẳng nghiêng', N'trọng lượng của vật giảm đi.', N'hướng của trọng lượng thay đổI', N'cả hướng và độ lớn của trọng lực thay đổi.', N'trọng lượng của vật không thay đổi.', N'D', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (178, N'Điền từ thích hợp vào chỗ trống: Mặt phẳng nghiêng càng nghiêng ít thì lực cần để kéo vật trên mặt phẳng nghiêng ……..', N'càng giảm', N'càng tăng', N'không thay đổi', N'tất cả đều đúng', N'A', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (179, N'Dụng cụ nào sau đây là ứng dụng của mặt phẳng nghiêng?', N'Cái kéo', N'Cầu thang gác', N'Mái nhà', N'Cái kìm', N'B', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (180, N'Dùng mặt phẳng nghiêng có thể kéo vật lên với lực kéo', N'xấp xỉ hơn trọng lượng của vật.', N'đúng bằng hơn trọng lượng của vật.', N'nhỏ hơn trọng lượng của vật.', N'lớn hơn trọng lượng của vật.', N'C', 1, 108)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (181, N'Dụng cụ nào sau đây không phải một ứng dụng của đòn bẩy khi sử dụng nó', N'Cái kéo', N'Cái búa đinh nhỏ ', N'Cái cưa', N'Cái cắt móng tay', N'C', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (182, N'Khi đưa một hòn đá nặng dời chỗ sang bên cạnh, người ta thường sử dụng', N'Ròng rọc cố định ', N'Mặt phẳng nghiêng ', N'Đòn bảy ', N'Mặt phẳng nghiêng và đòn bẩy', N'C', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (183, N'Nếu đòn bẩy quay quanh điểm tựa O, trọng lượng của vật cần nâng tác dụng vào điểm O1 của đòn bẩy, lực nâng vật tác dụng vào điểm O2 của đòn bẩy thì dùng đòn bẩy được lợi về lực trong trường hợp nào dưới đây?', N'Khoảng cách OO1 > OO2 ', N'Khoảng cách OO1 = OO2', N'Khoảng cách OO1 < OO2 ', N'Khoảng cách OO1 = 2OO2', N'C', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (184, N'Chọn phát biểu sai khi nói về tác dụng của đòn bẩy?', N'Tác dụng của đòn bẩy là giảm lực kéo hoặc đẩy vật.', N'Tác dụng của đòn bẩy là tăng lực kéo hoặc đẩy vật.', N'Đòn bẩy có tác dụng làm thay đổi hướng của lực vào vật.', N'Dùng đòn bẩy có thể được lợi về lực.', N'C', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (185, N'Trong các dụng cụ sau đây, dụng cụ nào là đòn bẩy?', N'Cái cầu thang gác', N'Mái chèo', N'Thùng đựng nước', N'Quyển sách nằm trên bàn', N'B', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (186, N'Điều kiện nào sau đây giúp người sử dụng đòn bẩy để nâng vật lên với lực nhỏ hơn trọng lượng của vật?', N'Khi OO2 < OO1 thì F2 < F1 ', N'Khi OO2 = OO1 thì F2 = F1 ', N'Khi OO2 > OO1 thì F2 < F1 ', N'Khi OO2 > OO1 thì F2 > F1', N'C', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (187, N'Cân nào sau đây không phải là một ứng dụng của đòn bẩy?', N'Cân Robecvan', N'Cân đồng hồ', N'Cần đòn', N'Cân tạ', N'B', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (188, N'Chọn từ thích hợp điền vào chỗ trống: Muốn lực nâng vật……… trọng lượng của vật thì phải làm cho khoảng cách từ điểm tựa tới điểm tác dụng của lực nâng……khoảng cách từ điểm tựa tới điểm tác dụng của trọng lượng vật.', N'nhỏ hơn, lớn hơn', N'nhỏ hơn, nhỏ hơn', N'lớn hơn, lớn hơn', N'lớn hơn, nhỏ hơn', N'A', 1, 109)
GO
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (189, N'Dụng cụ nào sau đây không phải là ứng dụng của đòn bẩy?', N'Cái kéo', N'Cái kìm', N'Cái cưa', N'Cái mở nút chai', N'C', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (190, N'Một người gánh một gánh nước. Thùng thứ nhất nặng 20 kg, thùng thứ hai nặng 30 kg. Gọi điểm tiếp xúc giữa vai với đòn gánh là O, điểm treo thùng thứ nhất vào đòn gánh là O1, điểm treo thùng thứ hai vào đòn gánh là O2. Hỏi OO1 và OO2 có giá trị nào sau đây thì gánh nước cân bằng?', N'OO1 = 90 cm, OO2 = 90 cm', N'OO1 = 90 cm, OO2 = 60 cm', N'OO1 = 60 cm, OO2 = 90 cm', N'OO1 = 60 cm, OO2 = 120 cm', N'B', 1, 109)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (191, N'Kết luận nào sau đây là đúng khi nói về tác dụng của ròng rọc động?Ròng rọc động có tác dụng làm lực kéo vật lên', N'lớn hơn trọng lượng của vật.', N'bằng trọng lượng của vật.', N'nhỏ hơn trọng lượng của vật.', N'lớn hơn trọng lượng của vật và thay đổi hướng của lực kéo.', N'C', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (192, N'Sử dụng ròng rọc khi đưa một vật lên cao ta được lợi', N'về lực', N'về hướng của lực', N'về đường đi', N'Cả 3 đều đúng', N'D', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (193, N'Máy cơ đơn giản nào sau đây chỉ có tác dụng làm đổi hướng của lực tác dụng?', N'Ròng rọc cố định ', N'Ròng rọc di động ', N'Đòn bẩy ', N'Mặt phằng nghiêng', N'A', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (194, N'Khi kéo một thùng nước từ dưới giếng lên, người ta thường sử dụng', N'ròng rọc cố định', N'mặt phẳng nghiêng.', N'đòn bẩy.', N'mặt phẳng nghiêng và đòn bẩy.', N'A', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (195, N'Chọn câu đúng:', N'Ròng rọc cố định chỉ thay đổi độ lớn của lực.', N'Trong hệ thống ròng rọc động, không có ròng rọc cố định.', N'Ròng rọc động có thể thay đổi cả độ lớn và hướng của lực.', N'Với hai ròng rọc cố định thì có thể thay đổi độ lớn của lực.', N'C', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (196, N'Muốn đứng ở dưới kéo một vật lên cao với lực kéo nhỏ hơn trọng lượng của vật phải dùng hệ thống ròng rọc nào dưới đây?', N'Một ròng rọc cố định.', N'Một ròng rọc động.', N'Hai ròng rọc cố định.', N'Một ròng rọc động và một ròng rọc cố định', N'D', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (197, N'Trường hợp nào sau đây không sử dụng ròng rọc?', N'Trong xây dựng các công trình nhỏ, người công nhân cần đưa các vật liệu lên cao.', N'Khi treo hoặc tháo cờ thì ta không phải trèo lên cột.', N'Chiếc kéo dùng để cắt kim loại thường có phần tay cầm dài hơn lưỡi kéo để được lợi về lực.', N'Ở đầu móc các cần cẩu hay xe ô tô cần cẩu đều được lắp các ròng rọc động.', N'C', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (198, N'Ròng rọc được sử dụng trong trường hợp nào sau đây:', N'Kéo một thùng bêtông lên cao để đố trần nhà', N'Đưa một thùng phuy nặng từ mặt đường lên sàn xe tải.', N'Cái chắn ôtô tại những điểm bán vé trên đường cao tốc.', N'Tất cả đều sai', N'A', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (199, N'Lí do chính của việc đặt ròng rọc cố định ở đỉnh cột cờ là để có thể', N'tăng cường độ của lực dùng để kéo cờ lên cao.', N'giảm cường độ của lực dùng để kéo cờ lên cao.', N'giữ nguyên hướng của lực dùng để kéo cờ lên cao.', N'thay đổi hướng của lực dùng để kéo cờ lên cao.', N'D', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (200, N'Kết luận nào sau đây là đúng khi nói về tác dụng của ròng rọc cố định? Ròng rọc cố định giúp', N'làm thay đổi độ lớn của lực kéo.', N'làm thay đổi hướng của lực kéo so với khi kéo trực tiếp.', N'làm thay đổi cả hướng và độ lớn của lực kéo so với khi kéo trực tiếp.', N'cả ba kết luận trên đều sai.', N'B', 1, 110)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (201, N'Khi đun nóng một hòn bi sắt thì xảy ra hiện tượng nào?', N'Khối lượng của hòn bi tăng ', N'Khối lượng của hòn bi giảm ', N'Khối lượng riêng của hòn bi tăng ', N'Khối lượng riêng của hòn bi giảm', N'D', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (202, N'CHọn phương án đúng. Một vật hình hộp chữ nhất đươnc làm bằng sắt.Khi tăng nhiệt độ của vật đó thì:', N'Chiều dài, rộng và chiều cao tăng ', N'Chỉ có chiều dài và chiều rộng tăng ', N'Chỉ có chiều cao tăng', N'Chiều dài, chiều rông và chiều cao không đổi', N'A', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (203, N'Các nha sĩ khuyên không nên ăn thức ăn quá nóng. Vì sao?', N'Vì răng dễ vỡ', N'Vì răng dễ bị ố vằng ', N'Vì răng dễ bị sâu ', N'Vì men răng dễ bị rạn nứt ', N'D', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (204, N'Một lọ thủy tinh được đạy bằng nút thủy tinh. Nút bị kẹt. Hỏi phải mở nút bằng cách nào trong các cách sau đây?', N'Hơ nóng hút ', N'Hơ nóng cổ lọ ', N'Hơ nóng cả nút và cổ lọ ', N'Hơ nóng đáy lọ', N'C', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (205, N'Chọn câu phát biểu sai', N'Chất rắn khi nóng lên thì nở ra.', N'Các chất rắn khác nhau nở vì nhiệt khác nhau.', N'Chất rắn khi lạnh đi thì co lại.', N'Các chất rắn khác nhau nở vì nhiệt như nhau.', N'D', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (206, N'Khi xây cầu, thông thường một đầu cầu người ta cho gối lên các con lăn. Hãy giải thích cách làm đó?', N'Để dễ dàng tu sửa cầu.', N'Để tránh tác hại của sự dãn nở vì nhiệt.', N'Để tạo thẩm mỹ.', N'Cả 3 lý do trên.', N'B', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (207, N'Cho ba thanh kim loại đồng, nhôm, sắt có cùng chiều dài ban đầu là 100 cm. Khi tăng thêm 500C thì độ tăng chiều dài của chúng theo thứ tự trên lần lượt là 0,12 cm; 0,086 cm; 0,060 cm. Trong ba chất đồng, nhôm và sắt, cách sắp xếp nào sau đây là đúng theo thứ tự từ chất dãn nở vì nhiệt nhiều nhất đến chất dãn nở vì nhiệt ít nhất?', N'Nhôm – Đồng – Sắt', N'Nhôm – Sắt – Đồng', N'Sắt – Nhôm – Đồng', N'Đồng – Nhôm – Sắt', N'A', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (208, N'Chọn câu trả lời đúng nhất. Người ta sử dụng hai cây thước khác nhau để đo chiều dài. Một cây thước bằng nhôm và một cây thước làm bằng đồng. Nếu nhiệt độ tăng lên thì dùng hai cây thước để đo thì cây thước nào sẽ cho kết quả chính xác hơn? Biết đồng nở vì nhiệt kém hơn nhôm.', N'Cả hai cây thước đều cho kết quả chính xác như nhau.', N'Cây thước làm bằng nhôm.', N'Cây thước làm bằng đồng.', N'Các phương án đưa ra đều sai.', N'C', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (209, N'Hãy dự đoán chiều cao của một chiếc cột bằng sắt sau mỗi năm.', N'Không có gì thay đổi.', N'Vào mùa hè cột sắt dài ra và vào mùa đông cột sắt ngắn lại.', N'Ngắn lại sau mỗi năm do bị không khí ăn mòn.', N'Vào mùa đông cột sắt dài ra và vào mùa hè cột sắt ngắn lại.', N'B', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (210, N'Khi một vật rắn được làm lạnh đi thì', N'khối lượng của vật giảm đi.', N'thể tích của vật giảm đi.', N'trọng lượng của vật giảm đi.', N'trọng lượng của vật tăng lên.', N'B', 1, 111)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (211, N'Kết luận nào sau đây khi nói về sự nở ra vì nhiệt của chất lỏng?', N'Chất lỏng co lại khi nhiệt độ tăng, nở ra khi nhiệt độ giảm ', N'Chất lỏng nở ra khi nhiệt độ tăng, co lại khi nhiệt độ giảm ', N'Chất lỏng không thay đổi khi nhiệt độ thay đổi ', N'Khối lượng riêng của chất lỏng tăng khi nhiệt độ thay đổi ', N'D', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (212, N'Khi tăng nhiệt độ của một lương nước từ 0 đến 4 độ C thì: ', N'Thể tich nước co lại ', N'Thể tích nước nở ra ', N'Thể tích nước không thay đổi ', N'Cả ba kết luật đều sai ', N'A', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (213, N'Hiện tượng nào sau đây xảy ra khi đun nóng một lượng chất lỏng ', N'Khối lượng chất lỏng tăng ', N'Khối lượng chất lỏng giảm ', N'Trọng lượng của chất lỏng tăng ', N'Thể tích của chất lỏng tăng', N'C', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (214, N'Khi đặt bình cầu đựng nước vào nước nóng, người ta thấy mực chất lỏng trong ống thủy tinh mới tụt xuống một tí, sau đó mới dâng lên cao hơn mức ban đầu. Điều đó chứng tỏ: ', N'Thể tích của nước tăng nhiều hơn thể tích của bình ', N'Thể tích của nước tăng ít hơn thể tích của bình ', N'Thể tích của nước tăng, của bình không tăng ', N'Thể tích của nước tanwg trước, thể tích của bình không tăng ', N'A', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (215, N'Hiện tượng nào sau đây sẽ xảy ra đối với khối lượng riêng của một chất lỏng khi đun nóng một lượng chất lỏng này trong một bình thủy tinh ', N'Khối lượng riêng của chất lỏng tăng ', N'Khối lượng riêng của chất lỏng giảm ', N'Khối lượng riêng của chất lỏng không đổi ', N'Khối lượng riêng của chất lỏng thoạt đầu giảm rồi sau đó mới tăng ', N'B', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (216, N'Chọn câu phát biểu sai', N'Chất lỏng co lại khi lạnh đi.', N'Độ dãn nở vì nhiệt của các chất lỏng khác nhau là như nhau.', N'Khi nhiệt độ thay đổi thì thể tích chất lỏng thay đổi.', N'Chất lỏng nở ra khi nóng lên.', N'B', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (217, N'Làm lạnh một lượng nước từ 100oC về 50oC. Khối lượng riêng và trọng lượng riêng của nước thay đổi như thế nào?', N'Cả khối lượng riêng và trọng lượng riêng đều tăng.', N'Ban đầu khối lượng riêng và trọng lượng riêng giảm sau đó bắt đầu tăng.', N'Cả khối lượng riêng và trọng lượng riêng đều giảm.', N'Cả khối lượng riêng và trọng lượng riêng đều không đổi.', N'A', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (218, N'Hai bình A và B giống nhau, cùng chứa đầy chất lỏng. Ban đầu nhiệt độ của chất lỏng trong hai bình là như nhau. Đặt hai bình vào trong cùng một chậu nước nóng thì thấy mực nước trong bình A dâng cao hơn bình B. Kết luận nào sau đây là đúng khi nói về các chất lỏng chứa trong hai bình?', N'Chất lỏng ở hai bình giống nhau nhưng nhiệt độ của chúng khác nhau.', N'Chất lỏng ở hai bình khác nhau, nhiệt độ của chúng khác nhau.', N'Hai bình A và B chứa cùng một loại chất lỏng.', N'Hai bình A và B chứa hai loại chất lỏng khác nhau.', N'D', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (219, N'Đun nóng một lượng nước đá từ 0oC đến 100oC. Khối lượng và thể tích lượng nước đó thay đổi như thế nào?', N'Khối lượng không đổi, ban đầu thể tích giảm sau đó tăng.', N'Khối lượng không đổi, thể tích giảm.', N'Khối lượng tăng, thể tích giảm.', N'Khối lượng tăng, thể tích không đổi.', N'A', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (220, N'Chọn câu trả lời đúng.Có hai bình giống hệt nhau chứa đầy chất lỏng. Một bình chứa rượu và bình còn lại chứa nước. Khi đun nóng cả hai bình ở cùng một nhiệt độ như nhau, hỏi lượng rượu hay nước trào ra khỏi bình nhiều hơn? Biết rằng rượu nở vì nhiệt lớn hơn nước.', N'Nước trào ra nhiều hơn rượu', N'Nước và rượu trào ra như nhau', N'Rượu trào ra nhiều hơn nước', N'Không đủ cơ sở để kết luận', N'C', 1, 112)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (221, N'Lí do chủ yếu nào khi lợp nhà bằng tôn, người ta chỉ đóng đinh một đầu còn đầu kia để tự do?', N'Để tiết kiệm đinh ', N'Để tôn không bị thủng nhiều lỗ ', N'Để tôn dễ dàng co dãn vì nhiệt ', N'Cả A,B,C đều đúng', N'D', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (222, N'Sự co dãn vì nhiệt khi bị ngăn cản ', N'Có thể gây ra những lực rất lớn ', N'Có thể gây ra những lực rất nhỏ ', N'Không gây ra lực', N'Cả 3 kết luận trên đều sai ', N'A', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (223, N'Tại sao chỗ tiếp nối của hai thanh ray đường sắt lại có một khe hở?', N'Vì không thể hàn hai thanh ray lại được.', N'Vì để vậy sẽ lắp các thanh ray dễ dàng hơn.', N'Vì khi nhiệt độ tăng thanh ray sẽ dài ra có chỗ giãn nở.', N'Vì chiều dài thanh ray không đủ.', N'C', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (224, N'Câu nào sau đây mô tả đúng cấu tạo của một băng kép?', N'Băng kép được cấu tạo từ hai thanh kim loại có bản chất khác nhau.', N'Băng kép được cấu tạo từ một thanh thép và một thanh đồng.', N'Băng kép được cấu tạo từ một thanh nhôm và một thanh đồng.', N'Băng kép được cấu tạo từ một thanh thép và một thanh nhôm.', N'A', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (225, N'Kết luận nào sau đây là đúng khi nói về ứng dụng của băng kép? Băng kép được ứng dụng', N'làm cốt cho các trụ bê tông', N'làm giá đỡ', N'trong việc đóng ngắt mạch điện', N'làm các dây điện thoại', N'C', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (226, N'Có một băng kép được làm từ 2 kim loại là đồng và sắt (đồng nở vì nhiệt nhiều hơn sắt). Khi nung nóng, băng kép sẽ như thế nào?', N'Cong về phía sắt', N'Cong về phía đồng', N'Không bị cong', N'Cả A, B và C đều sai', N'A', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (227, N'Băng kép được cấu tạo dựa trên hiện tượng nào dưới đây?', N'Các chất rắn nở ra khi nóng lên.', N'Các chất rắn co lại khi lạnh đi.', N'Các chất rắn khác nhau dãn nở vì nhiệt khác nhau.', N'Các chất rắn nở vì nhiệt ít.', N'C', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (228, N'Tại sao gạch lát ở vỉa hè có khoảng cách giữa các viên gạch lớn hơn so với các viên gạch được lát trong nhà? Hãy chọn câu trả lời đúng nhất.', N'Vì ngoài trời thời tiết rất nóng, phải chừa khoảng cách để có sự dãn nở giữa các viên gạch.', N'Vì lát như thế là rất lợi cho gạch. ', N'Vì lát như thế mới hợp mỹ quan thành phố.', N'Cả A, B, C đều đúng', N'A', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (229, N'Có nhận xét gì về mối quan hệ giữa độ dày của cốc thủy tinh và độ bền của cốc? Hãy chọn câu trả lời đúng.', N'Không có mối quan hệ gì giữa độ bền của cốc và độ dày của thủy tinh làm cốc.', N'Cốc thủy tinh mỏng bền hơn cốc thủy tinh dày vì sự dãn nở vì nhiệt ở mặt trong và mặt ngoài của cốc xảy ra gần như cùng một lúc.', N'Hai cốc bền như nhau vì cùng có độ dãn nở vì nhiệt như nhau.', N'Cốc thủy tinh dày bền hơn cốc thủy tinh mỏng vì được làm từ nhiều thủy tinh hơn.', N'B', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (230, N'Băng kép đang thẳng, nếu làm cho lạnh đi thì nó bị cong về phía thanh thép hay thanh đồng? Tại sao?', N'Cong về phía thanh đồng vì đồng co vì nhiệt ít hơn thanh thép.', N'Cong về phía thanh đồng vì đồng co vì nhiệt nhiều hơn thanh thép.', N'Cong về phía thanh đồng vì đồng nở vì nhiệt nhiều hơn thanh thép.', N'Cong về phía thanh thép vì đồng co vì nhiệt nhiều hơn thanh thép.', N'B', 1, 113)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (231, N'Nhiệt kế thường dung hoạt động dựa trene ', N'Hiện tượng bay hơi ', N'Hiện tượng biến dạng khi chịu tác dụng lực ', N'Hiện tượng dãn nở vì nhiệt của các chất ', N'Cả ba hiện tượng trên đều không phải ', N'C', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (232, N'Khi nhúng một nhiệt kế rượu vào nước nóng, mức rượu trong ống nhiệt kế tăng vì: ', N'Ống nhiệt kế nở dài ra ', N'Ống nhiệt kế co ngắn lại ', N'Cả ống nhiệt kế và rượu đều nở ra nhưng ống nhiệt kế nở nhiều hơn ', N'Cả ống nhiệt kế và rượu trong ống đều nở ra nhưng rượu nở ra nhiều hơn ', N'D', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (233, N'Đo nhiệt độ cơ thể người bình thường là 37oC. Trong thang nhiệt độ Farenhai, kết quả đo nào sau đây đúng?', N'37oF', N'66,6oF', N'310oF', N'98,6oF', N'D', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (234, N'Giá trị nhiệt độ đo được theo thang nhiệt độ Kenvin là 293K. Hỏi theo thang nhiệt độ Farenhai, nhiệt độ đó có giá trị là bao nhiêu? Biết rằng mỗi độ trong thang nhiệt độ Kenvin (1K) bằng 1 độ trong thang nhiệt độ Xenxiut (1oC) và 0oC ứng với 273K.', N'20oF', N'100oF', N'68oF', N'261oF', N'C', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (235, N'Trong thang nhiệt độ Farenhai, nhiệt độ của nước đang sôi là:', N'32oF', N'100oF', N'212oF', N'0oF', N'C', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (236, N'Cho hai nhiệt kế rượu và thủy ngân. Dùng nhiệt kế nào có thể đo được nhiệt độ của nước đang sôi? Cho biết nhiệt độ sôi của rượu và thủy ngân lần lượt là 80oC và 357oC.', N'Cả nhiệt kế thủy ngân và nhiệ-t kế rượu.', N'Không thể dùng nhiệt kế thủy ngân và nhiệt kế rượu.', N'Nhiệt kế rượu.', N'Nhiệt kế thủy ngân', N'D', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (237, N'Nước ở trong trường hợp nào dưới đây có trọng lượng riêng lớn nhất?', N'Thể lỏng, nhiệt độ cao hơn 4oC', N'Thể lỏng, nhiệt độ bằng 4oC', N'Thể rắn, nhiệt độ bằng 0oC', N'Thể hơi, nhiệt độ bằng 100oC', N'B', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (238, N'Quan sát các nhiệt kế thủy ngân và nhiệt kế rượu thấy ở phần trên của nhiệt kế thường phình ra, chỗ phình ra đó có tác dụng', N'Chứa lượng thủy ngân hoặc rượu khi dâng lên.', N'Chứa lượng khí còn dư khi thủy ngân hoặc rượu dâng lên.', N'Phình ra cho cân đối nhiệt kế.', N'Nhìn nhiệt kế đẹp hơn.', N'B', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (239, N'Khi nhúng một nhiệt kế rượu vào nước nóng, mực rượu trong ống nhiệt kế tăng lên vì:', N'Ống nhiệt kế dài ra.', N'Ống nhiệt kế ngắn lại.', N'Cả ống nhiệt kế và rượu trong ống đều nở ra nhưng rượu nở nhiều hơn.', N'Cả ống nhiệt kế và rượu trong ống đều nở ra nhưng ống nhiệt kế nở nhiều hơn.', N'C', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (240, N'Phát biểu nào sau đây không đúng?', N'Nhiệt kế y tế có thể dùng để đo nhiệt độ cơ thể người.', N'Nhiệt kế thủy ngân có thể dùng để đo nhiệt độ trong lò luyện kim.', N'Nhiệt kế kim loại có thể đo nhiệt độ của bàn là đang nóng.', N'Nhiệt kế rượu có thể dùng để đo nhiệt độ của khí quyển.', N'B', 1, 114)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (241, N'Trong các hiện tượng sau đây, hiện tượng nào không liên quan đến sự nóng chảy', N'Bỏ một cục nước đá vào một cốc nước', N'Đốt một ngọn nến ', N'Đốt một ngọn đèn dầu ', N'Đúc một cái chuông đồng', N'C', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (242, N'Khi đun nóng kẽm, chúng mềm ra và nóng chảy dần, phát biểu nào sau đây là đúng?', N'Trong thời gian nóng chảy, nhiệt độ của kẽm giảm dần.', N'Trong thời gian nóng chảy, nhiệt độ của kẽm lúc tăng lúc giảm.', N'Trong thời gian nóng chảy, nhiệt độ của kẽm không đổi.', N'Trong thời gian nóng chảy, nhiệt độ của kẽm tiếp tục tăng.', N'C', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (243, N'Cho nhiệt độ nóng chảy của một số chất:Thép	1300oC Đồng 1083oC Chì 327oC Kẽm 420oC. Khi thả một thỏi thép và một thỏi kẽm vào đồng đang nóng chảy. Thỏi nào nóng chảy theo đồng?', N'Thỏi thép', N'Cả hai thỏi đều nóng chảy theo đồng.', N'Cả hai thỏi đều không bị nóng chảy theo đồng.', N'Thỏi kẽm.', N'D', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (244, N'Sự nóng chảy là sự chuyển từ', N'Thể lỏng sang thể rắn', N'Thể rắn sang thể lỏng', N'Thể lỏng sang thể hơi', N'Thể hơi sang thể lỏng', N'B', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (245, N'Hiện tượng nào không liên quan đến hiện tượng nóng chảy trong các hiện tượng ta hay gặp trong đời sống sau đây?', N'Đốt một ngọn nến', N'Đun nấu mỡ vào mùa đông', N'Pha nước chanh đá', N'Cho nước vào tủ lạnh để làm đá', N'D', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (246, N'Kết luận nào sau đây là đúng khi nói về nhiệt độ nóng chảy?', N'Nhiệt độ nóng chảy của các chất khác nhau là khác nhau.', N'Nhiệt độ nóng chảy của các chất khác nhau là giống nhau.', N'Trong thời gian nóng chảy nhiệt độ luôn tăng.', N'Trong thời gian nóng chảy nhiệt độ luôn giảm.', N'A', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (247, N'Câu nào sau đây nói về sự nóng chảy là không đúng?', N'Mỗi chất nóng chảy ở một nhiệt độ xác định.', N'Trong khi đang nóng chảy, nhiệt độ tiếp tục tăng.', N'Trong khi đang nóng chảy, nhiệt độ không thay đổi.', N'Khi đã bắt đầu nóng chảy, nếu không tiếp tục đun thì sự nóng chảy sẽ ngừng lại.', N'B', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (248, N'Hiện tượng nóng chảy của một vật xảy ra khi', N'đun nóng vật rắn bất kì.', N'đun nóng vật đến nhiệt độ nóng chảy của chất cấu thành vật thể đó.', N'đun nóng vật trong nồi áp suất.', N'đun nóng vật đến 100oC.', N'B', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (249, N'Trong các hiện tượng sau đây, hiện tượng nào liên quan đến sự nóng chảy?', N'Sương đọng trên lá cây.', N'Khăn ướt sẽ khô khi được phơi ra nắng.', N'Đun nước đổ đầy ấm, nước có thể tràn ra ngoài.', N'Cục nước đá bỏ từ tủ đá ra ngoài, sau một thời gian, tan thành nước.', N'D', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (250, N'Nhiệt độ nóng chảy của bạc là:', N'-960oC', N'96oC', N'60oC', N'960oC', N'D', 1, 115)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (251, N'Hiện tượng nào sau đây không liên quan đến sự đông đặc ', N'Đúc tượng đồng ', N'Đổ bê tông ', N'Làm nước đá ', N'Hàn chì', N'B', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (252, N'Trong các hiện tượng sau đây, hiện tượng nào không lieenq uan đến sự nóng chảy, đông đặc', N'Ngọn nến đang cháy ', N'Vào mùa xuân , băng tuyến tan ra ', N'Xi măng đông cứng lại', N'Làm kem', N'C', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (253, N'Trong các câu so sánh nhiệt độ nóng chảy và nhiệt độ đông đặc của nước dưới đây, câu nào đúng?', N'Nhiệt độ nóng chảy cao hơn nhiệt độ đông đặc ', N'Nhiệt độ nóng chảy thập hơn nhiệt độ đông đặc ', N'Nhiệt độ nóng chảy có thể cao hơn, cũng có thể thấp hơn nhiệt độ đông đặc ', N'Nhiệt độ nóng chảy bằng nhiệt độ đông đặc ', N'A', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (254, N'Hiện tượng vào mùa đông ở các nước vùng băng tuyết thường xảy ra sự cố vỡ đường ống nước là do:', N'tuyết rơi nhiều đè nặng thành ống.', N'thể tích nước khi đông đặc tăng lên gây ra áp lực lớn lên thành ống.', N'trời lạnh làm đường ống bị cứng dòn và rạn nứt.', N'các phương án đưa ra đều sai.', N'A', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (255, N'Phát biểu nào sau đây là sai khi nói về sự nóng chảy và sự đông đặc?', N'Các chất khác nhau sẽ nóng chảy (hay đông đặc) ở nhiệt độ khác nhau.', N'Đối với một chất nhất định, nếu nóng chảy ở nhiệt độ nào thì sẽ đông đặc ở nhiệt độ ấy.', N'Nhiệt độ của vật sẽ tăng dần trong quá trình nóng chảy và giảm dần trong quá trình đông đặc.', N'Phần lớn các chất nóng chảy (hay đông đặc) ở một nhiệt độ nhất định.', N'C', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (256, N'Trong các hiện tượng sau đây, hiện tượng nào không liên quan đến sự đông đặc?', N'Tuyết rơi', N'Đúc tượng đồng', N'Làm đá trong tủ lạnh', N'Rèn thép trong lò rèn', N'D', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (257, N'Trong các câu so sánh nhiệt độ nóng chảy và nhiệt độ đông đặc của nước dưới đây, câu nào đúng?', N'Nhiệt độ nóng chảy cao hơn nhiệt độ đông đặc.', N'Nhiệt độ nóng chảy thấp hơn nhiệt độ đông đặc.', N'Nhiệt độ nóng chảy có thể cao hơn, cũng có thể thấp hơn nhiệt độ đông đặc.', N'Nhiệt độ nóng chảy bằng nhiệt độ đông đặc.', N'D', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (258, N'Nhiệt độ đông đảo của rượu là -117oC, của thủy ngân là -38,83oC . Ở nước lạnh người ta dùng nhiệt kế rượu hay nhiệt kế thủy ngân? Vì sao?', N'Dùng nhiệt kế thủy ngân vì nhiệt kế thủy ngân rất chính xác.', N'Dùng nhiệt kế thủy ngân vì nhiệt độ đông đặc của thủy ngân cao hơn nhiệt độ đông đặc của rượu.', N'Dùng nhiệt kế thủy ngân vì ở âm vài chục oC rượu bay hơi hết.', N'Dùng nhiệt kế rượu vì nhiệt kế rượu có thể đo nhiệt độ môi trường -50oC.', N'A', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (259, N'Khi đun nóng băng phiến, người ta thấy nhiệt độ của băng phiến tăng dần, khi tới 80oC nhiệt độ của băng phiến ngừng lại không tăng, mặc dù vẫn tiếp tục đun. Hỏi lúc đó băng phiến tồn tại ở thể nào?', N'Chỉ có ở thể hơi', N'Chỉ có ở thể rắn', N'Chỉ có ở thể lỏng', N'Chỉ có ở thể rắn và thể lỏng', N'C', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (260, N'Sự đông đặc là sự chuyển từ', N'thể rắn sang thể lỏng', N'thể lỏng sang thể hơi', N'thể lỏng sang thể rắn', N'thể hơi sang thể lỏng', N'D', 1, 116)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (261, N'Nhận định nào sau đây sai?', N'Nước bay hơi ở bất kì nhiệt độ nào ', N'TRong điều kiện đặc biệt nước có thể bay hơi ở cả trong lòng khối nước ', N'Trong thời gian bay hơi, nhiệt độ của nước có thể thay đổi', N'Nước trong bình đậy kín không bay hơi ', N'D', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (262, N'Nước đựng trong cốc bay hơi càng nhanh khi ', N'Nước trong cốc càng nhiều ', N'Nước trong cốc càng ít ', N'Nước trong cốc càng nóng ', N'Nước trong cốc càng lạnh', N'C', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (263, N'Về mùa đông ở các xứ lạnh ta thấy người đi thường thở ra “khói” là do:', N'Hơi thở của người có nhiều hơi nước, khi ra ngoài không khí lạnh bị bay hơi tạo thành khói.', N'Hơi thở của người có chứa nhiều hơi nước, khi ra ngoài không khí lạnh bị ngưng tụ thành các hạt nhỏ li ti tạo thành khói.', N'Hơi thở của người có chứa nhiều hơi nước, khi ra ngoài không khí lạnh bị đông đặc thành đá tạo thành khói.', N'Tất cả đều sai.', N'B', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (264, N'Trong các trường hợp phơi quần áo sau đây, trường hợp nào quần áo lâu khô nhất?', N'Có gió, quần áo căng ra.', N'Không có gió, quần áo căng ra.', N'Quần áo không căng ra, không có gió.', N'Quần áo không căng ra, có gió.', N'C', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (265, N'Làm thí nghiệm như thế nào để chứng minh trong hơi thở của chúng ta có nhiều hơi nước?', N'Hà hơi thở vào lòng bàn tay.', N'Hà hơi thở vào vung nồi đang đun trên bếp.', N'Hà hơi thở vào gương soi hoặc kính.', N'Hà hơi thở vào một tờ giấy trắng.', N'C', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (266, N'Tốc độ bay hơi của nước trong một cốc hình trụ càng lớn khi:', N'Nước trong cốc càng nhiều', N'Nước trong cốc càng ít', N'Cốc được đặt trong nhà', N'Cốc được đặt ngoài sân nắng', N'D', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (267, N'Trong các đặc điểm sau đây, đặc điểm nào không phải là sự bay hơi?', N'Xảy ra ở bất kì nhiệt độ nào của chất lỏng.', N'Xảy ra trên mặt thoáng của chất lỏng.', N'Không nhìn thấy được.', N'Xảy ra ở một nhiệt độ xác định của chất lỏng.', N'D', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (268, N'Chọn phát biểu đúng về định nghĩa của sự bay hơi?', N'Sự chuyển từ thể rắn sang thể hơi gọi là sự bay hơi.', N'Sự chuyển từ thể hơi sang thể rắn gọi là sự bay hơi.', N'Sự chuyển từ thể lỏng sang thể hơi gọi là sự bay hơi.', N'Sự chuyển từ thể hơi sang thể lỏng gọi là sự bay hơi.', N'C', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (269, N'Tốc độ bay hơi phụ thuộc vào yếu tố nào?', N'Nhiệt độ.', N'Tác động của gió.', N'Diện tích mặt thoáng của chất lỏng.', N'Cả ba đáp án A, B và C.', N'D', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (270, N'Trong các hiện tượng sau đây, hiện tượng nào không phải là sự bay hơi?', N'Quần áo sau khi giặt được phơi khô.', N'Lau ướt bảng, một lúc sau bảng sẽ khô.', N'Mực khô sau khi viết.', N'Sự tạo thành giọt nước đọng trên lá cây.', N'D', 1, 117)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (271, N'Mây được tạo thành từ', N'nước bay hơi', N'khói', N'nước đông đặc', N'hơi nước ngưng tụ', N'D', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (272, N'Tại sao khi cầm vào vỏ bình ga mini đang sử dụng ta thường thấy có một lớp nước rất mỏng trên đó?', N'Do hơi nước từ tay ta bốc ra.', N'Nước từ trong bình ga thấm ra.', N'Do vỏ bình ga lạnh hơn nhiệt độ môi trường nên hơi nước trong không khí ngưng tụ trên đó.', N'Cả B và C đều đúng.', N'C', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (273, N'Khi trời lạnh, ô tô có bật điều hòa và đóng kín cửa, hành khách ngồi trên ô tô thấy hiện tượng gì?', N'Nước bốc hơi trên xe.', N'Hơi nước ngưng tụ tạo thành giọt nước phía trong kính xe.', N'Hơi nước ngưng tụ tạo thành giọt nước phía ngoài kính xe.', N'Không có hiện tượng gì', N'B', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (274, N'Vào những hôm trời nồm, hơi nước có rất nhiều trong không khí. Quan sát trên những nền nhà lát đá hoặc gạch men ta thấy hiện tượng gì?', N'Nước bốc hơi bay lên', N'Hơi nước ngưng tụ ướt nền nhà', N'Nước đông đặc tạo thành đá', N'Không có hiện tượng gì', N'B', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (275, N'Vòng tuần hoàn của nước trong thiên nhiên gồm hiện tượng vật lý nào?', N'Bay hơi', N'Ngưng tụ', N'Bay hơi và ngưng tụ', N'Cả A, B, C đều sai', N'C', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (276, N'Sự ngưng tụ là sự chuyển từ', N'thể rắn sang thể lỏng', N'thể lỏng sang thể rắn', N'thể hơi sang thể lỏng', N'thể lỏng sang thể hơi', N'C', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (277, N'Bên ngoài thành cốc đựng nước đá có nước vì:', N'Nước trong cốc có thể thấm ra ngoài.', N'Hơi nước trong không khí ngưng tụ gặp lạnh tạo thành nước.', N'Nước trong cốc bay hơi ra bên ngoài.', N'Nước trong không khí tụ trên thành cốc.', N'D', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (278, N'Trường hợp nào sau đây liên quan đến sự ngưng tụ?', N'Khói tỏa ra từ vòi ấm đun nước', N'Nước trong cốc cạn dần', N'Phơi quần áo cho khô', N'Sự tạo thành nước', N'A', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (279, N'Hiện tượng nào sau đây không phải là sự ngưng tụ?', N'Hơi nước trong các đám mây sau một thời gian sẽ tạo thành mưa.', N'Khi hà hơi vào mặt kính cửa sổ sẽ xuất hiện những hạt nước nhỏ làm mờ kính.', N'Sự tạo thành giọt nước đọng trên lá cây vào ban đêm.', N'Nước mưa trên đường nhựa biến mất khi Mặt Trời lại xuất hiện sau cơn mưa.', N'D', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (280, N'Khi nấu cơm ta mở nắp vung ra thì thấy bên trong nắp có các giọt nước bám vào là do:', N'hơi nước trong nồi ngưng tụ.', N'hạt gạo bị nóng chảy.', N'hơi nước bên ngoài nồi ngưng tụ.', N'hơi nước bên ngoài nồi đông đặc.', N'A', 1, 118)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (281, N'Tính chất nào sau đây không phải là tính chất của sự sôi ', N'Sự sôi xảy ra ở cùng một nhiệt độ xác định đối với mọi chất lỏng ', N'Khi đnag sôi thì nhiệt độ chất lỏng không thay đổi ', N'Khi sôi có sự chuyển thể từ lòng sang hơi ', N'Khi sôi có sự bay hơi ở trong lòng chất lỏng', N'A', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (282, N'Sự sôi có đặc điểm nào dưới đây?', N'Xảy ra ở bất kì nhiệt độ nào ', N'Nhiệt độ không đổi trong thời gian sôi ', N'Chỉ xảy ra ở mặt thoáng của chất lỏng ', N'Có sự chuyển từ thể lỏng snag thể rắn ', N'B', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (283, N'Kết luận nào sau đây là đúng khi nói về sự phụ thuộc nhiệt độ sôi của chất lỏng vào độ cao so với mặt nước biển?', N'Càng lên cao nhiệt độ sôicàng giảm.', N'Càng lên cao nhiệt độ sôi càng cao.', N'Nhiệt độ sôi không phụ thuộc vào độ cao.', N'Cả ba kết luận trên đều sai.', N'A', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (284, N'Nhiệt độ sôi', N'không đổi trong suốt thời gian sôi.', N'luôn thay đổi trong suốt thời gian sôi.', N'luôn tăng trong thời gian sôi.', N'luôn giảm trong thời gian sôi.', N'A', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (285, N'Nhiệt độ sôi của chất lỏng phụ thuộc vào yếu tố nào sau đây?', N'Áp suất trên mặt thoáng của chất lỏng.', N'Diện tích mặt thoáng của chất lỏng.', N'Gió.', N'Khối lượng chất lỏng.', N'A', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (286, N'Hãy chọn nhận xét đúng nhất về nhiệt độ sôi.Ở nhiệt độ sôi thì', N'các bọt khí xuất hiện ở đáy bình.', N'các bọt khí nổi lên nhiều hơn, càng đi lên càng to ra, khi đến mặt thoáng chất lỏng thì vỡ tung.', N'nước reo.', N'các bọt khí nổi dần lên.', N'B', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (287, N'Trong suốt thời gian sôi, nhiệt độ của chất lỏng', N'tăng dần lên', N'giảm dần đi', N'khi tăng khi giảm', N'không thay đổi', N'D', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (288, N'Chọn từ thích hợp điền vào chỗ trống. Trong suốt thời gian sôi, nước vừa…. vào các bọt khí vừa…… trên mặt thoáng.', N'ngưng tụ', N'Hòa tan', N'bay hơi', N'kết tinh', N'C', 1, 119)
GO
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (289, N'Tại sao để đo nhiệt độ của hơi nước sôi, người ta phải dùng nhiệt kế thủy ngân?', N'Nhiệt độ sôi của thuỷ ngân cao hơn nhiệt độ sôi của nước.', N'Nhiệt độ sôi của thuỷ ngân thấp hơn nhiệt độ sôi của nước.', N'Vì nhiệt kế thuỷ ngân dùng tốt hơn nhiệt kế rượu và nhiệt kế y tế.', N'Vì nhiệt độ nóng chảy của thủy ngân thấp, khoảng -39oC', N'A', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (290, N'Trong các phát biểu sau, phát biểu nào không đúng khi nói về sự sôi?', N'Nước sôi ở nhiệt độ 100oC. Nhiệt độ này gọi là nhiệt độ sôi của nước.', N'Trong suốt thời gian sôi, nhiệt độ của nước không thay đổi..', N'Trong suốt thời gian sôi, nhiệt độ của nước tăng dần.', N'Sự sôi là một sự bay hơi đặc biệt. Trong suốt thời gian sôi, nước vừa bay hơi tạo ra các bọt khí vừa bay hơi trên mặt thoáng.', N'C', 1, 119)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (291, N'Khi lau bảng bằng khăn ướt thì chỉ một lát sau là bảng khô vì:', N'Sơn trên bảng hút nước.', N'Nước trên bảng chảy xuống đất.', N'Nước trên bảng bay hơi vào không khí.', N'Gỗ làm bảng hút nước.', N'C', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (292, N'Nguyên tắc cấu tạo và hoạt động của nhiệt kế dùng chất lỏng dựa trên hiện tượng:', N'Dãn nở vì nhiệt của chất lỏng', N'Dãn nở vì nhiệt của chất rắn', N'Dãn nở vì nhiệt của chất khí', N'Dãn nở vì nhiệt của các chất', N'A', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (293, N'Khi trồng chuối hoặc mía người ta thường phạt bớt lá để', N'Dễ cho việc đi lại chăm sóc cây.', N'Hạn chế lượng dinh dưỡng cung cấp cho cây.', N'Giảm bớt sự bay hơi làm cây đỡ bị mất nước hơn.', N'Đỡ tốn diện tích đất trồng.', N'C', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (294, N'Chọn câu đúng.', N'Khi nhiệt độ giảm, trọng lượng riêng khối khí giảm.', N'Khi nhiệt độ tăng, trọng lượng riêng khối khí tăng.', N'Khi nhiệt độ tăng hoặc giảm, trọng lượng riêng khối khí không thay đổi.', N'Khi nhiệt độ tăng, trọng lượng riêng khối khí giảm.', N'D', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (295, N'Nhiệt độ 50oC tương ứng với bao nhiêu độ Farenhai?', N'82oF', N'90oF', N'122oF', N'107,6oF', N'C', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (296, N'Sự sôi có đặc điểm nào dưới đây?', N'Xảy ra ở bất kì nhiệt độ nào.', N'Nhiệt độ không đổi trong thời gian sôi.', N'Chỉ xảy ra ở mặt thoáng của chất lỏng.', N'Có sự chuyển từ thể lỏng sang thể rắn.', N'B', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (297, N'Các nha sĩ khuyên không nên ăn thức ăn quá nóng. Vì sao?', N'Vì răng dễ bị sâu', N'Vì răng dễ bị rụng', N'Vì răng dễ bị vỡ', N'Vì men răng dễ bị rạn nứt', N'D', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (298, N'Khi đặt bình cầu đựng nước vào nước nóng người ta thấy mực chất lỏng trong ống thủy tinh mới đầu tụt xuống một ít, sau đó mới dâng lên cao hơn mức ban đầu. Điều đó chứng tỏ:', N'thể tích của nước tăng nhiều hơn thể tích của bình.', N'thể tích của nước tăng ít hơn thể tích của bình.', N'thể tích của nước tăng, của bình không tăng.', N'thể tích của bình tăng trước, của nước tăng sau và tăng nhiều hơn.', N'D', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (299, N'Những ngôi nhà mái lợp bằng tôn, khi đêm về và những lúc trời không có gió ta vẫn thỉnh thoảng nghe thấy những tiếng ken két phát ra từ mái tôn. Vì sao vậy?', N'Ban đêm, nhiệt độ giảm làm tôn co lại.', N'Ban đêm, không có tiếng ồn nên nghe được.', N'Ban đêm, nhiệt độ giảm làm tôn nở ra.', N'Các phương án đưa ra đều sai.', N'A', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (300, N'Kết luận nào sau đây là đúng khi nói về ứng dụng của băng kép?Băng kép được ứng dụng', N'làm các dây kim loại', N'làm giá đỡ', N'trong việc đóng ngắt mạch điện', N'làm cốt cho các trụ bê tông', N'C', 1, 120)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (302, N'Viết tập hợp các chữ cái trong từ QUY NHƠN.', N'M = {Q; U; Y; N; H; Ơ; N};', N'M= {Q; U; Y; N; H; O; N};', N'M = {Q; U; Y; N; H; O};', N'M = {Q; U; Y; N; H; Ơ};', N'D', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (303, N'Cho tập hợp K = {0; 5; 3; 4; 7}. Tập hợp K có bao nhiêu phần tử:', N'5                      ', N'8', N'3', N'2', N'A', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (304, N'Các cách để mô tả tập hợp là: ', N'Liệt kê các phần tử của tập hợp.', N'Nếu dấu hiệu đặc trưng cho các phần tử của tập hợp.', N'Minh họa bằng sơ đồ Venn', N'Cả A và  B', N'D', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (305, N'Bác Nam có một khu vườn trồng hoa quả. Trên khu vườn bác trồng cam, quýt, bơ, chuối và dứGọi E là tập hợp các cây mà bác Nam trồng trên khu vườn đó. Hãy viết E bằng cách liệt kê.', N'E = {cam; quýt; bơ};', N'E = {cam; quýt; bơ; dứa};', N'E = {cam; quýt; bơ; chuối; dứa};', N'E = {cam; quýt; bơ; chuối; dừa}.', N'C', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (306, N'Tập hợp Ν* là:', N'tập hợp số tự nhiên.', N'tập hợp các số tự nhiên chẵn.', N'tập hợp các số tự nhiên lẻ.', N'tập hợp có số tự nhiên khác 0.', N'D', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (307, N'Phát biểu sai.', N'Tập hợp N = {0;1;2;3;4;5;...}', N'7 ∈ Ν*', N'Tập hợp Ν* = {1;2;3;4;5;...}.', N'0 ∈ Ν*', N'D', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (308, N'Gọi X là tập hợp các chữ cái trong từ “thanh”. Cách viết đúng là:', N'X = {t; h; a; n; h}.', N'X = {t; h; n};', N'X= {t; h; a; n}.', N'X = {t; h; a; n; m}.', N'C', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (309, N'Gọi X là tập hợp các số tự nhiên không lớn hơn 5. Cách viết sai là:', N'X = {0; 1; 2; 3; 4; 5}.', N'X = {0; 2; 4; 1; 3; 6}.', N'X= {x ?N | x %lt; 5}.', N'X = {x ?N | x ? 5}.', N'C', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (310, N'Cho tập hợp U = { x ∈ Ν* |x là số lẻ}. Trong các số 3; 5; 6; 0; 7; 9 có bao nhiêu số không thuộc tập hợp U?', N'0;', N'2;', N'3;', N'4.', N'D', 1, 121)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (311, N'Cho phép chia 125: 25 = 5. Trong phép tính này thì 5 là:', N'Số bị chia;', N'Số chia;', N'Thương;', N'Số dư.', N'C', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (312, N'Phép nhân có tính chất:', N'Giao hoán', N'Kết hợp', N'Phân phối giữa phép nhân và phép cộng', N'Cả A, B và C đều đúng.', N'D', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (313, N'Với hai số tự nhiên a và b ( b khác 0) Tồn tại số tự nhiên q sao cho a = q. Khi đó phát biểu nào sau đây là đúng:', N'a chia hết cho ', N'b chia hết cho ', N'a chia cho b dư r.', N'b chia cho a dư r.', N'A', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (314, N'Với hai số tự nhiên a và b (b khác 0) ta luôn tìm được hai số q, r sao cho a = q + r, điều kiện của r là:', N'r < b;', N'0 < r < b;', N'0 ≤ r < b;', N'r ≥ 0;', N'C', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (315, N'Phát biểu nào sau đây là sai?', N'1 = 1.a = a;', N'0 = 0.a = a;', N'(ab)c = a(bc) = abc;', N'a(b + c) = ab + ac', N'B', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (316, N'Tính nhẩm 125.100', N'12 500;', N'1 250;', N'12 000;', N'12 050.', N'A', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (317, N'Tích b bằng:', N'a + a + … + a (a số hạng).', N'a + a + … + a (b số hạng).', N'a… a (b thừa số a).', N'a…a (a thừa số a).', N'B', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (318, N'Một trường Trung học cơ sở có 45 phòng học, mỗi phòng có 12 bộ bàn ghế, mỗi bộ bàn ghế có thể xếp cho 4 học sinh ngồi. Trường có thể nhận nhiều nhất bao nhiêu học sinh?', N'540 học sinh.', N'180 học sinh.', N'2 060 học sinh.', N'2 160 học sinh', N'D', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (319, N'Một trường học có 35 lớp học mỗi lớp có 20 bộ bàn ghế. Hỏi trường học đó có bao nhiêu bàn ghế.', N'70 bộ.', N'600 bộ.', N'700 bộ.', N'500 bộ.', N'C', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (320, N'Tính nhẩm: 125. 8 723.8', N'872 300', N'8 723 000', N'87 230 000', N'8 723.', N'B', 1, 122)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (321, N'Số nào trong các số sau là số nguyên tố?', N'3', N'8', N'12', N'15', N'A', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (322, N'Trong các số sau: 16; 17; 20; 21; 23; 97. Có bao nhiêu số là hợp số?', N'0;                   ', N'1', N'2', N'3', N'D', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (323, N'Hoàn thành phát biểu sau: “Số nguyên tố là số tự nhiên lớn hơn 1, chỉ có …”:', N'ước là 1.', N'ước là chính nó.', N'duy nhất một ước', N'hai ước là 1 và chính nó.', N'D', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (324, N'Cho A là tập hợp các số nguyên tố nhỏ hơn 30. đáp án đúng.', N'1 ∈ A;', N'2 ∉ A;', N'29 ∉ A;', N'17 ∈ A', N'D', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (325, N'Phân tích một số ra thừa số nguyên tố là:', N'phân tích số đó thành tích của số nguyên tố với các hợp số.', N'phân tích số đó thành tích của các số tự nhiên.', N'Phân tích số đó thành tích của các thừa số nguyên tố.', N'Phân tích số đó thành tích của hai thừa số nguyên tố.', N'D', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (326, N'Có bao nhiêu cách để phân tích một số ra thừa số nguyên tố?', N'1', N'2', N'3', N'4', N'B', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (327, N'Có bao nhiêu khẳng định đúng trong các khẳng định sau? a) Ước nguyên tố của 18 là 1; 2; và 3. b) Tích của hai số nguyên tố bất kì luôn là số lẻ. c) Mọi số chẵn đều là hợp số.', N'0', N'1', N'2', N'3', N'A', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (328, N'Tìm chữ số a để 49a là số nguyên tố:', N'1', N'9', N'A và B đều đúng;        ', N'cả A và B đều sai.', N'D', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (329, N'Phân tích 70 ra thừa số nguyên tố ta được: 70 = 2x.5y.7z. Tổng x + y + z = ?', N'3', N'4', N'5', N'6', N'A', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (330, N'Bạn Nam phân tích số 120 ra thừa số nguyên tố như sau: 120 = 23.3.5. Bạn An phân tích 105 ra thừa số nguyên tố như sau: 105 = 3.5.7. đáp án đúng.', N'Bạn Nam; ', N'Bạn An;', N'Cả Nam và An đều sai.', N'Cả Nam và An đều đúng.', N'D', 1, 123)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (331, N'Cho hai số tự nhiên a và b (b ≠ 0). Nếu có số tự nhiên k sao cho a = kb thì:', N'a chia hết cho k', N'b chia hết cho k', N'A và B đều đúng.', N'A và B đều sai.', N'A', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (332, N'Nếu a chia hết cho b, ta nói …:', N'b là ước của a', N'a là bội của b', N'A và B đều đúng.', N'A và B đều sai.', N'C', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (333, N'Tìm tập hợp M là ước của 24.', N'M = {1; 2; 3; 4; 8; 12; 24}.', N'M = {1; 2; 3; 4; 6; 8; 24}.', N'M = {1; 2; 4; 6; 8; 12; 24}.', N'M = {1; 2; 3; 4; 6; 8; 12; 24}.', N'D', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (334, N'Nếu tất cả các số hạng của một tổng đều chia hết cho cùng một số thì tổng đó:', N'Chia hết cho số đó.', N'Không chia hết cho số đó.', N'Là ước của số đó.', N'Không kết luận đượ', N'A', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (335, N'Không làm phép tính hãy cho biết tổng nào sau đây chia hết cho 5?', N'80 + 1945 + 15.', N'1930 + 100 + 21.', N'34 + 105 + 20.', N'1025 + 2125 + 46.', N'A', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (336, N'Nếu một tổng có ba số hạng, trong đó có 2 số hạng chia hết cho 7 và số hạng còn lại không chia hết cho 7 thì tổng đó:', N'chia hết cho 7.', N'không chia hết cho 7.', N'Không kết luận đượ', N'Chia hết cho ước của 7.', N'B', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (337, N'Trong các số: 16; 24; 35; 68. Số nào không là bội của 4? ', N'16.', N'24.', N'35.', N'68.', N'C', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (338, N'Phát biểu dưới đây là sai?', N'6 là ước của 12.', N'35 + 14 chia hết cho 7.', N'121 là bội của 12.', N'219.26 + 13 chia hết cho 13.', N'C', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (339, N'Hãy tìm tất cả các ước nhỏ hơn hoặc bằng 10 của 30.', N'1; 2; 3; 5; 10.', N'1; 3; 5; 6; 10.', N'1; 2; 5; 6; 10.', N'1; 2; 3; 5; 6; 10.', N'D', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (340, N'Hãy tìm tất cả các bội nhỏ hơn hoặc bằng 12 của 3.', N'1; 2; 3; 5; 10.', N'0; 3; 6; 9; 12.', N'1; 2; 5; 6; 10.', N'1; 2; 3; 5; 6; 10.', N'B', 1, 124)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (341, N'Thực hiện các phép tính sau: (-99) + (-11)', N'– 88', N'-100', N'-110', N'-99', N'C', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (342, N'Trong các phát biểu sau, có bao nhiêu phát biểu đúng, bao nhiêu phát biểu nào sai? a) Tổng của một số nguyên âm và một số nguyên dương là một số nguyên âm. b) Tổng của một số nguyên dương và một số nguyên âm là một số nguyên dương. c) Hai số đối nhau có tổng bằng 0.', N'1 phát biểu đúng, 2 phát biểu sai', N'2 phát biểu đúng, 1 phát biểu sai', N'Cả 3 phát biểu đều đúng', N'Cả 3 phát biểu đều sai', N'A', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (343, N'Trên trục số, một người bắt đầu từ điểm 0 di chuyển về bên phải (theo chiều dương) 4 đơn vị đến điểm +4. Sau đó, người đó đổi hướng di chuyển về bên trái 4 đơn vị. Hãy cho biết người đó dừng lại tại điểm nào?  So sánh kết quả hai biểu thức sau: A = – (12 – 25) và B = (-12 + 25); ', N'A > B', N'A < B ', N'A = B', N'A < B < 0', N'C', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (344, N'Thẻ tín dụng trả sau của bác Tám đang ghi nợ 2 000 000 đồng, sau khi bác Tám nộp vào 2 000 000 đồng thì bác Tám có bao nhiêu tiền trong tài khoản? Hãy dùng số nguyên để giải thích.', N'– 2 000 000 đồng', N'2 000 000 đồng', N'0 đồng', N'4 000 000 đồng', N'C', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (345, N'Tính nhanh các tổng sau: S = (45 – 3 756) + 3 756; ', N'45', N'7 467', N'3756', N'– 3 711', N'A', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (346, N'Mũi khoan một giàn khoan trên biển đang ở độ cao 5m so với mực nước biển, chú công nhân điều khiển nó hạ xuống 10m. Vậy mũi khoan ở độ cao nào (so với mực nước biển) sau khi hạ?', N'10m', N'-10m', N'5m', N'-5m', N'A', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (347, N'Thực hiện các phép tính sau: 4 + (-7) + (-5) + 12;  ', N'- 20', N'4   ', N'-4', N'- 28        ', N'B', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (348, N'Một tòa nhà có tám tầng được đánh số theo thứ tự 0 (tầng mặt đất), 1, 2, 3, ..., 7 và ba tầng hầm được đánh số -1; -2; -3. Em hãy dùng phép cộng các số nguyên để diễn tả hai tình huống sau đây: Một thang máy đang ở tầng – 3, nó đi lên 5 tầng. Hỏi thang máy dừng lại ở tầng mấy? (Ở một số tòa nhà, tầng mặt đất còn được gọi là tầng G).', N'Tầng G', N'Tầng 1', N'Tầng 2', N'Tầng 3', N'C', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (349, N'Bỏ dấu ngoặc rồi tính: (77 + 22 – 65) - (67 +  12 - 75); ', N'10', N'20', N'30', N'40', N'C', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (350, N'Trong các biểu thức dưới đây, giá trị của biểu thức nào là lớn nhất : M = [(-3) + 4] + 2;          N = (-3) + (4 + 2);           P = [(-3) + 2] + 4.', N'M', N'N', N'P', N'Không có giá trị biểu thức nào lớn nhất', N'D', 1, 125)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (351, N'Tích của hai số nguyên âm là số thế nào?', N'là số nguyên âm', N'là số nguyên dương', N'là số 0', N'vừa là số nguyên âm vừa là số nguyên dương.', N'B', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (352, N'Thực hiện phép tính sau: (-5).4', N'– 20', N'20', N'10', N'-10                   ', N'A', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (353, N'Phép nhân có tính chất gì:', N'Tính chất giao hoán', N'Tính chất kết hợp', N'Tính chất phân phối của phép nhân với phép cộng', N'Cả ba tính chất trên', N'D', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (354, N'Tích của một số nguyên a bất kì với số 0 có kết quả là:', N'a', N'1', N'0', N'a2', N'C', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (355, N'Tích của các số nguyên âm có số thừa số là số lẻ thì:', N'là số lẻ', N'là số chẵn', N'là số dương', N'là số âm', N'D', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (356, N'Tích của các số nguyên âm có số thừa số là số chẵn thì:', N'là số lẻ', N'là số chẵn', N'là số dương', N'là số âm', N'C', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (357, N'Cho tích 213.3 = 639. Từ đó suy ra nhanh kết quả của các tích sau: (- 213).3; ', N'-639', N'639', N'1 278', N'-1 278', N'A', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (358, N'Một xí nghiệp may gia công có chế độ thưởng và phạt như sau: Một sản phẩm tốt được thưởng 50 000 đồng, một sản phẩm có lỗi bị phạt 40 000 đồng. Chị Mai làm được 20 sản phẩm tốt và 4 sản phẩm bị lỗi. Chị Mai nhận được bao nhiêu tiền?', N'84 000 đồng', N'1 000 000 đồng', N'-160 000 đồng', N'840 000 đồng', N'D', 0, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (359, N'Tính tổng hai tích sau: a = (-2).(-3) và c = (+3).(+2);      ', N'a + c = 6', N'a + c = 12', N'a + c = -12', N'a + c = -6 ', N'B', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (360, N'P là tích của 8 số nguyên khác 0 trong đó có đúng 4 số dương. Q là tích của 6 số nguyên khác 0 trong đó có duy nhất một số dương. Hãy cho biết P và Q là số dương hay số âm. ', N'P dương, Q âm', N'P âm, Q dương', N'P, Q đều âm', N'P, Q đều dương', N'A', 1, 126)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (361, N'Tích của hai số nguyên âm là số thế nào?', N'là số nguyên âm', N'là số nguyên dương', N'là số 0', N'vừa là số nguyên âm vừa là số nguyên dương.', N'B', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (362, N'Thực hiện phép tính sau: (-5).4', N'– 20', N'20', N'10', N'-10                   ', N'A', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (363, N'Phép nhân có tính chất gì:', N'Tính chất giao hoán', N'Tính chất kết hợp', N'Tính chất phân phối của phép nhân với phép cộng', N'Cả ba tính chất trên', N'D', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (364, N'Tích của một số nguyên a bất kì với số 0 có kết quả là:', N'a', N'1', N'0', N'a2', N'C', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (365, N'Tích của các số nguyên âm có số thừa số là số lẻ thì:', N'là số lẻ', N'là số chẵn', N'là số dương', N'là số âm', N'D', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (366, N'Tích của các số nguyên âm có số thừa số là số chẵn thì:', N'là số lẻ', N'là số chẵn', N'là số dương', N'là số âm', N'C', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (367, N'Cho tích 213.3 = 639. Từ đó suy ra nhanh kết quả của các tích sau: (- 213).3; ', N'-639', N'639', N'1 278', N'-1 278', N'A', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (369, N'Tính tổng hai tích sau: a = (-2).(-3) và c = (+3).(+2);      ', N'a + c = 6', N'a + c = 12', N'a + c = -12', N'a + c = -6', N'B', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (370, N'P là tích của 8 số nguyên khác 0 trong đó có đúng 4 số dương. Q là tích của 6 số nguyên khác 0 trong đó có duy nhất một số dương. Hãy cho biết P và Q là số dương hay số âm. ', N'P dương, Q âm', N'P âm, Q dương', N'P, Q đều âm', N'P, Q đều dương', N'A', 1, 127)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (371, N'Diện tích hình bình hành có chiều dài một cạnh 20 cm và chiều cao tương ứng 5 cm là:', N'50 cm2', N'100 cm2', N'10 cm2', N'5 cm2', N'B', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (372, N'Diện tích của một hình thoi là 100 m2 và một đường chéo dài 20 dm. Độ dài đường chéo còn lại là:', N'50 dm', N'25 m', N'50 m', N'5 dm', N'B', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (373, N'Hình chữ nhật có chu vi bằng 28 cm. Tính diện tích của hình chữ nhật đó biết chiều dài hơn chiều rộng 6cm.', N'24 cm2', N'187 cm2', N'66 cm2', N'40 cm2', N'D', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (374, N'Hình thang cân có độ dài hai cạnh đáy là 5 m và 3,2 m; chiều cao là 4 m. Diện tích của hình thang cân này là:', N'8,2 m2', N'4,1 m2', N'16,4 m2', N'14,8 m2', N'C', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (375, N'Chu vi hình thoi có cạnh 5dm là:', N'20 cm', N'200 dm', N'25 dm', N'200 cm', N'D', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (376, N'Một mảnh giấy hình chữ nhật có chiều dài 12cm và diện tích mảnh giấy hình chữ nhật là 96 cm2. Tính chu vi mảnh vườn hình chữ nhật:', N'8 cm', N'30 cm ', N'40 cm', N'60 cm', N'C', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (377, N'Một hình thang cân có diện tích 200 m2 và chiều cao là 10m. Tính tổng độ dài hai đáy của hình thang cân:', N'40 m', N'20 m', N'10 m', N'2 m', N'A', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (378, N'Bác An muốn làm hàng rào cho khu vườn hình vuông trồng hoa hồng của mình. Biết khu vườn có cạnh 5m, tính độ dài hàng rào?', N'25m', N'20m', N'10m', N'5m', N'B', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (379, N'Cho hình thang cân có tổng hai đáy bằng 18 dm và chu vi hình thang cân 340 cm. Độ dài cạnh bên của hình thang cân là:', N'16dm', N'8 dm', N'16cm', N'8cm', N'B', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (380, N'Hình vuông có diện tích 64 m2. Độ dài cạnh hình vuông là: ', N'16 m', N'36 cm', N'8 m', N'8 cm', N'C', 1, 128)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (381, N'Hình nào dưới đây có vô số trục đối xứng', N'Hình lục giác đều', N'Hình vuông', N'Hình chữ nhật', N'Hình tròn', N'D', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (382, N'Hình vuông có bao nhiêu trục đối xứng:', N'2', N'3', N'4', N'0', N'C', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (383, N'Phát biểu nào dưới đây là đúng?', N'Mỗi đường chéo là một trục đối xứng của hình chữ nhật.', N'Mỗi đường thẳng đi qua tâm một đường tròn là trục đối xứng của hình tròn.', N'Mỗi đường thẳng đi qua trung điểm của hai cạnh đối diện là trục đối xứng của hình thoi.', N'Mỗi đường chéo là một trục đối xứng của hình bình hành.', N'B', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (384, N'Cho các phát biểu sau: a) Hình vuông ABCD chỉ có hai trục đối xứng là hai đường chéo AC, B b) Đường thẳng đi qua trung điểm của đoạn thẳng MN và vuông góc với MN là trục đối xứng của đoạn thẳng MN. c) Nếu đường thẳng d là trục đối xứng của đường tròn thì d đi qua tâm của đường tròn ấy. Số phát biểu đúng là:', N'0', N'1', N'2', N'3', N'C', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (385, N'Trong các câu sau, câu nào đúng?', N'Tam giác đều có 6 trục đối xứng', N'Hình chữ nhật với hai kích thước khác nhau có 4 trục đối xứng', N'Hình thang cân, góc ở đáy khác 900, có đúng một trục đối xứngHình bình hành có hai trục đối xứng.', N'Hình bình hành có hai trục đối xứng.', N'D', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (386, N'Trong các câu sau, câu nào sai?', N'Hình vuông có 4 trục đối xứng.', N'Hình thoi, các góc khác 900 có đúng hai trục đối xứng.', N'Hình lục giác đều có đúng 3 trục đối xứng.', N'Hình chữ nhật có hai kích thước khác nhau có đúng hai trục đối xứng.', N'C', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (387, N'Trong các phát biểu sau, có bao nhiêu phát biểu đúng?a) Số trục đối xứng của tam giác đều nhỏ hơn số trục đối xứng của hình thoi.  b) Hình tròn có một trục đối xứng là đường thẳng đi qua tâm của hình tròn. c) Hình thang cân có tâm đối xứng là giao điểm của hai đường chéo. d) Hình chữ nhật có hai trục đối xứng là hai đường chéo.', N'0', N'2', N'3', N'4', N'A', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (388, N'Trong các câu sau, câu nào sai?', N'Hình lục giác đều có 6 tâm đối xứng.', N'Hình tròn có một tâm đối xứng là tâm của đường tròn', N'Hình bình hành có tâm đối xứng là giao điểm của hai đường chéo', N'Hình thang cân không có tâm đối xứng.', N'A', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (389, N'Trong các chữ cái dưới đây, chữ cái có trục đối xứng?', N'A, H, E', N'A, H', N'A, B, H, E', N'B, E', N'C', 1, 129)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (390, N'Chữ cái nào dưới đây có hai trục đối xứng:', N'Chữ A', N'Chữ B', N'Chữ H', N'Chữ M', N'C', 1, 129)
GO
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (391, N'Tâm đối xứng của hình tròn là:', N'Tâm của đường tròn', N'Một điểm bất kì nằm bên trong đường tròn', N'Một điểm bất kì nằm trên đường tròn', N'Một điểm bất kì nằm bên ngoài đường tròn.', N'A', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (392, N'Hình nào dưới đây không có tâm đối xứng', N'Hình bình hành', N'Hình thoi', N'Hình chữ nhật', N'Hình thang cân', N'D', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (393, N'Phát biểu nào dưới đây là đúng?', N'Hình thoi có tâm đối xứng nhưng không có trục đối xứng.', N'Hình thang cân có trục đối xứng, nhưng không có tâm đối xứng.', N'Hình bình hành vừa có tâm đối xứng, vừa có trục đối xứng.', N'Hình chữ nhật có trục đối xứng nhưng không có tâm đối xứng.', N'B', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (394, N'Trong các hình: Hình bình hành, hình chữ nhật, hình vuông, hình lục giác đều, hình thoi thì có bao nhiêu hình không có tâm đối xứng?', N'0', N'1', N'2', N'3', N'A', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (395, N'Khẳng định nào dưới đây là sai về tam giác đều?', N'Tam giác đều có ba trục đối xứng', N'Tam giác đều có tâm đối xứng là giao điểm của ba trục đối xứng', N'Tam giác đều không có tâm đối xứng', N'Tam giác đều có ba cạnh bằng nhau', N'B', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (396, N'Trong các số dưới đây, số nào có tâm đối xứng', N'4', N'0', N'6', N'9', N'B', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (397, N'Hình nào dưới đây không có tâm đối xứng', N'Lục giác đều', N'Tam giác đều', N'Hình bình hành', N'Hình thoi', N'B', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (398, N'Các phát biểu sau đúng hay sai? Có bao nhiêu phát biểu sai? a) Tam giác đều ABC là hình đối xứng tâm. b) Hình thang cân là hình có tâm đối xứng và giao điểm của hai đường chéo là tâm đối xứng. c) Hình thoi ABCD có tâm đối xứng là điểm O (O là giao điểm của hai đường chéo AC và BD).', N'0', N'1', N'2', N'3', N'C', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (399, N'Cho đoạn thẳng MN dài 18cm. Biết O là tâm đối xứng của MN. Tính ON', N'9cm', N'8cm', N'18cm', N'6cm', N'A', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (400, N'Câu 10 . Hình thoi ABCD có tâm đối xứng O. Biết OA = 3cm, OB = 2cm. Hãy tính diện tích hình thoi.', N'6 cm2', N'12 cm2', N'24 cm2', N'48 cm2', N'B', 1, 130)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (401, N'Phân số a/b là phân số tối giản khi ƯC(a; b) bằng', N'{1; -1}     ', N'{2}     ', N'{1; 2}     ', N'{1; 2; 3}', N'A', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (402, N'TÌm số a; b biết 2456=a7=−111b', N'a = 3, b = -259     ', N'a = -3, b = -259', N'a = 3, b = 259     ', N'a = -3, b = 259', N'C', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (403, N'Phân số nào dưới đây là phân số tối giản?', N'-2/4     ', N'-15/-96     ', N'13/27     ', N'-29/58', N'A', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (404, N'Nhân cả tử số và mẫu số của phân số 14/23 với số nào để được phân số 168/276', N'14     ', N'23     ', N'12     ', N'22', N'D', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (405, N'Viết một phân số mới bằng phân số 5/9 sao cho mẫu của phân số mới gấp 7 lần mẫu của phân số cũ', N'35/63', N'30/49', N'49/49', N'25/49', N'A', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (406, N'Viết một phân số mới bằng phân số 5/9 sao cho mẫu của phân số mới gấp 7 lần mẫu của phân số cũ', N'Nếu ta nhân cả tử và mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Nếu ta nhân tử cuả một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Nếu ta nhân mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Nếu ta nhân cả tử và mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới lớn phân số đã cho', N'A', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (407, N'đáp án đúng:', N'Nếu ta chia cả tử và mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Nếu ta chia tử cuả một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Nếu ta chia mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Nếu ta chia cả tử và mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới lớn phân số đã cho', N'A', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (408, N'câu sai :', N'Hai phân số a/b và c/d gọi là những phân số bằng nhau nếu d = c (tích chéo bằng nhau)', N'Nếu ta chia cả tử và mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Nếu ta nhân cả tử và mẫu cảu một phân số với cùng một sô nguyên khác 0 thì ta được một phân số mới bằng phân số đã cho', N'Số nguyên a cũng được viết dưới dạng phân số là a/a', N'D', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (409, N'Phân số nào dưới đây bằng với phân số -2/5 ?', N'4/10     ', N'-6/15     ', N'6/15     ', N'-4/-10', N'B', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (410, N'câu sai?', N'1/3 = 45/135     ', N'-13/20 = 26/-40', N'-4/15 = -16/-60     ', N'6/7 = -42/-49', N'C', 1, 131)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (411, N'Sau khi rút gọn tối giản phân số 4/16 ta được phân số:', N'2/8     ', N'4/8     ', N'1/4     ', N'1/8', N'C', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (412, N'Trong các phân số sau, phân số nào là phân số tối giản?', N'3/42     ', N'17/34     ', N'3/17     ', N'4/48', N'C', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (413, N'35 phút = ? (giờ) (viết dưới dạng phân số tối giản)', N'25/45     ', N'5/30     ', N'7/12     ', N'5/10', N'C', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (414, N'Rút gọn phân số 44\55', N'4/5', N'4/11', N'11/5', N'4/55', N'A', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (415, N'Rút gọn phân số: -72/81', N'8/9', N'-8/9', N'7/8', N'-7/8', N'B', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (416, N'Rút gọn phân số 24/36', N'12/18', N'6/9', N'2/3', N'1/3', N'C', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (417, N'20 phút =? giờ', N'1/3', N'2/3', N'1/2', N'1/4', N'A', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (418, N'30 phút =? giờ', N'1/2', N'3/4', N'1/4', N'3/5', N'A', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (419, N'Câu sai ', N'Phân số a/b là tối giản nếu |a| và |b| là hai nguyên tố cùng nhau.', N'Khi rút gọn một phân số, người ta thường rút gọn về phân số tối giản.', N'Để rút gọn một phân số có thể phân tích tử và mẫu thành tích các thừa số', N'Để rút gọn một phân số có thể phân tích tử và mẫu thành thương các thừa số', N'D', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (420, N'Câu sai ', N'Muốn rút gọn phân số , ta chia cả tử và mẫu của phân số đó cho một ước chung khác 1 và -1 của chúng .', N'Muốn rút gọn phân số , ta chia cả tử và mẫu của phân số đó cho một bội chung khác 0 của chúng .', N'Để rút gọn một phân số có thể phân tích tử và mẫu thành tích các thừa số', N'Phân số tối giản (hay phân số không rút gọn được nữa ) là phân số mà cả tử và mẫu chỉ có ước chung là 1 và -1.', N'B', 1, 132)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (421, N'Điền dấu thích hợp vào chỗ chấm: -5/13 ... 7/13', N'>     ', N' <      ', N'=', N'Tất cả các đáp án trên đều sai', N'B', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (422, N'Điền dấu thích hợp vào chỗ chấm -12/25 ... 17/-25', N' >     ', N'<     ', N'=     ', N'Tất cả các đáp án trên đều sai', N'A', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (423, N'đáp án đúng', N'Muốn so sánh hai phân số không cùng mẫu, ta viết chúng dưới dạng hai phân số có cùng một mẫu dương rồi so sánh các tử với nhau: phân số nào có tử lớn hơn thì lớn hơn', N'Muốn so sánh hai phân số không cùng mẫu, ta viết chúng dưới dạng hai phân số có cùng một mẫu âm rồi so sánh các tử với nhau: phân số nào có tử lớn hơn thì lớn hơn', N'Muốn so sánh hai phân số không cùng mẫu, ta viết chúng dưới dạng hai phân số có cùng một mẫu dương rồi so sánh các tử với nhau: phân số nào có tử nhỏ hơn thì lớn hơn', N'Muốn so sánh hai phân số , ta so sánh các tử với nhau: phân số nào có tử lớn hơn thì lớn hơn', N'A', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (424, N'đáp án đúng: ', N'Trong hai phân số có cùng một mẫu dương, phân số nào có tử lớn hơn thì lớn hơn', N'Trong hai phân số , phân số nào có tử lớn hơn thì lớn hơn', N'Trong hai phân số , phân số nào có tử nhỏ hơn thì lớn hơn', N'Trong hai phân số có cùng một mẫu dương, phân số nào có tử nhỏ hơn thì lớn hơn', N'A', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (425, N'đáp án đúng', N'Trong hai phân số có cùng một tử số, phân số nào có mẫu lớn hơn thì lớn hơn', N'Trong hai phân số có cùng một tử số, phân số nào có mẫu nhỏ hơn thì lớn hơn', N'Trong hai phân số , phân số nào có mẫu lớn hơn thì lớn hơn', N'Trong hai phân số , phân số nào có mẫu nhỏ hơn thì lớn hơn', N'A', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (426, N'So sánh hai phân số : 25 và 56', N'25 < 56', N'25 > 56', N'25 = 56', N'Không xác định', N'A', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (427, N'So sánh hai phân số : 137 và 1327', N'137 < 1327', N'137 > 1327', N'137 = 1327', N'Không xác định', N'A', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (428, N'đáp án đúng: Đâu không phải là cách so sánh phân số:', N'So sánh tử số khi các phân số chung mẫu số', N'So sánh mẫu số khi các phân số chung tử số', N'số thứ 3 làm trung gian ', N'So sánh tử số với tử số, mẫu số với mẫu số.', N'D', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (429, N'So sánh hai phân số 2/5 và 3/5', N'2/5 > 3/5', N'2/5 < 3/5 ', N'2/5 = 3/5 ', N'Không xác định', N'B', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (430, N'So sánh hai phân số 2/-9 .... -4/9', N'lớn hơn ', N'nhỏ hơn ', N'bằng', N'Không xác định', N'A', 1, 133)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (431, N'đáp án đúng ', N'Muốn cộng hai phân số cùng mẫu ta cộng các tử và giữ nguyên mẫu', N'Muốn cộng hai phân số cùng mẫu ta cộng các tử và mẫu.', N'Muốn cộng hai phân số cùng mẫu ta cộng các mẫu và giữ nguyên tử', N'Muốn cộng hai phân số cùng mẫu ta cộng các tử và nhân đôi mẫu', N'A', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (432, N'đáp án đúng ', N'Muốn cộng hai phân số không cùng mẫu. ta viết chúng dưới dạng hai phân số cùng mẫu rồi cộng các tử với nhau và giữ nguyên mẫu chung', N'Muốn cộng hai phân số không cùng mẫu. ta cộng các tử với nhau và giữ nguyên mẫu ', N'Muốn cộng hai phân số không cùng mẫu. ta viết chúng dưới dạng hai phân số cùng tử rồi cộng các mẫu với nhau và giữ nguyên tử chung', N'Muốn cộng hai phân số không cùng mẫu. ta giữ nguyên phân số rồi cộng các tử với nhau và mẫu ', N'A', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (433, N'Tổng 1/2 + 1/2 có kết quả là', N'1/3     ', N'4/3     ', N'3/4     ', N'1', N'D', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (434, N'Tính tổng hai phân số 35/36 và -125/36', N'-5/2     ', N'-29/5     ', N'-40/9     ', N' 40/9', N'A', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (435, N'Thực hiện phép tính 65/91 + -44/55  ta được kết quả là', N'-53/35     ', N'51/35     ', N'-3/25     ', N'3/35', N'C', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (436, N'Viết phân số 7/15 dưới dạng tổng hai phân số tối giản có mẫu số khác nhau.', N'1/3 + 2/15', N'2/3 + 2/15', N'1/15 + 2/3', N'1/3 + 1/15', N'A', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (437, N'Viết phân số 1/8 dưới dạng tổng hai phân số dương có tử số bằng 1 và mẫu số khác nhau.', N'1/12 + 1/24', N'1/12 + 1/10', N'1/12 + 1/40', N'1/10 + 1/24', N'A', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (438, N'Viết các phân số bằng 15/17 có mẫu là số tự nhiên chẵn có hai chữ số.', N'30/34', N'50/68', N'30/68', N'60/34', N'A', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (439, N'Tính: 110+115+121+128+136+145', N'1/10', N'1/5', N'3/10', N'2/5', N'C', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (440, N'Tìm x biết x= -1/2+ 3/4', N'1/2', N'1/4', N'3/4', N'-1/2', N'B', 1, 134)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (441, N'Tính', N'1/16     ', N'-2     ', N'-15/32     ', N'-5/32', N'C', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (442, N'Tính', N'-2/27     ', N'-4/9     ', N'-1/18     ', N'-3/2', N'A', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (443, N'Kết quả phép tính -1/4 - 1/2 là', N'-16/8     ', N'-13/8     ', N'-6/16     ', N'-3/4', N'D', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (444, N'Tính −59.65', N'-30/45', N'30/45', N'3/4', N'-3/4', N'B', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (445, N'TÍnh 13.23', N'1', N'2/9', N'3/2', N'Cả 3 đáp số trên đều sai ', N'B', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (446, N'Tính 156.15', N'1/2', N'-1/2', N'1', N'2', N'A', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (447, N'Tính 1/2+5/2', N'3', N'1/3', N'-1/3', N'Không có kết quả nào đúng ', N'A', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (448, N'Tính 1-5/6', N'1/6', N'1/36', N'24/36', N'Tất cả các đáp số trên đều sai ', N'A', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (449, N'Tính 1-11/12', N'1/12', N'2/3', N'3/2', N'Tất cả các đáp số trên đều sai ', N'A', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (450, N'Tính 3.5', N'15', N'3/20', N'15/20', N'Tất cả các đáp án trên đều sai', N'A', 1, 135)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (451, N'Viết phân số 4/3 dưới dạng hỗn số ta được', N'113', N'313', N'123', N'323', N'A', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (452, N'Hỗn số  được viết dưới dạng phân só là', N'-21/4', N'-11/4', N'-10/4', N'-5/4', N'B', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (453, N'Viết phân số 131/1000 dưới dạng số thập phân ta được', N'0,131     ', N'0,1331     ', N'1,31     ', N'0,0131', N'A', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (454, N'Viết số thập phân 0,25 về dạng phân số ta được', N'1/4     ', N'5/2     ', N'2/5     ', N'1/5', N'A', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (455, N'Phân số 47/100 được viết dưới dạng phần trăm là:', N'4,7%     ', N'47%     ', N'0,47%     ', N'470%', N'B', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (456, N'đáp án sai. ', N'Khi ta viết gọn tổng của một số nguyên dương và phân số dương bằng cách bỏ dấu cộng xen giữa chúng thì được gọi là một hỗn số.', N'Số đối của hỗn số cũng được gọi là một hỗn số.', N'Một hỗn số gồm hai phần: phần nguyên và phần phân số.', N'Muốn đổi một phân số dương có tử lớn hơn mẫu thành một hỗn số ta chia mẫu cho tử. Thương tìm được chính là phần nguyên, phần phân số có tử là số dư còn mẫu là mẫu số của phân số đã cho.', N'D', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (457, N'đáp án sai.', N'Phân số thập phân là phân số có mẫu là một lũy thừa của 10. ', N'Các phân số thập phân có thể viết dưới dạng số thập phân.', N'Số chữ số thập phân bằng đúng số chữ số 0 ở mẫu của phân số thập phân.', N'Tất cả các đáp án trên đều sai', N'D', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (458, N'Viết số thập phân 0,015 về dạng phân số ta được', N'3/20', N'3/200', N'15/100', N'Tất cả đáp án trên đều sai', N'B', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (459, N'Viết phân số 259/10000 dưới dạng số thập phân ta được', N'0,259', N'2,95', N'0.0259', N'Tất cả các đáp án trên đều sai', N'C', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (460, N'Viết hỗn số 315 dưới dạng phân số:', N'3/5', N'16/5', N'8/5', N'Tất cả các đáp án trên đều sai', N'B', 1, 136)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (461, N'Cho hai đường thẩng a, Khi đó a, b có thể', N'Song song', N'Trùng nhau', N'Cắt nhau', N'Cả ba đáp án trên đều đúng', N'D', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (462, N'câu đúng:', N'Qua hai điểm phân biệt có vô số đường thẳng', N'Có vô số điểm cùng thuộc một đường thẳng', N'Hai đường thẳng phân biệt thì song song', N'Trong ba điểm thẳng hàng thì có hai điểm nằm giữa', N'B', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (463, N'Cho ba điểm A, B, C không thẳng hàng . Vẽ đường thẳng di qua các cặp điểm. Hỏi vẽ được những đường thẳng nào?', N'AB, BC, CA', N'AB, BC, CA, BA, CB, AC', N'AA, BC, CA, AB', N'AB, BC, CA, AA, BB, CC', N'A', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (464, N'Cho 5 điểm A, B, C, D, E trong đó không có ba điểm nào thẳng hàng. Vẽ đường thẳng đi qua các cặp điểm. Hỏi vẽ được bao nhiêu đường thẳng?', N'25', N'10', N'20', N'16', N'B', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (465, N'Cho 3 đường thẳng a, b, c phân biệt. Trong trường hợp nào thì ba đường thẳng đó dôi một không có giao điểm?', N'ba đường thẳng đôi một cắt nhau', N'a cắt b và a song song c', N'ba đường thẳng đôi một song song', N'a song song b và a cắt c', N'C', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (466, N'Cho 100 điểm trong đó không có 3 điểm nào thẳng hàng. Hỏi vẽ được bao nhiêu đường thẳng đi qua các cặp điểm.', N'4950 đường thẳng', N'4590 đường thẳng', N'9900 đường thẳng', N'100 đường thẳng', N'A', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (467, N'Cho trước một số điểm trong đó không có ba điểm nào thẳng hàng. Vẽ đường thẳng đi qua các cặp điểm. Biết tổng số đường thẳng vẽ được là 21. Hỏi có bao nhiêu điểm cho trước', N'6', N'10', N'12', N'7', N'D', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (468, N'Cho trước 50 điểm trong đó không có 3 điểm nào thẳng hàng. Vẽ các đường thẳng đi qua các cặp điểm. Hỏi vẽ được tất cả bao nhiêu đường thẳng?', N'1225', N'1275', N'2450', N'2550', N'A', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (469, N'phát biểu đúng?', N'Có vô số đường thẳng đi qua 2 điểm', N'Có ít nhất 1 đường thẳng đi qua 2 điểm cho trước', N'Có 1 và chỉ 1 đường thẳng đi qua hai điểm cho trước', N'Có 2 đường thẳng đi qua 2 điểm', N'C', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (470, N'Cho 3 đường thẳng a, b, c phân biệt. Có thể có nhiều nhất bao nhiêu giao điểm', N'1 giao điểm', N'2 giao điểm', N'3 giao điểm', N'vô số giao điểm', N'C', 1, 137)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (471, N'đáp án đúng?', N'Trang sách là hình ảnh của mặt phẳng', N'Sàn nhà là hình ảnh của mặt phẳng', N'Mặt bàn là hình ảnh của mặt phẳng', N'Cả A, B, C đều đúng', N'D', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (472, N'phát biểu đúng:', N'Góc có số đo 120° là góc vuông     ', N'Góc có số đo 80° là góc tù', N'Góc có số đo 100° là góc nhọn     ', N'Góc có số đo 150° là góc tù', N'D', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (473, N'Cho 9 tia chung gốc (không có tia nào trùng nhau) thì số góc tạo thành là:', N'16     ', N'72     ', N'36     ', N'42', N'C', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (474, N'Cho ba điểm A, B, C không thẳng hàng. Vẽ đường thằng a cắt các đoạn thằng AB, AC và không đi qua A, B, Gọi tên hai nửa mặt phẳng đối nhau bờ ', N'Nửa mặt phẳng bờ a chứa A và nửa mặt phẳng bờ a chứa B và C', N'Nửa mặt phẳng bờ a chứa B và nửa mặt phẳng bờ a chứa A và C', N'Nửa mặt phẳng bờ a chứa A và nửa mặt phẳng bờ a chứa B và C', N'Không xác định đươc', N'A', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (475, N'Cho ba điểm A, B, C không thẳng hàng. Vẽ đường thằng a cắt các đoạn thằng AB, AC và không đi qua A, B, C  Đoạn thẳng BC có cắt đường thẳng a không?', N'Có', N'Không', N'Không xác định được', N'Hên xui', N'B', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (476, N'Gọi M là điểm nằm giữa hai điểm A, Lấy điểm O không nằm trên đường thẳng AVẽ ba tia OA, OB, OM.Hỏi tia nào nằm giữa hai tia còn lại?', N'Tia OA nằm giữa hai tia OM và OB', N'Tia OM nằm giữa hai tia OA và OB', N'Tia OB nằm giữa hai tia OA và OM', N'Không xác định đc', N'B', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (477, N'Câu sai:', N'Góc là hình gồm hai tia chung gốc', N'Hai tia chung gốc tạo thành góc bẹt', N'Hai góc bằng nhau có số đo bằng nhau', N'Hai góc có số đo bằng nhau thì bằng nhau', N'B', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (478, N'Cho ∠xOm = 45° và góc xOm bằng góc yAn. Khi đó góc yAn bằng:', N'50°     ', N'40°     ', N'45°     ', N'30°', N'C', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (479, N'câu sai:', N'Góc vuông là góc có số đo bằng 90°', N'Góc có số đo lớn hơn 0° và nhỏ hơn 90° là góc nhọn', N'Góc tù là góc có số đo lớn hơn 90° và nhỏ hơn 180°', N'Góc có số đo nhỏ hơn 180° là góc tù', N'D', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (480, N'phát biểu sai:', N'Một điểm có thể thuộc đồng thời nhiều đường thẳng.', N'Với một đường thẳng a cho trước, có những điểm thuộc a và có những điểm không thuộc ', N'Trên đường thẳng chỉ có một điểm.', N'Một điểm có thể thuộc đồng thời hai đường thẳng.', N'C', 1, 138)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (481, N'Câu đúng nhất: Tam giác ABC là hình có:', N'Ba cạnh AB; AC; BC     ', N'Ba đỉnh A; B; C', N'Ba góc ∠A; ∠B; ∠C     ', N'Cả A, B, C đều đúng', N'D', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (482, N'Câu sai khi nói về tam giác MNP', N'ΔMNP có 3 góc là: ∠MNP; ∠MPN; ∠PMN', N'ΔMNP có 3 đường thẳng là: MP; MN; PN', N'Ba điểm M; N; P không thẳng hàng', N'ΔMNP có 3 cạnh là: MN; PM; PN', N'B', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (483, N'Cho 5 điểm A; B; C; D; E trong đó không có ba điểm nào thẳng hàng. Có bao nhiêu tam giác có các đỉnh là 3 trong 5 đỉnh trên:', N'9     ', N'10     ', N'8     ', N'7', N'B', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (484, N'Cho đường thẳng d không đi qua O. Trên d lấy sáu điểm A; B; C; D; E; F phân biệt. Có bao nhiêu tam giác nhận điểm O làm đỉnh và hai đỉnh còn lại là hai trong 6 điểm A; B; C; D; E; F', N'15     ', N'12     ', N'6     ', N'9', N'A', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (485, N'phát biểu sai trong các phát biểu sau:', N'Nếu tia Ot là tia phân giác của ∠xOy thì tia Ot nằm giữa hai tia Ox, Oy', N'Nếu tia Ot là tia phân giác của ∠xOy thì ∠xOt = ∠yOt = ∠xOy/2', N'Nếu ∠xOt = ∠yOt thì tia Ot là tia phân giác của ∠xOy', N'Nếu ∠xOt = ∠yOt và tia Ot nằm giữa hai tia Ox, Oy thì tia Ot là tia phân giác của ∠xOy', N'C', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (486, N'Cho Ot là phân giác của ∠xOy. Biết ∠xOy = 100°, số đo của ∠xOt là:', N'40°     ', N'60°     ', N'50°     ', N'200°', N'C', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (487, N'Cho ∠xOy là góc vuông có tia On là phân giác, số đo của ∠xOn là:', N'40°     ', N'90°     ', N'45°     ', N'85°', N'C', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (488, N'Cho tia On là tia phân giác của ∠mOt. Biết ∠mOn = 70°, số đo của ∠mOt là:', N'140°     ', N'120°     ', N'35°     ', N'60°', N'A', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (489, N'Cho ∠AOB = 90° và tia OB là tia phân giác của góc AOC . Khi đó góc AOC là:', N'Góc vuông     ', N'Góc nhọn     ', N'Góc tù     ', N'Góc bẹt', N'D', 1, 139)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (490, N'Phát biểu đúng trong các phát biểu sau:', N'Hai góc tù là hai góc kề nhau', N'Cho ba tia chung gốc Ox, Oy, Oz, ta luôn có: ∠xOy + ∠yOz = ∠xOz', N'Nếu tia Oy nằm giữa hai tia On và Om thì khi đó ta có: ∠yOn + ∠yOm = ∠mOn', N'Nếu ∠A và ∠B là hai góc bù nhau thì ∠A + ∠B = 90°', N'C', 1, 139)
GO
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (491, N'Chọn phát biểu đúng trong các phát biểu sau:', N'Đường tròn tâm O, bán kính R là hình gồm các điểm cách O một khoảng bằng R, kí hiệu là (O; R).', N'Đường tròn tâm O, đường kính R là hình gồm các điểm cách O một khoảng bằng R, kí hiệu là (O; R).s', N'Đường tròn tâm O, bán kính R là hình gồm các điểm cách O một khoảng bằng R/2, kí hiệu là (O; R).', N'Hình tròn tâm O, bán kính R là hình gồm các điểm cách O một khoảng bằng R, kí hiệu là (O; R).', N'A', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (492, N'Chọn phát biểu sai trong các phát biểu sau:', N'Hình gồm các điểm nằm trên đường tròn và các điểm nằm trong đường tròn đó là hình tròn.', N'Dây cung không đi qua tâm là bán kính của đường tròn đó.', N'Hai điểm A và B của một đường tròn chia đường tròn đó thành hai cung. Đoạn thẳng nối hai mút của một cung là dây.', N'Dây cung đi qua tâm là đường kính của đường tròn đó.', N'B', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (493, N'Nếu điểm M nằm trong đường tròn tâm O bán kính 4cm. Khi đó:', N'OM < 4cm     ', N'OM = 4cm     ', N'OM > 4cm     ', N'OM ≥ 4cm', N'A', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (494, N'Cho đường tròn (O; 5cm) và OM = 6cm. Chọn câu đúng:', N'Điểm M nằm trên đường tròn     ', N'Điểm M nằm trong đường tròn', N'Điểm M nằm ngoài đường tròn     ', N'Điểm M trùng với tâm đường tròn', N'C', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (495, N'Cho đường tròn (M; 1,5cm) và ba điểm A, B, C sao cho OA = 1cm; OB = 1,5cm; OC = 2cm. Chọn câu đúng:', N'Điểm A nằm trên đường tròn, điểm B nằm trong đường tròn và điểm C nằm ngoài đường tròn (M; 1,5cm)', N'Điểm A và điểm C nằm ngoài đường tròn, điểm B nằm trên đường tròn (M; 1,5cm)', N'Điểm A nằm trong đường tròn, điểm B nằm trên đường tròn và điểm C nằm ngoài đường tròn (M; 1,5cm)', N'Cả ba đều nằm trên đường tròn (M; 1,5cm)', N'C', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (496, N'Trên đường tròn có 9 điểm phân biệt. Hỏi có bao nhiêu dây cung được tạo thành từ 9 điểm đó?', N'9     ', N'18     ', N'72     ', N'36', N'D', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (497, N'Cho đường thẳng a và điểm A ∈ a, một độ dài R = 4cm. Các điểm M trong mặt phẳng có khoảng cách đến điểm A bằng 4cm thì nằm trên đường nào.', N'Các điểm M cách A một khoảng bằng 4cm thì nằm trên đường tròn tâm A, bán kính là 4cm', N'Các điểm M cách A một khoảng bằng 3cm thì nằm trên đường tròn tâm A, bán kính là 3cm', N'Các điểm M cách A một khoảng bằng 4cm thì nằm trên đường tròn tâm M, bán kính là 4cm', N'Các điểm M cách A một khoảng bằng 3cm thì nằm trên đường tròn tâm M, bán kính là 3cm', N'A', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (498, N'Cho đường thẳng a và điểm A ∈ a, một độ dài R = 4cm.  Trên đường thẳng a có bao nhiêu điểm cách điểm A một đoạn 4cm. Xác định các điểm ấy', N'Trên đường thẳng a có hai điểm M1, M2 cách điểm A một khoảng bằng 4cm. M1, M2 là giao điểm của đường thẳng a với đường tròn tâm A, bán kính là 4cm.', N'Trên đường thẳng a có hai điểm M1, M2 cách điểm A một khoảng bằng 3cm. M1, M2 là giao điểm của đường thẳng a với đường tròn tâm A, bán kính là 3cm', N'Trên đường thẳng a có hai điểm M1, M2 cách điểm A một khoảng bằng 2cm. M1, M2 là giao điểm của đường thẳng a với đường tròn tâm A, bán kính là 2cm', N'Trên đường thẳng a có hai điểm M1, M2 cách điểm A một khoảng bằng 1cm. M1, M2 là giao điểm của đường thẳng a với đường tròn tâm A, bán kính là 1cm', N'A', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (499, N'Cho hai điểm A, B cách nhau một khoảng bằng 4cm. Các điểm cách A một khoảng 3cm nằm trên đường nào? Cách điểm B một khoảng 2cm nằm trên đường nào?', N'Các điểm M có MA = 3cm và MB = 2cm là giao điểm của hai đường tròn (A; 3) và (B; 2)', N'Các điểm M có MA = 2cm và MB = 3cm là giao điểm của hai đường tròn (A; 3) và (B; 2)', N'Các điểm M có MA = 3cm và MB = 2cm là giao điểm của hai đường tròn (A; 2) và (B; 3)', N'Các điểm M có MA = 2cm và MB = 3cm là giao điểm của hai đường tròn (A; 2) và (B; 3)', N'B', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (500, N'Cho hai điểm A, B cách nhau một khoảng bằng 4cm. Tìm điểm M có khoảng cách đến A một đoạn 3cm và có khoảng cách đến B một đoạn 2cm. Có bao nhiêu điểm như vậy?', N'1', N'2', N'3', N'4', N'B', 1, 140)
INSERT [dbo].[NH_CAUHOI] ([MaCauHoi], [NoiDung], [A], [B], [C], [D], [DapAn], [TrangThai], [MaBaiHoc]) VALUES (501, N'Đ?i tên g?', N'Đ?i', N'Đoan', N'Chi?n', N'Nam', N'A', 1, 121)
SET IDENTITY_INSERT [dbo].[NH_CAUHOI] OFF
GO
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (2, 3)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (2, 6)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (2, 9)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (2, 10)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (2, 13)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (3, 3)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (3, 7)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (3, 9)
INSERT [dbo].[PC_GIANGDAY] ([MaLop], [MaPhuTrach]) VALUES (3, 11)
GO
/****** Object:  Index [IX_PHUCTRACHMON]    Script Date: 25/12/2021 10:05:50 SA ******/
ALTER TABLE [dbo].[GV_MON] ADD  CONSTRAINT [IX_PHUCTRACHMON] UNIQUE NONCLUSTERED 
(
	[MaPhuTrach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GIAOVIEN] ADD  CONSTRAINT [DF_GIAOVIEN_TrangThai]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[NH_CAUHOI] ADD  CONSTRAINT [DF_NganHangCauHoi_TrangThai]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[BAIHOC]  WITH CHECK ADD  CONSTRAINT [FK_BAIHOC_HocKy] FOREIGN KEY([MaHocKy])
REFERENCES [dbo].[HOCKY] ([MaHK])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BAIHOC] CHECK CONSTRAINT [FK_BAIHOC_HocKy]
GO
ALTER TABLE [dbo].[BAIHOC]  WITH CHECK ADD  CONSTRAINT [FK_BAIHOC_MON] FOREIGN KEY([MaMon])
REFERENCES [dbo].[MON] ([MaMon])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BAIHOC] CHECK CONSTRAINT [FK_BAIHOC_MON]
GO
ALTER TABLE [dbo].[BAIHOCKT]  WITH CHECK ADD  CONSTRAINT [FK_BAIHOCKT_BAIHOC] FOREIGN KEY([MaBaiHoc])
REFERENCES [dbo].[BAIHOC] ([MaBaiHoc])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BAIHOCKT] CHECK CONSTRAINT [FK_BAIHOCKT_BAIHOC]
GO
ALTER TABLE [dbo].[BAIHOCKT]  WITH CHECK ADD  CONSTRAINT [FK_BAIHOCKT_DANGKYKIEMTRA] FOREIGN KEY([MaDangKy])
REFERENCES [dbo].[DANGKYKIEMTRA] ([MaDangKy])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BAIHOCKT] CHECK CONSTRAINT [FK_BAIHOCKT_DANGKYKIEMTRA]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_CT_BAITHI_NH_CAUHOI] FOREIGN KEY([MaCauHoi])
REFERENCES [dbo].[NH_CAUHOI] ([MaCauHoi])
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [FK_CT_BAITHI_NH_CAUHOI]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDeThi_DANGKYKIEMTRA] FOREIGN KEY([MaDangKy])
REFERENCES [dbo].[DANGKYKIEMTRA] ([MaDangKy])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [FK_ChiTietDeThi_DANGKYKIEMTRA]
GO
ALTER TABLE [dbo].[CT_BAITHI]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDeThi_HOCSINH] FOREIGN KEY([MaHS])
REFERENCES [dbo].[HOCSINH] ([MaHS])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CT_BAITHI] CHECK CONSTRAINT [FK_ChiTietDeThi_HOCSINH]
GO
ALTER TABLE [dbo].[DANGKYKIEMTRA]  WITH CHECK ADD  CONSTRAINT [FK_DANGKYKIEMTRA_LOAIKIEMTRA1] FOREIGN KEY([MaLoai])
REFERENCES [dbo].[LOAIKIEMTRA] ([MaLoai])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DANGKYKIEMTRA] CHECK CONSTRAINT [FK_DANGKYKIEMTRA_LOAIKIEMTRA1]
GO
ALTER TABLE [dbo].[DIEM]  WITH CHECK ADD  CONSTRAINT [FK_Diem_DANGKYKIEMTRA] FOREIGN KEY([MaDangKy])
REFERENCES [dbo].[DANGKYKIEMTRA] ([MaDangKy])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DIEM] CHECK CONSTRAINT [FK_Diem_DANGKYKIEMTRA]
GO
ALTER TABLE [dbo].[DIEM]  WITH CHECK ADD  CONSTRAINT [FK_Diem_HOCSINH] FOREIGN KEY([MaHS])
REFERENCES [dbo].[HOCSINH] ([MaHS])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[DIEM] CHECK CONSTRAINT [FK_Diem_HOCSINH]
GO
ALTER TABLE [dbo].[GV_MON]  WITH CHECK ADD  CONSTRAINT [FK_PHUCTRACHMON_GIAOVIEN] FOREIGN KEY([MaGV])
REFERENCES [dbo].[GIAOVIEN] ([MaGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GV_MON] CHECK CONSTRAINT [FK_PHUCTRACHMON_GIAOVIEN]
GO
ALTER TABLE [dbo].[GV_MON]  WITH CHECK ADD  CONSTRAINT [FK_PHUCTRACHMON_MON] FOREIGN KEY([MaMon])
REFERENCES [dbo].[MON] ([MaMon])
GO
ALTER TABLE [dbo].[GV_MON] CHECK CONSTRAINT [FK_PHUCTRACHMON_MON]
GO
ALTER TABLE [dbo].[HOCSINH]  WITH CHECK ADD  CONSTRAINT [FK_HOCSINH_LOP] FOREIGN KEY([MaLop])
REFERENCES [dbo].[LOP] ([MaLop])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[HOCSINH] CHECK CONSTRAINT [FK_HOCSINH_LOP]
GO
ALTER TABLE [dbo].[LOAIKIEMTRA]  WITH CHECK ADD  CONSTRAINT [FK_LOAIKIEMTRA_HOCKY] FOREIGN KEY([MaHK])
REFERENCES [dbo].[HOCKY] ([MaHK])
GO
ALTER TABLE [dbo].[LOAIKIEMTRA] CHECK CONSTRAINT [FK_LOAIKIEMTRA_HOCKY]
GO
ALTER TABLE [dbo].[LOP]  WITH CHECK ADD  CONSTRAINT [FK_LOP_KHOI] FOREIGN KEY([MaKhoi])
REFERENCES [dbo].[KHOI] ([MaKhoi])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOP] CHECK CONSTRAINT [FK_LOP_KHOI]
GO
ALTER TABLE [dbo].[LOPKT]  WITH CHECK ADD  CONSTRAINT [FK_LOPKT_DANGKYKIEMTRA] FOREIGN KEY([MaDangKy])
REFERENCES [dbo].[DANGKYKIEMTRA] ([MaDangKy])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOPKT] CHECK CONSTRAINT [FK_LOPKT_DANGKYKIEMTRA]
GO
ALTER TABLE [dbo].[LOPKT]  WITH CHECK ADD  CONSTRAINT [FK_LOPKT_LOP] FOREIGN KEY([MaLop])
REFERENCES [dbo].[LOP] ([MaLop])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOPKT] CHECK CONSTRAINT [FK_LOPKT_LOP]
GO
ALTER TABLE [dbo].[MON]  WITH CHECK ADD  CONSTRAINT [FK_MON_KHOI] FOREIGN KEY([MaKhoi])
REFERENCES [dbo].[KHOI] ([MaKhoi])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[MON] CHECK CONSTRAINT [FK_MON_KHOI]
GO
ALTER TABLE [dbo].[NH_CAUHOI]  WITH CHECK ADD  CONSTRAINT [FK_NganHangCauHoi_BAIHOC] FOREIGN KEY([MaBaiHoc])
REFERENCES [dbo].[BAIHOC] ([MaBaiHoc])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[NH_CAUHOI] CHECK CONSTRAINT [FK_NganHangCauHoi_BAIHOC]
GO
ALTER TABLE [dbo].[PC_GIANGDAY]  WITH CHECK ADD  CONSTRAINT [FK_PHUCTRACHLOP_LOP] FOREIGN KEY([MaLop])
REFERENCES [dbo].[LOP] ([MaLop])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PC_GIANGDAY] CHECK CONSTRAINT [FK_PHUCTRACHLOP_LOP]
GO
ALTER TABLE [dbo].[PC_GIANGDAY]  WITH CHECK ADD  CONSTRAINT [FK_PHUCTRACHLOP_PHUCTRACHMON] FOREIGN KEY([MaPhuTrach])
REFERENCES [dbo].[GV_MON] ([MaPhuTrach])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PC_GIANGDAY] CHECK CONSTRAINT [FK_PHUCTRACHLOP_PHUCTRACHMON]
GO
/****** Object:  StoredProcedure [dbo].[GetAllGrades_GV]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllGrades_GV] @idGV CHAR(8)
AS
	SELECT k.*
	FROM dbo.KHOI AS k, dbo.MON AS m, dbo.GV_MON AS gv
	WHERE gv.MaGV=@idGV AND gv.MaMon=m.MaMon AND m.MaKhoi=k.MaKhoi
GO
/****** Object:  StoredProcedure [dbo].[GetAllLessons]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllLessons] (@IdLop INT, @IdMon INT)
AS 
BEGIN
	DECLARE @IdKTCuoiKy1 INT 
	SET @IdKTCuoiKy1=4

	DECLARE @IdHocKy1 INT
	SET @IdHocKy1=1

	 IF NOT EXISTS (SELECT *
					 FROM dbo.DANGKYKIEMTRA dk, dbo.LOPKT lop, dbo.BAIHOCKT bhkt, dbo.BAIHOC bh
					 WHERE dk.MaDangKy=lop.MaDangKy AND dk.MaDangKy=bhkt.MaDangKy AND bhkt.MaBaiHoc=bh.MaBaiHoc 
							AND lop.MaLop=@IdLop AND bh.MaMon=@IdMon AND dk.MaLoai=@IdKTCuoiKy1)
		SELECT MaBaiHoc, TenBai
		FROM dbo.BAIHOC
		WHERE MaMon=@IdMon AND MaHocKy=@IdHocKy1;
	ELSE
		SELECT MaBaiHoc, TenBai
		FROM dbo.BAIHOC
		WHERE MaMon=@IdMon;
END
GO
/****** Object:  StoredProcedure [dbo].[GetIdClassesRegis]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIdClassesRegis] @idClasses VARCHAR(500)
AS 
	IF OBJECT_ID('tempdb..#tempTable') IS NOT NULL 
	BEGIN 
	    DROP TABLE #tempTable 
	END
	
	CREATE TABLE #tempTable(
				idGrade int
	)
	
	WHILE(LEN(@idClasses)>0)
	BEGIN
		DECLARE @tmpId int;
		SET @tmpId=(SELECT CAST (SUBSTRING (@idClasses,0,CHARINDEX(',',@idClasses)) as int));
		SET @idClasses=(SELECT SUBSTRING (@idClasses,CHARINDEX(',',@idClasses)+1,LEN(@idClasses)));
		
		INSERT INTO #tempTable(idGrade) Values(@tmpId);
	END;
	
	SELECT * FROM #tempTable;
	DROP Table #tempTable;
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckAccountTeacher]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckAccountTeacher]
@USERNAME CHAR(8), @PASSWORD NCHAR(100)
AS
BEGIN
	IF NOT EXISTS (SELECT MaGV FROM KiemTraHS.dbo.GIAOVIEN WHERE MaGV = @USERNAME AND  MatKhau = @PASSWORD)
		RAISERROR('Sai tài khoản hoặc mật khẩu, vui lòng kiểm tra lại!', 16, 1)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKDAKIEMTRACHUA]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_CHECKDAKIEMTRACHUA]
@MAHS CHAR(9), @MADANGKY INT
AS
BEGIN
	IF EXISTS (SELECT DIEM FROM DIEM WHERE MAHS = @MAHS AND MADANGKY = @MADANGKY)
		RAISERROR('Học sinh đã kiểm tra môn này', 16, 1)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CheckEnoughQues]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CheckEnoughQues](@idLessons varchar(500), @numQues int)
AS 
CREATE TABLE #tempTable1(
				id int
	);
	INSERT INTO #tempTable1
	EXEC GetIdClassesRegis @idLessons;
	
DECLARE @count int=0;
SET @count=(SELECT COUNT(*) FROM KiemTraHS.dbo.NH_CAUHOI WHERE MaBaiHoc IN (SELECT * FROM #tempTable1));
IF(@count>=@numQues)	SELECT 1 as result;
ELSE SELECT 0 as result;
GO
/****** Object:  StoredProcedure [dbo].[SP_CHECKTAIKHOANHOCSINH]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHECKTAIKHOANHOCSINH]
@USERNAME CHAR(9), @PASSWORD NCHAR(100)
AS
BEGIN
	IF NOT EXISTS (SELECT MAHS FROM HOCSINH WHERE MAHS = @USERNAME AND MATKHAU = @PASSWORD)
		RAISERROR('Sai tài khoản hoặc mật khẩu, vui lòng kiểm tra lại!', 16, 1)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHONBAIKIEMTRA]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHONBAIKIEMTRA]
AS
BEGIN
	SELECT MON.MaMon, MON.TenMon, LKT.TenLoai, DKKTT.ThoiGianBatDau, DKKTT.ThoiGianLamBai, DKKTT.SoCauHoi, DKKTT.MaDangKy, LOPKT.MALOP, COUNT(BAIHOC.TenBai) AS N'SỐ BÀI HỌC' 
	FROM (SELECT TenLoai, MaLoai FROM LOAIKIEMTRA) AS LKT,
			(SELECT MON.MaMon, MON.TenMon FROM MON) AS MON,
			(SELECT ThoiGianBatDau, ThoiGianLamBai, SoCauHoi, MaDangKy, MaLoai FROM DANGKYKIEMTRA) AS DKKTT,
			(SELECT * FROM LOPKT) AS LOPKT,
			(SELECT * FROM BAIHOCKT) AS BAIHOCKT,
			(SELECT MaBaiHoc, TENBAI, MaMon FROM BAIHOC) AS BAIHOC
	WHERE LKT.MaLoai = DKKTT.MaLoai AND DKKTT.MaDangKy = LOPKT.MaDangKy AND DKKTT.MaDangKy = BAIHOCKT.MaDangKy AND BAIHOCKT.MaBaiHoc = BAIHOC.MaBaiHoc AND BAIHOC.MaMon = MON.MaMon
	GROUP BY MON.MaMon, MON.TenMon, LKT.TenLoai, DKKTT.ThoiGianBatDau, DKKTT.ThoiGianLamBai, DKKTT.SoCauHoi, DKKTT.MaDangKy, LOPKT.MALOP
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllClass_ViewExamDetail]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllClass_ViewExamDetail] @idSub int
AS 
			
SELECT tmp1.MaLop, tmp1.TenLop, tmp2.MaDangKy, tmp2.NgayThi, tmp2.GioThi, tmp2.TenLoai
FROM (SELECT l.MaLop ,l.TenLop 
			FROM KiemTraHS.dbo.LOP l, KiemTraHS.dbo.PC_GIANGDAY pc, KiemTraHS.dbo.GV_MON gvm
			WHERE l.MaLop =pc.MaLop AND pc.MaPhuTrach =gvm.MaPhuTrach 
			AND gvm.MaMon =@idSub) tmp1
LEFT JOIN (SELECT tmp1.MaLop, tmp1.TenLop, tmp1.MaDangKy, CAST(tmp1.ThoiGianBatDau AS date) as NgayThi, CAST(tmp1.ThoiGianBatDau AS time) as GioThi , tmp2.TenLoai
			FROM (SELECT tmp.*, l.TenLop
					FROM (SELECT tmp.*, dk.MaDangKy
							FROM (SELECT lkt.MaLop , MAX(dk.ThoiGianBatDau) as ThoiGianBatDau 
									FROM KiemTraHS.dbo.DANGKYKIEMTRA dk, KiemTraHS.dbo.LOPKT lkt, KiemTraHS.dbo.BAIHOCKT bhkt, 
										KiemTraHS.dbo.BAIHOC b 
									WHERE dk.MaDangKy =lkt.MaDangKy AND dk.MaDangKy =bhkt.MaDangKy AND bhkt.MaBaiHoc =b.MaBaiHoc  
										AND b.MaMon =@idSub
									GROUP BY lkt.MaLop) tmp, DANGKYKIEMTRA dk, LOPKT lkt
							WHERE dk.MaDangKy=lkt.MaDangKy and lkt.MaLop=tmp.MaLop and dk.ThoiGianBatDau=tmp.ThoiGianBatDau) tmp, LOP l
					WHERE tmp.MaLop=l.MaLop) tmp1
			LEFT JOIN (SELECT d.MaDangKy, l.TenLoai 
						FROM KiemTraHS.dbo.DANGKYKIEMTRA d , KiemTraHS.dbo.LOAIKIEMTRA l 
						WHERE d.MaLoai =l.MaLoai ) tmp2
			ON  tmp1.MaDangKy=tmp2.MaDangKy) tmp2
ON tmp1.MaLop= tmp2.MaLop
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllClassBy_Grade]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllClassBy_Grade] @idGrade int, @idSub int, @idExamTypes int
AS 

DECLARE @examType nvarchar(50);

SET @examType= (SELECT TenLoai 
			FROM KiemTraHS.dbo.LOAIKIEMTRA
			WHERE MaLoai =@idExamTypes);

		
CREATE TABLE #tempTable1(
				idClass int
	);
INSERT INTO #tempTable1
SELECT lop.MaLop
FROM KiemTraHS.dbo.DANGKYKIEMTRA d , KiemTraHS.dbo.LOPKT l, KiemTraHS.dbo.LOP lop , KiemTraHS.dbo.LOAIKIEMTRA lkt, 
	KiemTraHS.dbo.BAIHOCKT bhkt , KiemTraHS.dbo.BAIHOC bh
WHERE d.MaLoai=lkt.MaLoai and d.MaDangKy =l.MaDangKy and d.MaDangKy =bhkt.MaDangKy
	and bhkt.MaBaiHoc =bh.MaBaiHoc and bh.MaMon =@idSub and lkt.TenLoai LIKE N'%cuối kỳ 1%' 
	and l.MaLop =lop.MaLop and lop.MaKhoi = @idGrade	
	


if @examType like N'%cuối kỳ 1%'
	begin
		SELECT MaLop , TenLop 
		FROM KiemTraHS.dbo.LOP 
		WHERE MaKhoi = @idGrade AND MaLop NOT IN (SELECT * FROM #tempTable1)
	end
else
	begin
		SELECT l.MaLop , l.TenLop 
		FROM KiemTraHS.dbo.LOP as l, #tempTable1 as tmp
		WHERE l.MaLop =tmp.idClass
	end





GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllClassBy_Sub-Grade_Teacher]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllClassBy_Sub-Grade_Teacher] @idTeacher char(8), @idSub int
AS 
SELECT l.MaLop , l.TenLop 
FROM KiemTraHS.dbo.GV_MON as gvm, KiemTraHS.dbo.PC_GIANGDAY as pc, KiemTraHS.dbo.LOP as l
WHERE gvm.MaGV =@idTeacher and gvm.MaMon=@idSub and gvm.MaPhuTrach = pc.MaPhuTrach and pc.MaLop =l.MaLop
ORDER  BY l.TenLop 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllClassTeacher_ViewExamDetail]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllClassTeacher_ViewExamDetail] @idSub int, @idTeacher char(8)
AS 
			
SELECT tmp1.MaLop, tmp1.TenLop, tmp2.MaDangKy, tmp2.NgayThi, tmp2.GioThi, tmp2.TenLoai
FROM (SELECT l.MaLop ,l.TenLop 
			FROM KiemTraHS.dbo.LOP l, KiemTraHS.dbo.PC_GIANGDAY pc, KiemTraHS.dbo.GV_MON gvm
			WHERE l.MaLop =pc.MaLop AND pc.MaPhuTrach =gvm.MaPhuTrach 
			AND gvm.MaGV =@idTeacher AND gvm.MaMon =@idSub) tmp1
LEFT JOIN (SELECT tmp1.MaLop, tmp1.TenLop, tmp1.MaDangKy, CAST(tmp1.ThoiGianBatDau AS date) as NgayThi, CAST(tmp1.ThoiGianBatDau AS time) as GioThi , tmp2.TenLoai
			FROM (SELECT tmp.*, l.TenLop
					FROM (SELECT tmp.*, dk.MaDangKy
							FROM (SELECT lkt.MaLop , MAX(dk.ThoiGianBatDau) as ThoiGianBatDau 
									FROM KiemTraHS.dbo.DANGKYKIEMTRA dk, KiemTraHS.dbo.LOPKT lkt, KiemTraHS.dbo.BAIHOCKT bhkt, 
										KiemTraHS.dbo.BAIHOC b 
									WHERE dk.MaDangKy =lkt.MaDangKy AND dk.MaDangKy =bhkt.MaDangKy AND bhkt.MaBaiHoc =b.MaBaiHoc  
										AND b.MaMon =@idSub
									GROUP BY lkt.MaLop) tmp, DANGKYKIEMTRA dk, LOPKT lkt
							WHERE dk.MaDangKy=lkt.MaDangKy and lkt.MaLop=tmp.MaLop and dk.ThoiGianBatDau=tmp.ThoiGianBatDau) tmp, LOP l
					WHERE tmp.MaLop=l.MaLop) tmp1
			LEFT JOIN (SELECT d.MaDangKy, l.TenLoai 
						FROM KiemTraHS.dbo.DANGKYKIEMTRA d , KiemTraHS.dbo.LOAIKIEMTRA l 
						WHERE d.MaLoai =l.MaLoai ) tmp2
			ON  tmp1.MaDangKy=tmp2.MaDangKy) tmp2
ON tmp1.MaLop= tmp2.MaLop
		
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllExamsOfClass]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllExamsOfClass] @idClass int
AS 
SELECT dk.MaDangKy, lkt.TenLoai , CAST (dk.ThoiGianBatDau as date) as NgayKt, 
	CAST (dk.ThoiGianBatDau as time) as GioKt, dk.ThoiGianLamBai , dk.SoCauHoi, 
	CONCAT(lkt.TenLoai, '        ', CONVERT(varchar, CAST (dk.ThoiGianBatDau as date), 103)) as Display
FROM KiemTraHS.dbo.DANGKYKIEMTRA dk, KiemTraHS.dbo.LOPKT l, KiemTraHS.dbo.LOAIKIEMTRA lkt
WHERE dk.MaDangKy =l.MaDangKy AND l.MaLop =@idClass AND dk.MaLoai =lkt.MaLoai 
ORDER BY dk.ThoiGianBatDau DESC 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllLessonsBySub]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllLessonsBySub] @idSub INT
AS 
BEGIN
	Select b.MaBaiHoc , b.TenBai , b.MaHocKy
	from KiemTraHS.dbo.BAIHOC b , KiemTraHS.dbo.HOCKY h 
	WHERE b.MaHocKy =h.MaHK AND  b.MaMon =@idSub
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllLessonToRegis]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllLessonToRegis] @idSub int, @idClasses VARCHAR(500)
AS 
	DECLARE @flag int;
	EXEC @flag=SP_HaveTheFinalFirstTermExam @idSub, @idClasses;
	
	CREATE TABLE #Lessons(
				MaBaiHoc int,
				TenBai NVARCHAR(MAX),
				MaHK int,
				HocKy NVARCHAR(MAX)
			);
	if 	@flag=0
	begin
		INSERT INTO #Lessons
		Select b.MaBaiHoc , b.TenBai , b.MaHocKy , h.HocKy 
		from KiemTraHS.dbo.BAIHOC b , KiemTraHS.dbo.HOCKY h 
		WHERE b.MaHocKy =h.MaHK AND h.HocKy = N'Học kỳ 1' AND  b.MaMon =@idSub
	end
	else
	BEGIN 
		INSERT INTO #Lessons
		Select b.MaBaiHoc , b.TenBai , b.MaHocKy , h.HocKy 
		from KiemTraHS.dbo.BAIHOC b , KiemTraHS.dbo.HOCKY h 
		WHERE b.MaHocKy =h.MaHK AND  b.MaMon =@idSub
	END
		
	SELECT * FROM #Lessons;
			
	
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllLessonToRegis_Admin]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllLessonToRegis_Admin] @idSub int, @idExamType int
AS 
DECLARE @examType nvarchar(50);

SET @examType= (SELECT TenLoai 
			FROM KiemTraHS.dbo.LOAIKIEMTRA
			WHERE MaLoai =@idExamType);

if @examType like N'%cuối kỳ 1%'
	begin
		SELECT b.MaBaiHoc , b.TenBai , b.MaBaiHoc , h.HocKy
		FROM KiemTraHS.dbo.BAIHOC b, KiemTraHS.dbo.LOAIKIEMTRA l, KiemTraHS.dbo.HOCKY h
		WHERE b.MaMon = @idSub and b.MaHocKy =l.MaHK AND l.MaHK =h.MaHK  AND l.MaLoai =@idExamType
	end
else
	begin
		SELECT b.MaBaiHoc , b.TenBai , b.MaBaiHoc , h.HocKy
		FROM KiemTraHS.dbo.BAIHOC b, KiemTraHS.dbo.LOAIKIEMTRA l, KiemTraHS.dbo.HOCKY h
		WHERE b.MaMon = @idSub and b.MaHocKy =l.MaHK AND l.MaHK =h.MaHK
	end

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllQuesByLesson]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllQuesByLesson] @idLesson int
AS 
SELECT *
FROM KiemTraHS.dbo.NH_CAUHOI
WHERE MaBaiHoc=@idLesson ORDER BY TrangThai DESC 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllStudentOfClass]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllStudentOfClass] @idClass int, @idRegis int
AS

/*UPDATE KiemTraHS.dbo.DIEM 
SET Diem =0
WHERE MaHS IN (select hs.MaHS 
FROM KiemTraHS.dbo.HOCSINH hs , KiemTraHS.dbo.DANGKYKIEMTRA dk, KiemTraHS.dbo.LOPKT lkt, KiemTraHS.dbo.DIEM d
WHERE dk.MaDangKy =lkt .MaDangKy AND lkt.MaLop =hs.MaLop AND dk.MaDangKy =@idRegis AND lkt.MaLop =@idClass
	AND GETDATE()>DATEADD(mi, dk.ThoiGianLamBai ,   dk.ThoiGianBatDau) and dk.MaDangKy=d.MaDangKy and hs.MaHS=d.MaHS and d.Diem IS NULL)

SELECT d.MaHS 
FROM KiemTraHS.dbo.DIEM d , KiemTraHS.dbo.DANGKYKIEMTRA dk, KiemTraHS.dbo.LOPKT l 
WHERE d.MaDangKy =@idRegis and d.MaDangKy =dk.MaDangKy AND dk.MaDangKy =l.MaDangKy and l.MaLop =@idClass*/

DECLARE @startTime datetime;
DECLARE @time int;
SELECT @startTime=ThoiGianBatDau, @time=ThoiGianLamBai
From KiemTraHS.dbo.DANGKYKIEMTRA
WHERE MaDangKy =@idRegis;


if GETDATE()>DATEADD(mi, @time ,   @startTime)
	begin
		INSERT INTO KiemTraHS.dbo.DIEM 
		SELECT tmp1.MaHS, @idRegis, 0
		FROM (SELECT h.MaHS 
						FROM KiemTraHS.dbo.HOCSINH h 
						WHERE h.MaLop =@idClass) tmp1
		LEFT JOIN (SELECT d.MaHS 
							FROM KiemTraHS.dbo.DIEM d , KiemTraHS.dbo.DANGKYKIEMTRA dk, KiemTraHS.dbo.LOPKT l 
							WHERE d.MaDangKy =@idRegis and d.MaDangKy =dk.MaDangKy AND dk.MaDangKy =l.MaDangKy and l.MaLop =@idClass)	tmp2 ON tmp1.MaHS=tmp2.MaHS
		WHERE tmp2.MaHS IS NULL
	end;


		
SELECT tmp1.MaHS, tmp1.Ho, tmp1.Ten, ISNULL(CAST(tmp2.Diem AS varchar), 'Chưa thi') as Diem
FROM (SELECT hs.MaHS , hs.Ho , hs.Ten, (dk.ThoiGianBatDau +dk.ThoiGianLamBai) as ThoiGian
		FROM KiemTraHS.dbo.HOCSINH hs, KiemTraHS.dbo.DANGKYKIEMTRA dk
		WHERE hs.MaLop =@idClass and dk.MaDangKy=@idRegis) tmp1
LEFT JOIN (SELECT d.MaHS , d.Diem 
			FROM KiemTraHS.dbo.DIEM d, KiemTraHS.dbo.HOCSINH h 
			WHERE d.MaDangKy =@idRegis and d.MaHS=h.MaHS and h.MaLop=@idClass) tmp2
ON tmp1.MaHS=tmp2.MaHS




GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSub]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllSub]
AS 
SELECT m.*, k.Khoi 
FROM KiemTraHS.dbo.MON as m, KiemTraHS.dbo.KHOI as k
WHERE m.MaKhoi=k.MaKhoi 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllSubOfGrade_Teacher]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetAllSubOfGrade_Teacher] @idGV char(8)
AS 

SELECT m.MaMon , m.TenMon, tmp.Khoi
FROM KiemTraHS.dbo.GV_MON as gvm, KiemTraHS.dbo.MON as m, 
	(SELECT DISTINCT k.*
		FROM dbo.KHOI AS k, dbo.MON AS m, dbo.GV_MON AS gv
		WHERE gv.MaGV=@idGV AND gv.MaMon=m.MaMon AND m.MaKhoi=k.MaKhoi) as tmp
WHERE gvm.MaGV = @idGV AND  gvm.MaMon = m.MaMon AND  m.MaKhoi = tmp.MaKhoi
ORDER BY m.MaKhoi 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetExam]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetExam]  
    -- Add the parameters for the stored procedure here  
    @idRegis INT,
    @idStudent char(9)  
AS  
BEGIN    
	DECLARE @numQues INT;
	DECLARE @numLesson INT;
	DECLARE @idLesson INT = 0;

	CREATE TABLE #Exam(
				STTCau int NOT NULL IDENTITY PRIMARY KEY,
				MACAUHOI INT,
				NOIDUNG NVARCHAR(MAX),
				A NVARCHAR(MAX),
				B NVARCHAR(MAX),
				C NVARCHAR(MAX),
				D NVARCHAR(MAX),
			);

	-- Lấy ra số câu hỏi của đề
    SET  @numQues =  (Select SoCauHoi
	From DANGKYKIEMTRA   
    where MaDangKy=@idRegis);

	-- Nếu nó là bài kt với nhiều bài học khác nhau thì tiến hành
	-- 1. Đưa tất cả câu hỏi của các bài học vào 1 bảng tạm
	-- 2. random câu nào được đưa vào bài kt
	-- 3. random thứ tự của các câu trả lời
		IF OBJECT_ID(N'tempdb..#TEMP') IS NOT NULL
		BEGIN
		DROP TABLE #TEMP
		END
		CREATE TABLE #TEMP(
			MACAUHOI INT,
			NoiDung NVARCHAR(MAX)
		);
			
		-- Ứng với mỗi bài học, đưa tất cả các mã câu hỏi vào bảng tạm
		INSERT INTO #TEMP
		SELECT MaCauHoi, NoiDung
		FROM NH_CAUHOI WHERE TrangThai=1 and MaBaiHoc IN (
			SELECT MaBaiHoc
			FROM dbo.BAIHOCKT
			WHERE MaDangKy=@idRegis
		)
		DECLARE @tmpCount INT;
		SET @tmpCount= (SELECT COUNT(*) FROM #TEMP);

		IF(@tmpCount>=@numQues)
			BEGIN
				INSERT INTO #Exam(MACAUHOI, NOIDUNG)
				SELECT TOP(@numQues) *
				FROM #TEMP
				ORDER BY NEWID()
				

				DECLARE @index INT=@numQues;
				WHILE(@index>0)
					BEGIN
						DECLARE @tmpIdQues INT;
						SET @tmpIdQues= (SELECT TOP(1) MACAUHOI
						FROM (
							SELECT TOP(@index) STTCau, MACAUHOI
							FROM #Exam
							ORDER BY STTCau
						) AS tmp
						ORDER BY STTCau DESC);
						DECLARE @ThuTuDapAn CHAR(4);
						SELECT @ThuTuDapAn= [dbo].shuffle();

						INSERT INTO dbo.CT_BAITHI
						(
						    MaCauHoi,
						    MaDangKy,
						    ThuTuDapAn,
						    STTCau,
						    MaHS,
						    LuaChon
						)
						VALUES
						(   @tmpIdQues,   -- MaCauHoi - int
						    @idRegis,   -- MaDangKy - int
						    @ThuTuDapAn,  -- ThuTuDapAn - char(10)
						    @index,   -- STTCau - int
						    @idStudent,  -- MaHS - char(9)
						    NULL -- LuaChon - char(1)
						)

						DECLARE @SQL NVARCHAR(MAX)
						
						
						SET @SQL = N'UPDATE #Exam 
									SET A = OtherTable.' + LEFT(@ThuTuDapAn,1) + ', 
										B = OtherTable.' + SUBSTRING(@ThuTuDapAn,2,1) + ', 
										C = OtherTable.' + SUBSTRING(@ThuTuDapAn,3,1) + ',
										D = OtherTable.' + RIGHT(@ThuTuDapAn,1) + '
									FROM (
										SELECT MaCauHoi, A, B, C, D 
										FROM NH_CAUHOI) AS OtherTable
									WHERE 
										OtherTable.MaCauHoi = #Exam.MACAUHOI AND #Exam.MACAUHOI= '+ CAST(@tmpIdQues AS NVARCHAR(10))
						EXEC(@SQL)
						
						SET @index=@index-1;
					END
					SELECT * FROM #Exam;
			END
		ELSE
			BEGIN
				DECLARE @ERROR NVARCHAR(200);
				SET @ERROR = N'Không đủ câu hỏi thi, cần bổ sung thêm ' + CONVERT(NVARCHAR(100), (@numQues - @tmpCount)) + N' câu';
				RAISERROR( @ERROR, 16, 1)
				RETURN
			END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetExamDetail]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetExamDetail] @idStudent char(9), @idRegis int
AS 


CREATE TABLE #Exam(
				STTCau int,
				MACAUHOI INT,
				NOIDUNG NVARCHAR(MAX),
				A NVARCHAR(MAX),
				B NVARCHAR(MAX),
				C NVARCHAR(MAX),
				D NVARCHAR(MAX),
				DapAn char(1),
				LuaChon char(1)
			);

CREATE TABLE #TmpExam(
				STTCau int,
				MACAUHOI INT,
				ThuTuDapAn char(4),
				LuaChon char(1)
			);
		
INSERT INTO #TmpExam
SELECT ct.STTCau , ct.MaCauHoi , ct.ThuTuDapAn , ct.LuaChon 
FROM KiemTraHS.dbo.CT_BAITHI ct
WHERE ct.MaDangKy =@idRegis AND ct.MaHS =@idStudent
ORDER BY ct.STTCau ASC 


DECLARE @numQues int;
SET @numQues=(SELECT COUNT(*) FROM #TmpExam);

DECLARE @index int=@numQues;
While(@index>0)
begin
	DECLARE @STTCau int;
	DECLARE @MaCauHoi int;
	DECLArE @ThuTuDapAn char(4);
	DECLARE @LuaChon char(1);
	/*SELECT TOP(1) @STTCau=tmp.STTCau, @MaCauHoi=tmp.MaCauHoi, @ThuTuDapAn=tmp.ThuTuDapAn, @LuaChon=tmp.LuaChon
	FROM (SELECT TOP(@index) *
			FROM #TmpExam
			ORDER BY STTCau DESC) tmp;*/
	SELECT TOP(1) @STTCau=tmp.STTCau, @MaCauHoi=tmp.MaCauHoi, @ThuTuDapAn=tmp.ThuTuDapAn, @LuaChon=tmp.LuaChon
	FROM (SELECT TOP(@index) *
			FROM #TmpExam
			ORDER BY STTCau) tmp
	ORDER BY STTCau DESC
		
	/*SELECT TOP(@index) *
			FROM #TmpExam
			ORDER BY STTCau DESC
	SELECT TOP(1) tmp.STTCau, tmp.MaCauHoi, tmp.ThuTuDapAn, tmp.LuaChon
	FROM (SELECT TOP(@index) *
			FROM #TmpExam
			ORDER BY STTCau) tmp
	ORDER BY STTCauDESC*/

	
	DECLARE @SQL NVARCHAR(MAX);
	DECLARE @NoiDung nvarchar(MAX);
	DECLARE @a nvarchar(MAX);
	DECLARE @b nvarchar(MAX);
	DECLARE @c nvarchar(MAX);
	DECLARE @d nvarchar(MAX);
	DECLARE @DapAn char(1);
	
	SET @SQL=N'SELECT @NoiDung=NoiDung , @a='+LEFT(@ThuTuDapAn,1)+' , 
				@b='+SUBSTRING(@ThuTuDapAn,2,1)+', @c='+SUBSTRING(@ThuTuDapAn,3,1)+
				', @d='+RIGHT(@ThuTuDapAn,1)+', @DapAn=DapAn 
				FROM KiemTraHS.dbo.NH_CAUHOI
				WHERE MaCauHoi =@MaCauHoi'
	EXECUTE sp_executesql @SQL, N'@MaCauHoi nvarchar(75), @NoiDung nvarchar(MAX) OUTPUT, 
								@a nvarchar(MAX) OUTPUT, @b nvarchar(MAX) OUTPUT, 
								@c nvarchar(MAX) OUTPUT, @d nvarchar(MAX) OUTPUT, 
								@DapAn char(1) OUTPUT', @MaCauHoi = @MaCauHoi, @NoiDung = @NoiDung OUTPUT, 
								@a = @a OUTPUT, @b = @b OUTPUT, @c = @c OUTPUT, 
								@d = @d OUTPUT, @DapAn = @DapAn OUTPUT
	/*SELECT @SQL; 

	EXEC(@SQL)*/
	SET @DapAn = CASE @DapAn
                     WHEN LEFT(@ThuTuDapAn,1) THEN 'A'
                     WHEN SUBSTRING(@ThuTuDapAn,2,1) THEN 'B'
                     WHEN SUBSTRING(@ThuTuDapAn,3,1) THEN 'C'
                     WHEN RIGHT(@ThuTuDapAn,1) THEN 'D'
                   END 
    SET @LuaChon = CASE @LuaChon
                     WHEN LEFT(@ThuTuDapAn,1) THEN 'A'
                     WHEN SUBSTRING(@ThuTuDapAn,2,1) THEN 'B'
                     WHEN SUBSTRING(@ThuTuDapAn,3,1) THEN 'C'
                     WHEN RIGHT(@ThuTuDapAn,1) THEN 'D'
                   END 
                   
	INSERT INTO #Exam
	VALUES(@STTCau, @MaCauHoi, @NoiDung, @a, @b, @c, @d, @DapAn, @LuaChon);

	SET @index=@index-1;
end

SELECT * FROM #Exam
ORDER BY STTCau
GO
/****** Object:  StoredProcedure [dbo].[SP_GetExamTypes]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetExamTypes]
AS 
	SELECT *
	FROM KiemTraHS.dbo.LOAIKIEMTRA
	WHERE TenLoai NOT LIKE N'%cuối kỳ%'
GO
/****** Object:  StoredProcedure [dbo].[SP_GetExamTypes_Admin]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetExamTypes_Admin] @idGrade int
AS 
	SELECT *
	FROM KiemTraHS.dbo.LOAIKIEMTRA
	WHERE TenLoai LIKE N'%cuối kỳ%'
GO
/****** Object:  StoredProcedure [dbo].[SP_GETINFOSTUDENT]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETINFOSTUDENT]
@MAHS CHAR(9)
AS
BEGIN
	SELECT HO + ' ' + TEN AS N' HỌ TÊN', LOP.MALOP, TENLOP 
	FROM (SELECT HO, TEN, MALOP FROM HOCSINH WHERE MAHS = @MAHS) AS HOCSINH, (SELECT MALOP, TENLOP FROM LOP) AS LOP
	WHERE HOCSINH.MaLop = LOP.MaLop
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetInfoTeacher]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetInfoTeacher]
@MAGV CHAR(8)
AS
BEGIN
	SELECT HO + ' ' + TEN AS N'hoten'
FROM KiemTraHS.dbo.GIAOVIEN
WHERE MaGV =@MAGV
END


GO
/****** Object:  StoredProcedure [dbo].[SP_HaveTheFinalFirstTermExam]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HaveTheFinalFirstTermExam] @idSub int, @idClasses VARCHAR(500)
AS 
BEGIN
	CREATE TABLE #tempTable1(
				idGrade int
	);
	INSERT INTO #tempTable1
	EXEC GetIdClassesRegis @idClasses=@idClasses;
	

	DECLARE @result int=0;
	SELECT @result= COUNT(*) FROM (
		SELECT DISTINCT d.MaDangKy 
		FROM KiemTraHS.dbo.DANGKYKIEMTRA d , KiemTraHS.dbo.LOPKT l, KiemTraHS.dbo.BAIHOCKT bhkt , KiemTraHS.dbo.BAIHOC bh, KiemTraHS.dbo.MON m 
		WHERE d.MaDangKy =l.MaDangKy AND d.MaDangKy =bhkt .MaDangKy AND bhkt.MaBaiHoc =bh.MaBaiHoc and bh.MaMon =m.MaMon and m.MaMon =@idSub
			AND d.MaLoai IN (
				SELECT l2.MaLoai  
				FROM KiemTraHS.dbo.LOAIKIEMTRA l2 
				WHERE l2.TenLoai = 'Kiểm tra cuối kỳ 1')
			AND l.MaLop IN (
				SELECT idGrade
				FROM #tempTable1)
	) as tmp
	if (@result >0)
		return 1 ; --Đã thi kỳ 1
	else
		return 0; --Chưa thi kỳ 1
		
END
GO
/****** Object:  StoredProcedure [dbo].[SP_RegisExam]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RegisExam] @idExamType int, @numQues int, @datetimeStart datetime, @timeExam int, @idClasses varchar(500), @idLessons varchar(500)
AS 
	INSERT INTO KiemTraHS.dbo.DANGKYKIEMTRA (ThoiGianBatDau, ThoiGianLamBai, MaLoai, SoCauHoi)
	Values(@datetimeStart, @timeExam, @idExamType, @numQues)
	
	DECLARE @idRegis int;
	SET @idRegis=(SELECT SCOPE_IDENTITY());
	
	CREATE TABLE #tempTableIdLessons(
					id int
		);
	INSERT INTO #tempTableIdLessons
	EXEC GetIdClassesRegis @idLessons;
	
	INSERT INTO KiemTraHS.dbo.BAIHOCKT (MaDangKy, MaBaiHoc)
	SELECT  @idRegis, #tempTableIdLessons.id
	FROM    #tempTableIdLessons
	
	CREATE TABLE #tempTableIdClasses(
					id int
		);
	INSERT INTO #tempTableIdClasses
	EXEC GetIdClassesRegis @idClasses;
	
	INSERT INTO KiemTraHS.dbo.LOPKT (MaDangKy, MaLop)
	SELECT  @idRegis, #tempTableIdClasses.id
	FROM    #tempTableIdClasses
GO
/****** Object:  StoredProcedure [dbo].[SP_Score]    Script Date: 25/12/2021 10:05:50 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Score]  
    -- Add the parameters for the stored procedure here  
    @idRegis INT,
    @idStudent char(9),  
	@Ans VARCHAR(500)
AS  
BEGIN    
	CREATE TABLE #DetailExam(
				MaCauHoi int, 
				STTCau int NOT NULL,
				ThuTuDapAn CHAR(4),
				DapAn CHAR(1),
				LuaChon CHAR(1)
	);

	INSERT INTO #DetailExam
	(
	    STTCau,
	    ThuTuDapAn,
        MaCauHoi
	)
	SELECT STTCau, ThuTuDapAn, MaCauHoi
	FROM dbo.CT_BAITHI
	WHERE MaDangKy=@idRegis AND MaHS=@idStudent
	ORDER BY STTCau

	-- Lưu lại cái đáp án đúng vào bảng tạm #DetailExam

	UPDATE #DetailExam
	SET DapAn = OtherTable.DapAn
	FROM (
		SELECT MaCauHoi, DapAn
		FROM NH_CAUHOI) AS OtherTable
	WHERE #DetailExam.MaCauHoi=OtherTable.MaCauHoi

	DECLARE @numQues INT= LEN(@Ans)
	DECLARE @index INT= @numQues
	WHILE(@index>0)
	BEGIN
		DECLARE @tmpChoices CHAR(4);
		SELECT @tmpChoices=ThuTuDapAn  
		FROM #DetailExam
		WHERE STTCau=@index

		DECLARE @stusChoice CHAR(1)
		SET @stusChoice = RIGHT(@Ans,1)
		SET @Ans=LEFT(@Ans, @index-1)

		SET @stusChoice =
		CASE @stusChoice
		WHEN 'A' THEN LEFT(@tmpChoices, 1)
		WHEN 'B' THEN SUBSTRING(@tmpChoices, 2, 1)
		WHEN 'C' THEN SUBSTRING(@tmpChoices, 3, 1)
		WHEN 'D' THEN RIGHT(@tmpChoices, 1)
		ELSE NULL
		END

		UPDATE dbo.CT_BAITHI
		SET LuaChon=@stusChoice
		WHERE MaDangKy=@idRegis AND MaHS=@idStudent AND STTCau=@index

		UPDATE #DetailExam
		SET LuaChon=@stusChoice
		WHERE STTCau=@index

		SET @index=@index-1
	END
	SELECT * FROM #DetailExam
	DECLARE @score FLOAT=0
	SELECT @score= COUNT(*) 
		FROM #DetailExam
		WHERE DapAn=LuaChon
	SET @score= ROUND((@score/@numQues)*10, 1)
	SELECT @score AS Score
	INSERT INTO dbo.DIEM
	(
	    MaHS,
	    MaDangKy,
	    Diem
	)
	VALUES
	(   @idStudent,  -- MaHS - char(9)
	    @idRegis,   -- MaDangKy - int
	    @score -- Diem - float
	    )
END
GO
USE [master]
GO
ALTER DATABASE [KiemTraHS] SET  READ_WRITE 
GO
