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
using USoft.Common.Security;
using USoft.Common.CommonFunction;
using USoft.DataAccess;
using USoft.Globalization;

namespace USoft.Modules.Master
{
    public partial class UsersAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlBranch, "- Select One -", "spGetBranchToCombo ''", "BranchId", "BranchName", null);

                if (this.state == "add")
                {
                    imbUpdate.Enabled = false;
                    imbUpdate.Visible = false;
                    trMenu.Visible = false;
                    txtPassword.CssClass = "validate[required]";
                    txtConfirm.CssClass = "validate[required]";
                }
                else
                {
                    // Binding
                    ControlBindingHelper.BindDataSetToCombo(ddlPrivilegeMenu, "- Select One -", "spGetPrivilegeToCombo ''", "PrivilegeCode", "PrivilegeName", null);
                    ControlBindingHelper.BindDataSetToCombo(ddlUserMenu, "- Select One -", "spGetUserToCombo 'UserId <> ''" + editID + "'''", "UserId", "UserName", null);

                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadData();
                    LoadDataMenu("", editID);
                    txtUserId.Attributes["readonly"] = "readonly";
                    lblMarkPassword.Visible = false;
                    lblMarkConfirm.Visible = false;
                    lblMessage.Text = msg;
                }
            }
            else
            {
                lblMessage.Text = "";
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Users";
            ucHeaderPage.CssClass = "divHeader1";

            ucHeaderMenu.Text = "Privilege Menu";
            ucHeaderMenu.CssClass = "divHeader2";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";

            ucIsAllBranch.FirstListText = "- Select One -";
            ucIsAllBranch.CssClass = "validate[required]";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.Master.Users info = new USoft.DataAccess.Entities.Master.Users();
            USoft.DataAccess.Master.Users da = new USoft.DataAccess.Master.Users();

            info.UserId = editID;

            da.getUsersView(ref info);

            txtUserId.Text = info.UserId;
            txtUserName.Text = info.UserName;
            ddlBranch.SelectedValue = info.BranchId.ToString();
            txtEmail.Text = info.Email;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
            ddlChangePass.SelectedValue = info.CanChangePass;
            ddlSendEmail.SelectedValue = info.CanSendEmail;
            ucIsAllBranch.SelectedValue(Convert.ToString(info.IsAllBranch));
            ddlPrivilegeMenu.SelectedValue = info.PrivilegeCode;
        }

        private void LoadDataMenu(string PrivilegeCode, string UserId)
        {
            USoft.DataAccess.Entities.Master.Privilege info = new USoft.DataAccess.Entities.Master.Privilege();
            USoft.DataAccess.Master.Privilege da = new USoft.DataAccess.Master.Privilege();

            info.PrivilegeCode = PrivilegeCode;
            info.UserId = UserId;

            gvPrivilegeMenu.DataSource = da.getPrivilegeMenu(info);
            gvPrivilegeMenu.DataBind();

            if (UserId != "")
            {
                USoft.DataAccess.Entities.Master.Users info2 = new USoft.DataAccess.Entities.Master.Users();
                USoft.DataAccess.Master.Users da2 = new USoft.DataAccess.Master.Users();

                info2.UserId = UserId;
                
                da2.getUsersView(ref info2);

                //ddlPrivilegeMenu.SelectedValue = info2.PrivilegeCode;
            }
            
            pnlDataTable.Update();
        }

        protected void gvPrivilegeMenu_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.Cells[0].Text == e.Row.Cells[1].Text) || (e.Row.Cells[2].Text == "&nbsp;"))
                {
                    CheckBox chkInsert = (CheckBox)e.Row.FindControl("chkInsert");
                    CheckBox chkUpdate = (CheckBox)e.Row.FindControl("chkUpdate");
                    CheckBox chkDelete = (CheckBox)e.Row.FindControl("chkDelete");

                    chkInsert.Visible = false;
                    chkUpdate.Visible = false;
                    chkDelete.Visible = false;
                }
            }
        }

        protected bool ProcessData(string state)
        {
            USoft.DataAccess.Entities.Master.Users info = new USoft.DataAccess.Entities.Master.Users();
            USoft.DataAccess.Master.Users da = new USoft.DataAccess.Master.Users();

            info.UserId = txtUserId.Text;
            info.UserName = txtUserName.Text;
            info.BranchId = Convert.ToInt16(ddlBranch.SelectedValue);
            info.Email = txtEmail.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.CanChangePass = ddlChangePass.SelectedValue;
            info.CanSendEmail = ddlSendEmail.SelectedValue;
            info.IsAllBranch = Convert.ToBoolean(ucIsAllBranch.Value);
            info.InputBy = Session["UserId"].ToString();

            // On Update state, user can only update profile without password
            info.Pass = (txtPassword.Text.Trim() != "") ? EncryptionMD5.Encrypt(txtPassword.Text) : "";
            
            if (state == "U")   // Update
            {
                info.PrivilegeCode = ddlPrivilegeMenu.SelectedValue;
                lblMessage.Text = da.UsersUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.UsersInsert(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                if (state == "U")   // Update Menu
                {
                    da.UsersMenuClear(info); 
                    
                    foreach (TableRow tr in gvPrivilegeMenu.Rows)
                    {
                        CheckBox chkInsert = (CheckBox)tr.FindControl("chkInsert");
                        CheckBox chkUpdate = (CheckBox)tr.FindControl("chkUpdate");
                        CheckBox chkDelete = (CheckBox)tr.FindControl("chkDelete");
                        CheckBox chkView = (CheckBox)tr.FindControl("chkView");

                        info.MenuId = Convert.ToInt32(tr.Cells[0].Text);
                        info.Insert = (chkInsert.Visible) ? chkInsert.Checked : false;
                        info.Update = (chkUpdate.Visible) ? chkUpdate.Checked : false;
                        info.Delete = (chkDelete.Visible) ? chkDelete.Checked : false;
                        info.View = chkView.Checked;

                        da.UsersMenuUpdate(info);
                    }
                } 
                
                return true;
            }
            return false;
        }

        protected void ProcessForm()
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "tmp", "$.blockUI();", true);

            CekSessions.BlockUI(this.Page);

            if (txtPassword.Text != txtConfirm.Text) {
                lblMessage.Text = "Confirm Password Not Same !";
            } else {
                if (this.state == "add")
                {
                    if (ProcessData("A"))
                    {
                        //imbAdd.Visible = false;
                        Response.Redirect("UsersAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtUserId.Text + "&state=edit&msg=" + lblMessage.Text);
                    }
                }
                else
                {
                    ProcessData("U");
                }
            }

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void ddlPrivilegeMenu_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);
            
            LoadDataMenu(ddlPrivilegeMenu.SelectedValue, "");

            ddlUserMenu.SelectedValue = "";

            CekSessions.UnBlockUI(this.Page, ScriptManager1);
        }

        protected void ddlUserMenu_SelectedIndexChanged(object sender, EventArgs e)
        {
            CekSessions.BlockUI(this.Page);

            LoadDataMenu("", ddlUserMenu.SelectedValue);
            
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
            Response.Redirect("Users.aspx?validate=" + validate(0));
        }
    }
}
