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
using USoft.Globalization;
using USoft.Globalization.Users;
using USoft.AccordionMenu.DataProvider;

namespace USoft.Modules.Main
{
    public partial class EditUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUserId1.Text = Request.QueryString["UserId"];
                txtName1.Text = Request.QueryString["UserName"];
                DropDownList ddl_branch = (DropDownList)CtrlBranch.FindControl("ddlBranch");
                ddl_branch.SelectedIndex = ddl_branch.Items.IndexOf(ddl_branch.Items.FindByText(Request.QueryString["BranchName"]));
                DropDownList ddlIsActive = (DropDownList)CtrlIsActive.FindControl("ddlIsActive");
                ddlIsActive.SelectedIndex = ddlIsActive.Items.IndexOf(ddlIsActive.Items.FindByValue(Request.QueryString["Active"]));
                txtEmail1.Text = Request.QueryString["Email"];
                if (Request.QueryString["ChangePass"] == "Y")  chkCPass1.Checked = true;
                 else  chkCPass1.Checked = false;
                if (Request.QueryString["CanSendMail"] == "Y") chkSendMail1.Checked = true;
                 else chkSendMail1.Checked = false;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateUsers();
        }
        private void UpdateUsers()
        {
            UserControl uc = (UserControl)this.FindControl("CtrlBranch");
            DropDownList ddl = (DropDownList)uc.FindControl("ddlBranch");
            string strBranchId = ddl.SelectedValue.ToString();
            DropDownList dl = (DropDownList)CtrlIsActive.FindControl("ddlIsActive");
            string strStatus = dl.SelectedValue.ToString();
            UserEdit user = new UserEdit();
            user.UserID = txtUserId1.Text;
            user.Username = txtName1.Text;
            user.BranchID = Convert.ToInt32(ddl.SelectedValue.ToString());
            user.Status = Convert.ToInt16(strStatus);
            user.Email = txtEmail1.Text;
            if (chkCPass1.Checked)  user.ChangePass = "Y";
                else user.ChangePass = "N";
            if (chkSendMail1.Checked) user.SendMail = "Y";
            else user.SendMail = "N";     
            string newString = user.EditUser();
            if (newString == "DONE")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data has been Updated');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error When Update proses');", true);
            }
        }


        protected void btnEditMenu_Click(object sender, EventArgs e)
        {
            UserMenu usermenu = new UserMenu();
            usermenu.UserID = txtUserId1.Text;
            usermenu.PrivCode = Request.QueryString["PrivCode"];
            Session["menuprivcode"] = usermenu.PrivCode;
            gvMenu.DataSource = usermenu.GetAllMenu();
            gvMenu.DataBind();
            tblMenu.Attributes.Add("class", "show");
            updGrid.Update();
        }
        protected void imgBtnClose_Click(object sender, ImageClickEventArgs e)
        {
            tblMenu.Attributes.Add("class", "hide");
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            mpePR.Show();
        }
        protected void imgBtnCancel_Click(object sender, ImageClickEventArgs e)
        {
            mpePR.Hide();
        }
        protected void btnOK_Click(object sender, EventArgs e)
        {
            UserControl ucp = (UserControl)this.FindControl("CtrlPriviledge");
            DropDownList dd = (DropDownList)ucp.FindControl("ddlPriviledge");
            string strPrivCode = dd.SelectedValue.ToString();

            PrivMenu privmenu = new PrivMenu();
            if (strPrivCode == "") privmenu.PrivCode = "";
            else privmenu.PrivCode = strPrivCode;
            Session["menuprivcode"] = privmenu.PrivCode;
            gvMenu.DataSource = privmenu.GetAllPrivMenu();
            gvMenu.DataBind();
            updGrid.Update();
        }

        //btn menu by User
        protected void Button2_Click(object sender, EventArgs e)
        {
            mpeUSR.Show();
        }
        protected void imgBtnCancel2_Click(object sender, ImageClickEventArgs e)
        {
            mpeUSR.Hide();
        }
        protected void btnOK2_Click(object sender, EventArgs e)
        {
            UserControl ucs = (UserControl)this.FindControl("CtrlUserId");
            DropDownList du = (DropDownList)ucs.FindControl("ddlUserId");
            string strUserId = du.SelectedValue.ToString();
            string strPrivCod = du.SelectedItem.Attributes["code"].ToString();

            UserMenu usr = new UserMenu();
            usr.UserID = strUserId;
            usr.PrivCode = strPrivCod;
            Session["menuprivcode"] = usr.PrivCode;
            gvMenu.DataSource = usr.GetAllMenu();
            gvMenu.DataBind();
            updGrid.Update();
        }


        protected void btnSaveMenu_Click(object sender, EventArgs e)
        {
            foreach (TableRow tr in gvMenu.Rows)
            {
                try
                {
                    CheckBox chkInsert = tr.FindControl("chkInsert") as CheckBox;
                    CheckBox chkUpdate = tr.FindControl("chkUpdate") as CheckBox;
                    CheckBox chkDelete = tr.FindControl("chkDelete") as CheckBox;
                    CheckBox chkView = tr.FindControl("chkView") as CheckBox;

                    UserMenu uMenu = new UserMenu();
                    uMenu.UserID = txtUserId1.Text;
                    uMenu.PrivCode = Session["menuprivcode"].ToString();
                    uMenu.MenuId = Convert.ToInt32(tr.Cells[0].Text);
                    uMenu.Insert = chkInsert.Checked ? 1 : 0;
                    uMenu.Update = chkUpdate.Checked ? 1 : 0;
                    uMenu.Delete = chkDelete.Checked ? 1 : 0;
                    uMenu.View = chkView.Checked ? 1 : 0;
                    uMenu.SaveUserMenu();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Data Already Saved');", true);
                }
                catch
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Cannot Save Data');", true);
                }
            }
            AccordionMenuData.GetAllMenu();
        }
    }
}
