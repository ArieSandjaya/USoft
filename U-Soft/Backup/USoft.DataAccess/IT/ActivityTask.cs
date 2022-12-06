using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.IT
{
    public class ActivityTask : USoft.DataAccess.General.Common
    {
        // Parameter
        string povchActivityNo = "@povchActivityNo";
        string pivchActivityNo = "@pivchActivityNo";
        string pidtmActivityDate = "@pidtmActivityDate";
        string pivchRequestBy = "@pivchRequestBy";
        //string pivchEmail = "@pivchEmail";
        string piintBranchId = "@piintBranchId";
        string pivchDepartementCode = "@pivchDepartementCode";
        string piintProblemTypeCode = "@piintProblemTypeCode";
        string pivchItemTypeCode = "@pivchItemTypeCode";
        string pivchPriority = "@pivchPriority";
        string pivchStatus = "@pivchStatus";
        string pivchAssignTo = "@pivchAssignTo";
        string pivchAssignDescription = "@pivchAssignDescription";

        // Store Procedure
        string spITActivityTaskList = "spITActivityTaskList";
        string spITActivityTaskInsert = "spITActivityTaskInsert";
        string spITActivityTaskUpdate = "spITActivityTaskUpdate";
        string spITActivityTaskDelete = "spITActivityTaskDelete";
        string spITActivityTaskView = "spITActivityTaskView";
        string spITActivityAssignList = "spITActivityAssignList";
        string spITActivityAssignInsert = "spITActivityAssignInsert";
        
        // Field Name
        string ActivityNo = "ActivityNo";
        string ActivityDate = "ActivityDate";
        //string Email = "Email";
        string ProblemTypeCode = "ProblemTypeCode";
        string ProblemTypeName = "ProblemTypeName";
        string ItemTypeCode = "ItemTypeCode";
        string ItemTypeName = "ItemTypeName";
        string Priority = "Priority";
        string PIC = "PIC";
        string TerminatedBy = "TerminatedBy";

        public DataSet getActivityTask(ref USoft.DataAccess.Entities.IT.ActivityTask info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
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
                ds = sqlHandler.ExecuteAsDataSet(spITActivityTaskList, ref ListParam);
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

        public String ActivityTaskInsert(ref USoft.DataAccess.Entities.IT.ActivityTask info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = povchActivityNo;
            sqlParam.Value = info.ActivityNo;
            sqlParam.Size = 12;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pidtmActivityDate;
            sqlParam.Value = info.ActivityDate;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchRequestBy;
            sqlParam.Value = info.RequestBy;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintBranchId;
            sqlParam.Value = info.BranchId;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchDepartementCode;
            sqlParam.Value = info.DepartementCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintProblemTypeCode;
            sqlParam.Value = info.ProblemTypeCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchItemTypeCode;
            sqlParam.Value = info.ItemTypeCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchDescription;
            sqlParam.Value = info.Description;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchPriority;
            sqlParam.Value = info.Priority;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);

            try
            {
                sqlHandler.ExecuteAsDataSet(spITActivityTaskInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == povchActivityNo) { info.ActivityNo = sqlParamOut.Value.ToString(); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String ActivityTaskUpdate(USoft.DataAccess.Entities.IT.ActivityTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchActivityNo, info.ActivityNo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmActivityDate, info.ActivityDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchRequestBy, info.RequestBy));
            //ParameterCollection.Add(new KeyValuePair<string, object>(pivchEmail, info.Email));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintBranchId, info.BranchId));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDepartementCode, info.DepartementCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintProblemTypeCode, info.ProblemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchItemTypeCode, info.ItemTypeCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPriority, info.Priority));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITActivityTaskUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getActivityTaskView(ref USoft.DataAccess.Entities.IT.ActivityTask info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchActivityNo, info.ActivityNo));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spITActivityTaskView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ActivityNo = dr[ActivityNo].ToString();
                        info.ActivityDate = Convert.ToDateTime(dr[ActivityDate].ToString());
                        info.RequestBy = dr[RequestBy].ToString();
                        //info.Email = dr[Email].ToString();
                        info.BranchId = Convert.ToInt16(dr[BranchId].ToString());
                        info.BranchName = dr[BranchName].ToString();
                        info.DepartementCode = dr[DepartementCode].ToString();
                        info.DepartementName = dr[DepartementName].ToString();
                        info.ProblemTypeCode = Convert.ToInt32(dr[ProblemTypeCode].ToString());
                        info.ProblemTypeName = dr[ProblemTypeName].ToString();
                        info.ItemTypeCode = dr[ItemTypeCode].ToString();
                        info.ItemTypeName = dr[ItemTypeName].ToString();
                        info.Description = dr[Description].ToString();
                        info.Priority = dr[Priority].ToString();
                        info.PIC = dr[PIC].ToString();
                        info.TerminatedBy = dr[TerminatedBy].ToString();
                        info.Status = dr[Status].ToString();
                        if (dr[ApprovalState].ToString() != "")
                        {
                            info.ApprovalState = Convert.ToInt16(dr[ApprovalState].ToString());
                        }
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public String ActivityTaskDelete(USoft.DataAccess.Entities.IT.ActivityTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchActivityNo, info.ActivityNo));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITActivityTaskDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public DataSet getActivityAssign(USoft.DataAccess.Entities.IT.ActivityTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchActivityNo, info.ActivityNo)); 
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchWhereBy, info.WhereBy));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spITActivityAssignList, ParameterCollection);
            }
            catch
            { throw; }
        }

        public String ActivityAssignInsert(USoft.DataAccess.Entities.IT.ActivityTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchActivityNo, info.ActivityNo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchAssignTo, info.AssignTo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchAssignDescription, info.AssignDescription));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spITActivityAssignInsert, ParameterCollection);
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
