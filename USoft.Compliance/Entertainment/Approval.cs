using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Data;
using System.Data.SqlClient;

namespace USoft.Compliance.Entertainment
{
    public class Approval
    {
        public Approval()
        { }
        public DataTable ApprovalApps(int startRow, int maxRow)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", startRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", maxRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", 0));
            return sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_GIFT_VIEW_SHOW", ParameterCollection);
        }
        public int ApprovalAppsCount(int startRow, int maxRow)
        {
            int Total = 0;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", startRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", maxRow));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", 1));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("ENTERTAINMENT_GIFT_VIEW_SHOW", ParameterCollection);
            while (sDr.Read())
            {
                Total = Convert.ToInt32(sDr[0].ToString());
                Total = Convert.ToInt32((Convert.ToDouble(Total) / maxRow) + 0.5);
            }
            return Total;
        }
        public void ApprovalUpdate(int KeyId,string Status)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@KeyID", KeyId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Status", Status));
            sqlHandler.ExecuteNonQuery("ENTERTAINMENT_GIFT_APPROVE", ParameterCollection);
        }
    }
}
