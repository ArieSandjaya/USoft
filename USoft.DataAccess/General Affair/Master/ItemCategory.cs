using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.General_Affair.Master
{
    public class ItemCategory : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchItemCategoryCode = "@pivchItemCategoryCode";
        string pivchItemCategoryName = "@pivchItemCategoryName";

        // Store Procedure
        string spGAItemCategoryList = "spGAItemCategoryList";
        string spGAItemCategoryInsert = "spGAItemCategoryInsert";
        string spGAItemCategoryUpdate = "spGAItemCategoryUpdate";
        string spGAItemCategoryView = "spGAItemCategoryView";

        // Field Name
        string ItemCategoryCode = "ItemCategoryCode";
        string ItemCategoryName = "ItemCategoryName";

        public DataSet getItemCategory(ref USoft.DataAccess.Entities.General_Affair.Master.ItemCategory info)
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
                ds = sqlHandler.ExecuteAsDataSet(spGAItemCategoryList, ref ListParam);
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

        public String ItemCategoryInsert(USoft.DataAccess.Entities.General_Affair.Master.ItemCategory info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCategoryCode, info.ItemCategoryCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCategoryName, info.ItemCategoryName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAItemCategoryInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String ItemCategoryUpdate(USoft.DataAccess.Entities.General_Affair.Master.ItemCategory info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCategoryCode, info.ItemCategoryCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCategoryName, info.ItemCategoryName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAItemCategoryUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getItemCategoryView(ref USoft.DataAccess.Entities.General_Affair.Master.ItemCategory info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCategoryCode, info.ItemCategoryCode));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAItemCategoryView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ItemCategoryCode = dr[ItemCategoryCode].ToString();
                        info.ItemCategoryName = dr[ItemCategoryName].ToString();
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
