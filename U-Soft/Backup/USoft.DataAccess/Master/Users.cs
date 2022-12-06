using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.Master
{
    public class Users : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchUserId = "@pivchUserId";
        string pivchUserName = "@pivchUserName";
        string piintBranchId = "@piintBranchId";
        string pivchEmail = "@pivchEmail";
        string pivchPass = "@pivchPass";
        string pivchCanSendEmail = "@pivchCanSendEmail";
        string pivchCanChangePass = "@pivchCanChangePass";
        string pivchPrivilegeCode = "@pivchPrivilegeCode";
        string pibitIsAllBranch = "@pibitIsAllBranch";

        string piintMenuId = "@piintMenuId";
        string pibitInsert = "@pibitInsert";
        string pibitUpdate = "@pibitUpdate";
        string pibitDelete = "@pibitDelete";
        string pibitView = "@pibitView";
        
        // Store Procedure
        string spUsersList = "spUsersList";
        string spUsersInsert = "spUsersInsert";
        string spUsersUpdate = "spUsersUpdate";
        string spUsersView = "spUsersView";
        string spUsersMenuClear = "spUsersMenuClear";
        string spUsersMenuUpdate = "spUsersMenuUpdate";

        // Field Name
        string UserId = "UserId";
        string Email = "Email";
        string CanSendEmail = "CanSendMail";
        string CanChangePass = "ChangePass";
        string PrivilegeCode = "PrivilegeCode";
        string IsAllBranch = "IsAllBranch";
        
        public DataSet getUsers(ref USoft.DataAccess.Entities.Master.Users info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchWhereBy;
            sqlParam.Value = info.WhereBy;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintPageNo;
            sqlParam.Value = info.PageNo;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintPageSize;
            sqlParam.Value = info.PageSize;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pointTotalPage;
            sqlParam.Value = info.TotalPage;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pointTotalData;
            sqlParam.Value = info.TotalData;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            try
            {
                ds = sqlHandler.ExecuteAsDataSet(spUsersList, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == pointTotalPage) { info.TotalPage = Convert.ToInt32(sqlParamOut.Value); continue; }
                    if (sqlParamOut.ParameterName == pointTotalData) { info.TotalData = Convert.ToInt32(sqlParamOut.Value); continue; }
                }
                return ds;
            }
            catch
            { throw; }
        }

        public String UsersInsert(USoft.DataAccess.Entities.Master.Users info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserName, info.UserName));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchId, info.BranchId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchEmail, info.Email));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPass, info.Pass));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchCanSendEmail, info.CanSendEmail));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchCanChangePass, info.CanChangePass));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsAllBranch, info.IsAllBranch));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spUsersInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String UsersUpdate(USoft.DataAccess.Entities.Master.Users info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserName, info.UserName));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchId, info.BranchId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchEmail, info.Email));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPass, info.Pass));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchCanSendEmail, info.CanSendEmail));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchCanChangePass, info.CanChangePass));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsAllBranch, info.IsAllBranch));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spUsersUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getUsersView(ref USoft.DataAccess.Entities.Master.Users info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spUsersView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.UserId = dr[UserId].ToString();
                        info.UserName = dr[UserName].ToString();
                        info.BranchId = Convert.ToInt16(dr[BranchId].ToString());
                        info.Email = dr[Email].ToString();
                        info.IsActive = Convert.ToBoolean(dr[IsActive].ToString());
                        info.CanChangePass = dr[CanChangePass].ToString();
                        info.CanSendEmail = dr[CanSendEmail].ToString();
                        info.PrivilegeCode = dr[PrivilegeCode].ToString();
                        info.IsAllBranch = Convert.ToBoolean(dr[IsAllBranch].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public String UsersMenuClear(USoft.DataAccess.Entities.Master.Users info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));

            try
            {
                sqlHandler.ExecuteAsDataSet(spUsersMenuClear, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String UsersMenuUpdate(USoft.DataAccess.Entities.Master.Users info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintMenuId, info.MenuId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitInsert, info.Insert));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitUpdate, info.Update));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitDelete, info.Delete));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitView, info.View));

            try
            {
                sqlHandler.ExecuteAsDataSet(spUsersMenuUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
    }
}
