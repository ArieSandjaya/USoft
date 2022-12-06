using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Security;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.Data.SqlClient;
using System.Web;

namespace USoft.Compliance
{
    public class DeptEdit
    {
        private string _deptcode;
        private string _deptname;
        private int _status;

        public DeptEdit()
        { }
        public string EditDepartment()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@DeptCode", _deptcode));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DeptName", _deptname));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Status", _status));
            
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("ENTERTAINMENT_EDIT_DEPT", ParameterCollection);
            string value = "";
            while (sDr.Read())
            {
                value = sDr[0].ToString();
            }
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
        public int Status
        {
            get { return _status; }
            set { _status = value; }
        }
    }
}
