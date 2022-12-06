using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Data;
using System.Data.SqlClient;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.Common.Security
{
    public class FormSecurity
    {
        // Parameter
        string piintMenuId = "@piintMenuId";
        string piintState = "@piintState";
        string pivchUserId = "@pivchUserId";
        string piintBranchId = "@piintBranchId";

        // Store Procedure
        string spGetApprovalState = "spGetApprovalState";

        // Field Name
        string ApprovalState = "ApprovalState";
        
        public FormSecurity()
        { }
        public static Boolean isInsertAllowed(string ValData)
        {
            string[] value;
            value= ValData.Split('~');
            DataSet ds = new DataSet();
            ds = (DataSet)HttpContext.Current.Cache["MenuCache"];
            DataRow[] dr;
            dr = ds.Tables[0].Select("UserId = '" + value[0].ToString() + "'And MenuId ='"+ value[1].ToString() +"'", "UserId,MenuId");
            return Convert.ToBoolean(dr[0].ItemArray[6]);
        }
        public static Boolean isUpdateAllowed(string ValData)
        {
            string[] value;
            value = ValData.Split('~');
            DataSet ds = new DataSet();
            ds = (DataSet)HttpContext.Current.Cache["MenuCache"];
            DataRow[] dr;
            dr = ds.Tables[0].Select("UserId = '" + value[0].ToString() + "'And MenuId ='" + value[1].ToString() + "'", "UserId,MenuId");
            return Convert.ToBoolean(dr[0].ItemArray[7]);
        }
        public static Boolean isDeleteAllowed(string ValData)
        {
            string[] value;
            value = ValData.Split('~');
            DataSet ds = new DataSet();
            ds = (DataSet)HttpContext.Current.Cache["MenuCache"];
            DataRow[] dr;
            dr = ds.Tables[0].Select("UserId = '" + value[0].ToString() + "'And MenuId ='" + value[1].ToString() + "'", "UserId,MenuId");
            return Convert.ToBoolean(dr[0].ItemArray[8]);
        }
        public static Boolean isViewAllowed(string ValData)
        {
            string[] value;
            value = ValData.Split('~');
            DataSet ds = new DataSet();
            ds = (DataSet)HttpContext.Current.Cache["MenuCache"];
            DataRow[] dr;
            dr = ds.Tables[0].Select("UserId = '" + value[0].ToString() + "'And MenuId ='" + value[1].ToString() + "'", "UserId,MenuId");
            return Convert.ToBoolean(dr[0].ItemArray[9]);
        }
        public Boolean getApprovalState(string MenuId, int State, string UserId, int BranchId)
        {
            bool UserState = false;
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(piintMenuId, MenuId));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintState, State));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, UserId));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchId, BranchId));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGetApprovalState, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        UserState = Convert.ToBoolean(dr[ApprovalState].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }

            return UserState;
        }
    }
}
