USE [IT_ticketing_system]
GO
/****** Object:  Table [dbo].[SubAdmins]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubAdmins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[JobField] [nvarchar](100) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TicketMessages]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketMessages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [nvarchar](50) NULL,
	[UserName] [nvarchar](100) NULL,
	[Message] [nvarchar](max) NULL,
	[SentDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[TicketId] [nvarchar](50) NOT NULL,
	[Subject] [nvarchar](200) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Status] [nvarchar](20) NULL,
	[AssignedTo] [nvarchar](50) NULL,
	[AttachmentPath] [nvarchar](200) NULL,
	[AttachmentData] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[State] [nvarchar](100) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TicketMessages] ADD  DEFAULT (getdate()) FOR [SentDate]
GO
/****** Object:  StoredProcedure [dbo].[sp_AssignTicket]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AssignTicket]
    @TicketId VARCHAR(50), 
    @SubAdminId INT
AS
BEGIN
    UPDATE Tickets
    SET AssignedTo = @SubAdminId
    WHERE TicketId = @TicketId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateSubAdmin]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateSubAdmin]
    @Name NVARCHAR(100),
    @JobField NVARCHAR(100),
    @Username NVARCHAR(50),
    @Email NVARCHAR(100),
    @Password NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SubAdmins (Name, JobField, Username, Email, Password)
    VALUES (@Name, @JobField, @Username, @Email, @Password);
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteSubAdmin]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_DeleteSubAdmin]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM SubAdmins
    WHERE Id = @Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllTickets]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllTickets]
AS
BEGIN
    SELECT 
    t.TicketId,
    t.UserName,
    t.Subject,
    t.Category,
	t.AttachmentPath,
	t.AttachmentData,
    t.CreationDate,
    t.Status,
    sa.Name AS AssignedTo
FROM 
    Tickets t
LEFT JOIN 
    SubAdmins sa ON t.AssignedTo = sa.Id
ORDER BY 
    t.CreationDate DESC;
End
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMessagesByTicketId]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetMessagesByTicketId]
    @TicketId NVARCHAR(50)
AS
BEGIN
    SELECT Id, TicketId, UserName, Message, SentDate
    FROM TicketMessages
    WHERE TicketId = @TicketId
    ORDER BY SentDate ASC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTicketsByUserName]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTicketsByUserName]
    @Username NVARCHAR(100)
AS
BEGIN
    SELECT TicketId, Subject, Category, CreationDate, UserName, Status,AttachmentPath,AttachmentData
    FROM Tickets
    WHERE UserName = @Username
    ORDER BY CreationDate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTicket]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertTicket]
    @UserName NVARCHAR(100),
    @TicketId NVARCHAR(50),
    @Subject NVARCHAR(200),
    @Category NVARCHAR(50),
    @CreationDate DATETIME,
	@Status NVARCHAR(50) NULL,
	@AssignedTo NVARCHAR(50) NULL,
	@AttachmentPath NVARCHAR(MAX) NULL,
	@AttachmentData VARBINARY(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert values into the Tickets table
    INSERT INTO Tickets (UserName, TicketId, Subject, Category, CreationDate,Status,AssignedTo,AttachmentPath,AttachmentData) 
	VALUES (@UserName, @TicketId, @Subject, @Category, @CreationDate,@Status,@AssignedTo,@AttachmentPath,@AttachmentData);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RegisterUser]
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @PhoneNumber NVARCHAR(20),
    @Email NVARCHAR(100),
    @Address NVARCHAR(255),
    @State NVARCHAR(100),
    @City NVARCHAR(100),
    @Username NVARCHAR(100),
    @PasswordHash NVARCHAR(255)
AS
BEGIN
    INSERT INTO Users (FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, Address, State, City, Username, PasswordHash)
    VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @PhoneNumber, @Email, @Address, @State, @City, @Username, @PasswordHash)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SendMessageToUser]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SendMessageToUser]
    @TicketId NVARCHAR(50),
    @UserName NVARCHAR(100),
    @Message NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO TicketMessages (TicketId, UserName, Message, SentDate)
    VALUES (@TicketId, @UserName, @Message, GETDATE());
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateSubAdmin]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateSubAdmin]
    @Id INT,
    @Name NVARCHAR(100),
    @JobField NVARCHAR(100),
    @Username NVARCHAR(100),
    @Email NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    UPDATE SubAdmins
    SET Name = @Name,
        JobField = @JobField,
        Username = @Username,
        Email = @Email,
        Password = @Password
    WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateTicketStatus]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateTicketStatus]
    @TicketId NVARCHAR(50),
    @Status NVARCHAR(50)
AS
BEGIN
    UPDATE Tickets
    SET Status = @Status
    WHERE TicketId = @TicketId;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateSubAdmin]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ValidateSubAdmin]
    @Username NVARCHAR(100)
AS
BEGIN
    SELECT Password
    FROM SubAdmins
    WHERE Username = @Username
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateUser]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidateUser]
    @Username NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Fetch the password hash for the given username
    SELECT PasswordHash FROM Users WHERE Username = @Username;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_ViewAllSubAdmins]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ViewAllSubAdmins]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id, Name, JobField, Username, Email, Password
    FROM SubAdmins;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ViewAllTickets]    Script Date: 23-12-2024 1.32.55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ViewAllTickets]
AS
BEGIN
    SELECT Id,Category, Subject, 
           (SELECT Name FROM SubAdmins WHERE SubAdmins.Id = Tickets.AssignedTo) AS AssignedTo
    FROM Tickets
END
GO
