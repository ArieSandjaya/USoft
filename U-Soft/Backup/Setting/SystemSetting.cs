using System;
using System.Collections.Generic;
using System.Web;


namespace USoft.Common.Setting
{
    public static class SystemSetting
    {
        public static string ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["USOFT"].ToString();
        public static int PagingSize = Convert.ToInt16(System.Configuration.ConfigurationManager.AppSettings["PagingSize"].ToString());
        public static string ReportPath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"].ToString();
        public static string MinPassLength = System.Configuration.ConfigurationManager.AppSettings["MinPassLength"].ToString();
        public static string MailHost = System.Configuration.ConfigurationManager.AppSettings["MailHost"].ToString();
        public static string MailHostUfindo = System.Configuration.ConfigurationManager.AppSettings["MailHostUfindo"].ToString();
        public static string MailAgentName = System.Configuration.ConfigurationManager.AppSettings["MailAgentName"].ToString();
        public static string MailAgentAddress = System.Configuration.ConfigurationManager.AppSettings["MailAgentAddress"].ToString();
        public static int Port = Convert.ToInt16(System.Configuration.ConfigurationManager.AppSettings["Port"].ToString());
        public static string DefaultPassword = System.Configuration.ConfigurationManager.AppSettings["resetPWD"].ToString(); 
    }
}
