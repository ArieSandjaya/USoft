using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using USoft.Globalization;

namespace USoft
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void imgLogoff_Click(object sender, ImageClickEventArgs e)
        {
            HttpContext.Current.Session["UserId"] = null;
            HttpContext.Current.Session["UserName"] = null;
            HttpContext.Current.Session["BranchId"] = null;
            //HttpContext.Current.Session["PriviledgeCode"] = null; //
            HttpContext.Current.Session["PrivilegeCode"] = null; //
        }
    }
}
