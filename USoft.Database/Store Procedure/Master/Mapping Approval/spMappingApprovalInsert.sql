IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spMappingApprovalInsert]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spMappingApprovalInsert'
	DROP PROCEDURE [dbo].[spMappingApprovalInsert]
END
GO

PRINT 'CREATE PROCEDURE spMappingApprovalInsert'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spMappingApprovalInsert
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-15
**	Description		: SP untuk Insert Mapping Approval Data
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spMappingApprovalInsert
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
	
	BEGIN TRAN MappingApprovalInsert
		DECLARE
			@ErrMsg VARCHAR(2000),
			@pointApprovalId INT
			
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
			)
		)
		BEGIN
			SET @ErrMsg = 'Data Mapping Approval sudah ada dalam Database'
			GOTO ExitSP
		END
		
		INSERT INTO MsMappingApproval (
			MenuId,
			DepartementCode,
			ParentCode,
			UserIdApproval,
			IsBranch,
			State,
			StateDescription,
			IsActive,
			created_date,
			created_by
		)
		SELECT
			@piintMenuId,
			CASE
				WHEN @pivchDepartementCode = '' THEN NULL
				ELSE @pivchDepartementCode
			END,
			@pivchParentCode,
			CASE
				WHEN @pivchUserIdApproval = '' THEN NULL
				ELSE @pivchUserIdApproval
			END,
			ISNULL(@pibitIsBranch,0),
			@piintState,
			@pivchStateDescription,
			@pibitIsActive,
			GETDATE(),
			@pivchInputID
			
		IF @@ERROR <> 0
			GOTO ExitSP
		
		SELECT @pointApprovalId = IDENT_CURRENT('MsMappingApproval')
			
	COMMIT TRAN MappingApprovalInsert
	RETURN @pointApprovalId
	
	ExitSP:
	BEGIN
		IF @ErrMsg IS NULL
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN MappingApprovalInsert
	END
END
GO

SET NOCOUNT OFF
GO   