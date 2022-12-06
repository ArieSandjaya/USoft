using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using USoft.Common.Security;
using System.Data.SqlClient;
using USoft.Common.Setting;

namespace USoft.Globalization.Users
{
    public class UserSearch
    {
        private string userId;
        private string userName;
        private string status;


        public UserSearch()
        { }
        public DataTable GetUser()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", userId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Active", status));
            return sqlHandler.ExecuteAsDataTable("MsSearchUsers", ParameterCollection);
        }

        public string resetPWD()
        {
            string Password = SystemSetting.DefaultPassword;
            string EncryptPass = EncryptionMD5.Encrypt(Password);
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", userId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@resPass", EncryptPass));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("MsResetPassword", ParameterCollection);
            string value = "";
            while (sDr.Read())
            {
                value = sDr[0].ToString();
            }
            return value;
        }

        public string UserID
        {
            set { userId = value; }
        }
        public string UserName
        {
            set { userName = value; }
        }
        public string Status
        {
            set { status = value = value == "null" ? null : value; ; }
        }
    }
}
