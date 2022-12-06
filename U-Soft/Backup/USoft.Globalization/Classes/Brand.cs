using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.Data;

namespace USoft.Globalization.Classes
{
    public class Brand
    {
        public Brand()
        {}
        public DataSet GetBrand()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            return sqlHandler.ExecuteAsDataSet("CASH_REWARD_BRAND");
        }
    }
}
