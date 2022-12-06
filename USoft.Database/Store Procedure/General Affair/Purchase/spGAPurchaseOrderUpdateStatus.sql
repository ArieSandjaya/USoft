IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseOrderUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseOrderUpdateStatus'
	DROP PROCEDURE [dbo].[spGAPurchaseOrderUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseOrderUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseOrderUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Purchase Order
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseOrderUpdateStatus
	@pivchOrderID VARCHAR(30),
	@pivchStatus VARCHAR(1),
	@piintApprovalState INT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseOrderUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@RequestID VARCHAR(30),
			@OrderID VARCHAR(30),
			@Status CHAR(1),
			@MinID INT,
			@MaxID INT

		DECLARE @tmpItem AS TABLE (
			ID INT IDENTITY,
			ItemTypeCode VARCHAR(10),
			RequestQty FLOAT		
		)			

		-- Reject
		IF (@pivchStatus = 'D')
		BEGIN --1
			UPDATE GA_POrder
			SET
				Status = @pivchStatus,
				ApprovalState = 0,
				update_date = getdate(),
				update_by = @pivchInputID
			WHERE
				OrderId = @pivchOrderID
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			-- Validation
			IF(
				NOT EXISTS(
					SELECT ''
					FROM GA_POrderDtl WITH(NOLOCK)
					WHERE
						OrderId = @pivchOrderID
				)
			)
			BEGIN
				SET @ErrMsg = 'Insert Detail Data First'
				GOTO ExitSP
			END
			
			SELECT TOP 1
				@RequestID = b.RequestId,
				@OrderID = b.OrderId,
				@Status = b.Status
			FROM
				GA_POrderDtl AS a WITH(NOLOCK)
				INNER JOIN GA_PORequest AS b WITH(NOLOCK) ON
					a.RequestId = b.RequestId
			WHERE
				a.OrderId = @pivchOrderID
				AND (
					ISNULL(b.OrderId,'') <> ''
					OR
					b.Status <> 'A'
				)
				
			IF (@RequestID IS NOT NULL)
			BEGIN
				IF (ISNULL(@OrderID,'') <> '')
				BEGIN
					SET @ErrMsg = 'Request ID ' + @RequestID + ' already order with Order ID ' + @OrderId
					GOTO ExitSP
				END
				ELSE IF (@Status <> 'A')
				BEGIN
					SET @ErrMsg = 'Request ID ' + @RequestID + ' has not been Approve'
					GOTO ExitSP
				END
			END
			
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE GA_POrder
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					OrderId = @pivchOrderID
			
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3					
				UPDATE GA_POrder
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					OrderId = @pivchOrderID
				
				IF @@ERROR <> 0
					GOTO ExitSP
					
				UPDATE a
				SET
					a.OrderId = @pivchOrderID
				FROM
					GA_PORequest AS a WITH(NOLOCK)
					INNER JOIN GA_POrderDtl AS b WITH(NOLOCK) ON
						a.RequestId = b.RequestId
				WHERE
					b.OrderId = @pivchOrderID
					
				IF @@ERROR <> 0
					GOTO ExitSP

				
				-- Insert Data To Master Item
				INSERT INTO @tmpItem (
					ItemTypeCode,
					RequestQty
				)
				SELECT
					a.ItemTypeCode,
					SUM(Quantity) AS RequestQty
				FROM
					GA_PORequestDtl AS a WITH(NOLOCK)
					INNER JOIN GA_POrderDtl AS b WITH(NOLOCK) ON
						a.RequestId = b.RequestId
				WHERE
					b.OrderId = @pivchOrderID
				GROUP BY
					a.ItemTypeCode

				SELECT @MinID = MIN(ID), @MaxID = MAX(ID) FROM @tmpItem

				WHILE (@MinID <= @MaxID)
				BEGIN
					UPDATE a
					SET
						a.RequestQty = a.RequestQty + b.RequestQty,
						a.update_date = GETDATE(),
						a.update_by = @pivchInputID
					FROM
						GA_Item AS a WITH(NOLOCK)
						INNER JOIN @tmpItem AS b ON
							a.ItemTypeCode = b.ItemTypeCode
					WHERE
						b.ID = @MinID

					IF(@@ROWCOUNT = 0)
					BEGIN
						INSERT INTO GA_Item (
							ItemCode,
							ItemTypeCode,
							Quantity,
							RequestQty,
							IsActive,
							created_date,
							created_by
						)
						SELECT
							dbo.fnGenGAItemNo(),
							ItemTypeCode,
							0,
							RequestQty,
							1,
							GETDATE(),
							@pivchInputID
						FROM
							@tmpItem
						WHERE
							ID = @MinID
					END

					IF @@ERROR <> 0
						GOTO ExitSP
					
					SET @MinID = @MinID + 1
				END
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
			@pivchOrderID,
			@pivchInputID,
			CASE
				WHEN @pivchStatus = 'D' THEN 'X'
				WHEN @pivchStatus = 'R' THEN 'A'
				ELSE @pivchStatus
			END AS Status
			
		IF (@@ERROR <> 0)
			GOTO ExitSP
			
	COMMIT TRAN PurchaseOrderUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseOrderUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO     