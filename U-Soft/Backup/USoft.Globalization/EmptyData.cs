using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Data;

namespace USoft.Globalization
{
    public class EmptyData
    {
        public EmptyData()
        { }
        public DataSet emptyData(List<string> columnName)
        {
            SQLHelper helper = new SQLHelper();
            return helper.EmptyDataSet(columnName);
        }
    }
}
