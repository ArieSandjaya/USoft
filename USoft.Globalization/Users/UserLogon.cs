using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using USoft.Common.Security;
using System.Data.SqlClient;
using System.Web;

namespace USoft.Globalization.Users
{
    public class UserLogon
    {
        public UserLogon()
        {
 
        }
        public Boolean doLogon(string UserId,string Password)
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", UserId));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("spGetUserLogon", ParameterCollection);
            Boolean status = false;

            while (sDr.Read())
            {
                if (Password == EncryptionMD5.Decrypt(sDr["Pass"].ToString()))
                {
                    status = true;
                    HttpContext.Current.Session["UserId"] = sDr["UserId"].ToString();
                    HttpContext.Current.Session["UserName"] = sDr["UserName"].ToString();
                    HttpContext.Current.Session["BranchId"] = sDr["BranchId"].ToString();
                    HttpContext.Current.Session["Email"] = sDr["Email"].ToString();
                    HttpContext.Current.Session["ChangePass"] = sDr["ChangePass"].ToString();
                    //HttpContext.Current.Session["PriviledgeCode"] = sDr["PriviledgeCode"].ToString(); //
                    HttpContext.Current.Session["PrivilegeCode"] = sDr["PrivilegeCode"].ToString();
                }
            }

            return status;
        }
        public Boolean changePassword(string UserId, string Password, string newPassword)
        {
            try
            {
                CommonFunction cf = new CommonFunction();
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", UserId));
                SqlDataReader sDr;
                sDr = sqlHandler.ExecuteAsDataReader("spGetUserLogon", ParameterCollection);
                Boolean status = false;

                ParameterCollection.Clear();
                
                while (sDr.Read())
                {
                    if (Password == EncryptionMD5.Decrypt(sDr["Pass"].ToString()))
                    {
                        ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", UserId));
                        ParameterCollection.Add(new KeyValuePair<string, object>("@Pass", newPassword));
                        sqlHandler.ExecuteNonQuery("spUsersChangePassword", ParameterCollection);
                        status = true;
                    }
                    else
                    {
                        status = false;
                    }
                }
                return status;
            }
            catch
            {
                throw;
            }
        }
    }
}
