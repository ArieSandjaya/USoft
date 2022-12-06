using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;

namespace USoft.Accounting.Bapepam
{
    public class BindToJson
    {
        public BindToJson(){}
        public string convert(DataTable dt)
        {
            string[] HeaderFooter;
            CommonFunction cf = new CommonFunction();
            return cf.ConvertToJson(dt);
        }
        private void convertFile(DataTable dt,int type)
        {
            string[] HeaderFooter;
            if(type == 40)
            {
                HeaderFooter = ReportType.HeaderFooter("pembiayaankonsumen","records of pembiayaankonsumen",dt.Rows.Count);
            }
            else
            {
                HeaderFooter = ReportType.HeaderFooter("pembiayaansewagunausaha","records of pembiayaansewagunausaha",dt.Rows.Count);
            }
            CommonFunction cf = new CommonFunction();
            cf.ExportToJson(dt,DateTime.Today.ToString(),HeaderFooter[0],HeaderFooter[1]);
        }
        public void GetJSON(int type)
        {
            SQLHandler sqlHandler = new SQLHandler();
            if(type == 11)
            {
                convertFile(sqlHandler.ExecuteAsDataTable("ACCOUNTING_PEMBIAYAAN_SEWA_GUNA"),type);
                
            }
            else
            {
                convertFile(sqlHandler.ExecuteAsDataTable("ACCOUNTING_PEMBIAYAAN_KONSUMEN"),type);
            }
        }
    }
}
