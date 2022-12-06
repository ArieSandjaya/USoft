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
using USoft.Compliance;
using USoft.Globalization;

namespace USoft.Modules.Compliance.Master
{
    public partial class AddDealer : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();

            if (!IsPostBack)
            {

            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Add New Dealer";
            ucHeaderPage.CssClass = "divHeader2";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            DealerAdd dealer = new DealerAdd();
            dealer.DealerName = txtDealerName.Text;
            dealer.DealerCode = txtDealerCode.Text;
            
            string newString = dealer.CreateDealer();
            
            CekSessions.UnBlockUI(this.Page, ScriptManager1);

            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Dealer Already Exists');", true);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("dealer.aspx?validate=" + validate(0));
        }
    }
}
