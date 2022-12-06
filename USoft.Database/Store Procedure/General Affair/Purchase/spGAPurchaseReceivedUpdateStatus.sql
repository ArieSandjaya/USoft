IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spGAPurchaseReceivedUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
	PRINT 'DROP PROCEDURE spGAPurchaseReceivedUpdateStatus'
	DROP PROCEDURE [dbo].[spGAPurchaseReceivedUpdateStatus]
END
GO

PRINT 'CREATE PROCEDURE spGAPurchaseReceivedUpdateStatus'
GO

/*---------------------------------------------------------------------------
**	SP Name			: spGAPurchaseReceivedUpdateStatus
**	Running On		: 192.168.1.254
**	Database		: U-Soft
**	Created By		: dwi
**	Created Date	: 2013-05-31
**	Description		: SP untuk Verify Purchase Received
**
**	Change Log		:
**	No.		Date	Name		Description
---------------------------------------------------------------------------*/
CREATE PROCEDURE spGAPurchaseReceivedUpdateStatus
	@pivchReceivedID VARCHAR(30),
	@pivchStatus VARCHAR(1),
	@piintApprovalState INT,
	@pivchInputID VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON
	
	BEGIN TRAN PurchaseReceivedUpdateStatus
		DECLARE
			@ErrMsg VARCHAR(2000),
			@RequestID VARCHAR(30),
			@OrderID VARCHAR(30),
			@Status CHAR(1),
			@MinID INT,
			@MaxID INT,
			@ItemGroupName VARCHAR(255),
			@ItemTypeCode VARCHAR(10),
			@ItemTypeName VARCHAR(255),
			@RequestQty FLOAT,
			@CurrentQty FLOAT,
			@ReceivedQty FLOAT

		DECLARE @tmpItem AS TABLE (
			ID INT IDENTITY,
			RequestId VARCHAR(30),
			ItemGroupName VARCHAR(255),
			ItemTypeCode VARCHAR(10),
			ItemTypeName VARCHAR(255),
			RequestQty FLOAT,
			CurrentQty FLOAT,
			ReceivedQty FLOAT
		)

		-- Reject
		IF (@pivchStatus = 'D')
		BEGIN --1
			UPDATE GA_POReceived
			SET
				Status = @pivchStatus,
				ApprovalState = 0,
				update_date = getdate(),
				update_by = @pivchInputID
			WHERE
				ReceivedId = @pivchReceivedID
			
			IF @@ERROR <> 0
				GOTO ExitSP
		END --1
		ELSE
		BEGIN
			-- Begin Validation
			IF(
				NOT EXISTS(
					SELECT ''
					FROM GA_POReceivedDtl WITH(NOLOCK)
					WHERE
						ReceivedId = @pivchReceivedID
				)
			)
			BEGIN
				SET @ErrMsg = 'Insert Detail Data First'
				GOTO ExitSP
			END
			
			SELECT
				@OrderID = b.OrderId,
				@Status = b.Status
			FROM
				GA_POReceived AS a WITH(NOLOCK)
				INNER JOIN GA_POrder AS b WITH(NOLOCK) ON
					a.OrderId = b.OrderId
			WHERE
				a.ReceivedId = @pivchReceivedID
				
			IF (@Status <> 'A')
			BEGIN
				SET @ErrMsg = 'Order ID ' + @OrderID + ' has not been Approve'
				GOTO ExitSP
			END

			INSERT INTO @tmpItem
			SELECT
				a.RequestId,
				d.ItemGroupName,
				c.ItemTypeCode,
				c.ItemTypeName,
				a.Quantity AS RequestQty,
				(
					SELECT
						ISNULL(SUM(x.Quantity),0)
					FROM
						GA_POReceivedDtl AS x WITH(NOLOCK)
						INNER JOIN GA_POReceived AS y WITH(NOLOCK) ON
							x.ReceivedId = y.ReceivedId
					WHERE
						x.RequestDetailId = a.RequestDetailId
						AND y.Status = 'A'

				) AS CurrentQty,
				b.Quantity AS ReceivedQty
			FROM
				GA_PORequestDtl AS a WITH(NOLOCK)
				INNER JOIN GA_POReceivedDtl AS b WITH(NOLOCK) ON
					a.RequestDetailId = b.RequestDetailId
				INNER JOIN GA_ItemType AS c WITH(NOLOCK) ON
					a.ItemTypeCode = c.ItemTypeCode
				INNER JOIN GA_ItemGroup AS d WITH(NOLOCK) ON
					c.ItemGroupCode = d.ItemGroupCode
			WHERE
				b.ReceivedId = @pivchReceivedID

			SELECT @MinID = MIN(ID), @MaxID = MAX(ID) FROM @tmpItem
			
			WHILE(@MinID <= @MaxID)
			BEGIN
				SELECT
					@RequestId = RequestId,
					@ItemGroupName = ItemGroupName,
					@ItemTypeCode = ItemTypeCode,
					@ItemTypeName = ItemTypeName,
					@RequestQty = RequestQty,
					@CurrentQty = CurrentQty,
					@ReceivedQty = ReceivedQty
				FROM
					@tmpItem
				WHERE
					ID = @MinID

				IF (
					(@RequestQty < (@CurrentQty + @ReceivedQty))
					OR
					(@ReceivedQty <= 0)
				)
				BEGIN
					SET @ErrMsg = 'Invalid Item Quantity ' + @RequestID + ' - ' + @ItemGroupName + ' - ' + @ItemTypeName + ', Request Quantity = ' + CONVERT(VARCHAR,@RequestQty) + ', Outstanding Received Quantity = ' + CONVERT(VARCHAR,@CurrentQty) + ', Received Quantity = ' + CONVERT(VARCHAR,@ReceivedQty)
					GOTO ExitSP
				END

				SET @MinID = @MinID + 1
			END
			-- End Validation
			
			-- RFA
			IF (@pivchStatus = 'R')
			BEGIN --2
				UPDATE GA_POReceived
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ReceivedId = @pivchReceivedID
			
				IF @@ERROR <> 0
					GOTO ExitSP
			END --2
			-- Approve
			ELSE IF (@pivchStatus = 'A')
			BEGIN --3					
				UPDATE GA_POReceived
				SET
					Status = @pivchStatus,
					ApprovalState = ISNULL(@piintApprovalState,0) + 1,
					update_date = getdate(),
					update_by = @pivchInputID
				WHERE
					ReceivedId = @pivchReceivedID
				
				IF @@ERROR <> 0
					GOTO ExitSP
					
				SELECT @MinID = MIN(ID), @MaxID = MAX(ID) FROM @tmpItem

				WHILE (@MinID <= @MaxID)
				BEGIN
					UPDATE a
					SET
						a.Quantity = a.Quantity + b.ReceivedQty,
						a.RequestQty = a.RequestQty - b.ReceivedQty,
						a.update_date = GETDATE(),
						a.update_by = @pivchInputID
					FROM
						GA_Item AS a WITH(NOLOCK)
						INNER JOIN @tmpItem AS b ON
							a.ItemTypeCode = b.ItemTypeCode
					WHERE
						a.BranchId IS NULL
						AND	b.ID = @MinID
			
					IF(@@ROWCOUNT = 0)
					BEGIN
						SET @ErrMsg = 'Master Item Not Found'
						GOTO ExitSP
					END

					IF (@@ERROR <> 0)
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
			@pivchReceivedID,
			@pivchInputID,
			CASE
				WHEN @pivchStatus = 'D' THEN 'X'
				WHEN @pivchStatus = 'R' THEN 'A'
				ELSE @pivchStatus
			END AS Status
			
		IF (@@ERROR <> 0)
			GOTO ExitSP
			
	COMMIT TRAN PurchaseReceivedUpdateStatus
	RETURN
	
	ExitSP:
	BEGIN
		IF(@ErrMsg IS NULL)
		BEGIN
			SELECT @ErrMsg = LTRIM(STR(@@ERROR))
		END
		
		RAISERROR(@ErrMsg, 16, 1)
		ROLLBACK TRAN PurchaseReceivedUpdateStatus
	END
END
GO

SET NOCOUNT OFF
GO