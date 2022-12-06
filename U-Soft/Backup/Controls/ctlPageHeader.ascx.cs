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

namespace USoft.Controls
{
    public partial class ctlPageHeader : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserName"] != null) // 20130514 add dwi prevent error empty session
            {
                lblWelcome.Text = "Welcome : " + Session["UserName"].ToString();
            }
        }
    }
}