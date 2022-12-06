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
using USoft.Common.Shared;
using USoft.Accounting.Bapepam;

namespace USoft.Modules.Accounting.Bapepam
{
    public partial class Pembiayaankonsumen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label lbl = (Label)CtrlFormHeader.FindControl("lblHeader");
                lbl.Text = "Form 7 Bapepam";
            }
        }

        protected void btnConvert_Click(object sender, EventArgs e)
        {
            BindToJson bts = new BindToJson();
            bts.GetJSON(Convert.ToInt16(ddlReportType.SelectedItem.Value.ToString()));
        }
    }
}
