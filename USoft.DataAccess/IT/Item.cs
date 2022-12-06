using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.IT
{
    public class Item : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchItemCode = "@pivchItemCode";
        string pivchItemInCode = "@pivchItemInCode";
        string povchItemInCode = "@povchItemInCode";
        string pivchItemInDetailCode = "@pivchItemInDetailCode";
        string pivchItemTransCode = "@pivchItemTransCode";
        string povchItemTransCode = "@povchItemTransCode";
        string pivchItemTransDetailCode = "@pivchItemTransDetailCode";
        string pivchItemOutCode = "@pivchItemOutCode";
        string pidtmDateIn = "@pidtmDateIn";
        string pidtmDateTrans = "@pidtmDateTrans";
        string pidtmDateOut = "@pidtmDateOut";
        string piintBranchFrom = "@piintBranchFrom";
        string piintBranchTo = "@piintBranchTo";
        string pivchSupplierCode = "@pivchSupplierCode";
        string pivchItemTypeCode = "@pivchItemTypeCode";
        string pivchSerialNo = "@pivchSerialNo";
        string pivchBarcode = "@pivchBarcode";
        string piintConditionCode = "@piintConditionCode";
        string pivchPIC = "@pivchPIC";
        string pivchUsedBy = "@pivchUsedBy";
        string pivchPrivilegeCode = "@pivchPrivilegeCode";
        string pivchInputBy = "@pivchInputBy";
        string piintStatusIn = "@piintStatusIn";
        string piintStatusOut = "@piintStatusOut";
        string pivchStatus = "@pivchStatus";

        // Store Procedure
        string spITItemList = "spITItemList";
        string spITItemView = "spITItemView";
        string spITItemUpdate = "spITItemUpdate";
        string spITItemInList = "spITItemInList";
        string spITItemInView = "spITItemInView";
        string spITItemInInsert = "spITItemInInsert";
        string spITItemInUpdate = "spITItemInUpdate";
        string spITItemInDetailList = "spITItemInDetailList";
        string spITItemInDetailView = "spITItemInDetailView";
        string spITItemInDetailInsert = "spITItemInDetailInsert";
        string spITItemInDetailUpdate = "spITItemInDetailUpdate";
        string spITItemInDetailDelete = "spITItemInDetailDelete";
        string spITItemInUpdateStatus = "spITItemInUpdateStatus";
        string spITItemTransList = "spITItemTransList";
        string spITItemTransView = "spITItemTransView";
        string spITItemTransInsert = "spITItemTransInsert";
        string spITItemTransUpdate = "spITItemTransUpdate";
        string spITItemTransDetailList = "spITItemTransDetailList";
        string spITItemTransDetailView = "spITItemTransDetailView";
        string spITItemTransDetailInsert = "spITItemTransDetailInsert";
        string spITItemTransDetailUpdate = "spITItemTransDetailUpdate";
        string spITItemTransDetailDelete = "spITItemTransDetailDelete";
        string spITItemTransUpdateStatus = "spITItemTransUpdateStatus";
        string spITItemOutList = "spITItemOutList";
        string spITItemOutView = "spITItemOutView";
        string spITItemOutInsert = "spITItemOutInsert";
        string spITItemOutUpdate = "spITItemOutUpdate";
        string spITItemOutUpdateStatus = "spITItemOutUpdateStatus";
        string spITItemHistory = "spITItemHistory";

        // Field Name
        string ITItemCode = "ITItemCode";
        string ITItemInCode = "ITItemInCode";
        string ITItemInDtlCode = "ITItemInDtlCode";
        string ITItemTransCode = "ITItemTransCode";
        string ITItemTransDtlCode = "ITItemTransDtlCode";
        string ITItemOutCode = "ITItemOutCode";
        string ITItemOutDtlCode = "ITItemOutDtlCode";
        string ITItemName = "ITItemName";
        string Date = "Date";
        string DateTrans = "DateTrans";
        string ReceiveType = "ReceiveType";
        string BranchIdFrom = "BranchId_From";
        string BranchNameFrom = "BranchNameFrom";
        string BranchIdTo = "BranchId_To";
        string BranchNameTo = "BranchNameTo";
        string SupplierCode = "SupplierCode";
        string SupplierName = "SupplierName";
        string PrivilegeCode = "PrivilegeCode";
        string PrivilegeName = "PrivilegeName";
        string UsedBy = "UsedBy";
        string PIC = "PIC";
        string PICName = "PICName";
        string ItemTypeCode = "ItemTypeCode";
        string ItemTypeName = "ItemTypeName";
        string SerialNo = "SerialNo";
        string Barcode = "Barcode";
        string ConditionCode = "ConditionCode";
        string ConditionName = "ConditionName";
        string StatusIn = "StatusIn";
        string StatusOut = "StatusOut";
        string RepairStatus = "RepairStatus";
        string Remark = "Remark";

        //List Item
        public DataSet getItemList(ref USoft.DataAccess.Entities.IT.Item info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;

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
                ds = sqlHandler.ExecuteAsDataSet(spITItemList, ref ListParam);
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
        public void getItemView(ref USoft.DataAccess.Entities.IT.Item info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCode, info.ItemCode));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITItemView, ParameterCollection);

                if (dr.HasRows) 
                {
                    while (dr.Read())
                    {
                        info.ItemCode = dr[ITItemCode].ToString();
                        info.ItemInDetailCode = dr[ITItemInDtlCode].ToString();
                        info.ItemTransDetailCode = dr[ITItemTransDtlCode].ToString();
                        info.ItemOutDetailCode = dr[ITItemOutDtlCode].ToString();
                        info.ItemTypeName = dr[ItemTypeName].ToString();
                        info.SerialNo = dr[SerialNo].ToString();
                        info.Barcode = dr[Barcode].ToString();
                        info.Description = dr[Description].ToString();
                        info.ConditionCode = Convert.ToInt32(dr[ConditionCode]);
                        info.ConditionName = dr[ConditionName].ToString();
                        if (dr[StatusIn].ToString() != "")
                        {
                            info.StatusIn = Convert.ToInt16(dr[StatusIn].ToString());
                        }
                        if (dr[StatusOut].ToString() != "")
                        {
                            info.StatusOut = Convert.ToInt16(dr[StatusOut].ToString());
                        }
                        info.BranchName = dr[BranchName].ToString();
                        info.UsedBy = dr[UsedBy].ToString();
                        info.PrivilegeName = dr[PrivilegeName].ToString();
                        info.IsActive = Convert.ToBoolean(dr[IsActive].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
        public string ItemUpdate(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCode, info.ItemCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintConditionCode, info.ConditionCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputBy, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        
        //Item History
        public DataSet getItemHistory(ref USoft.DataAccess.Entities.IT.Item info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchItemCode;
            sqlParam.Value = info.ItemCode;
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
                ds = sqlHandler.ExecuteAsDataSet(spITItemHistory, ref ListParam);
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

        //Item IN 
        public DataSet getItemIn(ref USoft.DataAccess.Entities.IT.Item info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;

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
                ds = sqlHandler.ExecuteAsDataSet(spITItemInList, ref ListParam);
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
        public void getItemInView(ref USoft.DataAccess.Entities.IT.Item info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITItemInView, ParameterCollection);

                if (dr.HasRows) //ambil data bdsr row yg dipilih, & tampilin di form edit item header
                {
                    while (dr.Read())
                    {
                        info.ItemInCode = dr[ITItemInCode].ToString();
                        info.Date = Convert.ToDateTime(dr[Date].ToString());
                        if (dr[BranchId].ToString() != "")
                        {
                            info.BranchIdFrom = Convert.ToInt32(dr[BranchId].ToString());
                        }
                        info.BranchNameFrom = dr[BranchNameFrom].ToString();
                        info.ReceiveType = dr[ReceiveType].ToString();
                        info.SupplierCode = dr[SupplierCode].ToString();
                        info.SupplierName = dr[SupplierName].ToString();
                        //info.PIC = dr[PIC].ToString();
                        //info.UserName = dr[UserName].ToString();
                        info.Status = dr[Status].ToString();
                        info.CreatedBy = dr[CreatedBy].ToString();
                        info.CreatedName = dr[CreatedName].ToString();
                        if (dr[ApprovalState].ToString() != "")
                        {
                            info.ApprovalState = Convert.ToInt16(dr[ApprovalState].ToString());
                        }
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
        public string ItemIn_Insert(ref USoft.DataAccess.Entities.IT.Item info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = povchItemInCode;
            sqlParam.Value = info.ItemInCode;
            sqlParam.Size = 12;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmDateIn;
            sqlParam.Value = info.Date;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintBranchFrom;
            sqlParam.Value = info.BranchIdFrom;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchSupplierCode;
            sqlParam.Value = info.SupplierCode;
            ListParam.Add(sqlParam);

            //sqlParam = new SqlParameter();
            //sqlParam.ParameterName = pivchPIC;
            //sqlParam.Value = info.PIC;
            //ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemInInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == povchItemInCode) { info.ItemInCode = sqlParamOut.Value.ToString(); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;    
        }
        public string ItemIn_Update(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmDateIn, info.Date));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchFrom, info.BranchIdFrom));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierCode, info.SupplierCode));
            //ParameterCollection.Add(new KeyValuePair<string, object>(pivchPIC, info.PIC));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemInUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        
        //Item IN Detail
        public DataSet getItemInDetail(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchWhereBy, info.WhereBy));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spITItemInDetailList, ParameterCollection);
            }
            catch
            { throw; }
        }
        public void getItemInDetailView(ref USoft.DataAccess.Entities.IT.Item info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInDetailCode, info.ItemInDetailCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITItemInDetailView, ParameterCollection);

                if (dr.HasRows) //ambil data bdsr row yg dipilih, & tampilin di form edit item detail
                {
                    while (dr.Read())
                    {
                        info.ItemInDetailCode = dr[ITItemInDtlCode].ToString();
                        info.ItemInCode = dr[ITItemInCode].ToString();
                        info.StatusIn = Convert.ToInt32(dr[StatusIn]);
                        info.ItemTypeCode = dr[ItemTypeCode].ToString();
                        info.ItemTypeName = dr[ItemTypeName].ToString();
                        info.ItemOutCode = dr[ITItemOutCode].ToString();
                        info.SerialNo = dr[SerialNo].ToString();
                        info.Barcode = dr[Barcode].ToString();
                        info.Description = dr[Description].ToString();
                        info.ConditionCode = Convert.ToInt32(dr[ConditionCode]);
                        info.ConditionName = dr[ConditionName].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
        public string ItemInDetailInsert(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintStatusIn, info.StatusIn));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemOutCode, info.ItemOutCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSerialNo, info.SerialNo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBarcode, info.Barcode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintConditionCode, info.ConditionCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemInDetailInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemInDetailUpdate(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInDetailCode, info.ItemInDetailCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintStatusIn, info.StatusIn));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemOutCode, info.ItemOutCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSerialNo, info.SerialNo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBarcode, info.Barcode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintConditionCode, info.ConditionCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemInDetailUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemInDetailDelete(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInDetailCode, info.ItemInDetailCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            
            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemInDetailDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemInUpdateStatus(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg = "";

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemInCode, info.ItemInCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalState, info.ApprovalState));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemInUpdateStatus, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        //Transfer 
        public DataSet getItemTrans(ref USoft.DataAccess.Entities.IT.Item info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;

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
                ds = sqlHandler.ExecuteAsDataSet(spITItemTransList, ref ListParam);
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
        public void getItemTransView(ref USoft.DataAccess.Entities.IT.Item info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITItemTransView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ItemTransCode = dr[ITItemTransCode].ToString();
                        if (dr[BranchIdFrom].ToString() != "")
                        {
                            info.BranchIdFrom = Convert.ToInt32(dr[BranchIdFrom].ToString());
                        }
                        info.BranchNameFrom = dr[BranchNameFrom].ToString();
                        if (dr[BranchIdTo].ToString() != "")
                        {
                            info.BranchIdTo = Convert.ToInt32(dr[BranchIdTo].ToString());
                        }
                        info.BranchNameTo = dr[BranchNameTo].ToString();
                        info.TransDate = Convert.ToDateTime(dr[DateTrans].ToString());
                        info.Status = dr[Status].ToString();
                        info.CreatedBy = dr[CreatedBy].ToString();
                        info.CreatedName = dr[CreatedName].ToString();
                        if (dr[ApprovalState].ToString() != "")
                        {
                            info.ApprovalState = Convert.ToInt16(dr[ApprovalState].ToString());
                        }
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
        public string ItemTransInsert(ref USoft.DataAccess.Entities.IT.Item info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = povchItemTransCode;
            sqlParam.Value = info.ItemTransCode;
            sqlParam.Size = 12;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintBranchFrom;
            sqlParam.Value = info.BranchIdFrom;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintBranchTo;
            sqlParam.Value = info.BranchIdTo;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmDateTrans;
            sqlParam.Value = info.TransDate;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemTransInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == povchItemTransCode) { info.ItemTransCode = sqlParamOut.Value.ToString(); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemTransUpdate(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchFrom, info.BranchIdFrom));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchTo, info.BranchIdTo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmDateTrans, info.TransDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemTransUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        //Transfer Detail
        public DataSet getItemTransDetail(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchWhereBy, info.WhereBy));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spITItemTransDetailList, ParameterCollection);
            }
            catch
            { throw; }
        }
        public void getItemTransDetailView(ref USoft.DataAccess.Entities.IT.Item info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransDetailCode, info.ItemTransDetailCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITItemTransDetailView, ParameterCollection);

                if (dr.HasRows) //ambil data bdsr row yg dipilih, & tampilin di form edit item detail
                {
                    while (dr.Read())
                    {
                        info.ItemTransDetailCode = dr[ITItemTransDtlCode].ToString();
                        info.ItemTransCode = dr[ITItemTransCode].ToString();
                        info.ItemCode = dr[ITItemCode].ToString();
                        info.ConditionCode = Convert.ToInt32(dr[ConditionCode]);
                        info.UsedBy = dr[UsedBy].ToString();
                        info.PrivilegeCode = dr[PrivilegeCode].ToString();
                        info.ItemTypeCode = dr[ItemTypeCode].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
        public string ItemTransDetailInsert(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCode, info.ItemCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintConditionCode, info.ConditionCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUsedBy, info.UsedBy));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemTransDetailInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemTransDetailUpdate(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransDetailCode, info.ItemTransDetailCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCode, info.ItemCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintConditionCode, info.ConditionCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUsedBy, info.UsedBy));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemTransDetailUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemTransDetailDelete(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransDetailCode, info.ItemTransDetailCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemTransDetailDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemTransUpdateStatus(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTransCode, info.ItemTransCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalState, info.ApprovalState));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemTransUpdateStatus, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        //Item OUT 
        public DataSet getItemOut(ref USoft.DataAccess.Entities.IT.Item info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;

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
                ds = sqlHandler.ExecuteAsDataSet(spITItemOutList, ref ListParam);
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
        public void getItemOutView(ref USoft.DataAccess.Entities.IT.Item info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemOutCode, info.ItemOutCode));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITItemOutView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ItemOutCode = dr[ITItemOutCode].ToString();
                        info.ItemCode = dr[ITItemCode].ToString();
                        info.ItemName = dr[ITItemName].ToString();
                        info.ItemTypeCode = dr[ItemTypeCode].ToString();
                        info.ItemTypeName = dr[ItemTypeName].ToString();
                        info.Date = Convert.ToDateTime(dr[Date].ToString());
                        info.BranchIdFrom = (dr[BranchId].ToString() == "") ? 0 : Convert.ToInt32(dr[BranchId]);
                        info.BranchNameFrom = dr[BranchName].ToString();
                        info.SupplierCode = dr[SupplierCode].ToString();
                        info.SupplierName = dr[SupplierName].ToString();
                        info.ConditionCode = Convert.ToInt32(dr[ConditionCode]);
                        info.ConditionName = dr[ConditionName].ToString();
                        info.StatusOut = Convert.ToInt16(dr[StatusOut].ToString());
                        info.PIC = dr[PIC].ToString();
                        info.PICName = dr[PICName].ToString();
                        info.Status = dr[Status].ToString();
                        info.RepairStatus = dr[RepairStatus].ToString();
                        info.Remark = dr[Remark].ToString();
                        if (dr[ApprovalState].ToString() != "")
                        {
                            info.ApprovalState = Convert.ToInt16(dr[ApprovalState].ToString());
                        }
                        info.CreatedBy = dr[CreatedBy].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
        public String ItemOutInsert(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmDateOut, info.Date));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchFrom, info.BranchIdFrom));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCode, info.ItemCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintConditionCode, info.ConditionCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintStatusOut, info.StatusOut));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierCode, info.SupplierCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPIC, info.PIC));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputBy, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemOutInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public String ItemOutUpdate(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemOutCode, info.ItemOutCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmDateOut, info.Date));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchFrom, info.BranchIdFrom));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCode, info.ItemCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintConditionCode, info.ConditionCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintStatusOut, info.StatusOut));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierCode, info.SupplierCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPIC, info.PIC));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputBy, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemOutUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        public string ItemOutUpdateStatus(USoft.DataAccess.Entities.IT.Item info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemOutCode, info.ItemOutCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalState, info.ApprovalState));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITItemOutUpdateStatus, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        
    }
}
