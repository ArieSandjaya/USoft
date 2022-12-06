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
    public class Suppliers
    {
        CommonFunction cf = new CommonFunction();
        SQLHandler sqlHandler = new SQLHandler();
        public Suppliers()
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
                ParameterCollection.Add(new KeyValuePair<string, object>("@supplier_id", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@supplier_name", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@address", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@city", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@zipcode", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@phone", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@npwp", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Active", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", ""));
                ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", startIndex));
                ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", endIndex));
                sb.Append(cf.ConvertToJson(sqlHandler.ExecuteAsDataTable("MsSuppliers",ParameterCollection)));
                return serializer.DeserializeObject(sb.ToString());
        }
        public bool Insert(string supplier_id,string supplier_name,string address,string city,string zipcode,string phone,string npwp,string Active,string UpdateBy)
        {
            try
            {
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 1));
                ParameterCollection.Add(new KeyValuePair<string, object>("@supplier_id", supplier_id));
                ParameterCollection.Add(new KeyValuePair<string, object>("@supplier_name", supplier_name));
                ParameterCollection.Add(new KeyValuePair<string, object>("@address", address));
                ParameterCollection.Add(new KeyValuePair<string, object>("@city", city));
                ParameterCollection.Add(new KeyValuePair<string, object>("@zipcode", zipcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@phone", phone));
                ParameterCollection.Add(new KeyValuePair<string, object>("@npwp", npwp));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Active", Active));
                ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", UpdateBy));
                ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", 0));
                ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", 0));
                sqlHandler.ExecuteNonQuery("MsSuppliers",ParameterCollection);
                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool Update(string supplier_id,string supplier_name,string address,string city,string zipcode,string phone,string npwp,string Active,string UpdateBy)
        {
            try
            {
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@supplier_id", supplier_id));
                ParameterCollection.Add(new KeyValuePair<string, object>("@supplier_name", supplier_name));
                ParameterCollection.Add(new KeyValuePair<string, object>("@address", address));
                ParameterCollection.Add(new KeyValuePair<string, object>("@city", city));
                ParameterCollection.Add(new KeyValuePair<string, object>("@zipcode", zipcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@phone", phone));
                ParameterCollection.Add(new KeyValuePair<string, object>("@npwp", npwp));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Active", Active));
                ParameterCollection.Add(new KeyValuePair<string, object>("@updateBy", UpdateBy));
                ParameterCollection.Add(new KeyValuePair<string, object>("@StartIndex", 0));
                ParameterCollection.Add(new KeyValuePair<string, object>("@EndIndex", 0));
                sqlHandler.ExecuteNonQuery("MsSuppliers",ParameterCollection);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
