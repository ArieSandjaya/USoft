using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;

namespace USoft.Globalization
{
    public class ErrorMessage
    {
        public ErrorMessage()
        { }
        public static void SetMessage(Page myPage,string message)
        {
            myPage.RegisterStartupScript("myError", "<script language=JavaScript>alert('"+ message +"');</script>");
        }
    }
}
