using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Text;
using System.Collections.Specialized;
using USoft.Common.Shared;
using USoft.Accounting.Bapepam;

namespace USoft.Modules.Accounting.Bapepam
{
    /// <summary>
    /// Summary description for PembiayaanKonsumenServ
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService()]
    public class PembiayaanKonsumenServ : System.Web.Services.WebService
    {

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public object Show(string FormType)
        {
            NameValueCollection queryString = this.Context.Request.QueryString;
            int startIndex = int.Parse(queryString.GetValues("recordstartindex")[0]);
            int endIndex = int.Parse(queryString.GetValues("recordendindex")[0]);
            string FilterString = BuildQuery(queryString);
            SQLHandler sqlHandler = new SQLHandler();
            BindToJson json = new BindToJson();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.MaxJsonLength = 2147483644;
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@FormType", FormType));
            ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", startIndex));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", endIndex));
            ParameterCollection.Add(new KeyValuePair<string, object>("@FilterString", FilterString));
            StringBuilder sb = new StringBuilder("{ \"count\": ");
            sb.Append("\""+getTotalRow(FormType)+"\"");
            sb.Append(", \"data\":");
            sb.Append(json.convert(sqlHandler.ExecuteAsDataTable("ACCOUNTING_BAPEPAM_FORM7",ParameterCollection)));
            sb.Append("}");
            return serializer.DeserializeObject(sb.ToString());
            
        }
        private string BuildQuery(System.Collections.Specialized.NameValueCollection query)
        {
            string queryString = "";
            string[] values = query.GetValues("filterscount");
            if (values != null && values.Length > 0)
            {
                int filtersCount = int.Parse(query.GetValues("filterscount")[0]);
                string where = "";
                if (filtersCount > 0)
                {
                    where += " AND (" + BuildFilters(filtersCount, query);
                }
                queryString += where;
            }
            return queryString;
        }
        private string BuildFilters(int filtersCount, System.Collections.Specialized.NameValueCollection query)
        {
            string tmpDataField = "";
            string where = "";
            string tmpFilterOperator = "";
            for (int i = 0; i < filtersCount; i += 1)
            {
                string filterValue = query.GetValues("filtervalue" + i)[0];
                string filterCondition = query.GetValues("filtercondition" + i)[0];
                string filterDataField = query.GetValues("filterdatafield" + i)[0];
                string filterOperator = query.GetValues("filteroperator" + i)[0];
                if (tmpDataField == "")
                {
                    tmpDataField = filterDataField;
                }
                else if (tmpDataField != filterDataField)
                {
                    where += ") AND (";
                }
                else if (tmpDataField == filterDataField)
                {
                    if (tmpFilterOperator == "")
                    {
                        where += " AND ";
                    }
                    else
                    {
                        where += " OR ";
                    }
                }
                // build the "WHERE" clause depending on the filter's condition, value and datafield.
                where += GetFilterCondition(filterCondition, filterDataField, filterValue);
                if (i == filtersCount - 1)
                {
                    where += ")";
                }
                tmpFilterOperator = filterOperator;
                tmpDataField = filterDataField;
            }
            return where;
        }
        // Get the SQL string for the Filter Condition. The parameters are the filter's condition, column's dataField and the filter's value passed by the Grid.
        private string GetFilterCondition(string filterCondition, string filterDataField, string filterValue)
        {
            switch (filterCondition)
            {
                case "NOT_EMPTY":
                case "NOT_NULL":
                    return " " + filterDataField + " NOT LIKE '" + "" + "'";
                case "EMPTY":
                case "NULL":
                    return " " + filterDataField + " LIKE '" + "" + "'";
                case "CONTAINS_CASE_SENSITIVE":
                    return " " + filterDataField + " LIKE '%" + filterValue + "%'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";
                case "CONTAINS":
                    return " " + filterDataField + " LIKE '%" + filterValue + "%'";
                case "DOES_NOT_CONTAIN_CASE_SENSITIVE":
                    return " " +filterDataField + " NOT LIKE '%" + filterValue + "%'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "DOES_NOT_CONTAIN":
                    return " " + filterDataField + " NOT LIKE '%" + filterValue + "%'";
                case "EQUAL_CASE_SENSITIVE":
                    return " " + filterDataField + " = '" + filterValue + "'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "EQUAL":
                    return " " + filterDataField + " = '" + filterValue + "'";
                case "NOT_EQUAL_CASE_SENSITIVE":
                    return " BINARY " + filterDataField + " <> '" + filterValue + "'";
                case "NOT_EQUAL":
                    return " " + filterDataField + " <> '" + filterValue + "'";
                case "GREATER_THAN":
                    return " " + filterDataField + " > '" + filterValue + "'";
                case "LESS_THAN":
                    return " " + filterDataField + " < '" + filterValue + "'";
                case "GREATER_THAN_OR_EQUAL":
                    return " " + filterDataField + " >= '" + filterValue + "'";
                case "LESS_THAN_OR_EQUAL":
                    return " " + filterDataField + " <= '" + filterValue + "'";
                case "STARTS_WITH_CASE_SENSITIVE":
                    return " " + filterDataField + " LIKE '" + filterValue + "%'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "STARTS_WITH":
                    return " " + filterDataField + " LIKE '" + filterValue + "%'";
                case "ENDS_WITH_CASE_SENSITIVE":
                    return " " + filterDataField + " LIKE '%" + filterValue + "'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "ENDS_WITH":
                    return " " + filterDataField + " LIKE '%" + filterValue + "'";
            }
            return "";
        }
        private static int getTotalRow(string FormType)
        {
            int iTotal=0;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 1));
            ParameterCollection.Add(new KeyValuePair<string, object>("@FormType", FormType));
            ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@FilterString", ""));
            SqlDataReader dr = sqlHandler.ExecuteAsDataReader("ACCOUNTING_BAPEPAM_FORM7",ParameterCollection);
               while(dr.Read())
               {
                   iTotal = Convert.ToInt16(dr[0]);
               }
            return iTotal;
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void ConvertToJSON()
        {
            BindToJson bts = new BindToJson();
            bts.GetJSON(40);
        }
    }
}
