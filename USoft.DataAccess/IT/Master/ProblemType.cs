using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.IT.Master
{
    public class ProblemType : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchProblemTypeCode = "@pivchProblemTypeCode";
        string pivchProblemTypeName = "@pivchProblemTypeName";

        // Store Procedure
        string spITProblemTypeList = "spITProblemTypeList";
        string spITProblemTypeInsert = "spITProblemTypeInsert";
        string spITProblemTypeUpdate = "spITProblemTypeUpdate";
        string spITProblemTypeView = "spITProblemTypeView";

        // Field Name
        string ProblemTypeCode = "ProblemTypeCode";
        string ProblemTypeName = "ProblemTypeName";

        public DataSet getITProblemType(ref USoft.DataAccess.Entities.IT.Master.ProblemType info)
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
                ds = sqlHandler.ExecuteAsDataSet(spITProblemTypeList, ref ListParam);
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

        public string ITProblemTypeInsert(USoft.DataAccess.Entities.IT.Master.ProblemType info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchProblemTypeCode, info.ProblemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchProblemTypeName, info.ProblemTypeName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITProblemTypeInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public string ITProblemTypeUpdate(USoft.DataAccess.Entities.IT.Master.ProblemType info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchProblemTypeCode, info.ProblemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchProblemTypeName, info.ProblemTypeName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITProblemTypeUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getITProblemTypeView(ref USoft.DataAccess.Entities.IT.Master.ProblemType info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchProblemTypeCode, info.ProblemTypeCode));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITProblemTypeView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ProblemTypeCode = dr[ProblemTypeCode].ToString();
                        info.ProblemTypeName = dr[ProblemTypeName].ToString();
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
