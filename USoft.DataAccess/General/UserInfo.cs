using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.General
{
    public class UserInfo
    {
        // Parameter
        private string piintMenuId = "@piintMenuId";
        private string piintState = "@piintState";
        private string pivchUserId = "@pivchUserId";
        private string piintDataBranchId = "@piintDataBranchId";

        // Store Procedure
        private string spGetUserInfo = "spGetUserInfo";
        private string spGetApprovalState = "spGetApprovalState";

        // Field Name
        private string UserId = "UserId";
        private string BranchId = "BranchId";
        private string PrivilegeCode = "PrivilegeCode";
        private string DepartementCode = "DepartementCode";
        private string IsAllBranch = "IsAllBranch";
        private string IsActive = "IsActive";
        private string ApprovalState = "ApprovalState";
        private string MaxState = "MaxState";
        
        public void getUserInfo(ref USoft.DataAccess.Entities.UserInfo info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));
            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGetUserInfo, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.UserId = dr[UserId].ToString();
                        info.BranchId = Convert.ToInt32(dr[BranchId].ToString());
                        info.PrivilegeCode = dr[PrivilegeCode].ToString();
                        info.DepartementCode = dr[DepartementCode].ToString();
                        info.IsAllBranch = Convert.ToBoolean(dr[IsAllBranch].ToString());
                        info.IsActive = Convert.ToBoolean(dr[IsActive].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
        
        public void getApprovalState(ref USoft.DataAccess.Entities.UserInfo info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(piintMenuId, info.MenuId));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintState, info.State));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintDataBranchId, info.DataBranchId));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGetApprovalState, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ApprovalState = Convert.ToBoolean(dr[ApprovalState].ToString());
                        info.MaxState = Convert.ToInt32(dr[MaxState].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
    }
}
