using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.General_Affair.Master
{
    public class ItemType : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchItemTypeCode = "@pivchItemTypeCode";
        string pivchItemTypeName = "@pivchItemTypeName";
        string pivchItemGroupCode = "@pivchItemGroupCode";
        string pivchMeasurementCode = "@pivchMeasurementCode";

        // Store Procedure
        string spGAItemTypeList = "spGAItemTypeList";
        string spGAItemTypeInsert = "spGAItemTypeInsert";
        string spGAItemTypeUpdate = "spGAItemTypeUpdate";
        string spGAItemTypeView = "spGAItemTypeView";

        // Field Name
        string ItemTypeCode = "ItemTypeCode";
        string ItemTypeName = "ItemTypeName";
        string ItemGroupCode = "ItemGroupCode";
        string ItemCategoryCode = "ItemCategoryCode";
        string MeasurementCode = "MeasurementCode";

        public DataSet getItemType(ref USoft.DataAccess.Entities.General_Affair.Master.ItemType info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
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
                ds = sqlHandler.ExecuteAsDataSet(spGAItemTypeList, ref ListParam);
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

        public String ItemTypeInsert(USoft.DataAccess.Entities.General_Affair.Master.ItemType info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeName, info.ItemTypeName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemGroupCode, info.ItemGroupCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchMeasurementCode, info.MeasurementCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAItemTypeInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String ItemTypeUpdate(USoft.DataAccess.Entities.General_Affair.Master.ItemType info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeName, info.ItemTypeName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemGroupCode, info.ItemGroupCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchMeasurementCode, info.MeasurementCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAItemTypeUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getItemTypeView(ref USoft.DataAccess.Entities.General_Affair.Master.ItemType info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAItemTypeView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ItemTypeCode = dr[ItemTypeCode].ToString();
                        info.ItemTypeName = dr[ItemTypeName].ToString();
                        info.ItemGroupCode = dr[ItemGroupCode].ToString();
                        info.ItemCategoryCode = dr[ItemCategoryCode].ToString();
                        info.MeasurementCode = dr[MeasurementCode].ToString();
                        info.Description = dr[Description].ToString();
                        info.IsActive = Convert.ToBoolean(dr[IsActive].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
    }
}
