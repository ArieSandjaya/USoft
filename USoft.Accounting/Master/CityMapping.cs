using System;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Web.Script.Serialization;
using USoft.Common.Shared;
using USoft.Globalization.Classes;
using USoft.Accounting.Bapepam;

namespace USoft.Accounting.Master
{
    public class CityMapping
    {
        public CityMapping(){}
        public static object MappingCode()
        {
            SQLHandler sqlHandler = new SQLHandler();
            BindToJson json = new BindToJson();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = 2147483644;
            StringBuilder sb = new StringBuilder();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 2));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CITY_CODE", ""));
            ParameterCollection.Add(new KeyValuePair<string, object>("@MAP_CODE", ""));
            ParameterCollection.Add(new KeyValuePair<string, object>("@MAP_CITY", ""));
            ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", 0));

            sb.Append(json.convert(sqlHandler.ExecuteAsDataTable("ACCOUNTING_CITY_MAPPING",ParameterCollection)));
            return serializer.DeserializeObject(sb.ToString());
        }
        public static void SaveMap(string CityCode,string MapCode,string MapCity)
        {
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 1));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CITY_CODE", CityCode));
            ParameterCollection.Add(new KeyValuePair<string, object>("@MAP_CODE", MapCode));
            ParameterCollection.Add(new KeyValuePair<string, object>("@MAP_CITY", MapCity));
            ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", 0));
            SQLHandler sqlHandler = new SQLHandler();
            sqlHandler.ExecuteNonQuery("ACCOUNTING_CITY_MAPPING",ParameterCollection);
        }
    }
}
