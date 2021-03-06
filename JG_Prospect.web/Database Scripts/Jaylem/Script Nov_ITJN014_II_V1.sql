/****** Object:  StoredProcedure [dbo].[UDP_ForgotPasswordReset]    Script Date: 05-12-2016 05:32:00 PM ******/
DROP PROCEDURE [dbo].[UDP_ForgotPasswordReset]
GO
/****** Object:  StoredProcedure [dbo].[UDP_ForgotPasswordReset]    Script Date: 05-12-2016 05:32:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jaylem
-- Create date: 05-Dec-2016
-- Description:	Update password
-- =============================================
CREATE PROCEDURE [dbo].[UDP_ForgotPasswordReset] 
	@Login_Id varchar(50) = '', 
	@NewPassword varchar(50) = '', 
	@IsCustomer Bit,
	@result int output
AS
BEGIN
	SET NOCOUNT ON;
	Set @result ='0'


	If @IsCustomer = 0
	BEGIN
		IF EXISTS (SELECT Id FROM tblUsers WHERE Login_Id=@Login_Id)
		BEGIN
			UPDATE tblUsers Set [Password]=@NewPassword WHERE Login_Id = @Login_Id
			Set @result ='1'
		END
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT Id FROM new_customer WHERE (Email = @Login_Id OR CellPh = @Login_Id) AND Email != 'noEmail@blankemail.com')
		BEGIN
			UPDATE new_customer Set [Password]=@NewPassword WHERE (Email = @Login_Id OR CellPh = @Login_Id) AND Email != 'noEmail@blankemail.com'
			Set @result ='1'
		END
	END

	RETURN @result

END

GO
