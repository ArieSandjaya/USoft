using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Security;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.Data.SqlClient;
using System.Web;

namespace USoft.Globalization
{
    public class PrivCreate
    {
        private string _privcode;
        private string _privname;
                
        public PrivCreate()
        { }
        public string CreatePriviledge()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PrivCode", _privcode));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PrivName", _privname));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("MsCreatePriviledge", ParameterCollection);
            string value="";
            while (sDr.Read())
            {
                value = sDr[0].ToString();
            }
            HttpRuntime.Cache["MenuCache"] = null;
            AppStart.GetMenu();
            return value;
        }

        public string PrivCode
        {
            get { return _privcode; }
            set { _privcode = value; }
        }
        public string PrivName
        {
            get { return _privname; }
            set { _privname = value; }
        }
    }
}
