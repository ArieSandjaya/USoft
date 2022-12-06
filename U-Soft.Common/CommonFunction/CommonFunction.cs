using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.IO;
using System.Collections;

namespace USoft.Common.CommonFunction
{
    public class CommonFunction
    {
        public CommonFunction()
        {
        }
        public string SearchText(string SearchBy, string SearchValue)
        {
            string SearchSQL = "";

            if (SearchBy != "")
            {
                string[] StrSearch = SearchBy.Split('|');

                SearchSQL = StrSearch[1];

                switch (StrSearch[0])
                {
                    case "chr":
                    case "vch": SearchSQL += " LIKE '" + SearchValue + "'";
                        break;
                    case "int":
                    case "dcm":
                    case "mon": SearchSQL += " = " + SearchValue;
                        break;
                }
            }

            return SearchSQL;
        }
        public string SearchList(string SearchBy, string SearchValue)
        {
            string[] strArray = SearchBy.Split(new char[1]{'|'});
            return strArray[1].ToString() + "~" + SearchValue;
        }
        public string SearchValue(string SearchBy, string SearchValue)
        {
            return SearchBy + "~" + SearchValue;
        }
        public string SqlAndOr(string sqlText, bool state)
        {
            if (sqlText != "") { sqlText = (state) ? " AND" : " OR"; }

            return sqlText;
        }
        public string RemoveSpecialChar(string MyString)
        {
            MyString = MyString.Replace("\"", "");
            MyString = MyString.Replace("@", "");
            MyString = MyString.Replace("?", "");
            MyString = MyString.Replace(":", "");
            MyString = MyString.Replace(";", "");
            MyString = MyString.Replace("_", "");
            MyString = MyString.Replace("=", "");
            MyString = MyString.Replace("<", "");
            MyString = MyString.Replace(">", "");
            MyString = MyString.Replace("[", "");
            MyString = MyString.Replace("]", "");
            MyString = MyString.Replace("{", "");
            MyString = MyString.Replace("}", "");
            MyString = MyString.Replace("!", "");
            MyString = MyString.Replace("#", "");
            MyString = MyString.Replace(",", "");
            MyString = MyString.Replace("-", "");
            MyString = MyString.Replace(".", "");
            MyString = MyString.Replace("^", "");
            MyString = MyString.Replace("(", "");
            MyString = MyString.Replace(")", "");
            MyString = MyString.Replace("/", "");
            MyString = MyString.Replace("~", "");
            MyString = MyString.Replace("|", "");
            MyString = MyString.Replace("$", "");
            MyString = MyString.Replace("%", "");
            MyString = MyString.Replace("&", "");
            MyString = MyString.Replace("*", "");
            MyString = MyString.Replace("and", "");
            return MyString;
        }
        public string ZeroToEmpty(string value)
        {
            try
            {
                if (Convert.ToInt32(value) == 0)
                {
                    return "";
                }
                else
                {
                    return value;
                }
            }
            catch
            {
                return value;
            }
        }
        public string RemoveZeroAfterComma(string value)
        {
            string strValue = "";
            string[] arr = value.Split('.');
            
            for (int i = 0; i < arr.Length; i++)
            {
                if (Convert.ToDouble(arr[i].ToString()) > 0)
                {
                    if (i == 0)
                    {
                        strValue = strValue + arr[i].ToString();
                    }
                    else
                    {
                        strValue = strValue + "."+ arr[i].ToString();
                    }
                }
            }
            return strValue;
        }
        public string RemoveZeroToEmpty(string value)
        {
            return ZeroToEmpty(RemoveZeroAfterComma(value));
        }
        public string DateNormalize(DateTime dt)
        {
            string year = Convert.ToString(dt.Year);
            string month = (Convert.ToString(dt.Month).Length > 1?"0":"00") + Convert.ToString(dt.Month);
            string day = (Convert.ToString(dt.Day).Length > 1 ? "0" : "00") + Convert.ToString(dt.Day);

            return year + month.Substring(1,2) + day.Substring(1,2);
        }
        public void ExportDataTableToCsv(DataTable datatable, string filename)
        {
            DataTable toExcel = datatable.Copy();
            HttpContext context = HttpContext.Current;
            context.Response.Clear();
            foreach (DataColumn column in toExcel.Columns)
            {
                context.Response.Write(column.ColumnName + ",");
            }
            context.Response.Write(Environment.NewLine);
            foreach (DataRow row in toExcel.Rows)
            {
                for (int i = 0; i < toExcel.Columns.Count; i++)
                {
                    context.Response.Write(row[i].ToString().Replace(",", string.Empty) + ",");
                }
                context.Response.Write(Environment.NewLine);
            }
            context.Response.ContentType = "text/csv";
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + ".csv");
            context.Response.End();
        }
        public void ExportDataTableToXLS(DataTable datatable, string filename)
        {
            DataTable toExcel = datatable.Copy();
            HttpContext context = HttpContext.Current;
            context.Response.Clear();
            foreach (DataColumn column in toExcel.Columns)
            {
                context.Response.Write(column.ColumnName + "\t");//+ ","
            }
            context.Response.Write(Environment.NewLine);
            foreach (DataRow row in toExcel.Rows)
            {
                for (int i = 0; i < toExcel.Columns.Count; i++)
                {
                    context.Response.Write(row[i].ToString().Replace(",", string.Empty) + "\t");//
                }
                context.Response.Write(Environment.NewLine);
            }
            context.Response.ContentType = "application/xls";
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + ".xls");
            context.Response.End();
        }
        public void ExportToText(string dataString,string FileName)
        {
            HttpContext.Current.Response.AddHeader("Content-disposition", "attachment;filename="+ FileName + ".txt");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.Write(dataString);
            HttpContext.Current.Response.End();
        }
        public void ExportToJson(DataTable dt,string FileName,string sHeader,string sFooter)
        {
            //Export to Json Type File
            HttpResponse Response=HttpContext.Current.Response;
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/json";


            string rowDelimiter = "";
            StringBuilder result = new StringBuilder("[");
            foreach (DataRow row in dt.Rows)
            {
                result.Append(rowDelimiter);
                result.Append(JsonHelper.FromDataRow(row));
                rowDelimiter = ",";
            }
            result.Append("]");

            HttpContext.Current.Response.AddHeader("Content-disposition", "attachment;filename="+ FileName + ".json");
            HttpContext.Current.Response.ContentType = "application/json";
            HttpContext.Current.Response.Write(sHeader + result.ToString() + sFooter);
            HttpContext.Current.Response.End();
            

        }
        public string ImportToJson(DataTable dt)
        { //Get The Data Into Json Type
            HttpResponse Response=HttpContext.Current.Response;
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/json";


            string rowDelimiter = "";
            StringBuilder result = new StringBuilder("[");
            foreach (DataRow row in dt.Rows)
            {
                result.Append(rowDelimiter);
                result.Append(JsonHelper.FromDataRow(row));
                rowDelimiter = ",";
            }
            result.Append("]");
            return result.ToString();          

        }
        public string ToUpperFirstLetter(string source)
        {
            if (string.IsNullOrEmpty(source))
                return string.Empty;

            // convert to char array of the string
            char[] letters = source.ToCharArray();

            // upper case the first char
            letters[0] = char.ToUpper(letters[0]);
            // return the array made of the new char array
            return new string(letters);
        }
        public string DateFormatDDMMYYYY(String str)
        {
            if ((str.Length > 0) && (str != "&nbsp;"))
            {
                DateTime dtm;

                dtm = Convert.ToDateTime(str);
                return dtm.ToString("dd-MM-yyyy");
            }
            else
            {
                return null;
            }
        }
        public string DateFormatDDMMYYYYTime(String str)
        {
            if ((str.Length > 0) && (str != "&nbsp;"))
            {
                DateTime dtm;

                dtm = Convert.ToDateTime(str);
                return dtm.ToString("dd-MM-yyyy hh:mm tt"); //ex. 17-08-2013 17:08 PM
            }
            else
            {
                return null;
            }
        }
        public string DateFormatDDMMYYYY(DateTime dtm)
        {
            return dtm.ToString("dd-MM-yyyy");
        }
        public string DateFormatYYYYMMDD(String str)
        {
            if (str.Length > 0)
            {
                DateTime dtm;

                dtm = Convert.ToDateTime(str);
                return dtm.ToString("yyyy-MM-dd");
            }
            else
            {
                return null;
            }
        }
        public string DateFormatYYYYMMDD(DateTime dtm)
        {
            return dtm.ToString("yyyy-MM-dd");
        }
        public string NumberFormatDecimal(String dcm)
        {
            double Num;

            bool isNum = double.TryParse(dcm.Trim(), out Num);

            if (isNum)
            {
                return Num.ToString("#,##0.00");
            }
            return dcm;
        }
        public string NumberFormatDecimal(Double dcm)
        {
            return dcm.ToString("#,##0.00");
        }
        // Custom Type
        public string DocStatus(string str)
        {
            string val = null;
            
            switch (str)
            {
                case "D": val = "Draft";
                    break;
                case "A": val = "Approve";
                    break;
                case "X": val = "Reject";
                    break;
                case "R": val = "RFA";
                    break;
                default: val = str;
                    break;
            }

            return val;
        }
        
        public string YesNo(String str)
        {
            String val = null;
            switch (str)
            {
                case "True": val = "Yes";
                    break;
                case "False": val = "No";
                    break;
            }
            return val;
        }
        // Modules Type
        public string PurchaseType(string str)
        {
            string val = null;

            switch (str)
            {
                case "1": val = "Additional";
                    break;
                case "2": val = "Replacement";
                    break;
                default: val = str;
                    break;
            }

            return val;
        }
        public string ActivityStatus(string str)
        {
            string val = null;

            switch (str)
            {
                case "0": val = "Open";
                    break;
                case "1": val = "Assign";
                    break;
                case "2": val = "Solved";
                    break;
                case "3": val = "Closed";
                    break;
                case "4": val = "Done";
                    break;
                default: val = str;
                    break;
            }

            return val;
        }
        public string ActivityPriority(string str)
        {
            string val = null;

            switch (str)
            {
                case "0": val = "Low";
                    break;
                case "1": val = "Medium";
                    break;
                case "2": val = "High";
                    break;
                default: val = str;
                    break;
            }

            return val;
        }
        public string ScheduleType(string str)
        {
            string val = null;
            
            switch (str)
            {
                case "0": val = "Permanent";
                    break;
                case "1": val = "Temporer";
                    break;
                case "2": val = "Reporting";
                    break;
                case "3": val = "Monitoring";
                    break;
                case "4": val = "Service";
                    break;
                case "5": val = "Maintenance User";
                    break;
                case "6": val = "Backup Data";
                    break;
                default: val = str;
                    break;
            }

            return val;
        }
        public string ScheduleStatus(string str)
        {
            string val = null;

            switch (str)
            {
                case "1": val = "Open";
                    break;
                case "2": val = "Finish";
                    break;
                default: val = str;
                    break;
            }

            return val;
        }
        public string ItemStatusIn(string str)
        {
            string val = null;
            switch (str)
            {
                case "1": val = "New";
                    break;
                case "2": val = "Return";
                    break;
                case "3": val = "Replace";
                    break;
                default: val = str;
                    break;
            }
            return val;
        }
        public string ItemStatusOut(string str)
        {
            string val = null;

            switch (str)
            {
                case "1": val = "Repair";
                    break;
                case "2": val = "Dispose";
                    break;
                default: val = str;
                    break;
            }

            return val;
        }
    }
}
