using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace USoft.Common.CommonFunction
{
    public class JsonHelper
    {
        public JsonHelper(){}
        public static string FromDataRow(DataRow row)
        {
            DataColumnCollection cols = row.Table.Columns;
            string colDelimiter = "";

            StringBuilder result = new StringBuilder("{");       
            for (int i = 0; i < cols.Count; i++)
            {
                result.Append(colDelimiter).Append("\"")
                      .Append(cols[i].ColumnName).Append("\":")
                      .Append(JSONValueFromDataRowObject(row[i], cols[i].DataType));

                colDelimiter = ",";
            }
            result.Append("}");
            return result.ToString();
        }

        private static Type[] numeric = new Type[] {typeof(byte), typeof(decimal), typeof(double), 
                                         typeof(Int16), typeof(Int32), typeof(SByte), typeof(Single),
                                         typeof(UInt16), typeof(UInt32), typeof(UInt64)};
        private static long EpochTicks = new DateTime(1970, 1, 1).Ticks;

        private static string JSONValueFromDataRowObject(object value, Type DataType)
        {
            if (value == DBNull.Value) return "null";

            // numeric
            if (Array.IndexOf(numeric, DataType) > -1)
                return value.ToString();

            // boolean
            if (DataType == typeof(bool))
                return ((bool)value) ? "true" : "false";

            // date
            if (DataType == typeof(DateTime))       
                return "\"\\/Date(" + new TimeSpan(((DateTime)value).ToUniversalTime().Ticks - EpochTicks).TotalMilliseconds.ToString() + ")\\/\"";

            return "\"" + value.ToString().Replace(@"\", @"\\").Replace(Environment.NewLine, @"\n").Replace("\"", @"\""") + "\"";
        }

    }
}
