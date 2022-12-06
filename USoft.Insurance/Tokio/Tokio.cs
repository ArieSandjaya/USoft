using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;

namespace USoft.Insurance.Tokio
{
    public class Tokio
    {
        public Tokio()
        { }
        public DataSet GetTokio(int Branch, DateTime DateFrom, DateTime DateTo)
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@BranchId", Branch));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DateStart", cf.DateNormalize(DateFrom)));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DateEnd", cf.DateNormalize(DateTo)));
            return sqlHandler.ExecuteAsDataSet("INSURANCE_TOKIO", ParameterCollection);
        }
        public void ConvertTokio(DataSet ds)
        {
            CommonFunction cf = new CommonFunction();
            cf.ExportDataTableToXLS(ds.Tables[0], "Tokio");
        }
    }
}
