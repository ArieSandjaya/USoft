using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using USoft.Common.Setting;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.IO;
using System.Web;
using USoft.Globalization;

namespace USoft.Compliance
{
    public class AddDept
    {
        private string _deptcode;
        private string _deptname;

        public AddDept()
        { }

        public string CreateDepartment()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@DeptCode", _deptcode));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DeptName", _deptname));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("ENTERTAINMENT_CREATE_DEPT", ParameterCollection);
            string value = "";
            while (sDr.Read())
            {
                value = sDr[0].ToString();
            }
            HttpRuntime.Cache["EntDept"] = null;
            AppStart.GetEntDept();
            return value;
        }

        public string DeptCode
        {
            get { return _deptcode; }
            set { _deptcode = value; }
        }
        public string DeptName
        {
            get { return _deptname; }
            set { _deptname = value; }
        }        
    }
}
