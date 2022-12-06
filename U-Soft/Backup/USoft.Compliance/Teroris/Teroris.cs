using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.Shared;
using System.Data.SqlClient;

namespace USoft.Compliance.Teroris
{
    public class Teroris
    {
        public Teroris()
        { 
        }

        public DataSet emptyData(List<string> columnName)
        {
            SQLHelper helper = new SQLHelper();
            return helper.EmptyDataSet(columnName);
        }
        public DataSet getTerorisList(string name,int startRow,int maxRow)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@name", name));
            ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", startRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", maxRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", 0));
            return sqlHandler.ExecuteAsDataSet("TERORIS_SEARCH", ParameterCollection);
        }

        public Int32 getTerorisCount(string name, int startRow, int maxRow)
        {
            int Total = 0;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@name", name));
            ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", startRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", maxRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", 1));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("TERORIS_SEARCH", ParameterCollection);
            while (sDr.Read())
            {
                Total = Convert.ToInt32(sDr[0].ToString());
                Total = Convert.ToInt32((Convert.ToDouble(Total) / maxRow) + 0.5);
            }
            return Total;
        }
    }
}
