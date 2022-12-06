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
    public partial class PrivilegeAddEdit : USoft.Modules.PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserInfo();
            LoadControl();

            if (!Page.IsPostBack)
            {
                // Binding
                ControlBindingHelper.BindDataSetToCombo(ddlDepartement, "- Select One -", "spGetDepartementToCombo ''", "DepartementCode", "DepartementName", null);
                
                if (this.state == "add")
                {
                    imbUpdate.Enabled = false;
                    imbUpdate.Visible = false;
                    trPrivilegeMenu.Visible = false;
                }
                else
                {
                    imbAdd.Enabled = false;
                    imbAdd.Visible = false;
                    LoadData();
                    LoadDataMenu();
                    txtPrivilegeCode.Attributes["readonly"] = "readonly";
                    lblMessage.Text = msg;
                }
            }
        }

        protected void LoadControl()
        {
            ucHeaderPage.Text = cf.ToUpperFirstLetter(this.state) + " Privilege";
            ucHeaderPage.CssClass = "divHeader1";

            ucIsActive.FirstListText = "- Select One -";
            ucIsActive.CssClass = "validate[required]";

            ucHeaderMenu.Text = "Privilege Menu";
            ucHeaderMenu.CssClass = "divHeader2";
        }

        private void LoadData()
        {
            USoft.DataAccess.Entities.Master.Privilege info = new USoft.DataAccess.Entities.Master.Privilege();
            USoft.DataAccess.Master.Privilege da = new USoft.DataAccess.Master.Privilege();

            info.PrivilegeCode = editID;

            da.getPrivilegeView(ref info);

            txtPrivilegeCode.Text = info.PrivilegeCode;
            txtPrivilegeName.Text = info.PrivilegeName;
            ddlDepartement.SelectedValue = info.DepartementCode;
            txtOldCode.Text = info.OldCode;
            ucIsActive.SelectedValue(Convert.ToString(info.IsActive));
        }

        private void LoadDataMenu()
        {
            USoft.DataAccess.Entities.Master.Privilege info = new USoft.DataAccess.Entities.Master.Privilege();
            USoft.DataAccess.Master.Privilege da = new USoft.DataAccess.Master.Privilege();

            info.PrivilegeCode = editID;
            info.UserId = "";

            gvPrivilegeMenu.DataSource = da.getPrivilegeMenu(info);
            gvPrivilegeMenu.DataBind();
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
            USoft.DataAccess.Entities.Master.Privilege info = new USoft.DataAccess.Entities.Master.Privilege();
            USoft.DataAccess.Master.Privilege da = new USoft.DataAccess.Master.Privilege();

            info.PrivilegeCode = txtPrivilegeCode.Text;
            info.PrivilegeName = txtPrivilegeName.Text;
            info.DepartementCode = ddlDepartement.SelectedValue;
            info.OldCode = txtOldCode.Text;
            info.IsActive = Convert.ToBoolean(ucIsActive.Value);
            info.InputBy = Session["UserId"].ToString();

            if (state == "U")   // Update
            {
                lblMessage.Text = da.PrivilegeUpdate(info);
            }
            else // Add
            {
                lblMessage.Text = da.PrivilegeInsert(info);
            }

            if (lblMessage.Text == "Process Success")   // Prevent Multiple Add
            {
                if (state == "U")   // Update Menu
                {
                    da.PrivilegeMenuClear(info);
                    
                    foreach (TableRow tr in gvPrivilegeMenu.Rows)
                    {
                        CheckBox chkInsert = tr.FindControl("chkInsert") as CheckBox;
                        CheckBox chkUpdate = tr.FindControl("chkUpdate") as CheckBox;
                        CheckBox chkDelete = tr.FindControl("chkDelete") as CheckBox;
                        CheckBox chkView = tr.FindControl("chkView") as CheckBox;

                        info.MenuId = Convert.ToInt32(tr.Cells[0].Text);
                        info.Insert = (chkInsert.Visible) ? chkInsert.Checked : false;
                        info.Update = (chkUpdate.Visible) ? chkUpdate.Checked : false;
                        info.Delete = (chkDelete.Visible) ? chkDelete.Checked : false;
                        info.View = chkView.Checked;

                        da.PrivilegeMenuUpdate(info);
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

            if (this.state == "add")
            {
                if (ProcessData("A"))
                {
                    //imbSubmit.Visible = false;
                    Response.Redirect("PrivilegeAddEdit.aspx?validate=" + validate(0) + "&editID=" + txtPrivilegeCode.Text + "&state=edit&msg=" + lblMessage.Text);
                }
            }
            else
            {
                ProcessData("U");
            }

            pnlDataTable.Update();
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
            Response.Redirect("Privilege.aspx?validate=" + validate(0));
        }
    }
}
