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
    public class UserEdit
    {
        private string _userid;
        private string _username;
        private int _branchid;
        private int _status;
        private string _email;
        private string _changepass;
        private string _sendmail;
        
        public UserEdit()
        { }
        public string EditUser()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", _userid));
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserName", _username));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BranchId", _branchid));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Active", _status));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Email", _email));
            ParameterCollection.Add(new KeyValuePair<string, object>("@ChangePass", _changepass));
            ParameterCollection.Add(new KeyValuePair<string, object>("@SendMail", _sendmail));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("MsUpdateUser", ParameterCollection);
            string value = "";
            while (sDr.Read())
            {
                value = sDr[0].ToString();
            }
            HttpRuntime.Cache["MenuCache"] = null;
            AppStart.GetMenu();
            return value;
        }
        public string UserID
        {
            get { return _userid; }
            set { _userid = value; }
        }
        public string Username
        {
            get { return _username; }
            set { _username = value; }
        }
        public int BranchID
        {
            get { return _branchid;}
            set{_branchid = value;}
        }
        public int Status
        {
            get { return _status; }
            set { _status = value; }
        }
        public string Email
        {
            get { return _email; } 
            set { _email = value; }
        }
        public string ChangePass
        {
            get { return _changepass; }
            set { _changepass = value; }
        }
        public string SendMail
        {
            get { return _sendmail; }
            set { _sendmail = value; }
        }
        ////public string PrivCode /////////////////
        ////{
        ////    get { return _privcode; }
        ////    set { _privcode = value; }
        ////}
    }
}
