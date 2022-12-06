using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.Master
{
    public class Branch : USoft.DataAccess.General.Common
    {
        // Parameter
        string piintBranchId = "@piintBranchId";
        string pivchBranchCode = "@pivchBranchCode";
        string pivchBranchName = "@pivchBranchName";
        string piintBranchType = "@piintBranchType";
        string piintBranchParent = "@piintBranchParent";
        
        // Store Procedure
        string spBranchList = "spBranchList";
        string spBranchInsert = "spBranchInsert";
        string spBranchUpdate = "spBranchUpdate";
        string spBranchView = "spBranchView";

        // Field Name
        string BranchCode = "BranchCode";
        string BranchType = "BranchType";
        string BranchParent = "BranchParent";
        

        public DataSet getBranch(ref USoft.DataAccess.Entities.Master.Branch info)
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
                ds = sqlHandler.ExecuteAsDataSet(spBranchList, ref ListParam);
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

        public string BranchInsert(USoft.DataAccess.Entities.Master.Branch info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchId, info.BranchId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchCode, info.BranchCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchName, info.BranchName));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchType, info.BranchType));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchParent, info.BranchParent));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spBranchInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string BranchUpdate(USoft.DataAccess.Entities.Master.Branch info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            string sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchId, info.BranchId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchCode, info.BranchCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchName, info.BranchName));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchType, info.BranchType));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchParent, info.BranchParent));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spBranchUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getBranchView(ref USoft.DataAccess.Entities.Master.Branch info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchId, info.BranchId));
            
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spBranchView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.BranchId = Convert.ToInt32(dr[BranchId].ToString());
                        info.BranchCode = dr[BranchCode].ToString();
                        info.BranchName = dr[BranchName].ToString();
                        info.BranchType = Convert.ToInt32(dr[BranchType].ToString());
                        if (dr[BranchParent].ToString() != "")
                        {
                            info.BranchParent = Convert.ToInt32(dr[BranchParent].ToString());
                        }
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
