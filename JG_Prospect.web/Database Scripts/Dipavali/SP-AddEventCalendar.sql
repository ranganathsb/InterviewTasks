USE [JGBS_Interview]
GO
/****** Object:  StoredProcedure [dbo].[AddEventCalendar]    Script Date: 12-01-2017 PM 06:25:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[AddEventCalendar] 
	-- Add the parameters for the stored procedure here
	@CalendarName varchar(100),
    @InsertionDate datetime,
	@UserId int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into dbo.tbl_EventCalendar 
	(CalendarName,InsertionDate,UserId)
	values
	(@CalendarName,@InsertionDate,@UserId)

END
