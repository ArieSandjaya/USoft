using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Data;

namespace USoft.Compliance.Entertainment
{
    public class SearchHistory
    {
        private static DateTime _dateStart;
        private static DateTime _dateEnd;
        private static string _seqId;
        private static string _userName;
        private static string _keyId;
        public SearchHistory()
        { }
        public static DataTable search()
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@dateStart", _dateStart.ToString("yyyyMMdd")));
            ParameterCollection.Add(new KeyValuePair<string, object>("@dateEnd", _dateEnd.ToString("yyyyMMdd")));
            ParameterCollection.Add(new KeyValuePair<string, object>("@SeqId", _seqId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@username", _userName));
            return sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_GIFT_HISTORY", ParameterCollection);
        }
        public static DataRow SearchEdit()
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@KeyID", _keyId));
            DataTable dt = sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_GIFT_EDIT", ParameterCollection);
            return dt.Rows[0];
        }
        public static DateTime DateStart
        {
            set { _dateStart = value; }
        }
        public static DateTime DateEnd
        {
            set { _dateEnd = value; }
        }
        public static string SeqId
        {
            set { _seqId = value; }
        }
        public static string UserName
        {
            set { _userName = value; }
        }
        public static string KeyId
        {
            set { _keyId = value; }
        }
    }
}
