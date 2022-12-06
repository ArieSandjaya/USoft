using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.Shared;

namespace USoft.Compliance.Entertainment
{
    public class Recap
    {
        private static DateTime _startDate;
        private static DateTime _endDate;
        private static string _branch;
        private static string _status;
        private static int _rowIndex;
        private static int _maxRow;
        private static int _type;
        public Recap()
        { }
        public DataTable Search()
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@StartDate", _startDate.ToString("yyyyMMdd")));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EndDate", _endDate.ToString("yyyyMMdd")));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Branch", _branch));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Status", _status));
            ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", _rowIndex));
            ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", _maxRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", _type));
            return sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_GIFT_REPORT_VIEW", ParameterCollection);
        }
        public int SearchTotal()
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@StartDate", _startDate.ToString("yyyyMMdd")));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EndDate", _endDate.ToString("yyyyMMdd")));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Branch", _branch));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Status", _status));
            ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", _rowIndex));
            ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", _maxRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", _type));
            DataTable dt = sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_GIFT_REPORT_VIEW", ParameterCollection);
            return Convert.ToInt16(dt.Rows[0].ItemArray[0].ToString());
        }
        public DateTime DateStart
        {
            set { _startDate = value; }
        }
        public DateTime EndDate
        {
            set { _endDate = value; }
        }
        public string Branch
        {
            set { _branch = value; }
        }
        public string Status
        {
            set { _status = value; }
        }
        public int RowIndex
        {
            set { _rowIndex = value; }
        }
        public int MaxRow
        {
            set { _maxRow = value; }
        }
        public int Type
        {
            set { _type = value; }
        }
    }
}
