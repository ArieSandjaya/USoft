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
using USoft.Compliance.Master;
using USoft.Globalization;

namespace USoft.Modules.Compliance.Master
{
    public partial class EditDealer : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadControl();
            
            if (!IsPostBack)
            {
                txtDealerCode1.Text = Request.QueryString["KodeDealer"];
                txtDealerName1.Text = Request.QueryString["NamaDealer"];
                ucIsActive.SelectedValue((Request.QueryString["Status"] == "1") ? "True" : "False");
            }
        }

        private void LoadControl()
        {
            ucHeaderPage.Text = "Edit Dealer";
            ucHeaderPage.CssClass = "divHeader2";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateDealer();
        }
        private void UpdateDealer()
        {
            CekSessions.BlockUI(this.Page);

            DealerEdit deal = new DealerEdit();
            deal.DealerCode = txtDealerCode1.Text;
            deal.DealerName = txtDealerName1.Text;
            deal.Status = (ucIsActive.Value == "True") ? 1 : 0;

            string newString = deal.EditDealer();
            
            CekSessions.UnBlockUI(this.Page, ScriptManager1);

            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data has been Updated');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error When Update proses');", true);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("dealer.aspx?validate=" + validate(0));
        }
    }
}
