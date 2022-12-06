using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.Data.SqlClient;

namespace USoft.Globalization.Privilege
{
    public class PrivSearch
    {
        //private string status;

        public PrivSearch()
        { }

        public DataTable GetPriviledge()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            return sqlHandler.ExecuteAsDataTable("MsSearchPriviledge");
        }

        //public string Status
        //{
        //    set { status = value = value == "null" ? null : value; ; }
        //}
    }
}
