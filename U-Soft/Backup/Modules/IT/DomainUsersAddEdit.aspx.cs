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

namespace USoft.Modules.IT
{
    public partial class DomainUsersAddEdit : USoft.Modules.PageBase
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
                    txtPassword.CssClass = "validate[required]";
                }
                else
                {
                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadData();
                    lblPasswordMark.Visible = false;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Domain Branch Users";
            ucHeaderPage.CssClass = "divHeader1";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.IT.DomainUsers info = new USoft.DataAccess.Entities.IT.DomainUsers();
            USoft.DataAccess.IT.DomainUsers da = new USoft.DataAccess.IT.DomainUsers();

            info.BranchCode = editID;

            da.getBranchDomainView(ref info);

            txtBranchCode.Text = info.BranchCode;
            txtBranchName.Text = info.BranchName;
            txtIPAddress.Text = info.BranchIP;
            txtUsername.Text = info.UserName;
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.IT.DomainUsers info = new USoft.DataAccess.Entities.IT.DomainUsers();
            USoft.DataAccess.IT.DomainUsers da = new USoft.DataAccess.IT.DomainUsers();

            info.BranchCode = txtBranchCode.Text;
            info.BranchName = txtBranchName.Text;
            info.BranchIP = txtIPAddress.Text;
            info.UserName = txtUsername.Text;
            info.Password = (txtPassword.Text.Trim() != "") ? txtPassword.Text : "";
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                info.BranchCodeOld = editID;
                lblMessage.Text = da.BranchDomainUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.BranchDomainInsert(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                if (state == "U")   // Update
                {
                    //editID = info.BranchCodeOld;
                }
                return true;
            }
            return false;
        }

        protected void ProcessForm()
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.blockUI();", true);

            CekSessions.BlockUI(this.Page);

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //imbSubmit.Visible = false;
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

        protected void imbCancel_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("DomainUsers.aspx?validate=" + validate(0));
        }
    }
}
