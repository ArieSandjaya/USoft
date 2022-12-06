using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.IT
{
    public class ScheduleTask : USoft.DataAccess.General.Common
    {
        // Parameter
        
        string pivchScheduleNo = "@pivchScheduleNo";
        string pivchScheduleType = "@pivchScheduleType";
        string pivchScheduleTitle = "@pivchScheduleTitle";
        string pidtmStartDate = "@pidtmStartDate";
        string pidtmEndDate = "@pidtmEndDate";
        string pivchIntervalBy = "@pivchIntervalBy";
        string piintIntervalRange = "@piintIntervalRange";
        string pivchIntervalHour = "@pivchIntervalHour";
        string pivchIntervalMinute = "@pivchIntervalMinute";
        string pivchStatus = "@pivchStatus";

        // Store Procedure
        string spScheduleTaskList = "spScheduleTaskList";
        string spScheduleTaskInsert = "spScheduleTaskInsert";
        string spScheduleTaskUpdate = "spScheduleTaskUpdate";
        string spScheduleTaskDelete = "spScheduleTaskDelete";
        string spScheduleTaskView = "spScheduleTaskView";
        string spScheduleTaskNextList = "spScheduleTaskNextList";
        string spScheduleTaskFinish = "spScheduleTaskFinish";

        // Field Name
        string ScheduleNo = "ScheduleNo";
        string ScheduleType = "ScheduleType";
        string ScheduleTitle = "ScheduleTitle";
        string StartDate = "StartDate";
        string EndDate = "EndDate";
        string IntervalBy = "IntervalBy";
        string IntervalRange = "IntervalRange";
        string IntervalHour = "IntervalHour";
        string IntervalMinute = "IntervalMinute";

        public DataSet getScheduleTask(ref USoft.DataAccess.Entities.IT.ScheduleTask info)
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
                ds = sqlHandler.ExecuteAsDataSet(spScheduleTaskList, ref ListParam);
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

        public DataSet getScheduleTaskNext(USoft.DataAccess.Entities.IT.ScheduleTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchWhereBy, info.WhereBy));

            try
            {
                return sqlHandler.ExecuteAsDataSet(spScheduleTaskNextList, ParameterCollection);
            }
            catch
            { throw; }
        }

        public String ScheduleTaskInsert(USoft.DataAccess.Entities.IT.ScheduleTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleType, info.ScheduleType));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleTitle, info.ScheduleTitle));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmStartDate, info.StartDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmEndDate, info.EndDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchIntervalBy, info.IntervalBy));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintIntervalRange, info.IntervalRange));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchIntervalHour, info.IntervalHour));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchIntervalMinute, info.IntervalMinute));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spScheduleTaskInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String ScheduleTaskUpdate(USoft.DataAccess.Entities.IT.ScheduleTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleNo, info.ScheduleNo));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleType, info.ScheduleType));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleTitle, info.ScheduleTitle));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmStartDate, info.StartDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pidtmEndDate, info.EndDate));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchIntervalBy, info.IntervalBy));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintIntervalRange, info.IntervalRange));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchIntervalHour, info.IntervalHour));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchIntervalMinute, info.IntervalMinute));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchStatus, info.Status));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchDescription, info.Description));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spScheduleTaskUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String ScheduleTaskDelete(USoft.DataAccess.Entities.IT.ScheduleTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleNo, info.ScheduleNo));

            try
            {
                sqlHandler.ExecuteAsDataSet(spScheduleTaskDelete, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String ScheduleTaskFinish(USoft.DataAccess.Entities.IT.ScheduleTask info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleNo, info.ScheduleNo));

            try
            {
                sqlHandler.ExecuteAsDataSet(spScheduleTaskFinish, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getScheduleTaskView(ref USoft.DataAccess.Entities.IT.ScheduleTask info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchScheduleNo, info.ScheduleNo));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spScheduleTaskView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.ScheduleNo = dr[ScheduleNo].ToString();
                        info.ScheduleType = dr[ScheduleType].ToString();
                        info.ScheduleTitle = dr[ScheduleTitle].ToString();
                        info.Description = dr[Description].ToString();
                        info.StartDate = Convert.ToDateTime(dr[StartDate].ToString());
                        if(dr[EndDate] != DBNull.Value)
                        {
                            info.EndDate = Convert.ToDateTime(dr[EndDate].ToString());
                        }
                        info.IntervalBy = dr[IntervalBy].ToString();
                        info.IntervalRange = Convert.ToInt16(dr[IntervalRange].ToString());
                        info.IntervalHour = dr[IntervalHour].ToString();
                        info.IntervalMinute = dr[IntervalMinute].ToString();
                        info.Status = dr[Status].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
    }
}
