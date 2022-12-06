using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using USoft.Common.Setting;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.IO;
using System.Web;
using USoft.Globalization;

namespace USoft.Compliance
{
    public class DealerAdd
    {
        private string _dealerCode;
        private string _dealername;

        public DealerAdd()
        { }

        public string CreateDealer()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@DealerCode", _dealerCode));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DealerName", _dealername));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("ENTERTAINMENT_CREATE_DEALER", ParameterCollection);
            string value = "";
            while (sDr.Read())
            {
                value = sDr[0].ToString();
                HttpRuntime.Cache.Remove("ENTDEALER");
                AppStart.GetEntCompanyName();
            }
            return value;
        }

        public string DealerName
        {
            get { return _dealername; }
            set { _dealername = value; }
        }
        public string DealerCode
        {
            get { return _dealerCode; }
            set { _dealerCode = value; }
        }
    }
}
