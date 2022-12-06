using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.Master
{
    public class Privilege : USoft.DataAccess.General.Common
    {
        // Parameter
        string pivchPrivilegeCode = "@pivchPrivilegeCode";
        string pivchPrivilegeName = "@pivchPrivilegeName";
        string pivchDepartementCode = "@pivchDepartementCode";
        string pivchOldCode = "@pivchOldCode";
        
        string piintMenuId = "@piintMenuId";
        string pibitInsert = "@pibitInsert";
        string pibitUpdate = "@pibitUpdate";
        string pibitDelete = "@pibitDelete";
        string pibitView = "@pibitView";
        string pivchUserId = "@pivchUserId";

        // Store Procedure
        string spPrivilegeList = "spPrivilegeList";
        string spPrivilegeInsert = "spPrivilegeInsert";
        string spPrivilegeUpdate = "spPrivilegeUpdate";
        string spPrivilegeView = "spPrivilegeView";
        string spPrivilegeMenuList = "spPrivilegeMenuList";
        string spPrivilegeMenuClear = "spPrivilegeMenuClear";
        string spPrivilegeMenuUpdate = "spPrivilegeMenuUpdate";

        // Field Name
        string PrivilegeCode = "PrivilegeCode";
        string PrivilegeName = "PrivilegeName";
        string OldCode = "OldCode";
        
        public DataSet getPrivilege(ref USoft.DataAccess.Entities.Master.Privilege info)
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
                ds = sqlHandler.ExecuteAsDataSet(spPrivilegeList, ref ListParam);
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

        public String PrivilegeInsert(USoft.DataAccess.Entities.Master.Privilege info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeName, info.PrivilegeName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDepartementCode, info.DepartementCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOldCode, info.OldCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spPrivilegeInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String PrivilegeUpdate(USoft.DataAccess.Entities.Master.Privilege info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeName, info.PrivilegeName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDepartementCode, info.DepartementCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchOldCode, info.OldCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spPrivilegeUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getPrivilegeView(ref USoft.DataAccess.Entities.Master.Privilege info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spPrivilegeView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.PrivilegeCode = dr[PrivilegeCode].ToString();
                        info.PrivilegeName = dr[PrivilegeName].ToString();
                        info.DepartementCode = dr[DepartementCode].ToString();
                        info.DepartementName = dr[DepartementName].ToString();
                        info.OldCode = dr[OldCode].ToString();
                        info.IsActive = Convert.ToBoolean(dr[IsActive].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public DataSet getPrivilegeMenu(USoft.DataAccess.Entities.Master.Privilege info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, info.UserId));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spPrivilegeMenuList, ParameterCollection);
            }
            catch
            { throw; }
        }

        public String PrivilegeMenuClear(USoft.DataAccess.Entities.Master.Privilege info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));

            try
            {
                sqlHandler.ExecuteAsDataSet(spPrivilegeMenuClear, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String PrivilegeMenuUpdate(USoft.DataAccess.Entities.Master.Privilege info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPrivilegeCode, info.PrivilegeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintMenuId, info.MenuId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitInsert, info.Insert));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitUpdate, info.Update));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitDelete, info.Delete));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitView, info.View));

            try
            {
                sqlHandler.ExecuteAsDataSet(spPrivilegeMenuUpdate, ParameterCollection);
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
