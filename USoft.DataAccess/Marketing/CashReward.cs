using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using USoft.Common.Shared;

namespace USoft.DataAccess.Marketing
{
    public class CashReward : USoft.DataAccess.General.Common
    {
        public CashReward()
        {}
        public void getCashRewardHeader(ref DataAccess.Entities.Marketing.CashReward domain)
        {
            string paramName="@Contract";
            string paramValue="";


            SQLHelper sqlHandler = new SQLHelper();
            string[] strArray = Entities.EntitiesHelper.GetWhereIs(domain.WhereIs);
            paramName = strArray[0].ToString()==""?paramName:strArray[0].ToString();
            paramValue = strArray[1].ToString();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(paramName,paramValue));
            SqlDataReader dr = (SqlDataReader)sqlHandler.ExecuteAsDataReader(domain.MyQuery, ParameterCollection);

            List<KeyValuePair<string, object>> obj = (List<KeyValuePair<string, object>>)domain.ObjectCollection;
            sqlHandler.GetSqlValue(obj, dr);

        }
        public DataSet getCashRewardRecipients(ref DataAccess.Entities.Marketing.CashRewardDetail domain)
        {
            SQLHandler sqlHandler = new SQLHandler();
            string[] strArray = Entities.EntitiesHelper.GetWhereIs(domain.WhereIs);
            //paramName = strArray[0].ToString() == "" ? paramName : strArray[0].ToString();
            //paramValue = strArray[1].ToString();
            List<SqlParameter> ParameterCollection = new List<SqlParameter>();

            ParameterCollection.Add(new SqlParameter(piintPageNo, domain.PageNo));
            ParameterCollection.Add(new SqlParameter(piintPageSize, domain.PageSize));
            ParameterCollection.Add(new SqlParameter(pointTotalPage, SqlDbType.Int, 4, ParameterDirection.Output, true, 0, 0, null, DataRowVersion.Default, null));
            ParameterCollection.Add(new SqlParameter(pointTotalData, SqlDbType.Int, 4, ParameterDirection.Output, true, 0, 0, null, DataRowVersion.Default, null));
            DataSet ds = (DataSet)sqlHandler.ExecuteAsDataSet(domain.MyQuery, ref ParameterCollection);
            foreach (SqlParameter sqlParamOut in ParameterCollection)
            {
                if (sqlParamOut.ParameterName == pointTotalPage) { domain.TotalPage = Convert.ToInt32(sqlParamOut.Value); continue; }
                if (sqlParamOut.ParameterName == pointTotalData) { domain.TotalData = Convert.ToInt32(sqlParamOut.Value); continue; }
            }
            return ds;
        }
        public DataSet getCashReward(ref DataAccess.Entities.Marketing.CashReward domain)
        {
            string paramName="@Contract";
            string paramValue="";


            SQLHandler sqlHandler = new SQLHandler();
            string[] strArray = Entities.EntitiesHelper.GetWhereIs(domain.WhereIs);
            paramName = strArray[0].ToString()==""?paramName:strArray[0].ToString();
            paramValue = strArray[1].ToString();
            List<SqlParameter> ParameterCollection = new List<SqlParameter>();

            ParameterCollection.Add(new SqlParameter(paramName,paramValue));
            ParameterCollection.Add(new SqlParameter(piintPageNo,domain.PageNo));
            ParameterCollection.Add(new SqlParameter(piintPageSize,domain.PageSize));
            ParameterCollection.Add(new SqlParameter(pointTotalPage,SqlDbType.Int,4,ParameterDirection.Output,true,0,0,null,DataRowVersion.Default,null));
            ParameterCollection.Add(new SqlParameter(pointTotalData,SqlDbType.Int,4,ParameterDirection.Output,true,0,0,null,DataRowVersion.Default,null));
            DataSet ds = (DataSet)sqlHandler.ExecuteAsDataSet(domain.MyQuery,ref ParameterCollection);
                 foreach (SqlParameter sqlParamOut in ParameterCollection)
                    {
                        if (sqlParamOut.ParameterName == pointTotalPage) { domain.TotalPage = Convert.ToInt32(sqlParamOut.Value); continue; }
                        if (sqlParamOut.ParameterName == pointTotalData) { domain.TotalData = Convert.ToInt32(sqlParamOut.Value); continue; }
                    }
            return ds;
        }
    }
}
