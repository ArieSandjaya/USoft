using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Script.Serialization;
using System.Collections.Specialized;
using System.Web;
using USoft.Common.Security;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;

namespace USoft.Globalization.Classes
{
    public class Measurements
    {
        CommonFunction cf = new CommonFunction();
        SQLHandler sqlHandler = new SQLHandler();
        public Measurements()
        {}
        public object Select()
        {
                NameValueCollection queryString = HttpContext.Current.Request.QueryString;
                int startIndex = int.Parse(queryString.GetValues("recordstartindex")[0]);
                int endIndex = int.Parse(queryString.GetValues("recordendindex")[0]);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                serializer.MaxJsonLength = 2147483644;
                StringBuilder sb = new StringBuilder();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 0));
                ParameterCollection.Add(new KeyValuePair<string, object>("@measurement_code", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@description", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", startIndex));
                ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", endIndex));
                sb.Append(cf.ConvertToJson(sqlHandler.ExecuteAsDataTable("MsMeasurements",ParameterCollection)));
                return serializer.DeserializeObject(sb.ToString());
        }
        public bool Insert(string MeasurementCode,string MeasurementName,string UpdateBy)
        {
            try
            {
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 1));
                ParameterCollection.Add(new KeyValuePair<string, object>("@measurement_code", MeasurementCode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@description", MeasurementName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", UpdateBy));
                ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", 0));
                ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", 0));
                sqlHandler.ExecuteNonQuery("MsMeasurements",ParameterCollection);
                return true;
            }
            catch
            {
                throw;
            }
        }
        public bool Update(string MeasurementCode,string MeasurementName,string UpdateBy)
        {
            try
            {
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 2));
                ParameterCollection.Add(new KeyValuePair<string, object>("@measurement_code", MeasurementCode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@description", MeasurementName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", UpdateBy));
                ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", 0));
                ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", 0));
                sqlHandler.ExecuteNonQuery("MsMeasurements",ParameterCollection);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
