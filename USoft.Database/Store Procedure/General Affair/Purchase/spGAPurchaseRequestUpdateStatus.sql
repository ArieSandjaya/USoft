IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseRequestUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseRequestUpdateStatus'
	DROP PROCEDURE [dbo].[spGAPurchaseRequestUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseRequestUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseRequestUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Purchase Request
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseRequestUpdateStatus
	@pivchRequestID VARCHAR(30),
	@pivchStatus VARCHAR(1),
	@piintApprovalState INT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseRequestUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000)

		-- Reject
		IF (@pivchStatus = 'D')
		BEGIN --1
			UPDATE GA_PORequest
			SET
				Status = @pivchStatus,
				ApprovalState = 0,
				update_date = getdate(),
				update_by = @pivchInputID
			WHERE
				RequestId = @pivchRequestID
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			-- Validation
			IF(
				NOT EXISTS(
					SELECT ''
					FROM GA_PORequestDtl WITH(NOLOCK)
					WHERE
						RequestId = @pivchRequestID
				)
			)
			BEGIN
				SET @ErrMsg = 'Insert Detail Data First'
				GOTO ExitSP
			END
			
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE GA_PORequest
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					RequestId = @pivchRequestID
			
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3					
				UPDATE GA_PORequest
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					RequestId = @pivchRequestID
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
		
		-- Log Approval
		INSERT INTO GA_PApprovalLog (
			ApprovalLogDate,
			IDNumber,
			UserId,
			Status
		)
		SELECT
			GETDATE(),
			@pivchRequestID,
			@pivchInputID,
			CASE
				WHEN @pivchStatus = 'D' THEN 'X'
				WHEN @pivchStatus = 'R' THEN 'A'
				ELSE @pivchStatus
			END AS Status
			
		IF (@@ERROR <> 0)
			GOTO ExitSP
			
	COMMIT TRAN PurchaseRequestUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseRequestUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO    