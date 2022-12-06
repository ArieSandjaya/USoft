using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.General_Affair.Master
{
    public class ItemGroup : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchItemGroupCode = "@pivchItemGroupCode";
        string pivchItemGroupName = "@pivchItemGroupName";
        string pivchItemCategoryCode = "@pivchItemCategoryCode";

        // Store Procedure
        string spGAItemGroupList = "spGAItemGroupList";
        string spGAItemGroupInsert = "spGAItemGroupInsert";
        string spGAItemGroupUpdate = "spGAItemGroupUpdate";
        string spGAItemGroupView = "spGAItemGroupView";

        // Field Name
        string ItemGroupCode = "ItemGroupCode";
        string ItemGroupName = "ItemGroupName";
        string ItemCategoryCode = "ItemCategoryCode";

        public DataSet getItemGroup(ref USoft.DataAccess.Entities.General_Affair.Master.ItemGroup info)
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
                ds = sqlHandler.ExecuteAsDataSet(spGAItemGroupList, ref ListParam);
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

        public String ItemGroupInsert(USoft.DataAccess.Entities.General_Affair.Master.ItemGroup info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemGroupCode, info.ItemGroupCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemGroupName, info.ItemGroupName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCategoryCode, info.ItemCategoryCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAItemGroupInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String ItemGroupUpdate(USoft.DataAccess.Entities.General_Affair.Master.ItemGroup info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemGroupCode, info.ItemGroupCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemGroupName, info.ItemGroupName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemCategoryCode, info.ItemCategoryCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spGAItemGroupUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getItemGroupView(ref USoft.DataAccess.Entities.General_Affair.Master.ItemGroup info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemGroupCode, info.ItemGroupCode));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGAItemGroupView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ItemGroupCode = dr[ItemGroupCode].ToString();
                        info.ItemGroupName = dr[ItemGroupName].ToString();
                        info.ItemCategoryCode = dr[ItemCategoryCode].ToString();
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
