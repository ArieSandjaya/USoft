using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using USoft.Globalization;

namespace USoft
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            AppStart.GetMenu();
            /* Block by dwi 20130611
            AppStart.GetBranch();
            AppStart.GetPriviledge();
            AppStart.GetUserid();
            AppStart.GetEntCompanyName();
            AppStart.GetEntDept();
            */
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}