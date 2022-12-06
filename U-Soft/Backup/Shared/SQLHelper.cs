using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace USoft.Common.Shared
{
    public class SQLHelper:SQLHandler
    {
        public SQLHelper() { }
        public DataSet EmptyDataSet(List<string> ColumName)
        {
            DataSet EmptyDs = new DataSet();
            DataTable EmptyDt = new DataTable();
            EmptyDt.Rows.Add(EmptyDt.NewRow());

            for (int i = 0; i < ColumName.Count; i++)
            {
                EmptyDt.Columns.Add(ColumName[i].ToString());
            }

            EmptyDs.Tables.Add(EmptyDt);

            return EmptyDs;
        }
        public void GetSqlValue(List<KeyValuePair<string, object>> Controls, SqlDataReader DataReader)
        {
            DataReader.Read();
            foreach (KeyValuePair<string, object> pair in Controls)
            {
                if (pair.Value.ToString() == "System.Web.UI.WebControls.TextBox")
                {
                    TextBox tBox = (TextBox)pair.Value;
                    if (tBox.Attributes["stringFormat"] != null)
                    {
                        tBox.Text = string.Format(tBox.Attributes["stringFormat"], Convert.ToDouble(DataReader[pair.Key].ToString()));
                    }
                    else
                    {
                        tBox.Text = DataReader[pair.Key].ToString();
                    }
                }
                else if (pair.Value.ToString() == "System.Web.UI.WebControls.Label")
                {
                    Label lBox = (Label)pair.Value;
                    if (lBox.Attributes["stringFormat"] != null)
                    {
                        lBox.Text = string.Format(lBox.Attributes["stringFormat"], Convert.ToDouble(DataReader[pair.Key].ToString()));
                    }
                    else
                    {
                        lBox.Text = DataReader[pair.Key].ToString();
                    }
                }
            }
        }
    }
}
