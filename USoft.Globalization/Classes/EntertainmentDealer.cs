using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using USoft.Common.CommonFunction;
using System.Data;

namespace USoft.Globalization.Dealer
{
    public class EntertainmentDealer
    {
        public EntertainmentDealer()
        { }
        public DataSet GetEntertainmentDealer()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            return sqlHandler.ExecuteAsDataSet("ENTERTAINMENT_GET_DEALER");
        }
    }
}
