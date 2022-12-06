using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;

namespace USoft.Globalization
{
    public class Branch
    {
        public Branch()
        { }

        public DataSet GetBranch()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            return sqlHandler.ExecuteAsDataSet("MsGetBranch");
        }
    }
}
