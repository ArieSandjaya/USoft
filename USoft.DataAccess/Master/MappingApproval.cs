using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.Master
{
    public class MappingApproval : USoft.DataAccess.General.Common
    {
        // Parameter
        string pointApprovalId = "@pointApprovalId";
        string piintApprovalId = "@piintApprovalId";
        string piintMenuId = "@piintMenuId";
        string pivchDepartementCode = "@pivchDepartementCode";
        string pivchParentCode = "@pivchParentCode";
        string pivchUserIdApproval = "@pivchUserIdApproval";
        string pibitIsBranch = "@pibitIsBranch";
        string piintState = "@piintState";
        string pivchStateDescription = "@pivchStateDescription";
        string piintApprovalEmailId = "@piintApprovalEmailId";
        string pivchUserIdEmail = "@pivchUserIdEmail";

        // Store Procedure
        string spMappingApprovalList = "spMappingApprovalList";
        string spMappingApprovalInsert = "spMappingApprovalInsert";
        string spMappingApprovalUpdate = "spMappingApprovalUpdate";
        string spMappingApprovalDelete = "spMappingApprovalDelete";
        string spMappingApprovalView = "spMappingApprovalView";
        string spMappingApprovalEmailList = "spMappingApprovalEmailList";
        string spMappingApprovalEmailInsert = "spMappingApprovalEmailInsert";
        string spMappingApprovalEmailDelete = "spMappingApprovalEmailDelete";

        // Field Name
        string ApprovalID = "ApprovalID";
        string MenuId = "MenuId";
        string ParentCode = "ParentCode";
        string UserIdApproval = "UserIdApproval";
        string IsBranch = "IsBranch";
        string StateDescription = "StateDescription";
        
        public DataSet getMappingApproval(ref USoft.DataAccess.Entities.Master.MappingApproval info)
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
                ds = sqlHandler.ExecuteAsDataSet(spMappingApprovalList, ref ListParam);
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

        public String MappingApprovalInsert(ref USoft.DataAccess.Entities.Master.MappingApproval info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pointApprovalId;
            sqlParam.Value = info.MenuId;
            sqlParam.Direction = ParameterDirection.ReturnValue;
            ListParam.Add(sqlParam); 
            
            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintMenuId;
            sqlParam.Value = info.MenuId;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchDepartementCode;
            sqlParam.Value = info.DepartementCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchParentCode;
            sqlParam.Value = info.ParentCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchUserIdApproval;
            sqlParam.Value = info.UserIdApproval;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pibitIsBranch;
            sqlParam.Value = info.IsBranch;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintState;
            sqlParam.Value = info.State;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchStateDescription;
            sqlParam.Value = info.StateDescription;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pibitIsActive;
            sqlParam.Value = info.IsActive;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);            

            try
            {
                sqlHandler.ExecuteAsDataSet(spMappingApprovalInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == pointApprovalId) { info.ApprovalId = Convert.ToInt32(sqlParamOut.Value); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String MappingApprovalUpdate(USoft.DataAccess.Entities.Master.MappingApproval info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalId, info.ApprovalId));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintMenuId, info.MenuId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDepartementCode, info.DepartementCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchParentCode, info.ParentCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserIdApproval, info.UserIdApproval));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsBranch, info.IsBranch));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintState, info.State));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStateDescription, info.StateDescription));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spMappingApprovalUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String MappingApprovalDelete(USoft.DataAccess.Entities.Master.MappingApproval info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalId, info.ApprovalId));

            try
            {
                sqlHandler.ExecuteAsDataSet(spMappingApprovalDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getMappingApprovalView(ref USoft.DataAccess.Entities.Master.MappingApproval info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalId, info.ApprovalId));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spMappingApprovalView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ApprovalId = Convert.ToInt32(dr[ApprovalID].ToString());
                        info.MenuId = Convert.ToInt32(dr[MenuId].ToString());
                        info.DepartementCode = dr[DepartementCode].ToString();
                        info.ParentCode = dr[ParentCode].ToString();
                        info.UserIdApproval = dr[UserIdApproval].ToString();
                        info.IsBranch = Convert.ToBoolean(dr[IsBranch].ToString());
                        info.State = Convert.ToInt32(dr[State].ToString());
                        info.StateDescription = dr[StateDescription].ToString();
                        info.IsActive = Convert.ToBoolean(dr[IsActive].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public DataSet getMappingApprovalEmail(USoft.DataAccess.Entities.Master.MappingApproval info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalId, info.ApprovalId));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spMappingApprovalEmailList, ParameterCollection);
            }
            catch
            { throw; }
        }

        public String MappingApprovalEmailInsert(USoft.DataAccess.Entities.Master.MappingApproval info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalId, info.ApprovalId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserIdEmail, info.UserIdEmail));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spMappingApprovalEmailInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String MappingApprovalEmailDelete(USoft.DataAccess.Entities.Master.MappingApproval info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(piintApprovalEmailId, info.ApprovalEmailId));

            try
            {
                sqlHandler.ExecuteAsDataSet(spMappingApprovalEmailDelete, ParameterCollection);
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
