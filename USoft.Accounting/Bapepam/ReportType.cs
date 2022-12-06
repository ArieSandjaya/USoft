using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.Accounting.Bapepam
{
    public class ReportType
    {
        public ReportType(){}
        public static string[] HeaderFooter(string recordType,string recordDesc,int rowCount)
        {
            string[] strHeaderFooter = new string[2];
            strHeaderFooter[0] = "{"+"\"" +"manager" + "\"" + ":" + "\"" + recordType + "\"" +"," +
                                 "\"" +"description" + "\"" +":"+ "\""+recordDesc+"\""+","+
                                 "\"" +"total" +"\""+":"+""+rowCount+""+","+
                                 "\""+"records" +"\""+":";
            strHeaderFooter[1] = ","+"\""+"record-count"+"\""+":"+""+rowCount+""+"}";
            return strHeaderFooter;
        }
    }
}
