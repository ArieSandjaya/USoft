using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.Data.SqlClient;

namespace USoft.Compliance.Master
{
    public class DeptSearch
    {
        private string _deptname;
        private string _status;

        public DeptSearch()
        { }

        public DataTable GetDepartment()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            //ParameterCollection.Add(new KeyValuePair<string, object>("@DeptName", _deptname));
            //ParameterCollection.Add(new KeyValuePair<string, object>("@Status", _status));
            return sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_SEARCH_DEPT", ParameterCollection);
        }

        public string DeptName
        {
            set { _deptname = value; }
        }
        public string Status
        {
            set { _status = value = value == "null" ? null : value; ; }
        }
    }
}
