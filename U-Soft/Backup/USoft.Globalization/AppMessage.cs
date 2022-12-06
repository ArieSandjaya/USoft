using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;

namespace USoft.Globalization
{
    public class AppMessage
    {
        public AppMessage()
        { }
        public static void SetMessage(Page myPage,string message)
        {
            myPage.RegisterStartupScript("myError", "<script language=JavaScript>alert('"+ message +"');</script>");
        }

        public static void SetMessage(Page myPage, UpdatePanel upd, ScriptManager scm, string message)
        {
            ScriptManager.RegisterStartupScript(upd, upd.GetType(), "myScript", "alert('" + message + "');", true);
        }
    }
}
