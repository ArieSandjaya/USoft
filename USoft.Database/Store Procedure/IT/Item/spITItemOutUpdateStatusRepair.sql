IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spITItemOutUpdateStatusRepair]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spITItemOutUpdateStatusRepair'
	DROP PROCEDURE [dbo].[spITItemOutUpdateStatusRepair]
END
GO

PRINT 'CREATE PROCEDURE spITItemOutUpdateStatusRepair'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spITItemOutUpdateStatusRepair
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: z.alfarisi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Item-Out
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spITItemOutUpdateStatusRepair
	@pivchItemOutCode VARCHAR(8),
	@pivchRepairStatus VARCHAR(1),
	@piintRepairState INT,
	@piintRepairCondition INT,
	@pivchRepairDescription VARCHAR(255),
	@pivchInputBy VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN ItemOutUpdateStatusRepair
		DECLARE
			@ErrMsg VARCHAR(2000),
			@ITItemCode VARCHAR(10),
			@RepairState INT,
			@RepairCondition INT
		
		-- Reject
		IF (@pivchRepairStatus = 'D')
		BEGIN --1
			UPDATE IT_ItemOut
			SET
				RepairStatus = @pivchRepairStatus,
				ApprovalState = 3,
				update_date = getdate(),
				update_by = @pivchInputBy
			WHERE
				ITItemOutCode = @pivchItemOutCode
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			SELECT
				@ITItemCode = ITItemCode,
				@RepairState = RepairState,
				@RepairCondition = RepairCondition
			FROM
				IT_ItemOut WITH(NOLOCK)
			WHERE
				ITItemOutCode = @pivchItemOutCode
			
			-- RFA
			IF (@pivchRepairStatus = 'R')
			BEGIN --2
				UPDATE IT_ItemOut
				SET
					RepairStatus = @pivchRepairStatus,
					RepairState = @piintRepairState,
					RepairCondition = CASE
										WHEN @piintRepairState = '1' THEN @piintRepairCondition
										ELSE NULL
									END,
					RepairDescription = @pivchRepairDescription,
					ApprovalState = 4,
					created_by = @pivchInputBy,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchRepairStatus = 'A')
			BEGIN --3
				UPDATE IT_ItemOut
				SET
					RepairStatus = @pivchRepairStatus,
					ApprovalState = 5,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemOutCode = @pivchItemOutCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
					
				INSERT INTO IT_Item_History
				SELECT * FROM IT_Item WITH(NOLOCK) WHERE ITItemCode = @ITItemCode
				
				IF @@ERROR <> 0
					GOTO ExitSP
				
				UPDATE IT_Item
				SET
					ITItemOutCode = CASE
										WHEN @RepairState = '1' THEN NULL -- Return
										ELSE ITItemOutCode
									END,
					ConditionCode = CASE
										WHEN @RepairState = '1' THEN @RepairCondition -- Return
										ELSE ConditionCode
									END,
					IsActive = CASE
									WHEN @RepairState = '2' THEN 0
									ELSE IsActive
								END,
					StatusOut = CASE
									WHEN @RepairState = '1' THEN 3 -- Return
									WHEN @RepairState = '2' THEN 4 -- Replace
									ELSE ITItemOutCode
								END,
					update_date = getdate(),
					update_by = @pivchInputBy
				WHERE
					ITItemCode = @ITItemCode
					
				IF @@ERROR <> 0
					GOTO ExitSP
			END --3
		END
			
	COMMIT TRAN ItemOutUpdateStatusRepair
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN ItemOutUpdateStatusRepair
	END
END
GO

SET NOCOUNT OFF
GO 