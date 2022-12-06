using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.Globalization.Reports
{
    public class ReportGroup
    {
        public ReportGroup()
        { }
        public static string GetReportGroup(string ValData)
        {
            string[] value;
            value = ValData.Split('~');
            return value[2].ToString();
        }
    }
}
