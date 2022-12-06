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

using USoft.Globalization.Classes;
using USoft.Common.CommonFunction;
using USoft.DataAccess;
using USoft.Globalization;

namespace USoft.Modules.Master
{
    public partial class CurrencyAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                if (this.state == "add")
                {
                    imbUpdate.Enabled = false;
                    imbUpdate.Visible = false;
                }
                else
                {
                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadData();
                    txtCurrencyCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Currency";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.Master.Currency info = new USoft.DataAccess.Entities.Master.Currency();
            USoft.DataAccess.Master.Currency da = new USoft.DataAccess.Master.Currency();

            info.CurrencyCode = editID;

            da.getCurrencyView(ref info);

            txtCurrencyCode.Text = info.CurrencyCode;
            txtCurrencyName.Text = info.CurrencyName;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.Master.Currency info = new USoft.DataAccess.Entities.Master.Currency();
            USoft.DataAccess.Master.Currency da = new USoft.DataAccess.Master.Currency();

            info.CurrencyCode = txtCurrencyCode.Text;
            info.CurrencyName = txtCurrencyName.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.CurrencyUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.CurrencyInsert(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                return true;
            }
            return false;
        }

        protected void ProcessForm()
        {
            CekSessions.BlockUI(this.Page);

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //mbAdd.Visible = false;
                    Response.Redirect("CurrencyAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtCurrencyCode.Text + "&state=edit&msg=" + lblMessage.Text);
                }
            }
            else
            {
                ProcessData("U");
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbAdd_Click(object sender, ImageClickEventArgs e)
        {
            ProcessForm();
        }

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            ProcessForm();
        }

        protected void imbBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Currency.aspx?validate=" + validate(0));
        }
    }
}
