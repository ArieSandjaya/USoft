using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Text;
using System.Collections.Specialized;
using USoft.Common.Shared;
using USoft.Accounting.Master;
using USoft.Accounting.Bapepam;
using USoft.Globalization.Classes;

namespace USoft.Modules.Accounting.Master
{
    public partial class CityMap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             if (!IsPostBack)
            {
                Label lbl = (Label)CtrlFormHeader.FindControl("lblHeader");
                lbl.Text = "City Mapping";
            }
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static object Show()
        {
            NameValueCollection queryString = HttpContext.Current.Request.QueryString;
            int startIndex = int.Parse(queryString.GetValues("recordstartindex")[0]);
            int endIndex = int.Parse(queryString.GetValues("recordendindex")[0]);
            GridFilter GF = new GridFilter();
            string FilterString = GF.BuildQuery(queryString);
            SQLHandler sqlHandler = new SQLHandler();
            BindToJson json = new BindToJson();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = 2147483644;
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 99));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CITY_CODE", ""));
            ParameterCollection.Add(new KeyValuePair<string, object>("@MAP_CODE", ""));
            ParameterCollection.Add(new KeyValuePair<string, object>("@MAP_CITY", ""));
            ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", startIndex));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", endIndex));
            StringBuilder sb = new StringBuilder("{ \"count\": ");
            sb.Append("\""+GF.getTotalRow("ACCOUNTING_CITY_MAPPING",ParameterCollection)+"\"");
            sb.Append(", \"data\":");
            ParameterCollection.Remove(new KeyValuePair<string, object>("@TYPE", 99));
            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 0));
            sb.Append(json.convert(sqlHandler.ExecuteAsDataTable("ACCOUNTING_CITY_MAPPING",ParameterCollection)));
            sb.Append("}");
            return serializer.DeserializeObject(sb.ToString());
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static object GetMappingCode()
        {          
            return CityMapping.MappingCode();
        }
        [WebMethod]
        public static bool SaveMapping(string CityCode,string MapCode,string MapCity)
        {
            CityMapping.SaveMap(CityCode,MapCode,MapCity);
            return true;
        }
    }
}
