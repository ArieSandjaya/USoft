using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.Shared;

namespace USoft.Reports.List
{
    public class ReportLists
    {
        public ReportLists()
        { }
        public DataSet GetReportLists(string ReportGroups)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@ReportGroup", ReportGroups));
            return sqlHandler.ExecuteAsDataSet("REPORT_LISTS", ParameterCollection);
        }
    }
}
