using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using USoft.Common.Shared;

namespace USoft.DataAccess.Compliance
{
    public class HRiskCountry: USoft.DataAccess.General.Common
    {
        public HRiskCountry()
        {}
        public DataSet GetHRiskCountryLists(ref DataAccess.Entities.Compliance.HRiskCountry domain)
        {
            string paramName="@countryName";
            string paramValue="";


            SQLHandler sqlHandler = new SQLHandler();
            string[] strArray = Entities.EntitiesHelper.GetWhereIs(domain.WhereIs);
            paramName = strArray[0].ToString();
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
