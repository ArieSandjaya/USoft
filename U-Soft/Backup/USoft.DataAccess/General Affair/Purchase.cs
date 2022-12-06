using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.General_Affair
{
    public class Purchase : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchIDNumber = "@pivchIDNumber";
        string povchRequestId = "@povchRequestId";
        string pivchRequestId = "@pivchRequestId";
        string povchOrderId = "@povchOrderId";
        string pivchOrderId = "@pivchOrderId";
        string povchReceivedId = "@povchReceivedId";
        string pivchReceivedId = "@pivchReceivedId";
        string pidtmRequestDate = "@pidtmRequestDate";
        string pidtmOrderDate = "@pidtmOrderDate";
        string pidtmReceivedDate = "@pidtmReceivedDate";
        string pichrType = "@pichrType";
        string pivchReason = "@pivchReason";
        string pivchSupplierCode = "@pivchSupplierCode";
        string pivchPIC = "@pivchPIC";
        string pidtmDeliveryDate = "@pidtmDeliveryDate";
        string pivchOfferFrom = "@pivchOfferFrom";
        string pivchOfferNo = "@pivchOfferNo";
        string pidtmOfferDate = "@pidtmOfferDate";
        string pivchStatus = "pivchStatus";

        string pivchRequestDetailID = "@pivchRequestDetailID";
        string pivchOrderDetailID = "@pivchOrderDetailID";
        string pivchReceivedDetailID = "@pivchReceivedDetailID";
        string pivchItemTypeCode = "@pivchItemTypeCode";
        string pidblQuantity = "@pidblQuantity";
        string pivchMeasurementCode = "@pivchMeasurementCode";
        string pimonPrice = "@pimonPrice";
        string pivchCurrencyCode = "@pivchCurrencyCode";
                
        // Store Procedure
        string spGAPurchaseApprovalLog = "spGAPurchaseApprovalLog";
        string spGAPurchaseRequestList = "spGAPurchaseRequestList";
        string spGAPurchaseRequestInsert = "spGAPurchaseRequestInsert";
        string spGAPurchaseRequestUpdate = "spGAPurchaseRequestUpdate";
        string spGAPurchaseRequestView = "spGAPurchaseRequestView";
        string spGAPurchaseRequestUpdateStatus = "spGAPurchaseRequestUpdateStatus";

        string spGAPurchaseRequestDetailList = "spGAPurchaseRequestDetailList";
        string spGAPurchaseRequestDetailInsert = "spGAPurchaseRequestDetailInsert";
        string spGAPurchaseRequestDetailUpdate = "spGAPurchaseRequestDetailUpdate";
        string spGAPurchaseRequestDetailDelete = "spGAPurchaseRequestDetailDelete";
        string spGAPurchaseRequestDetailView = "spGAPurchaseRequestDetailView";

        string spGAPurchaseOrderList = "spGAPurchaseOrderList";
        string spGAPurchaseOrderInsert = "spGAPurchaseOrderInsert";
        string spGAPurchaseOrderUpdate = "spGAPurchaseOrderUpdate";
        string spGAPurchaseOrderView = "spGAPurchaseOrderView";
        string spGAPurchaseOrderUpdateStatus = "spGAPurchaseOrderUpdateStatus";

        string spGAPurchaseOrderRequestDetailList = "spGAPurchaseOrderRequestDetailList";
        string spGAPurchaseOrderDetailList = "spGAPurchaseOrderDetailList";
        string spGAPurchaseOrderDetailInsert = "spGAPurchaseOrderDetailInsert";
        string spGAPurchaseOrderDetailDelete = "spGAPurchaseOrderDetailDelete";

        string spGAPurchaseReceivedList = "spGAPurchaseReceivedList";
        string spGAPurchaseReceivedInsert = "spGAPurchaseReceivedInsert";
        string spGAPurchaseReceivedUpdate = "spGAPurchaseReceivedUpdate";
        string spGAPurchaseReceivedView = "spGAPurchaseReceivedView";
        string spGAPurchaseReceivedUpdateStatus = "spGAPurchaseReceivedUpdateStatus";

        string spGAPurchaseReceivedRequestDetailList = "spGAPurchaseReceivedRequestDetailList";
        string spGAPurchaseReceivedDetailList = "spGAPurchaseReceivedDetailList";
        string spGAPurchaseReceivedDetailInsert = "spGAPurchaseReceivedDetailInsert";
        string spGAPurchaseReceivedDetailDelete = "spGAPurchaseReceivedDetailDelete";
        string spGAPurchaseReceivedDetailUpdate = "spGAPurchaseReceivedDetailUpdate";
        string spGAPurchaseReceivedDetailView = "spGAPurchaseReceivedDetailView";

        string spGAPurchaseRequestApprovalList = "spGAPurchaseRequestApprovalList";

        // Field Name
        string RequestId = "RequestId";
        string RequestDate = "RequestDate";
        string OrderId = "OrderId";
        string OrderDate = "OrderDate";
        string ReceivedId = "ReceivedId";
        string ReceivedDate = "ReceivedDate";
        string Type = "Type";
        string Reason = "Reason";
        string SupplierCode = "SupplierCode";
        string SupplierName = "SupplierName";
        string DeliveryDate = "DeliveryDate";
        string PIC = "PIC";
        string OfferFrom = "OfferFrom";
        string OfferNo = "OfferNo";
        string OfferDate = "OfferDate";

        string RequestDetailId = "RequestDetailId";
        string ItemCategoryCode = "ItemCategoryCode";
        string ItemCategoryName = "ItemCategoryName";
        string ItemGroupCode = "ItemGroupCode";
        string ItemGroupName = "ItemGroupName";
        string ItemTypeCode = "ItemTypeCode";
        string ItemTypeName = "ItemTypeName";
        string RequestQty = "RequestQty";
        string CurrentQty = "CurrentQty";
        string Quantity = "Quantity";
        string MeasurementCode = "MeasurementCode";
        string Price = "Price";
        string CurrencyCode = "CurrencyCode";
        string Total = "Total";

        public DataSet getPurchase(ref USoft.DataAccess.Entities.General_Affair.Purchase info, int state)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sp = "";

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchWhereBy;
            sqlParam.Value = info.WhereBy;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintPageNo;
            sqlParam.Value = info.PageNo;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintPageSize;
            sqlParam.Value = info.PageSize;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pointTotalPage;
            sqlParam.Value = info.TotalPage;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pointTotalData;
            sqlParam.Value = info.TotalData;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            try
            {
                switch (state)
                {
                    case 1: sp = spGAPurchaseRequestList; break;
                    case 2: sp = spGAPurchaseOrderList; break;
                    case 3: sp = spGAPurchaseReceivedList; break;
                    case 4: sp = spGAPurchaseRequestApprovalList; break;
                }

                ds = sqlHandler.ExecuteAsDataSet(sp, ref ListParam);

                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == pointTotalPage) { info.TotalPage = Convert.ToInt32(sqlParamOut.Value); continue; }
                    if (sqlParamOut.ParameterName == pointTotalData) { info.TotalData = Convert.ToInt32(sqlParamOut.Value); continue; }
                }
                return ds;
            }
            catch
            { throw; }
        }

        public void getPurchaseRequestView(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAPurchaseRequestView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.RequestId = dr[RequestId].ToString();
                        info.RequestDate = Convert.ToDateTime(dr[RequestDate].ToString());
                        info.Type = dr[Type].ToString();
                        info.Reason = dr[Reason].ToString();
                        info.SupplierCode = dr[SupplierCode].ToString();
                        info.SupplierName = dr[SupplierName].ToString();
                        info.Total = Convert.ToDouble(dr[Total].ToString());
                        info.CurrencyCode = dr[CurrencyCode].ToString();
                        info.BranchId = Convert.ToInt32(dr[BranchId].ToString());
                        info.BranchName = dr[BranchName].ToString();
                        info.DepartementName = dr[DepartementName].ToString();
                        info.Description = dr[Description].ToString();
                        info.CreatedBy = dr[CreatedBy].ToString();
                        info.CreatedName = dr[CreatedName].ToString();
                        info.UpdateBy = dr[UpdateBy].ToString();
                        info.UpdateName = dr[UpdateName].ToString();
                        info.Status = dr[Status].ToString();
                        info.ApprovalState = Convert.ToInt32(dr[ApprovalState].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public string PurchaseRequestInsert(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = povchRequestId;
            sqlParam.Value = info.RequestId;
            sqlParam.Size = 30;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmRequestDate;
            sqlParam.Value = info.RequestDate;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pichrType;
            sqlParam.Value = info.Type;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchReason;
            sqlParam.Value = info.Reason;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchSupplierCode;
            sqlParam.Value = info.SupplierCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchCurrencyCode;
            sqlParam.Value = info.CurrencyCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchDescription;
            sqlParam.Value = info.Description;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseRequestInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == povchRequestId) { info.RequestId = sqlParamOut.Value.ToString(); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseRequestUpdate(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmRequestDate, info.RequestDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pichrType, info.Type));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReason, info.Reason));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierCode, info.SupplierCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchCurrencyCode, info.CurrencyCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseRequestUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseRequestUpdateStatus(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg = "";

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalState, info.ApprovalState));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseRequestUpdateStatus, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public DataSet getPurchaseRequestDetail(USoft.DataAccess.Entities.General_Affair.Purchase info, int state)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sp = "";

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId)); 
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchWhereBy, info.WhereBy));

            try
            {
                switch (state)
                {
                    case 1 : sp = spGAPurchaseRequestDetailList; break;
                    case 2 : sp = spGAPurchaseOrderRequestDetailList; break;
                    case 3 : sp = spGAPurchaseReceivedRequestDetailList; break;
                }

                return sqlHandler.ExecuteAsDataSet(sp, ParameterCollection);
            }
            catch
            { throw; }
        }

        public void getPurchaseRequestDetailView(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestDetailID, info.RequestDetailId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAPurchaseRequestDetailView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.RequestDetailId = dr[RequestDetailId].ToString();
                        info.RequestId = dr[RequestId].ToString();
                        info.ItemCategoryCode = dr[ItemCategoryCode].ToString();
                        info.ItemGroupCode = dr[ItemGroupCode].ToString();
                        info.ItemTypeCode = dr[ItemTypeCode].ToString();
                        info.Quantity = Convert.ToDouble(dr[Quantity].ToString());
                        info.MeasurementCode = dr[MeasurementCode].ToString();
                        info.Price = Convert.ToDouble(dr[Price].ToString());
                        info.Status = dr[Status].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public string PurchaseRequestDetailInsert(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidblQuantity, info.Quantity));
            ParameterCollection.Add(new KeyValuePair<string, object>(pimonPrice, info.Price));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseRequestDetailInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseRequestDetailUpdate(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestDetailID, info.RequestDetailId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidblQuantity, info.Quantity));
            ParameterCollection.Add(new KeyValuePair<string, object>(pimonPrice, info.Price));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseRequestDetailUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseRequestDetailDelete(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestDetailID, info.RequestDetailId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseRequestDetailDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseOrderInsert(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = povchOrderId;
            sqlParam.Value = info.OrderId;
            sqlParam.Size = 30;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmOrderDate;
            sqlParam.Value = info.OrderDate;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchSupplierCode;
            sqlParam.Value = info.SupplierCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchCurrencyCode;
            sqlParam.Value = info.CurrencyCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchPIC;
            sqlParam.Value = info.PIC;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmDeliveryDate;
            sqlParam.Value = info.DeliveryDate;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchOfferFrom;
            sqlParam.Value = info.OfferFrom;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchOfferNo;
            sqlParam.Value = info.OfferNo;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmOfferDate;
            sqlParam.Value = info.OfferDate;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchDescription;
            sqlParam.Value = info.Description;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseOrderInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == povchOrderId) { info.OrderId = sqlParamOut.Value.ToString(); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseOrderUpdate(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderId, info.OrderId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmOrderDate, info.OrderDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierCode, info.SupplierCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchCurrencyCode, info.CurrencyCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPIC, info.PIC));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmDeliveryDate, info.DeliveryDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOfferFrom, info.OfferFrom));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOfferNo, info.OfferNo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmOfferDate, info.OfferDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseOrderUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getPurchaseOrderView(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderId, info.OrderId));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAPurchaseOrderView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.OrderId = dr[OrderId].ToString();
                        info.OrderDate = Convert.ToDateTime(dr[OrderDate].ToString());
                        info.SupplierCode = dr[SupplierCode].ToString();
                        info.SupplierName = dr[SupplierName].ToString();
                        info.CurrencyCode = dr[CurrencyCode].ToString();
                        info.Total = Convert.ToDouble(dr[Total].ToString());
                        info.PIC = dr[PIC].ToString();
                        if (dr[DeliveryDate].ToString() != "")
                        {
                            info.DeliveryDate = Convert.ToDateTime(dr[DeliveryDate].ToString());
                        }
                        info.OfferFrom = dr[OfferFrom].ToString();
                        info.OfferNo = dr[OfferNo].ToString();
                        if (dr[OfferDate].ToString() != "")
                        {
                            info.OfferDate = Convert.ToDateTime(dr[OfferDate].ToString());
                        }
                        info.Description = dr[Description].ToString();
                        info.CreatedBy = dr[CreatedBy].ToString();
                        info.CreatedName = dr[CreatedName].ToString();
                        info.UpdateBy = dr[UpdateBy].ToString();
                        info.UpdateName = dr[UpdateName].ToString();
                        info.Status = dr[Status].ToString();
                        info.ApprovalState = Convert.ToInt32(dr[ApprovalState].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public DataSet getPurchaseOrderDetail(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderId, info.OrderId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchWhereBy, info.WhereBy));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spGAPurchaseOrderDetailList, ParameterCollection);
            }
            catch
            { throw; }
        }

        public string PurchaseOrderDetailInsert(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderId, info.OrderId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestId, info.RequestId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseOrderDetailInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseOrderDetailDelete(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderDetailID, info.OrderDetailId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderId, info.OrderId));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseOrderDetailDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseOrderUpdateStatus(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg = "";

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderId, info.OrderId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalState, info.ApprovalState));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseOrderUpdateStatus, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseReceivedInsert(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = povchReceivedId;
            sqlParam.Value = info.ReceivedId;
            sqlParam.Size = 30;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmReceivedDate;
            sqlParam.Value = info.ReceivedDate;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchOrderId;
            sqlParam.Value = info.OrderId;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchPIC;
            sqlParam.Value = info.PIC;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchDescription;
            sqlParam.Value = info.Description;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseReceivedInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == povchReceivedId) { info.ReceivedId = sqlParamOut.Value.ToString(); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseReceivedUpdate(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmReceivedDate, info.ReceivedDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOrderId, info.OrderId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPIC, info.PIC));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseReceivedUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getPurchaseReceivedView(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAPurchaseReceivedView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ReceivedId = dr[ReceivedId].ToString();
                        info.ReceivedDate = Convert.ToDateTime(dr[ReceivedDate].ToString());
                        info.OrderId = dr[OrderId].ToString();
                        info.OrderDate = Convert.ToDateTime(dr[OrderDate].ToString());
                        info.SupplierName = dr[SupplierName].ToString();
                        info.CurrencyCode = dr[CurrencyCode].ToString();
                        info.PIC = dr[PIC].ToString();
                        info.Description = dr[Description].ToString();
                        info.CreatedBy = dr[CreatedBy].ToString();
                        info.CreatedName = dr[CreatedName].ToString();
                        info.UpdateBy = dr[UpdateBy].ToString();
                        info.UpdateName = dr[UpdateName].ToString();
                        info.Status = dr[Status].ToString();
                        info.ApprovalState = Convert.ToInt32(dr[ApprovalState].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public DataSet getPurchaseReceivedDetail(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchWhereBy, info.WhereBy));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spGAPurchaseReceivedDetailList, ParameterCollection);
            }
            catch
            { throw; }
        }

        public void getPurchaseReceivedDetailView(ref USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
           SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedDetailID, info.ReceivedDetailId));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAPurchaseReceivedDetailView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.RequestId = dr[RequestId].ToString();
                        info.ItemCategoryName = dr[ItemCategoryName].ToString();
                        info.ItemGroupName = dr[ItemGroupName].ToString();
                        info.ItemTypeName = dr[ItemTypeName].ToString();
                        info.RequestQty = Convert.ToDouble(dr[RequestQty].ToString());
                        info.CurrentQty = Convert.ToDouble(dr[CurrentQty].ToString());
                        info.Quantity = Convert.ToDouble(dr[Quantity].ToString());
                        info.MeasurementCode = dr[MeasurementCode].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public string PurchaseReceivedDetailInsert(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestDetailID, info.RequestDetailId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseReceivedDetailInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseReceivedDetailDelete(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedDetailID, info.ReceivedDetailId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseReceivedDetailDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseReceivedDetailUpdate(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedDetailID, info.ReceivedDetailId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidblQuantity, info.Quantity));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseReceivedDetailUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string PurchaseReceivedUpdateStatus(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg = "";

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchReceivedId, info.ReceivedId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalState, info.ApprovalState));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAPurchaseReceivedUpdateStatus, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public DataSet getPurchaseApprovalLog(USoft.DataAccess.Entities.General_Affair.Purchase info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchIDNumber, info.IDNumber));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spGAPurchaseApprovalLog, ParameterCollection);
            }
            catch
            { throw; }
        }
    }
}
