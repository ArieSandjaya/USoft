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
    public partial class BranchAddEdit : USoft.Modules.PageBase
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
                    txtBranchId.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Branch";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.Master.Branch info = new USoft.DataAccess.Entities.Master.Branch();
            USoft.DataAccess.Master.Branch da = new USoft.DataAccess.Master.Branch();

            info.BranchId = Convert.ToInt32(editID);

            da.getBranchView(ref info);

            txtBranchId.Text = info.BranchId.ToString();
            txtBranchCode.Text = info.BranchCode;
            txtBranchName.Text = info.BranchName;
            ddlBranchType.SelectedValue = info.BranchType.ToString();
            if (ddlBranchType.SelectedValue == "2")
            {
                ControlBindingHelper.BindDataSetToCombo(ddlBranchParent, "- Select One -", "spGetBranchToCombo 'BranchType = 1'", "BranchId", "BranchName", info.BranchParent.ToString());
                ddlBranchParent.CssClass = "validate[required]";
            }
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.Master.Branch info = new USoft.DataAccess.Entities.Master.Branch();
            USoft.DataAccess.Master.Branch da = new USoft.DataAccess.Master.Branch();

            info.BranchId = Convert.ToInt32(txtBranchId.Text);
            info.BranchCode = txtBranchCode.Text;
            info.BranchName = txtBranchName.Text;
            info.BranchType = Convert.ToInt32(ddlBranchType.SelectedValue);
            info.BranchParent = Convert.ToInt32((ddlBranchParent.SelectedValue != "") ? ddlBranchParent.SelectedValue : null);
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.BranchUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.BranchInsert(info);
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
                    //imbAdd.Visible = false;
                    Response.Redirect("BranchAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtBranchId.Text + "&state=edit&msg=" + lblMessage.Text);
                }
            }
            else
            {
                ProcessData("U");
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void ddlBranchType_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            ddlBranchParent.Items.Clear();
            ddlBranchParent.CssClass = "";

            if (ddlBranchType.SelectedValue == "2")
            {
                ControlBindingHelper.BindDataSetToCombo(ddlBranchParent, "- Select One -", "spGetBranchToCombo 'BranchType = 1'", "BranchId", "BranchName", null);
                ddlBranchParent.CssClass = "validate[required]";
            }

            pnlBranchParent.Update();

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
            Response.Redirect("Branch.aspx?validate=" + validate(0));
        }
    }
}
