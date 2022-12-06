using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Security;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.Data.SqlClient;
using System.Web;
using USoft.Globalization;

namespace USoft.Compliance
{
    public class DealerEdit
    {
        private string _dealercode;
        private string _dealername;
        private int _status;

        public DealerEdit()
        { }
        public string EditDealer()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@DealerCode", _dealercode));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DealerName", _dealername));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Status", _status));
            
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("ENTERTAINMENT_EDIT_DEALER", ParameterCollection);
            string value = "";
            while (sDr.Read())
            {
                value = sDr[0].ToString();
                HttpRuntime.Cache.Remove("ENTDEALER");
                AppStart.GetEntCompanyName();
            }
            return value;
        }
        public string DealerCode 
        {
            get { return _dealercode; }
            set { _dealercode = value; }
        }
        public string DealerName
        {
            get { return _dealername; }
            set { _dealername = value; }
        }
        public int Status
        {
            get { return _status; }
            set { _status = value; }
        }
    }
}
