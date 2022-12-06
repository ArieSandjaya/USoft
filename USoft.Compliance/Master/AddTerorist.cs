using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using USoft.Common.Setting;
using System.IO;
using USoft.Common.Shared;

namespace USoft.Compliance.Teroris
{
    public class AddTerorist
    {
        public AddTerorist()
        { }
        public DataTable ExportToDb(string exts,string filePath)
        {
            string strExcelConn;
            if (exts == ".xls")
            {
                strExcelConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties='Excel 8.0;HDR=YES;'";
            }
            else
            {
                strExcelConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties='Excel 12.0 Xml;HDR=YES;'";
            }
            DataTable dtExcel = RetrieveData(strExcelConn);
            int iStartCount = GetRowCounts();
            SqlBulkCopyImport(dtExcel);
            int iEndCount = GetRowCounts();
            File.Delete(filePath);
            return ShowImported();

        }
        protected DataTable RetrieveData(string strConn)
        {
            DataTable dtExcel = new DataTable();
            using (OleDbConnection conn = new OleDbConnection(strConn))
            {
                OleDbDataAdapter da = new OleDbDataAdapter("select * from [TERORIST_LIST$]", conn);
                da.Fill(dtExcel);
            }
            return dtExcel;
        }
        protected void SqlBulkCopyImport(DataTable dtExcel)
        {
            using (SqlConnection conn = new SqlConnection(SystemSetting.ConnectionString))
            {
               SQLHandler sqlHandler = new SQLHandler();
               List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
               ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 0));
               sqlHandler.ExecuteNonQuery("TERORIS_INSERT",ParameterCollection);
               conn.Open();
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
                {
                    bulkCopy.DestinationTableName = "temp_terorist_list";
                    foreach (DataColumn dc in dtExcel.Columns)
                    {
                        bulkCopy.ColumnMappings.Add(dc.ColumnName, dc.ColumnName);
                    }
                    bulkCopy.WriteToServer(dtExcel);
                }
            }
        }
        protected int GetRowCounts()
        {
            int iRowCount = 0;

            using (SqlConnection conn = new SqlConnection(SystemSetting.ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("select count(*) from TERORIST_LIST", conn);
                conn.Open();

                // Execute the SqlCommand and get the row counts.
                iRowCount = (int)cmd.ExecuteScalar();
            }

            return iRowCount;
        }
        private DataTable ShowImported()
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 2));
            return sqlHandler.ExecuteAsDataTable("TERORIS_INSERT", ParameterCollection);
        }
        public DataTable SaveImportes()
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@TYPE", 1));
                sqlHandler.ExecuteNonQuery("TERORIS_INSERT", ParameterCollection);
                return ShowImported();
            }
            catch
            {
                return null;
            }
        }
    }
}
