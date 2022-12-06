IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalUpdate]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalUpdate'
	DROP PROCEDURE [dbo].[spMappingApprovalUpdate]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalUpdate'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalUpdate
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Update Activity Task Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalUpdate
	@piintApprovalId INT,
	@piintMenuId INT,
    @pivchDepartementCode VARCHAR(2),
    @pivchParentCode VARCHAR(5),
    @pivchUserIdApproval VARCHAR(50),
    @pibitIsBranch BIT,
    @piintState INT,
    @pivchStateDescription VARCHAR(255),
    @pibitIsActive BIT,
	@pivchInputID VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN MappingApprovalUpdate
		DECLARE
			@ErrMsg VARCHAR(2000)
				
		IF(
			EXISTS(
				SELECT ''
				FROM MsMappingApproval WITH(NOLOCK)
				WHERE
					MenuId = @piintMenuId
					AND ISNULL(DepartementCode,'') = @pivchDepartementCode
					AND ParentCode = @pivchParentCode
					AND ISNULL(IsBranch,0) = @pibitIsBranch
					AND State = @piintState
					AND ApprovalID <> @piintApprovalId
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Mapping Approval sudah ada dalam Database'
			GOTO ExitSP
		END
		
		UPDATE MsMappingApproval
		SET
			MenuId = @piintMenuId,
			DepartementCode = CASE
								WHEN @pivchDepartementCode = '' THEN NULL
								ELSE @pivchDepartementCode
							END,
			ParentCode = @pivchParentCode,
			UserIdApproval = CASE
								WHEN @pivchUserIdApproval = '' THEN NULL
								ELSE @pivchUserIdApproval
							END,
			IsBranch = ISNULL(@pibitIsBranch,0),
			State = @piintState,
			StateDescription = @pivchStateDescription,
			IsActive = @pibitIsActive,
			update_date = GETDATE(),
			update_by = @pivchInputID
		WHERE
			ApprovalID = @piintApprovalID
	
		IF @@ERROR <> 0
			GOTO ExitSP
			
	COMMIT TRAN MappingApprovalUpdate
	RETURN
	
	ExitSP:
	BEGIN
		SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalUpdate
	END
END
GO

SET NOCOUNT OFF
GO     