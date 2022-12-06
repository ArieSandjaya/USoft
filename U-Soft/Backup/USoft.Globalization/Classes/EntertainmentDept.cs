using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;

namespace USoft.Globalization.Classes
{
    public class EntertainmentDept
    {
        public EntertainmentDept()
        { }
        public DataSet GetEntertainmentDept()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            return sqlHandler.ExecuteAsDataSet("ENTERTAINMENT_GET_DEPT");
        }
    }
}
