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
    public partial class MappingApprovalAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlMenu, "- Select One -", "spGetMenuToCombo 'MenuLink IS NOT NULL'", "MenuId", "MenuName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlDepartement, "All Departement", "spGetDepartementToCombo ''", "DepartementCode", "DepartementName", null);
                ControlBindingHelper.BindDataSetToCombo(ddlParent, "- Select One -", "spGetPrivilegeToCombo ''", "PrivilegeCode", "PrivilegeName", null);

                if (this.state == "add")
                {
                    imbUpdate.Enabled = false;
                    imbUpdate.Visible = false;
                    trMail.Visible = false;
                }
                else
                {
                    ControlBindingHelper.BindDataSetToCombo(ddlUserMail, "- Select One -", "spGetUserToCombo 'Email IS NOT NULL AND Email <> '''''", "UserId", "UserName", null);
                    
                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadData();
                    LoadDataMail();
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Mapping Approval";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";

            ucIsBranch.FirstListText = "- Select One -";
            ucIsBranch.CssClass = "validate[required]";

            ucHeaderMail.Text = "E-Mail Notification";
            ucHeaderMail.CssClass = "divHeader2";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.Master.MappingApproval info = new USoft.DataAccess.Entities.Master.MappingApproval();
            USoft.DataAccess.Master.MappingApproval da = new USoft.DataAccess.Master.MappingApproval();

            info.ApprovalId = Convert.ToInt32(editID);

            da.getMappingApprovalView(ref info);

            ddlMenu.SelectedValue = info.MenuId.ToString();
            ddlDepartement.SelectedValue = info.DepartementCode;
            ddlParent.SelectedValue = info.ParentCode;
            ControlBindingHelper.BindDataSetToCombo(ddlUserApproval, "All", "spGetUserByPrivilegeToCombo 'PrivilegeCode = ''" + ddlParent.SelectedValue + "'''", "UserId", "UserName", info.UserIdApproval);
            ucIsBranch.SelectedValue(Convert.ToString(info.IsBranch)); 
            txtState.Text = info.State.ToString();
            txtStateDescription.Text = info.StateDescription;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        private void LoadDataMail()
        {
            USoft.DataAccess.Entities.Master.MappingApproval info = new USoft.DataAccess.Entities.Master.MappingApproval();
            USoft.DataAccess.Master.MappingApproval da = new USoft.DataAccess.Master.MappingApproval();

            info.ApprovalId = Convert.ToInt32(editID);

            gvApprovalMail.DataSource = da.getMappingApprovalEmail(info);
            gvApprovalMail.DataBind();
        }

        protected void gvApprovalMail_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // reference the Delete LinkButton
                LinkButton db = (LinkButton)e.Row.Cells[3].Controls[0];
                db.OnClientClick = "return confirm('Are you certain you want to delete this User E-Mail ?');";
            }
        }

        protected void gvApprovalMail_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow rows = gvApprovalMail.Rows[e.RowIndex];

            USoft.DataAccess.Entities.Master.MappingApproval info = new USoft.DataAccess.Entities.Master.MappingApproval();
            USoft.DataAccess.Master.MappingApproval da = new USoft.DataAccess.Master.MappingApproval();

            info.ApprovalEmailId = Convert.ToInt32(rows.Cells[0].Text);

            lblMessage.Text = da.MappingApprovalEmailDelete(info);

            LoadDataMail();

            pnlDataTable.Update();
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.Master.MappingApproval info = new USoft.DataAccess.Entities.Master.MappingApproval();
            USoft.DataAccess.Master.MappingApproval da = new USoft.DataAccess.Master.MappingApproval();

            info.MenuId = Convert.ToInt32(ddlMenu.SelectedValue);
            info.DepartementCode = ddlDepartement.SelectedValue;
            info.ParentCode = ddlParent.SelectedValue;
            info.UserIdApproval = ddlUserApproval.SelectedValue;
            info.IsBranch = Convert.ToBoolean(ucIsBranch.Value);
            info.State = Convert.ToInt32((txtState.Text != "") ? txtState.Text : null);
            info.StateDescription = txtStateDescription.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                info.ApprovalId = Convert.ToInt16(editID);
                lblMessage.Text = da.MappingApprovalUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.MappingApprovalInsert(ref info);
                ReturnID = info.ApprovalId.ToString();
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
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
                    Response.Redirect("MappingApprovalAddEdit.aspx?validate=" + validate(0) + "&editID=" + ReturnID + "&state=edit&msg=" + lblMessage.Text);
                }
            }
            else
            {
                ProcessData("U");
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void ddlParent_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            ddlUserApproval.Items.Clear();

            if (ddlParent.SelectedValue != "")
            {
                ControlBindingHelper.BindDataSetToCombo(ddlUserApproval, "All", "spGetUserByPrivilegeToCombo 'PrivilegeCode = ''" + ddlParent.SelectedValue + "'''", "UserId", "UserName", null);
            }

            pnlUserApproval.Update();

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void imbAddMail_Click(object sender, ImageClickEventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            if (ddlUserMail.SelectedValue != "")
            {
                USoft.DataAccess.Entities.Master.MappingApproval info = new USoft.DataAccess.Entities.Master.MappingApproval();
                USoft.DataAccess.Master.MappingApproval da = new USoft.DataAccess.Master.MappingApproval();

                info.ApprovalId = Convert.ToInt32(editID);
                info.UserIdEmail = ddlUserMail.SelectedValue;
                info.InputBy = Session["UserId"].ToString();

                lblMessage.Text = da.MappingApprovalEmailInsert(info);

                LoadDataMail();
                pnlDataTable.Update();
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
            Response.Redirect("MappingApproval.aspx?validate=" + validate(0));
        }
    }
}
